namespace Moshine.Api.Weather;

uses
  CoreLocation,
  Foundation,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.WeatherUnderground,
  Moshine.Foundation.Web,
  RemObjects.Elements.RTL;

type

  WeatherUndergroundProxy = public class(WebProxy)
  private
  private
    _apiKey:String;

  public
    constructor(apiKey:String);
    begin
      _apiKey := apiKey;
    end;

    method conditionsForName(name:String):NSDictionary;
    begin
        var apiUrl := NSString.stringWithFormat('https://api.wunderground.com/api/%@/conditions/q/%@.json',_apiKey,name);
        exit WebRequest<NSDictionary>('GET',apiUrl,false);
    end;

  end;

  WeatherUndergroundApi = public class
  private
    _apiKey:String;
    _proxy:WeatherUndergroundProxy;
  protected
  public
    constructor(apiKey:String);
    begin
      _apiKey := apiKey;
      _proxy := new WeatherUndergroundProxy(_apiKey);
    end;

    method populateConditions(foundConditions:Conditions) fromDictionary(someDictionary:NSDictionary);
    begin
      var currentObservation := someDictionary.valueForKey('current_observation');
      foundConditions.Observation.Weather := currentObservation.valueForKey('weather') as NSString;
      foundConditions.Observation.WindDirection := currentObservation.valueForKey('wind_dir') as NSString;

      foundConditions.Observation.Temperature := currentObservation.valueForKey('temp_c') as NSInteger;
      foundConditions.Observation.WindDegress := currentObservation.valueForKey('wind_degrees') as NSInteger;
      foundConditions.Observation.WindSpeed := Convert.ToInt32(currentObservation.valueForKey('wind_mph') as NSInteger * WeatherConstants.knotsPerMph);

      foundConditions.Observation.WindSpeedGusting :=  Convert.ToInt32(AsInteger(currentObservation.valueForKey('wind_gust_mph')) * WeatherConstants.knotsPerMph);

      fillWindAsString(foundConditions);

    end;

    method populateConditions(foundConditions:Conditions) fromString(someString:String);
    begin
      var serializer := new JsonDeserializer(someString);
      var node := serializer.Deserialize;

      var currentObservation := node.Item['current_observation'] as JsonObject;

      foundConditions.Observation.Weather := (currentObservation.Item['weather'] as JsonStringValue).StringValue;
      foundConditions.Observation.WindDirection := (currentObservation.Item['wind_dir'] as JsonStringValue).StringValue;
      foundConditions.Observation.Temperature := (currentObservation.Item['temp_c'] as JsonIntegerValue).IntegerValue;
      foundConditions.Observation.WindDegress := (currentObservation.Item['wind_degrees'] as JsonIntegerValue).IntegerValue;
      foundConditions.Observation.WindSpeed := Convert.ToInt32((currentObservation.Item['wind_mph'] as JsonIntegerValue).IntegerValue * WeatherConstants.knotsPerMph);

      var value := AsInteger('wind_gust_mph') fromJsonObject(currentObservation);

      foundConditions.Observation.WindSpeedGusting :=  Convert.ToInt32(value * WeatherConstants.knotsPerMph);

      fillWindAsString(foundConditions);
    end;

    method fillWindAsString(foundConditions:Conditions);
    begin
      if(foundConditions.Observation.WindSpeedGusting > 0) then
      begin
        foundConditions.Observation.WindAsString := NSString.stringWithFormat('From the %@ at %d Gusting to %d Knots',
          foundConditions.Observation.WindDirection,foundConditions.Observation.WindSpeed,foundConditions.Observation.WindSpeedGusting);
        foundConditions.Observation.ShortWindAsString := NSString.stringWithFormat('%@ %d Gusting %d Knts',
          foundConditions.Observation.WindDirection,foundConditions.Observation.WindSpeed,foundConditions.Observation.WindSpeedGusting);

      end
      else
      begin
        foundConditions.Observation.WindAsString := NSString.stringWithFormat('From the %@ at %d Knots',
          foundConditions.Observation.WindDirection,foundConditions.Observation.WindSpeed);
        foundConditions.Observation.ShortWindAsString := NSString.stringWithFormat('%@ %d Knts',
          foundConditions.Observation.WindDirection,foundConditions.Observation.WindSpeed);
      end;

    end;

    method conditionsForName(name:String):Conditions;
    begin
      var foundConditions := new Conditions;

      /*
      var apiUrl := NSString.stringWithFormat('https://api.wunderground.com/api/%@/conditions/q/%@.json',_apiKey,name);
      var aUrl := Url.UrlWithString(apiUrl);
      var aRequest := new HttpRequest(aUrl);
      var response := Http.GetString(nil, aRequest);
      */

      var response := _proxy.conditionsForName(name);

      populateConditions(foundConditions) fromDictionary(response);

      exit foundConditions;
    end;

    method AsInteger(obj:NSObject):NSInteger;
    begin

      if(obj is NSInteger)then
      begin
        exit obj as NSInteger;
      end;
      exit Convert.ToInt32(obj as NSInteger);

    end;

    method AsInteger(elementName:String) fromJsonObject(parentObj:JsonObject):Integer;
    begin
      var obj := parentObj.Item[elementName];

      if (obj is JsonIntegerValue) then
      begin
        exit (obj as JsonIntegerValue).IntegerValue;
      end;

      exit Convert.ToInt32((obj as JsonStringValue).StringValue);

    end;


    method geoLookup(currentLocation:CLLocationCoordinate2D):Location;
    begin

      var foundLocation := new Location;

      var apiUrl := NSString.stringWithFormat('https://api.wunderground.com/api/%@/geolookup/q/%.04f,%.04f.json',_apiKey,
        currentLocation.latitude,currentLocation.longitude);

      var aUrl := Url.UrlWithString(apiUrl);
      var aRequest := new HttpRequest(aUrl);
      var response := Http.GetString(nil, aRequest);
      var serializer := new JsonDeserializer(response);
      var node := serializer.Deserialize;

      var stations := node.Item['location'].Item['nearby_weather_stations'] as JsonObject;

      var airports := stations.Item['airport'];

      if(assigned(airports))then
      begin
        var airPortstations := airports.Item['station'] as JsonArray;
        if(assigned(airPortstations))then
        begin
          for each airportStation in airPortstations do
          begin
            var airport := new AirportStation;
            airport.City := (airportStation.Item['city'] as JsonStringValue).StringValue;
            airport.ICAO := (airportStation.Item['icao'] as JsonStringValue).StringValue;
            foundLocation.NearbyWeatherStations.add(airport);
          end;
        end;
      end;

      var personals := stations.Item['pws'];

      if(assigned(personals))then
      begin
        var personalStations := personals.Item['station'] as JsonArray;
        if(assigned(personalStations))then
        begin
          for each personalStation in personalStations do
          begin
            var personal := new PersonalStation;
            personal.City := (personalStation.Item['city'] as JsonStringValue).StringValue;
            personal.Id := (personalStation.Item['id'] as JsonStringValue).StringValue;
            personal.Neighborhood := (personalStation.Item['neighborhood'] as JsonStringValue).StringValue;

            foundLocation.NearbyWeatherStations.add(personal);
          end;
        end;
      end;

      exit foundLocation;


    end;
  end;

end.
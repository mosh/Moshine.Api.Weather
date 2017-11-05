namespace Moshine.Api.Weather;

uses
  CoreLocation,
  Foundation,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.WeatherUnderground;

type

  WeatherUndergroundApi = public class
  private
    _apiKey:String;
  protected
  public
    constructor(apiKey:String);
    begin
      _apiKey := apiKey;
    end;

    method conditionsForName(name:String):Conditions;
    begin
      var foundConditions := new Conditions;
      var apiUrl := NSString.stringWithFormat('https://api.wunderground.com/api/%@/conditions/q/%@.json',_apiKey,name);

      var aUrl := URL.UrlWithString(apiUrl);
      var aRequest := new HttpRequest(aUrl);
      var response := Http.GetString(nil, aRequest);
      var serializer := new JsonDeserializer(response);
      var node := serializer.Deserialize;

      var currentObservation := node.Item['current_observation'] as JsonObject;


      foundConditions.Observation.Weather := (currentObservation.Item['weather'] as JsonStringValue).StringValue;
      foundConditions.Observation.WindDirection := (currentObservation.Item['wind_dir'] as JsonStringValue).StringValue;
      foundConditions.Observation.Temperature := (currentObservation.Item['temp_c'] as JsonIntegerValue).IntegerValue;
      foundConditions.Observation.WindDegress := (currentObservation.Item['wind_degrees'] as JsonIntegerValue).IntegerValue;
      foundConditions.Observation.WindSpeed := Convert.ToInt32((currentObservation.Item['wind_mph'] as JsonIntegerValue).IntegerValue * WeatherConstants.knotsPerMph);
      foundConditions.Observation.WindSpeedGusting := Convert.ToInt32(Convert.ToInt32((currentObservation.Item['wind_gust_mph'] as JsonStringValue).StringValue) * WeatherConstants.knotsPerMph);

      if(foundConditions.Observation.WindSpeedGusting > 0) then
      begin
        foundConditions.Observation.WindAsString := NSString.stringWithFormat('From the %@ at %d Gusting to %d Knots',
        foundConditions.Observation.WindDirection,foundConditions.Observation.WindSpeed,foundConditions.Observation.WindSpeedGusting);

      end
      else
      begin
        foundConditions.Observation.WindAsString := NSString.stringWithFormat('From the %@ at %d Knots',foundConditions.Observation.WindDirection,foundConditions.Observation.WindSpeed);
      end;



      exit foundConditions;
    end;


    method geoLookup(currentLocation:CLLocationCoordinate2D):Location;
    begin

      var foundLocation := new Location;

      var apiUrl := NSString.stringWithFormat('https://api.wunderground.com/api/%@/geolookup/q/%.04f,%.04f.json',_apiKey,
        currentLocation.latitude,currentLocation.longitude);

      var aUrl := URL.UrlWithString(apiUrl);
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
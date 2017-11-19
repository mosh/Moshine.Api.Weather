namespace Moshine.Api.Weather;

uses
  Foundation,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.WeatherUnderground, RemObjects.Elements.RTL;

type

  WeatherPopulator = public class
  private
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

  public

    method populateConditions(foundConditions:Conditions) fromDictionary(someDictionary:NSDictionary);
    begin
      var currentObservation := someDictionary.valueForKey('current_observation');
      foundConditions.Observation.Weather := currentObservation.valueForKey('weather') as NSString;
      foundConditions.Observation.WindDirection := currentObservation.valueForKey('wind_dir') as NSString;

      foundConditions.Observation.Temperature := currentObservation.valueForKey('temp_c') as NSInteger;
      foundConditions.Observation.WindDegress := currentObservation.valueForKey('wind_degrees') as NSInteger;
      foundConditions.Observation.WindSpeed := Convert.ToInt32(currentObservation.valueForKey('wind_mph') as NSInteger * WeatherConstants.knotsPerMph);

      foundConditions.Observation.WindSpeedGusting :=  Convert.ToInt32(AsInteger(currentObservation.valueForKey('wind_gust_mph')) * WeatherConstants.knotsPerMph);

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

    end;


    method populateLocation(foundLocation:Location) fromString(someString:String);
    begin
      var serializer := new JsonDeserializer(someString);
      var node := serializer.Deserialize;


      var location := node.Item['location'];

      foundLocation.Type := (location.Item['type'] as JsonStringValue).StringValue;
      foundLocation.Country := (location.Item['country'] as JsonStringValue).StringValue;
      foundLocation.CountryIso3166 := (location.Item['country_iso3166'] as JsonStringValue).StringValue;
      foundLocation.State := (location.Item['state'] as JsonStringValue).StringValue;
      foundLocation.City := (location.Item['city'] as JsonStringValue).StringValue;
      foundLocation.TimeZoneShort := (location.Item['tz_short'] as JsonStringValue).StringValue;
      foundLocation.TimeZoneLong := (location.Item['tz_long'] as JsonStringValue).StringValue;
      foundLocation.Latitude := Convert.ToDoubleInvariant((location.Item['lat'] as JsonStringValue).StringValue);
      foundLocation.Longitude := Convert.ToDoubleInvariant((location.Item['lon'] as JsonStringValue).StringValue);
      foundLocation.Zip := (location.Item['zip'] as JsonStringValue).StringValue;
      foundLocation.Magic := (location.Item['magic'] as JsonStringValue).StringValue;
      foundLocation.wmo := (location.Item['wmo'] as JsonStringValue).StringValue;

      var stations := location.Item['nearby_weather_stations'] as JsonObject;

      var airports := stations.Item['airport'];

      if(assigned(airports))then
      begin
        var airPortstations := airports.Item['station'] as JsonArray;
        if(assigned(airPortstations))then
        begin
          for each airportStation in airPortstations do
          begin
            if((airportStation.Item['city'] as JsonStringValue).StringValue.Length>0)then
            begin
              var airport := new AirportStation;
              airport.City := (airportStation.Item['city'] as JsonStringValue).StringValue;
              airport.ICAO := (airportStation.Item['icao'] as JsonStringValue).StringValue;
              airport.State := (airportStation.Item['state'] as JsonStringValue).StringValue;
              airport.Country := (airportStation.Item['country'] as JsonStringValue).StringValue;
              airport.Latitude := Convert.ToDoubleInvariant((airportStation.Item['lat'] as JsonStringValue).StringValue);
              airport.Longitude := Convert.ToDoubleInvariant((airportStation.Item['lon'] as JsonStringValue).StringValue);

              foundLocation.NearbyWeatherStations.add(airport);
            end;
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
            if((personalStation.Item['city'] as JsonStringValue).StringValue.Length>0)then
            begin
              var personal := new PersonalStation;
              personal.City := (personalStation.Item['city'] as JsonStringValue).StringValue;
              personal.Id := (personalStation.Item['id'] as JsonStringValue).StringValue;
              personal.Neighborhood := (personalStation.Item['neighborhood'] as JsonStringValue).StringValue;
              personal.State := (personalStation.Item['state'] as JsonStringValue).StringValue;
              personal.Country := (personalStation.Item['country'] as JsonStringValue).StringValue;
              personal.Latitude := Convert.ToDoubleInvariant((personalStation.Item['lat'] as JsonStringValue).StringValue);
              personal.Longitude := Convert.ToDoubleInvariant((personalStation.Item['lon'] as JsonStringValue).StringValue);
              personal.DistanceKm := (personalStation.Item['distance_km'] as JsonIntegerValue).IntegerValue;
              personal.DistanceMiles := (personalStation.Item['distance_mi'] as JsonIntegerValue).IntegerValue;

              foundLocation.NearbyWeatherStations.add(personal);
            end;
          end;
        end;
      end;


    end;
  end;

end.
namespace Moshine.Api.Weather;

uses
  Foundation,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.WeatherUnderground, RemObjects.Elements.RTL;

type

  WeatherPopulator = public class
  private

    method AsDouble(obj:NSObject):Double;
    begin
      if(obj is Double)then
      begin
        exit obj as Double;
      end;

      var value := Convert.TryToDoubleInvariant((obj as String).Trim);
      exit iif(assigned(value), value,0);

    end;

    method AsInteger(obj:NSObject):NSInteger;
    begin

      if(obj is NSInteger)then
      begin
        exit obj as NSInteger;
      end;
      exit Convert.ToInt32(obj as NSString);

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

    method AsDouble(elementName:String) fromJsonObject(parentObj:JsonObject):Double;
    begin
      var obj := parentObj.Item[elementName];

      if (obj is JsonStringValue) then
      begin
        var value := Convert.TryToDoubleInvariant((obj as JsonStringValue).StringValue.Trim);
        exit iif(assigned(value), value,0);
      end;
      exit (obj as JsonFloatValue).Value;
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

      foundConditions.Observation.WindSpeedGusting :=  Convert.ToInt32(AsDouble(currentObservation.valueForKey('wind_gust_mph')) * WeatherConstants.knotsPerMph);

      foundConditions.Observation.StationId := currentObservation.valueForKey('station_id');
      foundConditions.Observation.ObservationTimeRfc822 := currentObservation.valueForKey('observation_time_rfc822');
      foundConditions.Observation.ObservationEpoch := AsDouble(currentObservation.valueForKey('observation_epoch'));
      foundConditions.Observation.LocalEpoch := AsDouble(currentObservation.valueForKey('local_epoch'));
      foundConditions.Observation.LocalTimeZoneShort := currentObservation.valueForKey('local_tz_short');
      foundConditions.Observation.LocalTimeZoneLong := currentObservation.valueForKey('local_tz_long');
      foundConditions.Observation.LocalTimeZoneOffset := AsDouble(currentObservation.valueForKey('local_tz_offset'));
      foundConditions.Observation.TemperatureF := AsDouble(currentObservation.valueForKey('temp_f'));
      foundConditions.Observation.TemperatureC := AsDouble(currentObservation.valueForKey('temp_c'));
      foundConditions.Observation.RelativeHumidity := currentObservation.valueForKey('relative_humidity');
      foundConditions.Observation.PressureMb := AsInteger(currentObservation.valueForKey('pressure_mb'));
      foundConditions.Observation.PressureIn := AsDouble(currentObservation.valueForKey('pressure_in'));
      foundConditions.Observation.PressureTrend := currentObservation.valueForKey('pressure_trend');
      foundConditions.Observation.DewpointString := currentObservation.valueForKey('dewpoint_string');
      foundConditions.Observation.DewpointF := AsDouble(currentObservation.valueForKey('dewpoint_f'));
      foundConditions.Observation.DewpointC := AsDouble(currentObservation.valueForKey('dewpoint_c'));
      foundConditions.Observation.HeatIndexString := currentObservation.valueForKey('observation_time_rfc822');
      foundConditions.Observation.HeatIndexF := AsDouble(currentObservation.valueForKey('heat_index_f'));
      foundConditions.Observation.HeatIndexC := AsDouble(currentObservation.valueForKey('heat_index_c'));
      foundConditions.Observation.WindChillString := currentObservation.valueForKey('heat_index_string');
      foundConditions.Observation.VisibilityM := AsDouble(currentObservation.valueForKey('visibility_mi'));
      foundConditions.Observation.VisibityKm := AsDouble(currentObservation.valueForKey('visibility_km'));
      foundConditions.Observation.Precipitation1hrString := currentObservation.valueForKey('precip_1hr_string');
      foundConditions.Observation.Precipitation1hrInch := AsDouble(currentObservation.valueForKey('precip_1hr_in'));
      foundConditions.Observation.Precipitation1hrMetric := AsDouble(currentObservation.valueForKey('precip_1hr_metric'));
      foundConditions.Observation.PrecipitationTodayString := currentObservation.valueForKey('precip_today_string');
      foundConditions.Observation.PrecipitationTodayInch := AsDouble(currentObservation.valueForKey('precip_today_in'));
      foundConditions.Observation.PrecipitationTodayMetric := AsDouble(currentObservation.valueForKey('precip_today_metric'));

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


      var location := node.Item['location'] as JsonObject;

      foundLocation.Type := (location.Item['type'] as JsonStringValue).StringValue;
      foundLocation.Country := (location.Item['country'] as JsonStringValue).StringValue;
      foundLocation.CountryIso3166 := (location.Item['country_iso3166'] as JsonStringValue).StringValue;
      foundLocation.State := (location.Item['state'] as JsonStringValue).StringValue;
      foundLocation.City := (location.Item['city'] as JsonStringValue).StringValue;
      foundLocation.TimeZoneShort := (location.Item['tz_short'] as JsonStringValue).StringValue;
      foundLocation.TimeZoneLong := (location.Item['tz_long'] as JsonStringValue).StringValue;
      foundLocation.Latitude := AsDouble('lat') fromJsonObject(location);
      foundLocation.Longitude := AsDouble('lon') fromJsonObject(location);
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
              airport.Latitude := AsDouble('lat') fromJsonObject(location);
              airport.Longitude := AsDouble('lon') fromJsonObject(location);

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
          for each personalStation:JsonObject in personalStations do
          begin
            if((personalStation.Item['city'] as JsonStringValue).StringValue.Length>0)then
            begin
              var personal := new PersonalStation;
              personal.City := (personalStation.Item['city'] as JsonStringValue).StringValue;
              personal.Id := (personalStation.Item['id'] as JsonStringValue).StringValue;
              personal.Neighborhood := (personalStation.Item['neighborhood'] as JsonStringValue).StringValue;
              personal.State := (personalStation.Item['state'] as JsonStringValue).StringValue;
              personal.Country := (personalStation.Item['country'] as JsonStringValue).StringValue;
              personal.Latitude := AsDouble('lat') fromJsonObject(personalStation);
              personal.Longitude := AsDouble('lon') fromJsonObject(personalStation);
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
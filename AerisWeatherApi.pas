namespace Moshine.Api.Weather;

uses
  RemObjects.Elements.RTL,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.Aeris,
  Moshine.Api.Weather.Proxies;

type

  AerisWeatherApi = public class(IWeatherApi)
  private
    property Proxy:AerisProxy;

  public
    constructor(clientIdValue:String; clientSecretValue:String);
    begin
      Proxy := new AerisProxy(clientIdValue, clientSecretValue);
    end;

    method GetCurrentConditions(location:LocationCoordinate2D):ICurrentConditions;
    begin

    end;

    method GetForecast(forecastLocation:LocationCoordinate2D):IForecast;
    begin
      var newForecast := new Forecast;
      var values := Proxy.Forecast(forecastLocation);
      if(not assigned(values))then
      begin
        exit nil;
      end;

      var value := values['success'];

      if((assigned(value)) and (Boolean(value)))then
      begin
        /*
        var response:Array of PlatformImmutableDictionary<String,Object> := values['response'];

        newForecast.Interval := response[0]['interval'];
        var profile:PlatformImmutableDictionary<String,Object> := response[0]['profile'];

        newForecast.Profile.TimeZone := profile['tz'];
        newForecast.Profile.ElevationFeet := profile['elevFT'];
        newForecast.Profile.ElevationMeters := profile['elevM'];

        var location:PlatformImmutableDictionary<String,Object> := response[0]['loc'];

        newForecast.Location.Longitude := location['long'];
        newForecast.Location.Lattitude := location['lat'];

        var periods:array of PlatformImmutableDictionary<String,Object> := response[0]['periods'];

        for each period in periods do
        begin
          var newPeriod := new Period;
          newPeriod.Weather := period['weather'];

          newPeriod.MaxTemperatureCentigrade := period['maxTempC'];
          newPeriod.MinTemperatureCentigrade := period['minTempC'];
          newPeriod.AverageTemperatureCentigrade := period['avgTempC'];
          newPeriod.WindDirection := period['windDir'];
          newPeriod.WindGusts := period['windGustsKTS'];
          newPeriod.WindSpeed := period['windSpeedKTS'];

          newForecast.Periods.Add(newPeriod);
        end;
        */

      end;
      exit newForecast;
    end;

  end;
end.
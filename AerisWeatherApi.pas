namespace Moshine.Api.Weather;

uses
  Foundation,
  RemObjects.Elements.RTL,
  CoreLocation,
  Moshine.Api.Weather.Models.Aeris;

type

  AerisWeatherApi = public class
  private
    property Proxy:AerisProxy;

  public
    constructor(clientIdValue:String; clientSecretValue:String);
    begin
      Proxy := new AerisProxy(clientIdValue, clientSecretValue);
    end;

    method Forecast(forecastLocation:CLLocationCoordinate2D):Forecast;
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
        var response:NSArray<NSDictionary> := values['response'];

        newForecast.Interval := response[0]['interval'];
        var profile:NSDictionary := response[0]['profile'];

        newForecast.Profile.TimeZone := profile['tz'];
        newForecast.Profile.ElevationFeet := profile['elevFT'];
        newForecast.Profile.ElevationMeters := profile['elevM'];

        var location:NSDictionary := response[0]['loc'];

        newForecast.Location.Longitude := location['long'];
        newForecast.Location.Lattitude := location['lat'];

        var periods:NSArray<NSDictionary> := response[0]['periods'];

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

      end;
      exit newForecast;
    end;

  end;
end.
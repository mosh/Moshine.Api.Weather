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

    method Forecast(location:CLLocationCoordinate2D):Forecast;
    begin
      var newForecast := new Forecast;
      var values := Proxy.Forecast(location);
      if(not assigned(values))then
      begin
        exit nil;
      end;

      var value := values['success'];

      if((assigned(value)) and (Boolean(value)))then
      begin
        var response:NSArray<NSDictionary> := values['response'];

        var profile:NSDictionary := response[0]['profile'];

        newForecast.Profile.TimeZone := profile['tz'];
        newForecast.Profile.ElevationFeet := profile['elevFT'];
        newForecast.Profile.ElevationMeters := profile['elevM'];

      end;
      exit newForecast;
    end;

  end;
end.
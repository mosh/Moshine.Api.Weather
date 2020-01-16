namespace Moshine.Api.Weather;

uses
  CoreLocation,
  Moshine.Api.Weather.Proxies, Moshine.Api.Weather.Models.WorldWeatherOnline;

type
  WorldWeatherOnlineApi = public class
  private
    property proxy:WorldWeatherOnlineProxy;
  protected
  public
    constructor(apiKey:String);
    begin
      proxy := new WorldWeatherOnlineProxy(apiKey);
    end;

    method Forecast(forecastLocation:CLLocationCoordinate2D):MarineWeather;
    begin

      var weather := new MarineWeather;

      exit weather;

    end;
  end;

end.
namespace Moshine.Api.Weather;

uses
  Moshine.Api.Weather.Proxies,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.WorldWeatherOnline, RemObjects.Elements.RTL;

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

    method Forecast(forecastLocation:LocationCoordinate2D):MarineWeather;
    begin
      exit proxy.GetMarineForecast(forecastLocation);
    end;
  end;

end.
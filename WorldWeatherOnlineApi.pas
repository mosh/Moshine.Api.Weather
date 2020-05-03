namespace Moshine.Api.Weather;

uses
  Moshine.Api.Weather.Proxies,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.WorldWeatherOnline, RemObjects.Elements.RTL;

type

  WorldWeatherOnlineApi = public class(IWeatherApi)
  private
    property proxy:WorldWeatherOnlineProxy;
  protected
  public
    constructor(apiKey:String);
    begin
      proxy := new WorldWeatherOnlineProxy(apiKey);
    end;

    method GetForecast(forecastLocation:LocationCoordinate2D):IForecast;
    begin
      exit proxy.GetMarineForecast(forecastLocation);
    end;

    method GetCurrentConditions(location:LocationCoordinate2D):ICurrentConditions;
    begin

    end;

  end;

end.
namespace Moshine.Api.Weather;

uses
  Moshine.Api.Location.Models,
  Moshine.Api.Weather.Proxies,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.WorldWeatherOnline, RemObjects.Elements.RTL;

type

  WorldWeatherOnlineApi = public class(ProxyBase)
  private
    property proxy:WorldWeatherOnlineProxy;
  protected
  public
    constructor(apiKey:String);
    begin
      proxy := new WorldWeatherOnlineProxy(apiKey);
    end;

    method GetForecast(forecastLocation:LocationCoordinate2D):IForecast; override;
    begin
      exit proxy.GetMarineForecast(forecastLocation);
    end;

    method GetCurrentConditions(location:LocationCoordinate2D):ICurrentConditions; override;
    begin

    end;

  end;

end.
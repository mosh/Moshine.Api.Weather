namespace Moshine.Api.Weather;

uses
  Moshine.Api.Location.Models,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.StormGlass, Moshine.Api.Weather.Proxies;

/*
type

  StormGlassApi = public class(WeatherApiBase)
  private
    proxy:StormGlassProxy;
  public

    constructor(apiKey:String);
    begin
      proxy := new StormGlassProxy(Formatter, apiKey);
    end;

    method GetForecast(location:LocationCoordinate2D):IForecast; override;
    begin
      exit proxy.GetForecast(location);
    end;

    method GetCurrentConditions(location:LocationCoordinate2D):ICurrentConditions; override;
    begin
      exit proxy.GetCurrentConditions(location);
    end;

  end;
*/
end.
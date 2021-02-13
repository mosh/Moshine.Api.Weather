namespace Moshine.Api.Weather;

uses
  Moshine.Api.Location.Models,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.StormGlass, Moshine.Api.Weather.Proxies;

type
  StormGlassApi = public class(IWeatherApi)
  private
    proxy:StormGlassProxy;
  public
    constructor(apiKey:String);
    begin
      proxy := new StormGlassProxy(apiKey);
    end;

    method GetForecast(location:LocationCoordinate2D):IForecast;
    begin
      exit proxy.GetForecast(location);
    end;

    method GetCurrentConditions(location:LocationCoordinate2D):ICurrentConditions;
    begin
      exit proxy.GetCurrentConditions(location);
    end;

  end;
end.
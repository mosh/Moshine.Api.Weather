namespace Moshine.Api.Weather;

uses
  Moshine.Api.Location.Models,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.StormGlass,
  Moshine.Api.Weather.Proxies,
  RemObjects.Elements.RTL;

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

    method GetForecast(location:LocationCoordinate2D; startTime:DateTime; endTime:DateTime):IForecast;
    begin
      exit proxy.GetForecast(location, startTime, endTime);
    end;


    method GetCurrentConditions(location:LocationCoordinate2D):ICurrentConditions; override;
    begin
      exit proxy.GetCurrentConditions(location);
    end;

    method GetCompleteCurrentConditions(location:LocationCoordinate2D):ICurrentConditions;
    begin
      exit proxy.GetCompleteCurrentConditions(location);
    end;


  end;
end.
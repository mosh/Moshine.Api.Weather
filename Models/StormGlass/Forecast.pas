namespace Moshine.Api.Weather.Models.StormGlass;

uses
  Moshine.Api.Weather.Models,
  RemObjects.Elements.RTL;

type

  Forecast = public class(IForecast)
  public
    property Hours:List<Hour>;
    property Meta:Meta;

  end;
end.
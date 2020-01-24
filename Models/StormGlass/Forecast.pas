namespace Moshine.Api.Weather.Models.StormGlass;

uses
  RemObjects.Elements.RTL;

type

  Forecast = public class
  public
    property Hours:List<Hour>;
    property Meta:Meta;
  end;
end.
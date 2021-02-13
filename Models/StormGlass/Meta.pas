namespace Moshine.Api.Weather.Models.StormGlass;

uses
  Moshine.Api.Location.Models,
  Moshine.Api.Weather.Models, RemObjects.Elements.RTL;

type
  Meta = public class
  public
    property Cost:Integer;
    property dailyQuota:Integer;
    property &End:DateTime;
    property Location:LocationCoordinate2D;
    property &params:List<String>;
  end;
end.
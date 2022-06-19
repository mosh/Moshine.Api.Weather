namespace Moshine.Api.Weather.Models.StormGlass;

uses
  Moshine.Api.Weather.Models, RemObjects.Elements.RTL;

type

  Tides = public class(ITides)
  private
  protected
  public
    property Tides:List<Tide> := new List<Tide>;
    property Station:Station := new Station;
    property Datum:String;
    property Start:DateTime;
    property &End:DateTime;
    property Latitude:Double;
    property Longitude:Double;

  end;

end.
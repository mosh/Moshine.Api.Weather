namespace Moshine.Api.Weather.Models;

uses
  RemObjects.Elements.RTL;

type
  ITides = public interface
  public
    property Tides:List<Tide>;
    property Station:Station;
  end;

end.
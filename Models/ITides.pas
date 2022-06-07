namespace Moshine.Api.Weather.Models;

type
  ITides = public interface
  public
    property Tides:List<Tide>;
    property Station:Station;
  end;

end.
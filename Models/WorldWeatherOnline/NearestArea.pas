namespace Moshine.Api.Weather.Models.WorldWeatherOnline;

uses
  Moshine.Api.Weather.Models;

type
  NearestArea = public class
  public
    property Location:LocationCoordinate2D;
    property DistanceMiles:Single;
  end;
end.
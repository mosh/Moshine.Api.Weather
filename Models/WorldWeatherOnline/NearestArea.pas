namespace Moshine.Api.Weather.Models.WorldWeatherOnline;

type
  NearestArea = public class
  public
    property Location:LocationCoordinate2D;
    property DistanceMiles:Single;
  end;
end.
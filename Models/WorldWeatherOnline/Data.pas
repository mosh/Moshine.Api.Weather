namespace Moshine.Api.Weather.Models.WorldWeatherOnline;

uses
  RemObjects.Elements.RTL;

type
  Data = public class
  public
    var request: List<Request>;
    var weather: List<Weather>;
    var nearest_area: List<NearestArea>;
  end;

end.
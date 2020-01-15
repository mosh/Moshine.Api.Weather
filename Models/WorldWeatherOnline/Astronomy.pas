namespace Moshine.Api.Weather.Models.WorldWeatherOnline;

type
  Astronomy = public class
  public
    property sunrise: DateTime read  write ;
    property sunset: DateTime read  write ;
    property moonrise: DateTime read  write ;
    property moonset: DateTime read  write ;
  end;

end.
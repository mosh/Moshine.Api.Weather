namespace Moshine.Api.Weather.Models.WorldWeatherOnline;

type
  MarineWeatherInput = public class
  public
    property query: String read  write ;
    property format: String read  write ;
    property fx: String read  write ;
    property callback: String read  write ;
  end;

end.
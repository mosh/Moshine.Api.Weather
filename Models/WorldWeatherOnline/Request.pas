namespace Moshine.Api.Weather.Models.WorldWeatherOnline;

type
  Request = public class
  public
    property query: String read  write ;
    property &type: String read  write ;
  end;

end.
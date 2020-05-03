namespace Moshine.Api.Weather.Models.WorldWeatherOnline;

uses
  Moshine.Api.Weather.Models;

type
  MarineWeather = public class(IForecast)
  public
    var data: Data;

  end;

end.
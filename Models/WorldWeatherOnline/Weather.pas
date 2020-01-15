namespace Moshine.Api.Weather.Models.WorldWeatherOnline;

type
  Weather = public class
  public
    property date: DateTime read  write ;
    property astronomy: List<Astronomy> read  write ;
    property hourly: List<Hourly> read  write ;
    property maxtempC: Integer read  write ;
    property mintempC: Integer read  write ;
    property maxtempF: Integer read  write ;
    property mintempF: Integer read  write ;
  end;

end.
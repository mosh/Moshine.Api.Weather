namespace Moshine.Api.Weather.Models.StormGlass;

uses
  Moshine.Api.Weather.Models;

type
  CurrentConditions = public class(ICurrentConditions)
  public
    property WindSpeed:DoubleWeatherValue := new DoubleWeatherValue;
    property WindSpeedGusting:DoubleWeatherValue := new DoubleWeatherValue;
    property WindDirection:StringWeatherValue := new StringWeatherValue;
    property ShortWindAsString:StringWeatherValue := new StringWeatherValue;
    property Weather:StringWeatherValue := new StringWeatherValue;

  end;

end.
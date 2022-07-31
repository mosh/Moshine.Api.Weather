namespace Moshine.Api.Weather.Models.StormGlass;

uses
  Moshine.Api.Weather.Models;

type
  CurrentConditions = public class(ICurrentConditions)
  public
    property WindSpeed:AverageDoubleWeatherValue := new AverageDoubleWeatherValue;
    property WindSpeedGusting:AverageDoubleWeatherValue := new AverageDoubleWeatherValue;
    property WindDirection:StringWeatherValue := new StringWeatherValue;
    property ShortWindAsString:StringWeatherValue := new StringWeatherValue;
    property Weather:StringWeatherValue := new StringWeatherValue;

  end;

end.
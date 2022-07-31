namespace Moshine.Api.Weather.Models;

type
  ICurrentConditions = public interface

    property WindSpeed:AverageDoubleWeatherValue read;
    property WindSpeedGusting:AverageDoubleWeatherValue read;
    property WindDirection:StringWeatherValue read;
    property ShortWindAsString:StringWeatherValue read;
    property Weather:StringWeatherValue read;

  end;

end.
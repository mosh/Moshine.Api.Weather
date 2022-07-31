namespace Moshine.Api.Weather.Models;

type
  ICurrentConditions = public interface

    property WindSpeed:DoubleWeatherValue read;
    property WindSpeedGusting:DoubleWeatherValue read;
    property WindDirection:StringWeatherValue read;
    property ShortWindAsString:StringWeatherValue read;
    property Weather:StringWeatherValue read;

  end;

end.
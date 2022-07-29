namespace Moshine.Api.Weather.Models;

type

  ICompleteCurrentConditions = public interface(ICurrentConditions)
    property AirTemperature:DoubleWeatherValue read;
    property CloudCover:DoubleWeatherValue read;
    property Humidity:DoubleWeatherValue read;
    property IceCover:DoubleWeatherValue read;
    property Precipitation:DoubleWeatherValue read;
    property Pressure:DoubleWeatherValue read;
    property SecondarySwellDirection:DoubleWeatherValue read;
    property SecondarySwellHeight:DoubleWeatherValue read;
    property SecondarySwellPeriod:DoubleWeatherValue read;
    property SnowDepth:DoubleWeatherValue read;
    property SwellDirection:DoubleWeatherValue read;
    property SwellHeight:DoubleWeatherValue read;
    property SwellPeriod:DoubleWeatherValue read;
    property WaterTemperature:DoubleWeatherValue read;
    property WaveDirection:DoubleWeatherValue read;
    property WaveHeight:DoubleWeatherValue read;
    property WavePeriod:DoubleWeatherValue read;
    property WindWaveDirection:DoubleWeatherValue read;
    property WindWaveHeight:DoubleWeatherValue read;
    property WindWavePeriod:DoubleWeatherValue read;
  end;
end.
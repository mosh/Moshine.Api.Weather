namespace Moshine.Api.Weather.Models.StormGlass;

uses
  Moshine.Api.Weather.Models;

type
  CompleteCurrentConditions = public class(CurrentConditions, ICompleteCurrentConditions)
  public
    property AirTemperature:DoubleWeatherValue := new DoubleWeatherValue;
    property CloudCover:DoubleWeatherValue := new DoubleWeatherValue;
    property Humidity:DoubleWeatherValue := new DoubleWeatherValue;
    property IceCover:DoubleWeatherValue := new DoubleWeatherValue;
    property Precipitation:DoubleWeatherValue := new DoubleWeatherValue;
    property Pressure:DoubleWeatherValue := new DoubleWeatherValue;
    property SecondarySwellDirection:DoubleWeatherValue := new DoubleWeatherValue;
    property SecondarySwellHeight:DoubleWeatherValue := new DoubleWeatherValue;
    property SecondarySwellPeriod:DoubleWeatherValue := new DoubleWeatherValue;
    property SnowDepth:DoubleWeatherValue := new DoubleWeatherValue;
    property SwellDirection:DoubleWeatherValue := new DoubleWeatherValue;
    property SwellHeight:DoubleWeatherValue := new DoubleWeatherValue;
    property SwellPeriod:DoubleWeatherValue := new DoubleWeatherValue;
    property WaterTemperature:DoubleWeatherValue := new DoubleWeatherValue;
    property WaveDirection:DoubleWeatherValue := new DoubleWeatherValue;
    property WaveHeight:DoubleWeatherValue := new DoubleWeatherValue;
    property WavePeriod:DoubleWeatherValue := new DoubleWeatherValue;
    property WindWaveDirection:DoubleWeatherValue := new DoubleWeatherValue;
    property WindWaveHeight:DoubleWeatherValue := new DoubleWeatherValue;
    property WindWavePeriod:DoubleWeatherValue := new DoubleWeatherValue;

  end;
end.
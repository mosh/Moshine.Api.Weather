namespace Moshine.Api.Weather.Models;

type

  ICompleteCurrentConditions = public interface(ICurrentConditions)
    /// Degress Celsuis
    property AirTemperature:DoubleWeatherValue read;

    /// Total cloud coverage in percent
    property CloudCover:DoubleWeatherValue read;

    /// Relative humidity in percent
    property Humidity:DoubleWeatherValue read;

    /// Proportion, 0-1
    property IceCover:DoubleWeatherValue read;

    /// Mean precipitation in kg/m²/h = mm/h
    property Precipitation:DoubleWeatherValue read;

    /// Air pressure in hPa
    property Pressure:DoubleWeatherValue read;

    /// Direction of secondary swell waves. 0° indicates swell coming from north
    property SecondarySwellDirection:DoubleWeatherValue read;

    /// Height of secondary swell waves in meters
    property SecondarySwellHeight:DoubleWeatherValue read;

    /// Period of secondary swell waves in seconds
    property SecondarySwellPeriod:DoubleWeatherValue read;

    /// Depth of snow in meters
    property SnowDepth:DoubleWeatherValue read;

    /// Direction of swell waves. 0° indicates swell coming from north
    property SwellDirection:DoubleWeatherValue read;

    /// Height of swell waves in meters
    property SwellHeight:DoubleWeatherValue read;

    /// Period of swell waves in seconds
    property SwellPeriod:DoubleWeatherValue read;

    /// Water temperature in degrees celsius
    property WaterTemperature:DoubleWeatherValue read;

    /// Direction of combined wind and swell waves. 0° indicates waves coming from north
    property WaveDirection:DoubleWeatherValue read;

    /// Significant Height of combined wind and swell waves in meter
    property WaveHeight:DoubleWeatherValue read;

    /// Period of combined wind and swell waves in seconds
    property WavePeriod:DoubleWeatherValue read;

    /// Direction of wind waves. 0° indicates waves coming from north
    property WindWaveDirection:DoubleWeatherValue read;

    /// Height of wind waves in meters
    property WindWaveHeight:DoubleWeatherValue read;

    /// Period of wind waves in seconds
    property WindWavePeriod:DoubleWeatherValue read;

  end;
end.
namespace Moshine.Api.Weather.Models.WorldWeatherOnline;

uses
  RemObjects.Elements.RTL;

type
  Hourly = public class
  public
    property cloudcover: Integer read  write ;
    property humidity: Single read  write ;
    property pressure: Integer read  write ;
    property pressureInches:Integer;
    property sigHeight_m: Single read  write ;
    property swellDir: Single read  write ;
    property swellHeight_m: Single read  write ;
    property swellHeight_ft: Single read  write ;
    property swellPeriod_secs: Single read  write ;
    property tempC: Integer read  write ;
    property tempF: Integer read  write ;
    property time: Integer read  write ;
    property visibility: Integer read  write ;
    property waterTemp_C: Integer read  write ;
    property waterTemp_F: Integer read  write ;
    property windspeedMiles: Integer read  write ;
    property windspeedKmph: Integer read  write ;
    property winddirDegree: Integer read  write ;
    property winddir16Point: String read  write ;
    property weatherCode: String read  write ;
    property weatherDesc: List<WeatherDesc> read  write ;
    property weatherIconUrl: List<WeatherIconUrl> read  write ;
    property precipMM: Single read  write ;
    property precipInches:Integer;
    property visibilityMiles:Integer;
    property HeatIndexC:Integer;
    property DewpointC:Integer;
    property HeatIndexF:Integer;
    property WindChillC:Integer;
    property WindChillF:Integer;
    property WindGustMiles:Integer;
    property WindGustKmph:Integer;
    property FeelsLikeC:Integer;
    property FeelsLikeF:Integer;
    property swellDir16Point:String;

  end;

end.
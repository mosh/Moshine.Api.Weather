namespace Moshine.Api.Weather.Models.DarkSky;

uses
  Moshine.Api.Weather.Models;

type

  ForecastMoment = public class
  public
    property Temperature:Double;
    property ApparentTemperature:Double;
    property Humidity:Double;
    property WindSpeed:Double;
    property WindBearing:Integer;
    property CloudCover:Double;
    property Pressure:Double;
  end;

  Forecast = public class(IForecast)
  private
    _currently:ForecastMoment := new ForecastMoment;
  public
    property Latitude:Double;
    property Longitude:Double;
    property TimeZone:String;

    property Currently:ForecastMoment read _currently;

/*
    "currently": {
                "time": 1453402675,
                "summary": "Rain",
                "icon": "rain",
                "nearestStormDistance": 0,
                "precipIntensity": 0.1685,
                "precipIntensityError": 0.0067,
                "precipProbability": 1,
                "precipType": "rain",
                "temperature": 48.71,
                "apparentTemperature": 46.93,
                "dewPoint": 47.7,
                "humidity": 0.96,
                "windSpeed": 4.64,
                "windBearing": 186,
                "visibility": 4.3,
                "cloudCover": 0.73,
                "pressure": 1009.7,
                "ozone": 328.35
              },
*/

  end;

end.
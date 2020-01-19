﻿namespace Moshine.Api.Weather;

uses
  Moshine.Api.Weather.Proxies,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.WorldWeatherOnline;

type
  WorldWeatherOnlineApi = public class
  private
    property proxy:WorldWeatherOnlineProxy;
  protected
  public
    constructor(apiKey:String);
    begin
      proxy := new WorldWeatherOnlineProxy(apiKey);
    end;

    method Forecast(forecastLocation:LocationCoordinate2D):MarineWeather;
    begin

      var weather := new MarineWeather;

      var response := proxy.GetMarineForecast(forecastLocation);

      exit weather;

    end;
  end;

end.
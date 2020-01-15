namespace Moshine.Api.Weather.Proxies;

uses
  CoreLocation;

type
  WorldWeatherOnlineProxy = public class
  private
    property ApiKey:String;
  public
    constructor(apiKeyValue:String);
    begin
      ApiKey := apiKeyValue;
    end;

    method GetMarineForecast(forecastLocation:CLLocationCoordinate2D):MarineWeather;
    begin
      var url := $'https://api.worldweatheronline.com/premium/v1/marine.ashx?key={ApiKey}&q={forecastLocation.latitude}, {forecastLocation.latitude}&format=json&includelocation=yes&tide=yes';

    end;
  end;

end.
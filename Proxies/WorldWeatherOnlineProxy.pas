namespace Moshine.Api.Weather.Proxies;

uses
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.WorldWeatherOnline,
  RemObjects.Elements.RTL, Moshine.Foundation.Web;

type
  WorldWeatherOnlineProxy = public class(WebProxy)
  private
    property ApiKey:String;
  public
    constructor(apiKeyValue:String);
    begin
      ApiKey := apiKeyValue;
    end;

    method GetMarineForecast(forecastLocation:LocationCoordinate2D):Dictionary<String,Object>;
    begin
      var url := $'https://api.worldweatheronline.com/premium/v1/marine.ashx?key={ApiKey}&q={forecastLocation.Latitude}, {forecastLocation.Latitude}&format=json&includelocation=yes&tide=yes';

      exit WebRequest<Dictionary<String,Object>>('GET',url,false);

    end;
  end;

end.
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

    method GetMarineForecast(forecastLocation:LocationCoordinate2D):MarineWeather;
    begin
      var url := $'https://api.worldweatheronline.com/premium/v1/marine.ashx?key={ApiKey}&q={forecastLocation.Latitude},{forecastLocation.Latitude}&format=json&includelocation=yes&tide=yes';
      var stringResponse := WebRequestAsString('GET',url,nil,false);

      var weather := new MarineWeather;
      weather.data := new Data;

      var document := JsonDocument.FromString(stringResponse);

      var rootNode := document.Root;

      var dataNode := rootNode.Item['data'];

      var requestNode := dataNode.Item['request'] as JsonArray;

      weather.data.request := new List<Request>;

      for each requestItem in requestNode.Items do
      begin
        var newRequest := new Request;

        weather.data.request.Add(newRequest);

      end;

      var weatherNode := dataNode.Item['weather'] as JsonArray;

      weather.data.weather := new List<Weather>;

      for each weatherItem in weatherNode.Items do
      begin
        var newWeather := new Weather;

        newWeather.hourly := new List<Hourly>;

        for each hour in weatherItem.Item['hourly'] as JsonArray do
        begin
          var newHourly := new Hourly;

          newHourly.weatherIconUrl := new List<WeatherIconUrl>;
          newHourly.weatherDesc := new List<WeatherDesc>;

          for each iconUrl in hour.Item['weatherIconUrl'] as JsonArray do
          begin
            var newWeatherIconUrl := new WeatherIconUrl;
            newWeatherIconUrl.value := iconUrl['value'].StringValue;

            newHourly.weatherIconUrl.Add(newWeatherIconUrl);
          end;

          for each description in hour.Item['weatherDesc'] as JsonArray do
          begin
            var newWeatherDesc := new WeatherDesc;
            newWeatherDesc.value := description['value'].StringValue;

            newHourly.weatherDesc.Add(newWeatherDesc);
          end;

          newWeather.hourly.Add(newHourly);
        end;

        weather.data.weather.Add(newWeather);
      end;

      exit weather;
    end;
  end;

end.
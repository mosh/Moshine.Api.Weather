namespace Moshine.Api.Weather.Proxies;

uses
  Moshine.Api.Location.Models,
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
      var url := $'https://api.worldweatheronline.com/premium/v1/marine.ashx?key={ApiKey}&q={forecastLocation.latitude},{forecastLocation.latitude}&format=json&includelocation=yes&tide=yes';
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
        newRequest.type := requestItem['type'].StringValue;
        newRequest.query := requestItem['query'].StringValue;
        weather.data.request.Add(newRequest);
      end;

      weather.data.nearest_area := new List<NearestArea>;

      var nearest_areaNode := dataNode['nearest_area'] as JsonArray;

      for each nearestAreaItem in nearest_areaNode.Items do
      begin
        var newNearestArea := new NearestArea;
        newNearestArea.Location := new LocationCoordinate2D(
          Convert.ToDouble(nearestAreaItem['latitude'].StringValue, Locale.Current),
          Convert.ToDouble(nearestAreaItem['longitude'].StringValue, Locale.Current));
        newNearestArea.DistanceMiles := Convert.ToDouble(nearestAreaItem['distance_miles'].StringValue, Locale.Current);
        weather.data.nearest_area.Add(newNearestArea);

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

          newHourly.time := Convert.ToInt32(hour['time'].StringValue);

          newHourly.tempC := Convert.ToInt32(hour['tempC'].StringValue);
          newHourly.tempF := Convert.ToInt32(hour['tempF'].StringValue);
          newHourly.windspeedMiles := Convert.ToInt32(hour['windspeedMiles'].StringValue);
          newHourly.windspeedKmph := Convert.ToInt32(hour['windspeedKmph'].StringValue);
          newHourly.winddirDegree := Convert.ToInt32(hour['winddirDegree'].StringValue);
          newHourly.winddir16Point := hour['winddir16Point'].StringValue;
          newHourly.weatherCode := hour['weatherCode'].StringValue;


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

          newHourly.precipMM := Convert.ToDouble(hour['precipMM'].StringValue, Locale.Current);
          newHourly.precipInches := Convert.ToDouble(hour['precipInches'].StringValue, Locale.Current);
          newHourly.humidity := Convert.ToDouble(hour['humidity'].StringValue, Locale.Current);
          newHourly.visibility := Convert.ToInt32(hour['visibility'].StringValue);
          newHourly.visibilityMiles := Convert.ToInt32(hour['visibility'].StringValue);
          newHourly.pressure := Convert.ToInt32(hour['pressure'].StringValue);
          newHourly.pressureInches := Convert.ToInt32(hour['visibility'].StringValue);
          newHourly.cloudcover := Convert.ToInt32(hour['cloudcover'].StringValue);
          newHourly.HeatIndexC := Convert.ToInt32(hour['HeatIndexC'].StringValue);
          newHourly.HeatIndexF := Convert.ToInt32(hour['HeatIndexF'].StringValue);
          newHourly.DewpointC := Convert.ToInt32(hour['HeatIndexC'].StringValue);
          newHourly.HeatIndexF := Convert.ToInt32(hour['HeatIndexF'].StringValue);
          newHourly.WindChillC := Convert.ToInt32(hour['WindChillC'].StringValue);
          newHourly.WindChillF := Convert.ToInt32(hour['WindChillF'].StringValue);
          newHourly.WindGustMiles := Convert.ToInt32(hour['WindGustMiles'].StringValue);
          newHourly.WindGustKmph := Convert.ToInt32(hour['WindGustKmph'].StringValue);
          newHourly.FeelsLikeC := Convert.ToInt32(hour['FeelsLikeC'].StringValue);
          newHourly.FeelsLikeF := Convert.ToInt32(hour['FeelsLikeF'].StringValue);

          newHourly.sigHeight_m := Convert.ToDouble(hour['sigHeight_m'].StringValue, Locale.Current);
          newHourly.swellHeight_m := Convert.ToDouble(hour['swellHeight_m'].StringValue, Locale.Current);
          newHourly.swellHeight_ft := Convert.ToDouble(hour['swellHeight_ft'].StringValue, Locale.Current);
          newHourly.swellDir := Convert.ToDouble(hour['swellDir'].StringValue, Locale.Current);
          newHourly.swellDir16Point := hour['swellDir16Point'].StringValue;
          newHourly.swellPeriod_secs := Convert.ToDouble(hour['swellPeriod_secs'].StringValue, Locale.Current);
          newHourly.waterTemp_C := Convert.ToInt32(hour['waterTemp_C'].StringValue);
          newHourly.waterTemp_F := Convert.ToInt32(hour['waterTemp_F'].StringValue);


          newWeather.hourly.Add(newHourly);
        end;

        weather.data.weather.Add(newWeather);
      end;

      exit weather;
    end;
  end;

end.
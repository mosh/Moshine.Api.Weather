namespace Moshine.Api.Weather;

uses
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.DarkSky,
  RemObjects.Elements.RTL;

type

  DarkSkyApi = public class
  private
    _apiKey:String;

  public
    constructor(apiKey:String);
    begin
      _apiKey := apiKey;
    end;

    method GetForecast(location:LocationCoordinate2D):Forecast;
    begin
      var obj := new Forecast;

      var value := $'https://api.darksky.net/forecast/{_apiKey}/{location.Latitude},{location.Longitude}?units=uk2';

      // nearestStormDistance and visibility are in miles and windSpeed is in miles per hour
      // 1 mile per hour is 0.868976 knot

      var aUrl := Url.UrlWithString(value);

      var aRequest := new HttpRequest(aUrl);

      var response := Http.GetString(nil, aRequest);
      /*
      var serializer := new JsonDeserializer(response);

      var node := serializer.Deserialize;

      obj.Latitude := (node.Item['latitude'] as JsonFloatValue).FloatValue;
      obj.Longitude := (node.Item['longitude'] as JsonFloatValue).FloatValue;
      obj.TimeZone := (node.Item['timezone'] as JsonStringValue).StringValue;

      var currently:JsonObject := node.Item['currently'] as JsonObject;

      obj.Currently.Temperature := (currently.Item['temperature'] as JsonFloatValue).FloatValue;
      obj.Currently.ApparentTemperature := (currently.Item['apparentTemperature'] as JsonFloatValue).FloatValue;
      obj.Currently.Humidity := (currently.Item['humidity'] as JsonFloatValue).FloatValue;
      obj.Currently.WindSpeed := (currently.Item['windSpeed'] as JsonFloatValue).FloatValue * WeatherConstants.knotsPerMph;
      obj.Currently.WindBearing := (currently.Item['windBearing'] as JsonIntegerValue).IntegerValue;
      obj.Currently.CloudCover := (currently.Item['cloudCover'] as JsonFloatValue).FloatValue;
      obj.Currently.Pressure := (currently.Item['pressure'] as JsonFloatValue).FloatValue;
      */
      exit obj;

    end;


  end;

end.
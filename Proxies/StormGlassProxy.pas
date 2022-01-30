namespace Moshine.Api.Weather.Proxies;

uses
  Moshine.Api.Weather,
  Moshine.Api.Location.Models,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.StormGlass,
  Moshine.Foundation,
  Moshine.Foundation.Web, RemObjects.Elements.RTL;
type

  StormGlassProxy = public class(WebProxy)
  private

    property ApiKey:String;

    _formatter:WeatherApiFormatter;
  public

    constructor(formatter:WeatherApiFormatter; apiKeyValue:String);
    begin
      ApiKey := apiKeyValue;
      _formatter := formatter;

      self._requestBuilder := method (url: String; webMethod: String; addAuthentication: Boolean): Moshine.Foundation.Web.HttpRequest
        begin
          var request := new Moshine.Foundation.Web.HttpRequest(webMethod, url);
          request.AddHeader('Authorization',ApiKey);
          exit request;
        end

    end;

    method GetForecastForArea();
    begin
      var box := $'60,20:58,17';
      var url := $'https://api.stormglass.io/v1/weather/area?box=${box}';
    end;


    method GetCurrentConditions(location:LocationCoordinate2D):ICurrentConditions;
    begin

      var since := DateTime.TimeSinceEpoch;

      var url := $'https://api.stormglass.io/v2/weather/point?lat={location.latitude}&lng={location.longitude}&params=windDirection,gust,windSpeed&start={since}&end={since}';

      var stringValues := WebRequestAsString('GET', url, nil, true);

      var converter := new StormGlassConverter(_formatter);

      exit converter.ToCurrentConditions(stringValues);

    end;

    method GetForecast(location:LocationCoordinate2D):IForecast;
    begin
      var url := $'https://api.stormglass.io/v1/weather/point?lat={location.latitude}&lng={location.longitude}';

      var stringValues := WebRequestAsString('GET', url, nil, true);

      var converter := new StormGlassConverter(_formatter);

      exit converter.ToForecast(stringValues);

    end;

  end;
end.
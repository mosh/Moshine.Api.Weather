namespace Moshine.Api.Weather.Proxies;

uses
  Moshine.Api.Weather,
  Moshine.Api.Weather.Converters,
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
    _provider:StormGlassUrlProvider;
  public

    constructor(formatter:WeatherApiFormatter; apiKeyValue:String);
    begin
      ApiKey := apiKeyValue;
      _formatter := formatter;
      _provider := new StormGlassUrlProvider(ApiKey);

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

      var request := _provider.ForCurrentConditions(location);

      var stringValues := WebRequestAsString(request);

      var converter := new StormGlassConverter(_formatter);

      exit converter.ToCurrentConditions(stringValues);

    end;


    method GetForecast(location:LocationCoordinate2D; startTime:DateTime; endTime:DateTime):IForecast;
    begin
      var request := _provider.ForForecast(location, startTime, endTime);

      var stringValues := WebRequestAsString(request);

      var converter := new StormGlassConverter(_formatter);

      exit converter.ToForecast(stringValues);

    end;

    method GetForecast(location:LocationCoordinate2D):IForecast;
    begin

      var request := _provider.ForForecast(location);

      var stringValues := WebRequestAsString(request);

      var converter := new StormGlassConverter(_formatter);

      exit converter.ToForecast(stringValues);

    end;

    method GetCompleteCurrentConditions(location:LocationCoordinate2D):ICompleteCurrentConditions;
    begin
      var request := _provider.ForCompleteCurrentConditions(location);

      var stringValues := WebRequestAsString(request);

      var converter := new StormGlassConverter(_formatter);

      exit converter.ToCompleteCurrentConditions(stringValues);

    end;

    method GetCompleteForecast(location:LocationCoordinate2D; startTime:DateTime; endTime:DateTime):IForecast;
    begin

      var request := _provider.ForCompleteForecast(location, startTime, endTime);

      var stringValues := WebRequestAsString(request);

      var converter := new StormGlassConverter(_formatter);

      exit converter.ToForecast(stringValues);

    end;


    method GetCompleteForecast(location:LocationCoordinate2D):IForecast;
    begin

      var request := _provider.ForCompleteForecast(location);

      var stringValues := WebRequestAsString(request);

      var converter := new StormGlassConverter(_formatter);

      exit converter.ToForecast(stringValues);

    end;

    method GetCurrentTides(location:LocationCoordinate2D):ITides;
    begin
      var request := _provider.ForCurrentTides(location);
      var stringValues := WebRequestAsString(request);

      var converter := new StormGlassConverter(_formatter);

      exit converter.ToTides(stringValues);
    end;


  end;
end.
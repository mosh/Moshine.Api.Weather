namespace Moshine.Api.Weather.Proxies;

uses
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.StormGlass,
  Moshine.Foundation.Web, RemObjects.Elements.RTL;
type

  StormGlassProxy = public class(WebProxy)
  private
    property ApiKey:String;
  public
    constructor(apiKeyValue:String);
    begin
      ApiKey := apiKeyValue;

      self._requestBuilder := method (url: String; webMethod: String; addAuthentication: Boolean): Moshine.Foundation.Web.HttpRequest
        begin

          var request:Moshine.Foundation.Web.HttpRequest;

          {$IF TOFFEE}
          {$ELSEIF ECHOES}
          request := new PlatformHttpRequest(MethodToHttpMethod(webMethod), url);
          PlatformHttpRequest(request).Headers.Add('Authorization',ApiKey);
          {$ENDIF}

          exit request;

        end

    end;

    method GetForecast(location:LocationCoordinate2D):Forecast;
    begin
      var url := $'https://api.stormglass.io/v1/weather/point?lat={location.Latitude}&lng={location.Longitude}';

      var stringValues := WebRequestAsString('GET', url, nil, true);

      var newForecast := new Forecast;

      var document := JsonDocument.FromString(stringValues);

      var rootNode := document.Root;
      var metaNode := rootNode.Item['meta'];

      var paramsNode := metaNode.Item['params'] as JsonArray;

      newForecast.Meta := new Meta;
      newForecast.Meta.params := new List<String>;

      for each paramValue in paramsNode do
      begin
        newForecast.Meta.params.Add(paramValue.StringValue);
      end;


      exit newForecast;
    end;

  end;
end.
namespace Moshine.Api.Weather.Proxies;

uses
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.StormGlass,
  Moshine.Foundation,
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

    method GetForecast(location:LocationCoordinate2D):Forecast;
    begin
      var url := $'https://api.stormglass.io/v1/weather/point?lat={location.Latitude}&lng={location.Longitude}';

      var stringValues := WebRequestAsString('GET', url, nil, true);

      var newForecast := new Forecast;

      var document := JsonDocument.FromString(stringValues);

      var rootNode := document.Root;
      var metaNode := rootNode.Item['meta'];

      var lat := metaNode.Item['lat'].FloatValue;
      var lng := metaNode.Item['lng'].FloatValue;

      var paramsNode := metaNode.Item['params'] as JsonArray;

      newForecast.Meta := new Meta;
      newForecast.Meta.Location := new LocationCoordinate2D(lat,lng);
      newForecast.Meta.params := new List<String>;

      for each paramValue in paramsNode do
      begin
        newForecast.Meta.params.Add(paramValue.StringValue);
      end;

      var hoursNode := rootNode.Item['hours'] as JsonArray;

      newForecast.Hours := new List<Hour>;

      for each hourItem in hoursNode do
      begin
        var newHour := new Hour;
        newHour.Information := new List<Information>;

        var timeNode := hourItem.Item['time'];

        newHour.Time := DateTime.ParseISO8601DateTime(timeNode.StringValue);

        for each paramValue in newForecast.Meta.params do
        begin
          var values := hourItem.Item[paramValue] as JsonArray;

          var newInformation := new Information;
          newInformation.Name := paramValue;

          newInformation.Values := new List<Value>;

          for each valueItem in values do
          begin
            var sourceValueItem := valueItem.Item['value'];

            var generalValue:Value := nil;

            case sourceValueItem type of
              JsonFloatValue: generalValue := new DoubleValue(Value := sourceValueItem.FloatValue);
              JsonIntegerValue: generalValue := new IntegerValue(Value := sourceValueItem.IntegerValue);
              JsonStringValue: generalValue := new StringValue(Value := sourceValueItem.StringValue);
              else
                raise new Exception('unexpected json type');
            end;

            generalValue.source := valueItem.Item['source'].StringValue;

            newInformation.Values.Add(generalValue);

          end;

          newHour.Information.Add(newInformation);

        end;

        newForecast.Hours.Add(newHour);

      end;


      exit newForecast;
    end;

  end;
end.
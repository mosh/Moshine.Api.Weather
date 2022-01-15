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

    const ToKnots:Double = 1.94384;

    property ApiKey:String;

    _formatter:Formatter;
  public

    constructor(formatter:Formatter; apiKeyValue:String);
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


    method DegreesToCompass(num:Double):String;
    begin
      var val := Integer((num/22.5)+.5);
      var arr := ['N','NNE','NE','ENE','E','ESE', 'SE', 'SSE','S','SSW','SW','WSW','W','WNW','NW','NNW'];
      exit arr[(val mod 16)];
    end;


    method GetCurrentConditions(location:LocationCoordinate2D):ICurrentConditions;
    begin

      var since := DateTime.TimeSinceEpoch;

      var url := $'https://api.stormglass.io/v2/weather/point?lat={location.latitude}&lng={location.longitude}&params=windDirection,gust,windSpeed&start={since}&end={since}';

      var stringValues := WebRequestAsString('GET', url, nil, true);

      var document := JsonDocument.FromString(stringValues);

      var rootNode := document.Root;
      var metaNode := rootNode.Item['meta'];

      var lat := metaNode.Item['lat'].FloatValue;
      var lng := metaNode.Item['lng'].FloatValue;

      var paramsNode := metaNode.Item['params'] as JsonArray;
      var hoursNode := rootNode.Item['hours'] as JsonArray;

      var hour := hoursNode.First;

      var gust := hour.Item['gust'] as JsonObject;
      var windDirection := hour.Item['windDirection'] as JsonObject;
      var windSpeed := hour.Item['windSpeed'] as JsonObject;

      var gustValue := gust.Item['noaa'] as JsonFloatValue;
      var windDirectionValue := windDirection.Item['noaa'] as JsonFloatValue;
      var windSpeedValue := windSpeed.Item['noaa'] as JsonFloatValue;

      var current := new CurrentConditions;

      current.WindSpeedGusting := _formatter.Format(Double(gustValue) * ToKnots);
      current.WindSpeed := _formatter.Format(Double(windSpeedValue) * ToKnots);
      current.WindDirection := DegreesToCompass(windDirectionValue);
      current.ShortWindAsString := '';
      current.Weather := '';

      exit current;

    end;

    method GetForecast(location:LocationCoordinate2D):IForecast;
    begin
      var url := $'https://api.stormglass.io/v1/weather/point?lat={location.latitude}&lng={location.longitude}';

      var stringValues := WebRequestAsString('GET', url, nil, true);

      var newForecast := new StormGlassForecast(_formatter);

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
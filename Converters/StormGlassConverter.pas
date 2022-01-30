namespace Moshine.Api.Weather;

uses
  Moshine.Foundation,
  Moshine.Api.Location.Models,
  Moshine.Api.Weather.Extensions,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.StormGlass,
  RemObjects.Elements.RTL;

type

  StormGlassConverter = public class(IConverter)
  private
    const ToKnots:Double = 1.94384;
  private
    _formatter:WeatherApiFormatter;

  public
    constructor(formatter:WeatherApiFormatter);
    begin
      _formatter := formatter;
    end;

    method ToCurrentConditions(someJson:String):ICurrentConditions;
    begin

      var document := JsonDocument.FromString(someJson);

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
      current.WindDirection := Double(windDirectionValue).DegreesToCompass;
      current.ShortWindAsString := '';
      current.Weather := '';

      exit current;

    end;

    method ToForecast(someJson:String):IForecast;
    begin

      var document := JsonDocument.FromString(someJson);
      var formatter := new WeatherApiFormatter;


      var newForecast := new StormGlassForecast(formatter);


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
namespace Moshine.Api.Weather.Converters;

uses
  Moshine.Foundation,
  Moshine.Api.Location.Models,
  Moshine.Api.Weather.Extensions,
  Moshine.Api.Weather.Interfaces,
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.StormGlass,
  Moshine.Api.Weather,
  RemObjects.Elements.RTL;

type

  StormGlassConverter = public class(IConverter)
  private
    // metres per second to knots
    const ToKnots:Double = 1.94384;

  private
    _formatter:WeatherApiFormatter;

    method ToValue(key:String; value:JsonNode):Value;
    begin
      var generalValue:Value := nil;

      case value type of
        JsonFloatValue: generalValue := new DoubleValue(Value := value.FloatValue);
        JsonIntegerValue: generalValue := new IntegerValue(Value := value.IntegerValue);
        JsonStringValue: generalValue := new StringValue(Value := value.StringValue);
        else
          raise new Exception('unexpected json type');
      end;

      generalValue.source := key;

      exit generalValue;

    end;

  public
    constructor(formatter:WeatherApiFormatter);
    begin
      _formatter := formatter;
    end;

    method ToCompleteCurrentConditions(someJson:String):ICompleteCurrentConditions;
    begin

      var fullCurrentConditions := PopulateCurrentConditions(someJson, new CompleteCurrentConditions) as CompleteCurrentConditions;

      var document := JsonDocument.FromString(someJson);
      var rootNode := document.Root;

      var hoursNode := rootNode.Item['hours'] as JsonArray;
      var hour := hoursNode.First as JsonObject;

      for each key in hour.Keys do
      begin
        var item := hour.Item[key];

        case key of
          'airTemperature':
            begin
              for each itemKey in item.Keys do
              begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.AirTemperature.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
            end;
          'cloudCover':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.CloudCover.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'humidity':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.Humidity.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'iceCover':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.IceCover.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'precipitation':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.Precipitation.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'pressure':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.Pressure.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'secondarySwellDirection':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.SecondarySwellDirection.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'secondarySwellHeight':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.SecondarySwellHeight.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'secondarySwellPeriod':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.SecondarySwellPeriod.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'snowDepth':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.SnowDepth.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'swellDirection':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.SwellDirection.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'swellHeight':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.SwellHeight.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'swellPeriod':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.SwellPeriod.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'waterTemperature':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.WaterTemperature.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'waveDirection':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.WaveDirection.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'windWaveDirection':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.WindWaveDirection.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'windWaveHeight':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.WindWaveHeight.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;
          'windWavePeriod':
          begin
              for each itemKey in item.Keys do
                begin
                var itemItem := item[itemKey].FloatValue;
                fullCurrentConditions.WindWavePeriod.Values.Add(new KeyValuePair<String,Double>(itemKey, itemItem));
              end;
          end;


        end;
      end;


      exit fullCurrentConditions;
    end;

    method ToCurrentConditions(someJson:String):ICurrentConditions; //{$IFDEF DARWIN} implements IConverter.ToCurrentConditions; {$ENDIF}
    begin

    end;


    method PopulateCurrentConditions(someJson:String; conditions:CurrentConditions):ICurrentConditions;
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

      if(not assigned(conditions))then
      begin
        conditions := new CurrentConditions;
      end;

      conditions.WindSpeedGusting := _formatter.Format(Double(gustValue) * ToKnots);
      conditions.WindSpeed := _formatter.Format(Double(windSpeedValue) * ToKnots);
      conditions.WindDirection := Double(windDirectionValue).DegreesToCompass;
      conditions.ShortWindAsString := '';
      conditions.Weather := '';

      exit conditions;

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

          var paramValues := hourItem.Item[paramValue];

          if(paramValues is JsonObject) then
          begin
            var newInformation := new Information;
            newInformation.Name := paramValue;
            newInformation.Values := new List<Value>;

            var paramAsJsonObject := paramValues as JsonObject;

            for each paramProperty in paramAsJsonObject do
            begin
              var newValue := ToValue(paramProperty.Item1, paramProperty.Item2);
              newInformation.Values.Add(newValue);
            end;

            newHour.Information.Add(newInformation);

          end
          else if (paramValues is JsonArray) then
          begin

            var values :=  paramValues as JsonArray;

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

        end;

        newForecast.Hours.Add(newHour);

      end;

      exit newForecast;

    end;

    method ToTides(someJson:String):ITides;
    begin
      var tides := new Tides;
      var document := JsonDocument.FromString(someJson);

      var rootNode := document.Root;
      var dataNode := rootNode.Item['data'];

      for each tide in dataNode as JsonArray do
      begin
        if (assigned(tide))then
        begin
          var newTide := new Tide;
          newTide.Height := tide.Item['height'].FloatValue;
          newTide.Time := DateTime.ParseISO8601DateTime(tide.Item['time'].StringValue);
          newTide.Type := tide.Item['type'].StringValue;
          tides.Tides.Add(newTide);
        end;
      end;

      var stationNode := rootNode.Item['meta'].Item['station'];

      tides.Station.Name := stationNode.Item['name'].StringValue;
      tides.Station.Source := stationNode.Item['source'].StringValue;
      tides.Station.Distance := stationNode.Item['distance'].IntegerValue;
      tides.Station.Latitude := stationNode.Item['lat'].FloatValue;
      tides.Station.Longitude := stationNode.Item['lng'].FloatValue;

      var aFormat := 'yyyy-MM-dd hh:mm';

      tides.Start := DateTime.TryParse(rootNode.Item['meta'].Item['start'].StringValue, aFormat);
      tides.End := DateTime.TryParse(rootNode.Item['meta'].Item['end'].StringValue, aFormat);
      tides.Datum := rootNode.Item['meta'].Item['datum'].StringValue;
      tides.Latitude := rootNode.Item['meta'].Item['lat'].FloatValue;
      tides.Longitude := rootNode.Item['meta'].Item['lng'].FloatValue;

      exit tides;
    end;

  end;

end.
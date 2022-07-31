namespace Moshine.Api.Weather.Models;

uses
  RemObjects.Elements.RTL;

type

  WeatherValue<T> = public class
  public
    property Values:List<KeyValuePair<String,T>> := new List<KeyValuePair<String,T>>;
  end;

  DoubleWeatherValue = public class(WeatherValue<Double>)
  public
    [ToString]
    method ToString:String;
    begin
      if(self.Values.Any)then
      begin
        exit self.Values.First.Value.ToString;
      end;
      exit '';
    end;
  end;

  StringWeatherValue = public class(WeatherValue<String>)
  public
    [ToString]
    method ToString:String;
    begin
      if(self.Values.Any)then
      begin
        exit self.Values.First.Value.ToString;
      end;
      exit '';
    end;
  end;

  IntegerWeatherValue = public class(WeatherValue<Integer>)
  public

    [ToString]
    method ToString:String;
    begin
      if(self.Values.Any)then
      begin
        exit self.Values.First.Value.ToString;
      end;
      exit '';
    end;

  end;

  AverageDoubleWeatherValue = public class(DoubleWeatherValue)
  public

    [ToString]
    method ToString:String;
    begin
      if(self.Values.Any)then
      begin
        var sum:Double := 0;
        for each value in Values do
        begin
          sum := sum + value.Value;
        end;

        var avg := sum / self.Values.Count;

        exit $'{avg}';
      end;
      exit '';
    end;

  end;


end.
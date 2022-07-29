namespace Moshine.Api.Weather.Models;

uses
  RemObjects.Elements.RTL;

type

  WeatherValue<T> = public class
  public
    property Values:List<KeyValuePair<String,T>> := new List<KeyValuePair<String,T>>;
  end;

  DoubleWeatherValue = public class(WeatherValue<Double>)
  end;

  StringWeatherValue = public class(WeatherValue<String>)
  end;

  IntegerWeatherValue = public class(WeatherValue<Integer>)
  end;


end.
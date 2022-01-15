namespace Moshine.Api.Weather;

uses
  Moshine.Api.Weather.Models,RemObjects.Elements.RTL;


type

  WeatherApiFormatter = public class
  public

    property digits:Integer := 2;


    method Format(value:Double):Double;
    begin
      exit Math.Round(value, digits);
    end;

  end;

end.
namespace Moshine.Api.Weather.Models;

uses
  RemObjects.Elements.RTL;

type
  IForecast = public interface
    property WindSpeed:Double read;
    property WindSpeedGusting:Double read;
    property WindDirection:String read;
    property ShortWindAsString:String read;
    property Weather:String read;
  end;

end.
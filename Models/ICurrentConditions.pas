namespace Moshine.Api.Weather.Models;

type
  ICurrentConditions = public class
    property WindSpeed:Double read;
    property WindSpeedGusting:Double read;
    property WindDirection:String read;
    property ShortWindAsString:String read;
    property Weather:String read;

  end;

end.
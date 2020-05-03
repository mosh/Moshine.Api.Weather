namespace Moshine.Api.Weather.Models.StormGlass;

uses
  Moshine.Api.Weather.Models;

type
  CurrentConditions = public class(ICurrentConditions)
  public
    property WindSpeed:Double;
    property WindSpeedGusting:Double;
    property WindDirection:String;
    property ShortWindAsString:String;
    property Weather:String;

  end;

end.
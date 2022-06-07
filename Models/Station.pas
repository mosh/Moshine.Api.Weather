namespace Moshine.Api.Weather.Models;

type
  Station = public class
  public
    property Distance:Integer;
    property Latitude:Double;
    property Longitude:Double;
    property Name:String;
    property Source:String;
  end;
end.
namespace Moshine.Api.Weather.Models;

uses
  RemObjects.Elements.Rtl;

type
  Tide = public class
  public
    property &Type:String;
    property Height:Double;
    property Time:DateTime;
  end;
end.
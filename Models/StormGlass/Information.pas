namespace Moshine.Api.Weather.Models.StormGlass;

uses
  RemObjects.Elements.RTL;

type
  Information = public class
  public
    property Name:String;
    property Values:List<Value>;
  end;

end.
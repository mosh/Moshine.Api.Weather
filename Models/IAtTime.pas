namespace Moshine.Api.Weather.Models;

uses
  RemObjects.Elements.RTL;

type

  IAtTime = public interface
    property Time:DateTime read;
    property WindSpeed:Double read;
    property WindDirection:Integer read;
    property WindGust:Double read;
  end;

end.
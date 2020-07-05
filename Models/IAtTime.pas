namespace Moshine.Api.Weather.Models;

uses
  RemObjects.Elements.RTL;

type

  IAtTime = public interface
    property Time:DateTime read;
    property WindSpeed:Double read;
    property WindDirection:Double read;
    property WindGust:Double read;

    property CurrentSpeed:Double read;
    property CurrentDirection:Double read;

    property Pressure:Double read;
    property CloudCover:Double read;

    property SwellHeight:Double read;
    property SwellDirection:Double read;

    property WaveHeight:Double read;
  end;

end.
namespace Moshine.Api.Weather.Models;

uses
  RemObjects.Elements.RTL;

type

  IForecast = public interface
    property Times:List<IAtTime> read;
  end;

end.
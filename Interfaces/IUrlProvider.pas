namespace Moshine.Api.Weather.Interfaces;


uses
  Moshine.Api.Location.Models, RemObjects.Elements.RTL;

type
  IUrlProvider = public interface

    method ForCurrentConditions(location:LocationCoordinate2D):String;
    method ForForecast(location:LocationCoordinate2D):String;
  end;

end.
namespace Moshine.Api.Weather.Interfaces;


uses
  Moshine.Api.Location.Models,
  Moshine.Foundation.Web,
  RemObjects.Elements.RTL;

type
  IUrlProvider = public interface

    method ForCurrentConditions(location:LocationCoordinate2D):Moshine.Foundation.Web.HttpRequest;
    method ForForecast(location:LocationCoordinate2D):Moshine.Foundation.Web.HttpRequest;
    method ForCompleteCurrentConditions(location:LocationCoordinate2D):Moshine.Foundation.Web.HttpRequest;
    method ForCompleteForecast(location:LocationCoordinate2D):Moshine.Foundation.Web.HttpRequest;
    method ForCurrentTides(location:LocationCoordinate2D):Moshine.Foundation.Web.HttpRequest;

  end;

end.
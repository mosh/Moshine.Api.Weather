namespace Moshine.Api.Weather;

uses
  Moshine.Api.Location.Models,
  Moshine.Api.Weather.Models;

type

  IWeatherApi = public interface

    method GetForecast(location:LocationCoordinate2D):IForecast;
    method GetCurrentConditions(location:LocationCoordinate2D):ICurrentConditions;

  end;

end.
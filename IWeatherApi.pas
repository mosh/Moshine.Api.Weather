namespace Moshine.Api.Weather;

uses
  Moshine.Api.Weather.Models;

type

  IWeatherApi = public interface

    method GetForecast(location:LocationCoordinate2D):IForecast;

  end;

end.
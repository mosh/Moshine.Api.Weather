namespace Moshine.Api.Weather;

uses
  Moshine.Api.Location.Models,
  Moshine.Api.Weather.Models;

type

  WeatherApiBase = public abstract class(IWeatherApi)
  private
  protected
  public
    property Formatter:WeatherApiFormatter := new WeatherApiFormatter;

    method GetForecast(location:LocationCoordinate2D):IForecast; abstract;
    method GetCurrentConditions(location:LocationCoordinate2D):ICurrentConditions; abstract;

  end;

end.
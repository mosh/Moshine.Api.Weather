namespace Moshine.Api.Weather;

uses
  Moshine.Api.Location.Models,
  Moshine.Api.Weather.Interfaces,
  Moshine.Foundation,
  RemObjects.Elements.RTL;

type
  StormGlassUrlProvider = public class(IUrlProvider)
  public


    method ForCurrentConditions(location:LocationCoordinate2D):String;
    begin
      var since := DateTime.TimeSinceEpoch;

      exit $'https://api.stormglass.io/v2/weather/point?lat={location.latitude}&lng={location.longitude}&params=windDirection,gust,windSpeed&start={since}&end={since}';
    end;

    method ForForecast(location:LocationCoordinate2D):String;
    begin
      exit $'https://api.stormglass.io/v1/weather/point?lat={location.latitude}&lng={location.longitude}';
    end;
  end;

end.
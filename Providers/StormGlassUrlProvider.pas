namespace Moshine.Api.Weather;

uses
  Moshine.Api.Location.Models,
  Moshine.Api.Weather.Interfaces,
  Moshine.Foundation,
  Moshine.Foundation.Web,
  RemObjects.Elements.RTL;

type

  StormGlassUrlProvider = public class(IUrlProvider)

  private
    _keyCode:String;

    method HttpRequestForStormGlass(url:String): Moshine.Foundation.Web.HttpRequest;
    begin
      var request := new Moshine.Foundation.  Web.HttpRequest('GET',url);
      request.AddHeader('Authorization',_keyCode);
      exit request;
    end;


  public

    constructor(keyCode:String);
    begin
      _keyCode := keyCode;
    end;


    method ForCurrentConditions(location:LocationCoordinate2D):Moshine.Foundation.Web.HttpRequest;
    begin
      var since := DateTime.TimeSinceEpochNow;
      var url := $'https://api.stormglass.io/v2/weather/point?lat={location.latitude}&lng={location.longitude}&params=windDirection,gust,windSpeed&start={since}&end={since}';
      exit HttpRequestForStormGlass(url);
    end;

    method ForForecast(location:LocationCoordinate2D):Moshine.Foundation.Web.HttpRequest;
    begin

      var startTime := DateTime.UtcNow;
      var endTime := startTime.AddHours(24);
      var startValue := startTime.TimeSinceEpoch;
      var endValue := endTime.TimeSinceEpoch;
      var url := $'https://api.stormglass.io/v2/weather/point?lat={location.latitude}&lng={location.longitude}&params=windDirection,gust,windSpeed&start={startValue}&end={endValue}';
      exit HttpRequestForStormGlass(url);
    end;
  end;

end.
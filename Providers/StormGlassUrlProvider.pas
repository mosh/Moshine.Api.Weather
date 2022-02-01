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
      var request := new Moshine.Foundation.Web.HttpRequest(url,HttpRequestMode.Get);
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
      var since := DateTime.TimeSinceEpoch;
      exit HttpRequestForStormGlass($'https://api.stormglass.io/v2/weather/point?lat={location.latitude}&lng={location.longitude}&params=windDirection,gust,windSpeed&start={since}&end={since}');
    end;

    method ForForecast(location:LocationCoordinate2D):Moshine.Foundation.Web.HttpRequest;
    begin
      exit HttpRequestForStormGlass($'https://api.stormglass.io/v1/weather/point?lat={location.latitude}&lng={location.longitude}');
    end;
  end;

end.
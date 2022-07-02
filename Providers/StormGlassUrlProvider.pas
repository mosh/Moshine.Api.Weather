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

    property WindParameters :=  ['windDirection','gust','windSpeed'];

    // 'visiblity' - Not valid
    property AllParameters := [
      'airTemperature','pressure','cloudCover','currentDirection','currentSpeed',
      'gust','humidity','iceCover','precipitation','seaLevel',
      'snowDepth','swellDirection','swellHeight','swellPeriod','secondarySwellDirection',
      'secondarySwellHeight','secondarySwellPeriod','waterTemperature','waveDirection',
      'waveHeight','wavePeriod','windWaveDirection','windWaveHeight','windWavePeriod','windDirection', 'windSpeed',
      ];

    method ArrayAsString(values:array of String):String;
    begin
      var value := '';

      for x:= 0 to values.length-1 do
      begin
        value := value + values[x];
        if(x < values.length -1)then
        begin
          value := value + ',';
        end;
      end;
      exit value;

    end;

    method ParameterizedForCurrentConditions(location:LocationCoordinate2D; parameters:array of String):Moshine.Foundation.Web.HttpRequest;
    begin
      var since := DateTime.TimeSinceEpochNow;
      var url := $'https://api.stormglass.io/v2/weather/point?lat={location.latitude}&lng={location.longitude}&params={ArrayAsString(parameters)}&start={since}&end={since}';
      exit HttpRequestForStormGlass(url);
    end;

    method ParameterizedForForecast(location:LocationCoordinate2D; parameters:array of String):Moshine.Foundation.Web.HttpRequest;
    begin
      var startTime := DateTime.UtcNow;
      var endTime := startTime.AddHours(24);

      exit ParameterizedForForecast(location, startTime, endTime, parameters);
    end;

    method ParameterizedForForecast(location:LocationCoordinate2D; startTime:DateTime; endTime:DateTime; parameters:array of String):Moshine.Foundation.Web.HttpRequest;
    begin

      var startValue := startTime.TimeSinceEpoch;
      var endValue := endTime.TimeSinceEpoch;
      var url := $'https://api.stormglass.io/v2/weather/point?lat={location.latitude}&lng={location.longitude}&params={ArrayAsString(parameters)}&start={startValue}&end={endValue}';
      exit HttpRequestForStormGlass(url);
    end;



  public

    constructor(keyCode:String);
    begin
      _keyCode := keyCode;
    end;


    method ForCurrentConditions(location:LocationCoordinate2D):Moshine.Foundation.Web.HttpRequest;
    begin
      exit ParameterizedForCurrentConditions(location, WindParameters);
    end;


    method ForForecast(location:LocationCoordinate2D):Moshine.Foundation.Web.HttpRequest;
    begin
      exit ParameterizedForForecast(location, WindParameters);
    end;

    method ForForecast(location:LocationCoordinate2D; startTime:DateTime; endTime:DateTime):Moshine.Foundation.Web.HttpRequest;
    begin
      exit ParameterizedForForecast(location, startTime, endTime, WindParameters);
    end;


    method ForCompleteCurrentConditions(location:LocationCoordinate2D):Moshine.Foundation.Web.HttpRequest;
    begin
      exit ParameterizedForCurrentConditions(location, AllParameters);
    end;

    method ForCompleteForecast(location:LocationCoordinate2D; startTime:DateTime; endTime:DateTime):Moshine.Foundation.Web.HttpRequest;
    begin
      exit ParameterizedForForecast(location, startTime, endTime, AllParameters);
    end;


    method ForCompleteForecast(location:LocationCoordinate2D):Moshine.Foundation.Web.HttpRequest;
    begin
      exit ParameterizedForForecast(location, AllParameters);
    end;

    method ForCurrentTides(location:LocationCoordinate2D):Moshine.Foundation.Web.HttpRequest;
    begin
      var startTime := DateTime.UtcNow;
      var endTime := startTime.AddHours(24);
      var startValue := startTime.TimeSinceEpoch;
      var endValue := endTime.TimeSinceEpoch;

      var url := $'https://api.stormglass.io/v2/tide/extremes/point?lat={location.latitude}&lng={location.longitude}&start={startValue}&end={endValue}';
      exit HttpRequestForStormGlass(url);

    end;


  end;

end.
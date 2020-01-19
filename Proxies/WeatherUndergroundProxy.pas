namespace Moshine.Api.Weather.Proxies;

uses
  {$IF TOFFEE}
  Foundation,
  {$ENDIF}
  Moshine.Foundation.Web,
  RemObjects.Elements.RTL;

type

  WeatherUndergroundProxy = public class(WebProxy)
  private
    _apiKey:String;

  public

    constructor(apiKey:String);
    begin
      _apiKey := apiKey;
    end;

    method conditionsForName(name:String):Dictionary<String,Object>;
    begin
      {$IF TOFFEE}
      NSLog('%@','WeatherUndergroundProxy.conditionsForName');
      {$ENDIF}
      var apiUrl := $'https://api.wunderground.com/api/{_apiKey}/conditions/q/{name}.json';
      //exit WebRequest<Dictionary<String,Object>>('GET',apiUrl,false);
    end;

    method conditionsForPersonalWeatherStation(id:String):Dictionary<String,Object>;
    begin
      {$IF TOFFEE}
      NSLog('%@','WeatherUndergroundProxy.conditionsForPersonalWeatherStation');
      {$ENDIF}
      var apiUrl := $'https://api.wunderground.com/api/{_apiKey}/conditions/q/pws:{id}.json';
      //exit WebRequest<Dictionary<String,Object>>('GET',apiUrl,false);
    end;


  end;

end.
namespace Moshine.Api.Weather;

uses
  Foundation,
  Moshine.Foundation.Web;

type

  WeatherUndergroundProxy = public class(WebProxy)
  private
    _apiKey:String;

  public

    constructor(apiKey:String);
    begin
      _apiKey := apiKey;
    end;

    method conditionsForName(name:String):NSDictionary;
    begin
      NSLog('%@','WeatherUndergroundProxy.conditionsForName');
      var apiUrl := NSString.stringWithFormat('https://api.wunderground.com/api/%@/conditions/q/%@.json',_apiKey,name);
      exit WebRequest<NSDictionary>('GET',apiUrl,false);
    end;

    method conditionsForPersonalWeatherStation(id:String):NSDictionary;
    begin
      NSLog('%@','WeatherUndergroundProxy.conditionsForPersonalWeatherStation');
      var apiUrl := NSString.stringWithFormat('https://api.wunderground.com/api/%@/conditions/q/pws:%@.json',_apiKey,id);
      exit WebRequest<NSDictionary>('GET',apiUrl,false);
    end;


  end;

end.
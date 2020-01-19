namespace Moshine.Api.Weather;

uses
  Moshine.Api.Weather.Models,
  Moshine.Api.Weather.Models.WeatherUnderground,
  Moshine.Api.Weather.Services.WeatherUnderground,
  Moshine.Foundation.Web,
  Moshine.Api.Weather.Proxies,
  RemObjects.Elements.RTL;

type

  ///
  /// Depreciated - api no longer supported
  ///
  WeatherUndergroundApi = public class
  private
    _apiKey:String;
    _proxy:WeatherUndergroundProxy;
    _populator:WeatherPopulator := new WeatherPopulator;

    method conditionsResponse(name:String):String;
    begin
      var apiUrl := $'https://api.wunderground.com/api/{_apiKey}/conditions/q/{name}.json';
      var aUrl := Url.UrlWithString(apiUrl);
      var aRequest := new HttpRequest(aUrl);
      exit Http.GetString(nil, aRequest);
    end;

    method geoLookupResponse(currentLocation:Location):String;
    begin
      var apiUrl := $'https://api.wunderground.com/api/{_apiKey}/geolookup/q/{currentLocation.Latitude},{currentLocation.Longitude}.json';

      var aUrl := Url.UrlWithString(apiUrl);
      var aRequest := new HttpRequest(aUrl);
      exit Http.GetString(nil, aRequest);

    end;

  public

    constructor(apiKey:String);
    begin
      _apiKey := apiKey;
      _proxy := new WeatherUndergroundProxy(_apiKey);
    end;

    method conditionsForPersonalWeatherStation(id:String):Conditions;
    begin
      //NSLog('%@','WeatherUndergroundApi.conditionsForPersonalWeatherStation');
      var foundConditions := new Conditions;

      var response := _proxy.conditionsForPersonalWeatherStation(id);

      _populator.populateConditions(foundConditions) fromDictionary(response);

      exit foundConditions;
    end;

    method conditionsForName(name:String):Conditions;
    begin
      //NSLog('%@','WeatherUndergroundApi.conditionsForName');
      var foundConditions := new Conditions;

      var response := _proxy.conditionsForName(name);

      _populator.populateConditions(foundConditions) fromDictionary(response);

      exit foundConditions;
    end;

    method geoLookup(currentLocation:Location):Location;
    begin
      //NSLog('%@','WeatherUndergroundApi.geoLookup');

      var foundLocation := new Location;

      var response := geoLookupResponse(currentLocation);

      _populator.populateLocation(foundLocation) fromString(response);

      exit foundLocation;

    end;
  end;

end.
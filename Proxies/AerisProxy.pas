namespace Moshine.Api.Weather.Proxies;

uses
  Moshine.Foundation.Web,
  Moshine.Api.Weather.Models,
  RemObjects.Elements.RTL;

type
  AerisProxy = public class(WebProxy)
  private
    const apiBase = 'https://api.aerisapi.com/';

  private
    clientId:String;
    clientSecret:String;
  public
    constructor(clientIdValue:String; clientSecretValue:String);
    begin
      clientId := clientIdValue;
      clientSecret := clientSecretValue;
    end;

    method Forecast(location: LocationCoordinate2D):ImmutableDictionary<String,Object>;
    begin
      var locationString := $'{location.Latitude},{location.Longitude}';
      var url := $'{apiBase}/forecasts?client_id={clientId}&client_secret={clientSecret}&p={locationString}&radius=400mi';
      exit WebRequestAs<ImmutableDictionary<String,Object>>('GET',url,false);
    end;

  end;

end.
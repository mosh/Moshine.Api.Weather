namespace Moshine.Api.Weather.Proxies;

uses
  CoreLocation,
  Foundation,
  Moshine.Foundation.Web,
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

    method Forecast(location:Location):ImmutableDictionary;
    begin
      var locationString := $'{location.latitude},{location.longitude}');
      var url := $'{apiBase}/forecasts?client_id={clientId}&client_secret={clientSecret}&p={locationString}&radius=400mi';
      exit WebRequest<ImmutableDictionary>('GET',url,false);
    end;

  end;

end.
namespace Moshine.Api.Weather.Proxies;

uses
  CoreLocation,
  Foundation,
  Moshine.Foundation.Web;

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

    method Forecast(location:CLLocationCoordinate2D):NSDictionary;
    begin
      var locationString := NSString.stringWithFormat('%.04f,%.04f',location.latitude,location.longitude);
      var url := $'{apiBase}/forecasts?client_id={clientId}&client_secret={clientSecret}&p={locationString}&radius=400mi';
      exit WebRequest<NSDictionary>('GET',url,false);
    end;

  end;

end.
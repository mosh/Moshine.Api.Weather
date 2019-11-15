namespace Moshine.Api.Weather;

uses
  Moshine.Api.Models.Aeris;

type
  AerisWeatherApi = public class
  private
    const apiBase := 'https://api.aerisapi.com/';
    clientId:String;
    clientSecret:String;

  public
    constructor(clientIdValue:String; clientSecretValue:String);
    begin
      clientId := clientIdValue;
      clientSecret := clientSecretValue;
    end;

    method Forecast:Forecast;
    begin
      var url := $'{apiBase}/forecasts?client_id={clientId}&client_secret={clientSecret}&p=38.55,-68.31&radius=400mi';
    end;
  end;
end.
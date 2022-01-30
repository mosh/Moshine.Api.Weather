namespace Moshine.Api.Weather;

uses
  Moshine.Api.Weather.Models;

type

  IConverter = public interface
    method ToCurrentConditions(someJson:String):ICurrentConditions;
    method ToForecast(someJson:String):IForecast;
  end;

end.
namespace Moshine.Api.Weather.Interfaces;

uses
  Moshine.Api.Weather.Models;

type

  IConverter = public interface
    method ToCurrentConditions(someJson:String):ICurrentConditions;
    method ToForecast(someJson:String):IForecast;
  end;

end.
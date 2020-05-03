namespace Moshine.Api.Weather.Models.WorldWeatherOnline;

uses
  Moshine.Api.Weather.Models;

type
  MarineWeather = public class(IForecast)
  public
    var data: Data;

    property WindSpeed:Double read
      begin

      end;
    property WindSpeedGusting:Double read
      begin

      end;

   property WindDirection:String read
     begin

     end;

   property ShortWindAsString:String read
     begin

     end;

   property Weather:String read
     begin

     end;

  end;

end.
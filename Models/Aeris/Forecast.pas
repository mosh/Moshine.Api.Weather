namespace Moshine.Api.Weather.Models.Aeris;

uses
  Moshine.Api.Weather.Models,
  RemObjects.Elements.RTL;

type
   Forecast = public class(IForecast)
   public

     property Profile:Profile := new Profile;
     property Location:LocationCoordinate2D := new LocationCoordinate2D;
     property Periods:List<Period> := new List<Period>;
     property Interval:String;


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
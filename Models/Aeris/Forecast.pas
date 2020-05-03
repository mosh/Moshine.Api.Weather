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

  end;

end.
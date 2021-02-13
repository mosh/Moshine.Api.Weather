namespace Moshine.Api.Weather.Models.Aeris;

uses
  Moshine.Api.Location.Models,
  Moshine.Api.Weather.Models,
  RemObjects.Elements.RTL;

type
   AerisForecast = public class(IForecast)
   public

     property Profile:Profile := new Profile;
     property Location:LocationCoordinate2D := new LocationCoordinate2D;
     property Periods:List<Period> := new List<Period>;
     property Interval:String;

     property Times:List<IAtTime> read
      begin
        raise new NotImplementedException;
      end;

  end;

end.
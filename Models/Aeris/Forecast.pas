namespace Moshine.Api.Weather.Models.Aeris;

type
   Forecast = public class
   public

     property Profile:Profile := new Profile;
     property Location:Location := new Location;
     property Periods:List<Period> := new List<Period>;
  end;

end.
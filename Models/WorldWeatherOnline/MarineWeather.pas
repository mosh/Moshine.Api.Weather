namespace Moshine.Api.Weather.Models.WorldWeatherOnline;

uses
  Moshine.Api.Weather.Models, RemObjects.Elements.RTL;

type
  MarineWeather = public class(IForecast)
  public
    var data: Data;

    property Times:List<IAtTime> read
      begin
        raise new NotImplementedException;
      end;


  end;

end.
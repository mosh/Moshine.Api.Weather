namespace Moshine.Api.Weather.Models.WeatherUnderground;


type

  AirportStation = public class(Station)
  protected

    method set_title(value: nullable String); override;
    begin
    end;

    method get_title: nullable String; override;
    begin
      exit self.ICAO + ' - ' + self.City;
    end;

  public
    property ICAO:String;
  end;


end.
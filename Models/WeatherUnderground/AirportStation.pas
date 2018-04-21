namespace Moshine.Api.Weather.Models.WeatherUnderground;

uses
  Foundation;

type

  AirportStation = public class(Station)
  protected

    method set_title(value: nullable NSString); override;
    begin
    end;

    method get_title: nullable NSString; override;
    begin
      exit self.ICAO + ' - ' + self.City;
    end;

  public
    property ICAO:String;
  end;


end.
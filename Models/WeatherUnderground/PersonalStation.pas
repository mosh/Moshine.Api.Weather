namespace Moshine.Api.Weather.Models.WeatherUnderground;

uses
  Foundation;

type

  PersonalStation = public class(Station)
  protected

    method set_title(value: nullable NSString); override;
    begin
    end;

    method get_title: nullable NSString; override;
    begin
      exit self.Neighborhood;
    end;

  public
    property Id:String;
    property Neighborhood:String;
    property DistanceKm:Integer;
    property DistanceMiles:Integer;
  end;


end.
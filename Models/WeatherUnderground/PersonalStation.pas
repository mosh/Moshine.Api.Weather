namespace Moshine.Api.Weather.Models.WeatherUnderground;


type

  PersonalStation = public class(Station)
  protected

    method set_title(value: nullable String); override;
    begin
    end;

    method get_title: nullable String; override;
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
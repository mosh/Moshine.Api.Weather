namespace Moshine.Api.Weather.Models.WeatherUnderground;

uses
  Foundation,
  MapKit;

type
  Station = public abstract class(IMKAnnotation)
  protected

    method set_title(value: nullable NSString); abstract;

    method get_title: nullable NSString; abstract;

    method set_subtitle(value:nullable NSString);
    begin
    end;

    method get_subtitle: nullable NSString;
    begin
      exit '';
    end;


    method set_coordinate(value: CLLocationCoordinate2D);
    begin
      self.Latitude := value.latitude;
      self.Longitude := value.longitude;
    end;

    method get_coordinate: CLLocationCoordinate2D;
    begin
      exit new CLLocationCoordinate2D(latitude := self.Latitude, longitude := self.Longitude);
    end;

  public
    property City:String;
    property State:String;
    property Country:String;
    property Latitude:Double;
    property Longitude:Double;

    // IMKAnnotation
    property coordinate: CLLocationCoordinate2D read get_coordinate write set_coordinate;
    property title: nullable NSString read get_title write set_title;
    property subtitle: nullable NSString read get_subtitle write set_subtitle;
    // IMKAnnotation

  end;

end.
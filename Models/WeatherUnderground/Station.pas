namespace Moshine.Api.Weather.Models.WeatherUnderground;

uses
{$IF TOFFEE}
  CoreLocation,
  Foundation,
  MapKit,
{$ENDIF}
  Moshine.Api.Weather.Models;

type



  Station = public abstract class({$IF TOFFEE}IMKAnnotation{$ENDIF})
  protected

    method set_title(value: nullable String); abstract;

    method get_title: nullable String; abstract;

    method set_subtitle(value:nullable String);
    begin
    end;

    method get_subtitle: nullable String;
    begin
      exit '';
    end;


    method set_coordinate(value: LocationCoordinate2D);
    begin
      self.Latitude := value.Latitude;
      self.Longitude := value.Longitude;
    end;

    method get_coordinate: LocationCoordinate2D;
    begin
      //exit new LocationCoordinate2D(Latitude := self.Latitude, Longitude := self.Longitude);
    end;

  public
    property City:String;
    property State:String;
    property Country:String;
    property Latitude:Double;
    property Longitude:Double;

    // IMKAnnotation
    property coordinate: LocationCoordinate2D read get_coordinate write set_coordinate;
    property title: nullable String read get_title write set_title;
    property subtitle: nullable String read get_subtitle write set_subtitle;
    // IMKAnnotation

  end;

end.
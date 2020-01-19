namespace Moshine.Api.Weather.Models.WeatherUnderground;

uses
  RemObjects.Elements.RTL;

type

  Location = public class
  private
    _nearbyStations:List<Station> := new List<Station>;
  protected
  public
    property NearbyWeatherStations:List<Station> read _nearbyStations;
    property &Type:String;
    property Country:String;
    property CountryIso3166:String;
    property State:String;
    property City:String;
    property TimeZoneShort:String;
    property TimeZoneLong:String;
    property Latitude:Double;
    property Longitude:Double;
    property Zip:String;
    property Magic:String;
    property wmo:String;

  end;

end.
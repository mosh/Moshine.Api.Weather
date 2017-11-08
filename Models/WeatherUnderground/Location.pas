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
  end;

  Station = public class
  public
    property City:String;
  end;

  PersonalStation = public class(Station)
  public
    property Id:String;
    property Neighborhood:String;
  end;

  AirportStation = public class(Station)
  public
    property ICAO:String;
  end;

end.
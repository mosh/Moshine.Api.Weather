namespace Moshine.Api.Weather.Models;

uses
  RemObjects.Elements.RTL;

type

  BoundingBox = public class
  public
    property MinPoint: LocationCoordinate2D read  write ;
    property MaxPoint: LocationCoordinate2D read  write ;
  end;


  LocationCoordinate2DExtensions = public extension class(LocationCoordinate2D)
  private
    // Semi-axes of WGS-84 geoidal reference
    const WGS84_a:Double = 6378137.0; // Major semiaxis [m]
    const WGS84_b:Double = 6356752.3; // Minor semiaxis [m]


    // degrees to radians
    class method Deg2rad(degrees:Double):Double;
    begin
      {$IFDEF ECHOES}
      exit System.Math.PI * degrees / 180.0;
      {$ELSE}
      raise new NotImplementedException;
      {$ENDIF}
    end;

    // radians to degrees
    class method Rad2deg(radians:Double):Double;
    begin
      {$IFDEF ECHOES}
      exit 180.0 * radians / System.Math.PI;
      {$ELSE}
      raise new NotImplementedException;
      {$ENDIF}
    end;

    // Earth radius at a given latitude, according to the WGS-84 ellipsoid [m]
    class method WGS84EarthRadius(lat:Double):Double;
    begin
      // http://en.wikipedia.org/wiki/Earth_radius
      var An := WGS84_a * WGS84_a * Math.Cos(lat);
      var Bn := WGS84_b * WGS84_b * Math.Sin(lat);
      var Ad := WGS84_a * Math.Cos(lat);
      var Bd := WGS84_b * Math.Sin(lat);
      exit Math.Sqrt((An*An + Bn*Bn) / (Ad*Ad + Bd*Bd));
    end;
  public
    // https://stackoverflow.com/questions/238260/how-to-calculate-the-bounding-box-for-a-given-lat-lng-location
    // 'halfSideInKm' is the half length of the bounding box you want in kilometers.
    class method  GetBoundingBox(point:LocationCoordinate2D; halfSideInKm:Double):BoundingBox;
    begin
      // Bounding box surrounding the point at given coordinates,
      // assuming local approximation of Earth surface as a sphere
      // of radius given by WGS84
      var lat := Deg2rad(point.Latitude);
      var lon := Deg2rad(point.Longitude);
      var halfSide := 1000 * halfSideInKm;

      // Radius of Earth at given latitude
      var radius := WGS84EarthRadius(lat);
      // Radius of the parallel at given latitude
      var pradius := radius * Math.Cos(lat);

      var latMin := lat - halfSide / radius;
      var latMax := lat + halfSide / radius;
      var lonMin := lon - halfSide / pradius;
      var lonMax := lon + halfSide / pradius;

      exit new BoundingBox (
          MinPoint := new LocationCoordinate2D ( Latitude := Rad2deg(latMin), Longitude := Rad2deg(lonMin) ),
          MaxPoint := new LocationCoordinate2D ( Latitude := Rad2deg(latMax), Longitude := Rad2deg(lonMax) )
          );
    end;

  end;

end.
namespace Moshine.Api.Weather.Models;

uses
  Moshine.Api.Weather,
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text;

type

  GeoLocation = public class
  private
    var radLat: Double;
    var radLon: Double;
    var degLat: Double;
    var degLon: Double;
    class var MIN_LAT: Double := Helpers.ConvertDegreesToRadians(-90.0);
    class var MAX_LAT: Double := Helpers.ConvertDegreesToRadians(90.0);
    class var MIN_LON: Double := Helpers.ConvertDegreesToRadians(-180.0);
    class var MAX_LON: Double := Helpers.ConvertDegreesToRadians(180.0);
    class const earthRadius: Double = 6371.01;
    constructor;
    begin
    end;

    method CheckBounds;
    begin
      if (radLat < MIN_LAT) or (radLat > MAX_LAT) or (radLon < MIN_LON) or (radLon > MAX_LON) then begin
        raise new Exception('Arguments are out of bounds');
      end;
    end;

  public
    class method FromDegrees(latitude: Double; longitude: Double): GeoLocation;
    begin
      var &result: GeoLocation := new GeoLocation(radLat := Helpers.ConvertDegreesToRadians(latitude), radLon := Helpers.ConvertDegreesToRadians(longitude), degLat := latitude, degLon := longitude);
      &result.CheckBounds();
      exit &result;
    end;

    class method FromRadians(latitude: Double; longitude: Double): GeoLocation;
    begin
      var &result: GeoLocation := new GeoLocation(radLat := latitude, radLon := longitude, degLat := Helpers.ConvertRadiansToDegrees(latitude), degLon := Helpers.ConvertRadiansToDegrees(longitude));
      &result.CheckBounds();
      exit &result;
    end;

    // *
    //          * @return the latitude, in degrees.
    method getLatitudeInDegrees: Double;
    begin
      exit degLat;
    end;

    // *
    //          * @return the longitude, in degrees.
    method getLongitudeInDegrees: Double;
    begin
      exit degLon;
    end;

    // *
    //          * @return the latitude, in radians.
    method getLatitudeInRadians: Double;
    begin
      exit radLat;
    end;

    // *
    //          * @return the longitude, in radians.
    method getLongitudeInRadians: Double;
    begin
      exit radLon;
    end;

    method ToString: String; override;
    begin
      exit $'( {degLat} #176 {degLon} #176 = ({radLat} rad, {radLon} rad)';
    end;

    method DistanceTo(location: GeoLocation): Double;
    begin
      exit Math.Acos((Math.Sin(radLat) * Math.Sin(location.radLat)) + (Math.Cos(radLat) * Math.Cos(location.radLat) * Math.Cos(radLon - location.radLon))) * earthRadius;
    end;

    method BoundingCoordinates(distance: Double): array of GeoLocation;
    begin
      if distance < 0.0 then
        begin
        raise new Exception('Distance cannot be less than 0');
      end;
      //  angular distance in radians on a great circle
      var radDist: Double := distance / earthRadius;
      var minLat: Double := radLat - radDist;
      var maxLat: Double := radLat + radDist;
      var minLon: Double;
      var maxLon: Double;
      if (minLat > MIN_LAT) and (maxLat < MAX_LAT) then
      begin
        var deltaLon: Double := Math.Asin(Math.Sin(radDist) / Math.Cos(radLat));
        minLon := radLon - deltaLon;
        if minLon < MIN_LON then
        begin
          minLon := minLon + 2.0 * Math.PI;
        end;
        maxLon := radLon + deltaLon;
        if maxLon > MAX_LON then
        begin
          maxLon := maxLon - 2.0 * Math.PI;
        end;
      end
      else
      begin
        //  a pole is within the distance
        minLat := Math.Max(minLat, MIN_LAT);
        maxLat := Math.Min(maxLat, MAX_LAT);
        minLon := MIN_LON;
        maxLon := MAX_LON;
      end;
      exit array of GeoLocation([FromRadians(minLat, minLon), FromRadians(maxLat, maxLon)]);
    end;

  end;


end.
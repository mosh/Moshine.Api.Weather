namespace Moshine.Api.Weather.Models;

type
  {$IF TOFFEE}
  PlatformLocationCoordinate2D = public CoreLocation.CLLocationCoordinate2D;
  {$ELSE}
  PlatformLocationCoordinate2D = public class
  public
    property latitude:Double read write;
    property longitude:Double read write;

  end;
  {$ENDIF}

  LocationCoordinate2D = public class mapped to PlatformLocationCoordinate2D
  public
    property Latitude: Double read mapped.latitude write mapped.latitude;
    property Longitude: Double read mapped.longitude write mapped.longitude;

    {$IF ECHOES}
    constructor; mapped to constructor;
    {$ENDIF}

    constructor(latitudeValue:Double;longitudeValue:Double);
    begin

      {$IF TOFFEE}
      self := CoreLocation.CLLocationCoordinate2DMake(latitudeValue, longitudeValue);
      {$ELSE}
      self := new LocationCoordinate2D;
      self.Latitude := latitudeValue;
      self.Longitude := longitudeValue;
      {$ENDIF}

    end;


  end;


end.
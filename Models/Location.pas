namespace Moshine.Api.Weather.Models;

type
  {$IF TOFFEE}
  PlatformLocation = public CoreLocation.CLLocationCoordinate2D;
  {$ELSEIF ECHOES}
  PlatformLocation = public System.Device.Location.GeoCoordinate;
  {$ENDIF}


  Location = public class mapped to PlatformLocation
  end;


end.
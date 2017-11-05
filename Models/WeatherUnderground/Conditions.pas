namespace Moshine.Api.Weather;

type

  Conditions = public class
  private
    _observation:Observation := new Observation;
  protected
  public
    property Observation:Observation read _observation;
  end;

  Observation = public class
  public
    property Weather:String;
    property Temperature:Integer;
    property WindDirection:String;
    property WindDegress:Integer;
    property WindSpeed:Integer;
    property WindSpeedGusting:Integer;
    property WindAsString:String;

  end;

end.
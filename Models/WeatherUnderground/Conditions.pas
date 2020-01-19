namespace Moshine.Api.Weather.Models.WeatherUnderground;

{$IF TOFFEE}
uses
  Foundation;
{$ELSE}
{$ENDIF}



type

  Conditions = public class
  private
    _observation:Observation := new Observation;
  protected
  public
    property Observation:Observation read _observation;
  end;


end.
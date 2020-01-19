namespace Moshine.Api.Weather.Models.WeatherUnderground;

type

  Observation = public class
  private

    method get_WindAsString: String;
    begin

      if(self.WindSpeedGusting > 0) then
      begin
        exit $'From the {self.WindDirection} at {self.WindSpeed} Gusting to {self.WindSpeedGusting} Knots';
      end
      else
      begin
        exit $'From the {self.WindDirection} at {self.WindSpeed} Knots';
      end;

    end;

    method get_ShortWindAsString:String;
    begin
      if(self.WindSpeedGusting > 0) then
      begin
        exit $'{self.WindDirection} {self.WindSpeed} G {self.WindSpeedGusting} Kts';
      end
      else
      begin
        exit $'{self.WindDirection} {self.WindSpeed} Kts';
      end;
    end;

  public
    property Weather:String;
    property Temperature:Integer;
    property WindDirection:String;
    property WindDegress:Integer;
    property WindSpeed:Integer;
    property WindSpeedGusting:Integer;

    property WindAsString:String read get_WindAsString;
    property ShortWindAsString:String read get_ShortWindAsString;

    property StationId:String;
    property TemperatureString:String;
    property ObservationTimeRfc822:String;
    property ObservationEpoch:Double;
    property LocalEpoch:Double;
    property LocalTimeZoneShort:String;
    property LocalTimeZoneLong:String;
    property LocalTimeZoneOffset:Double;
    property TemperatureF:Double;
    property TemperatureC:Double;
    property RelativeHumidity:String;
    property PressureMb:Integer;
    property PressureIn:Double;
    property PressureTrend:String;
    property DewpointString:String;
    property DewpointF:Double;
    property DewpointC:Double;
    property HeatIndexString:String;
    property HeatIndexF:Double;
    property HeatIndexC:Double;
    property WindChillString:String;
    property VisibilityM:Double;
    property VisibityKm:Double;
    property Precipitation1hrString:String;
    property Precipitation1hrInch:Double;
    property Precipitation1hrMetric:Double;
    property PrecipitationTodayString:String;
    property PrecipitationTodayInch:Double;
    property PrecipitationTodayMetric:Double;

    constructor;
    begin
      self.Weather := '';
      self.WindDirection := '';

    end;

  end;

end.
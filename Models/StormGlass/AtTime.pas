namespace Moshine.Api.Weather.Models.StormGlass;

uses
  Moshine.Api.Weather,
  Moshine.Api.Weather.Models, RemObjects.Elements.RTL;

type

  AtTime = public class(IAtTime)
  private
    _someHour:Hour;
    _formatter:WeatherApiFormatter;

    method getDoubleValue(name:String):Double;
    begin
      var item := _someHour.Information.FirstOrDefault(i -> i.Name = name);
      if(not item.Values.Any)then
      begin
        writeLn($'No values for {name}');
        exit 0;
      end;
      exit _formatter.Format(DoubleValue(item.Values.First).Value);
    end;

  public

    constructor(formatter:WeatherApiFormatter;someHour:Hour);
    begin
      _someHour := someHour;
      _formatter := formatter;
    end;

    property Time:DateTime read
      begin
        exit _someHour.Time;
      end;

    property WindSpeed:Double read
      begin
        exit getDoubleValue('windSpeed');
      end;

    property WindDirection:Double read
      begin
        exit getDoubleValue('windDirection');
      end;

    property WindGust:Double read
      begin
        exit getDoubleValue('gust');
      end;


    property CurrentSpeed:Double read
      begin
        exit getDoubleValue('currentSpeed');
      end;

    property CurrentDirection:Double read
      begin
        exit getDoubleValue('currentDirection');
      end;

    property Pressure:Double read
      begin
        exit getDoubleValue('pressure');
      end;

    property CloudCover:Double read
      begin
        exit getDoubleValue('cloudCover');
      end;

    property SwellHeight:Double read
      begin
        exit getDoubleValue('swellHeight');
      end;

    property SwellDirection:Double read
      begin
        exit getDoubleValue('swellDirection');
      end;


    property WaveHeight:Double read
      begin
        exit getDoubleValue('waveHeight');
      end;


  end;

end.
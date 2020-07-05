namespace Moshine.Api.Weather.Models.StormGlass;

uses
  Moshine.Api.Weather.Models, RemObjects.Elements.RTL;

type

  AtTime = public class(IAtTime)
  private
    _someHour:Hour;
  public
    constructor(someHour:Hour);
    begin
      _someHour := someHour;
    end;

    property Time:DateTime read
      begin
        exit _someHour.Time;
      end;

    property WindSpeed:Double read
      begin
        var item := _someHour.Information.FirstOrDefault(i -> i.Name = 'windSpeed');
        exit DoubleValue(item.Values.First).Value;
      end;

    property WindDirection:Double read
      begin
        var item := _someHour.Information.FirstOrDefault(i -> i.Name = 'windDirection');
        exit DoubleValue(item.Values.First).Value;
      end;

    property WindGust:Double read
      begin
        var item := _someHour.Information.FirstOrDefault(i -> i.Name = 'gust');
        exit DoubleValue(item.Values.First).Value;
      end;


    property CurrentSpeed:Double read
      begin
        var item := _someHour.Information.FirstOrDefault(i -> i.Name = 'currentSpeed');
        exit DoubleValue(item.Values.First).Value;
      end;

    property CurrentDirection:Double read
      begin
        var item := _someHour.Information.FirstOrDefault(i -> i.Name = 'currentDirection');
        exit DoubleValue(item.Values.First).Value;
      end;

    property Pressure:Double read
      begin
        var item := _someHour.Information.FirstOrDefault(i -> i.Name = 'pressure');
        exit DoubleValue(item.Values.First).Value;
      end;

    property CloudCover:Double read
      begin
        var item := _someHour.Information.FirstOrDefault(i -> i.Name = 'cloudCover');
        exit DoubleValue(item.Values.First).Value;
      end;

    property SwellHeight:Double read
      begin
        var item := _someHour.Information.FirstOrDefault(i -> i.Name = 'swellHeight');
        exit DoubleValue(item.Values.First).Value;
      end;

    property SwellDirection:Double read
      begin
        var item := _someHour.Information.FirstOrDefault(i -> i.Name = 'swellDirection');
        exit DoubleValue(item.Values.First).Value;
      end;


    property WaveHeight:Double read
      begin
        var item := _someHour.Information.FirstOrDefault(i -> i.Name = 'waveHeight');
        exit DoubleValue(item.Values.First).Value;
      end;


  end;

end.
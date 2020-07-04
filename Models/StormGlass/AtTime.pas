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

      end;

    property WindDirection:Integer read
      begin
        var item := _someHour.Information.FirstOrDefault(i -> i.Name = 'windDirection');

      end;

    property WindGust:Double read
      begin
        var item := _someHour.Information.FirstOrDefault(i -> i.Name = 'gust');


      end;


  end;

end.
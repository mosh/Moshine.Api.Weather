namespace Moshine.Api.Weather.Models.StormGlass;

uses
  Moshine.Api.Weather.Models,
  RemObjects.Elements.RTL;

type

  Forecast = public class(IForecast)
  public
    property Hours:List<Hour>;
    property Meta:Meta;

    property WindSpeed:Double read
      begin

      end;
    property WindSpeedGusting:Double read
      begin

      end;

    property WindDirection:String read
      begin

      end;

    property ShortWindAsString:String read
      begin

      end;

    property Weather:String read
      begin

      end;

  end;
end.
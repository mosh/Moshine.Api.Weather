namespace Moshine.Api.Weather.Models.StormGlass;

uses
  Moshine.Api.Weather,
  Moshine.Api.Weather.Models,
  RemObjects.Elements.RTL;

type

  StormGlassForecast = public class(IForecast)
  private
    _times:List<IAtTime>;
    _formatter:Formatter;

  public
    property Hours:List<Hour>;
    property Meta:Meta;

    constructor(formatter:Formatter);
    begin
      _formatter := formatter;
    end;


    property Times:List<IAtTime> read
    begin
      if(not assigned(_times))then
      begin
        _times := new List<IAtTime>;
        _times.Add(Hours.Select(h ->
          begin
            var someTime:IAtTime := new AtTime(_formatter, h);
            exit someTime;
          end));
      end;

      exit _times;

    end;


  end;
end.
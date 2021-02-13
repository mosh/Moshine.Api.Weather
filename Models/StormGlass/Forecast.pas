namespace Moshine.Api.Weather.Models.StormGlass;

uses
  Moshine.Api.Weather.Models,
  RemObjects.Elements.RTL;

type

  StormGlassForecast = public class(IForecast)
  private
    _times:List<IAtTime>;

  public
    property Hours:List<Hour>;
    property Meta:Meta;

     property Times:List<IAtTime> read
      begin
        if(not assigned(_times))then
        begin
          _times := new List<IAtTime>;
          _times.Add(Hours.Select(h ->
            begin
              var someTime:IAtTime := new AtTime(h);
              exit someTime;
            end));
        end;

        exit _times;

      end;


  end;
end.
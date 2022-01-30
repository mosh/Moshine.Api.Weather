namespace Moshine.Api.Weather.Extensions;

type
  DoubleExtensions = public extension class(Double)
  private
  protected
  public
    method DegreesToCompass:String;
    begin
      var val := Integer((self/22.5)+.5);
      var arr := ['N','NNE','NE','ENE','E','ESE', 'SE', 'SSE','S','SSW','SW','WSW','W','WNW','NW','NNW'];
      exit arr[(val mod 16)];
    end;

  end;

end.
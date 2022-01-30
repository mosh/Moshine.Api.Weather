namespace Moshine.Api.Weather.Extensions;

type
  WeatherStringExtensions = public extension class(String)
  private
  protected
  public

    method DegreesToCompass(num:Double):String;
    begin
      var val := Integer((num/22.5)+.5);
      var arr := ['N','NNE','NE','ENE','E','ESE', 'SE', 'SSE','S','SSW','SW','WSW','W','WNW','NW','NNW'];
      exit arr[(val mod 16)];
    end;

  end;

end.
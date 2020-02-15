namespace Moshine.Api.Weather;

type
  Helpers = public class
  public
    class method ConvertDegreesToRadians(degrees:Double):Double;
    begin
      exit (Math.PI / 180) * degrees;
    end;

    class method ConvertRadiansToDegrees(radian:Double):Double;
    begin
      exit radian * (180.0 / Math.PI);
    end;

  end;
end.
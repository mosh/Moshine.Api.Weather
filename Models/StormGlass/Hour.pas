﻿namespace Moshine.Api.Weather.Models.StormGlass;

uses
  RemObjects.Elements.RTL;

type
  Hour = public class
  public
    property Information:List<Information>;
    property Time:DateTime;
  end;

end.
﻿namespace Moshine.Api.Weather;

{$IFDEF TOFFEE OR DARWIN}

uses
  Foundation,
  Moshine.Api.Weather.Models;

type

    CurrentConditionsURLDownloadBlock = public block(conditions:ICurrentConditions);

  [Cocoa]
  CurrentConditionsDataProvider = public class(URLSessionDownloadDelegate)
  private

    _currentConditionsDelegate:CurrentConditionsURLDownloadBlock;

  public

    constructor(currentConditionsDelegate:CurrentConditionsURLDownloadBlock);
    begin
      _currentConditionsDelegate := currentConditionsDelegate
    end;

    method URLSession(session: NSURLSession) downloadTask(downloadTask: NSURLSessionDownloadTask) didFinishDownloadingToURL(location: NSURL);
    begin


      var value := new NSString withContentsOfURL(location);

      var formatter := new WeatherApiFormatter;
      var converter := new StormGlassConverter(formatter);

      var conditions := converter.ToCurrentConditions(value);

      _currentConditionsDelegate(conditions);

    end;

    method BackgroundUrlSession:URLSession;
    begin
      var config := URLSessionConfiguration.backgroundSessionConfigurationWithIdentifier('Moshine.Api.Weather.CurrentContions');
      config.sessionSendsLaunchEvents := true;
      config.discretionary := true;

      exit URLSession.sessionWithConfiguration(config) &delegate(self) delegateQueue(nil);
    end;

  end;

{$ENDIF}

end.
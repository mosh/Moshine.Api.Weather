namespace Moshine.Api.Weather;

{$IFDEF TOFFEE OR DARWIN}

uses
  Foundation,
  Moshine.Api.Weather.Converters,
  Moshine.Api.Weather.Models;

type

  ForecastURLDownloadBlock = public block(forecast:IForecast);

  [Cocoa]
  ForecastDataProvider = public class(URLSessionDownloadDelegate)
  private
    _forecastDelegate:ForecastURLDownloadBlock;
  public

    constructor(forecastDelegate:ForecastURLDownloadBlock);
    begin
      _forecastDelegate := forecastDelegate
    end;


    method URLSession(session: NSURLSession) downloadTask(downloadTask: NSURLSessionDownloadTask) didFinishDownloadingToURL(location: NSURL);
    begin

      var value := new NSString withContentsOfURL(location);

      var formatter := new WeatherApiFormatter;
      var converter := new StormGlassConverter(formatter);

      var forecast := converter.ToForecast(value);

      _forecastDelegate(forecast);

    end;

    method BackgroundUrlSession:URLSession;
    begin
      var config := URLSessionConfiguration.backgroundSessionConfigurationWithIdentifier('Moshine.Api.Weather.Forecast');
      config.sessionSendsLaunchEvents := true;
      config.discretionary := true;

      exit URLSession.sessionWithConfiguration(config) &delegate(self) delegateQueue(nil);
    end;

  end;

{$ENDIF}


end.
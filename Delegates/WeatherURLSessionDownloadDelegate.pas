namespace Moshine.Api.Weather;

{$IFDEF TOFFEE OR DARWIN}

uses
  Foundation;

type

  WeatherURLDownloadBlock = public block(jsonText:String);

  [Cocoa]
  WeatherURLSessionDownloadDelegate = public class(URLSessionDownloadDelegate)

  private
    _block:WeatherURLDownloadBlock;
  public

    constructor (completionBlock:WeatherURLDownloadBlock);
    begin
      _block := completionBlock;
    end;

    method URLSession(session: NSURLSession) downloadTask(downloadTask: NSURLSessionDownloadTask) didFinishDownloadingToURL(location: NSURL);
    begin

      var value := new NSString withContentsOfURL(location);

      _block(value);

    end;

  end;

{$ENDIF}

end.
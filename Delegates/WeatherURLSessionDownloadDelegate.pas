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

      var error:NSError;
      var encoding:^NSStringEncoding;

      var value := NSString.stringWithContentsOfURL(location) usedEncoding(encoding) error(var error);

      if(assigned(error))then
      begin
        raise new Exception(error.description);
      end;


      _block(value);

    end;

  end;

{$ENDIF}

end.
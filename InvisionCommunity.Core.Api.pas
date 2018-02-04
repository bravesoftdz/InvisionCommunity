unit InvisionCommunity.Core.Api;

interface

uses
  System.Net.HttpClient,
  System.Net.URLClient,
  System.SysUtils;

type
  TicRequest = class
  private
    FToken: string;
    FBasicAuth: TNetHeader;
    FHttp: THTTPClient;
    FUrl: TURI;
    FOnError: TProc<Exception>;
    function GetUrl: string;
    procedure SetUrl(const Value: string);
    procedure SetToken(const Value: string);
  protected
    procedure DoCheckError(const AResponse: string);
    function Get(const Path: string): string;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Token: string read FToken write SetToken;
    property Url: string read GetUrl write SetUrl;
    property OnError: TProc<Exception> read FOnError write FOnError;
  end;

implementation

uses
  System.JSON,
  System.NetEncoding,
  InvisionCommunity.Exceptions;

{ TicRequest }

constructor TicRequest.Create;
begin
  FHttp := THTTPClient.Create;
  FHttp.AllowCookies := true;
end;

destructor TicRequest.Destroy;
begin
  FHttp.Free;
  inherited;
end;

procedure TicRequest.DoCheckError(const AResponse: string);
var
  FJSON: TJSONObject;
  LExcept: TInvisionCommunityExcception;
begin
  FJSON := TJSONObject.ParseJSONValue(AResponse) as TJSONObject;
  LExcept := TInvisionCommunityExcception.Create('');
  try
    if not FJSON.Values['errorCode'].Null then
    begin
      LExcept.Message := Format('%S: %S', [FJSON.Values['errorCode'].Value, FJSON.Values['errorMessage'].Value]);
      if Assigned(OnError) then
        OnError(LExcept)
      else
        raise LExcept;
    end;
  finally
  //  LExcept.Free;
    FJSON.Free;
  end;
end;

function TicRequest.Get(const Path: string): string;
begin
  FUrl.Path := Path;
  Result := FHttp.Get(Url, nil, [FBasicAuth]).ContentAsString;
  DoCheckError(Result);
end;

function TicRequest.GetUrl: string;
begin
  Result := FUrl.ToString;
end;

procedure TicRequest.SetToken(const Value: string);
begin
  FToken := Value;
  FBasicAuth := TNetHeader.Create('Authorization', 'Basic ' + TNetEncoding.Base64.Encode(Value + ':'));
end;

procedure TicRequest.SetUrl(const Value: string);
begin
  FUrl := TUri.Create(Value);
end;

end.


unit InvisionCommunity.Core.Api;

interface

uses
  System.Net.HttpClient,
  System.Net.URLClient,
  System.SysUtils;

type
  IicRequest = interface
    ['{12414A80-A055-4ACC-AA79-1AD6498C2194}']
    function GetUrl: string;
    procedure SetUrl(const Value: string);
    function GetToken: string;
    procedure SetToken(const Value: string);
    function GetOnError: TProc<Exception>;
    procedure SetOnError(const Value: TProc<Exception>);
    //
    property Token: string read GetToken write SetToken;
    property Url: string read GetUrl write SetUrl;
    property OnError: TProc<Exception> read GetOnError write SetOnError;
  end;

  TicRequest = class(TInterfacedObject, IicRequest)
  private
    FToken: string;
    FBasicAuth: TNetHeader;
    FHttp: THTTPClient;
    FUrl: TURI;
    FOnError: TProc<Exception>;
    function GetUrl: string;
    procedure SetUrl(const Value: string);
    procedure SetToken(const Value: string);
    function GetToken: string;
    function GetOnError: TProc<Exception>;
    procedure SetOnError(const Value: TProc<Exception>);
  protected
    procedure DoCheckError(const AResponse: string);
    function Get(const Path: string): string;
  public
    constructor Create; overload;
    constructor Create(const AUrl, AToken: string); overload;
    destructor Destroy; override;
  published
    property Token: string read GetToken write SetToken;
    property Url: string read GetUrl write SetUrl;
    property OnError: TProc<Exception> read GetOnError write SetOnError;
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
  FHttp.AllowCookies := True;
end;

constructor TicRequest.Create(const AUrl, AToken: string);
begin
  Create;
  Url := AUrl;
  Token := AToken;
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
    if Assigned(FJSON.Values['errorCode']) then
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

function TicRequest.GetOnError: TProc<Exception>;
begin
  Result := FOnError
end;

function TicRequest.GetToken: string;
begin
  Result := FToken;
end;

function TicRequest.GetUrl: string;
begin
  Result := FUrl.ToString;
end;

procedure TicRequest.SetOnError(const Value: TProc<Exception>);
begin
  FOnError := Value;
end;

procedure TicRequest.SetToken(const Value: string);
begin
  FToken := Value;
  FBasicAuth := TNetHeader.Create('Authorization', 'Basic ' + TNetEncoding.Base64.Encode(Value + ':'));
end;

procedure TicRequest.SetUrl(const Value: string);
begin
  FUrl := TURI.Create(Value);
end;

end.


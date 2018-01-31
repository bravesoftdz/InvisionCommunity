unit InvisionCommunity.Core.Api;

interface

uses
  System.Net.HttpClient,
  System.Net.URLClient;

type
  TicRequest = class
  private
    FToken: string;
    FHttp: THTTPClient;
    FUrl: TURI;
    function GetUrl: string;
    procedure SetUrl(const Value: string);
    procedure MyOnAuth(const Sender: TObject; AnAuthTarget: TAuthTargetType; const ARealm, AURL: string; var AUserName, APassword: string; var AbortAuth: Boolean; var Persistence: TAuthPersistenceType);
  protected
    function Get(const Path: string): string;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Token: string read FToken write FToken;
    property Url: string read GetUrl write SetUrl;
  end;

implementation

{ TicRequest }

constructor TicRequest.Create;
begin
  FHttp := THTTPClient.Create;
  FHttp.AuthEvent := MyOnAuth;

end;

destructor TicRequest.Destroy;
begin
  FHttp.Free;
  inherited;
end;

function TicRequest.Get(const Path: string): string;
begin
  FUrl.Path := Path;
  Result := FHttp.Get(FUrl.ToString).ContentAsString;
end;

function TicRequest.GetUrl: string;
begin
  Result := FUrl.ToString;
end;

procedure TicRequest.MyOnAuth(const Sender: TObject; AnAuthTarget: TAuthTargetType; const ARealm, AURL: string; var AUserName, APassword: string; var AbortAuth: Boolean; var Persistence: TAuthPersistenceType);
begin
  AUserName := Token;
end;

procedure TicRequest.SetUrl(const Value: string);
begin
  FUrl := TUri.Create(Value);
end;

end.


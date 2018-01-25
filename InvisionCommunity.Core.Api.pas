unit InvisionCommunity.Core.Api;

interface

uses
  System.Net.HttpClient;

type
  TicRequest = class
  private
    FToken: string;
    FHttp: THTTPClient;
    FUrl: string;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Token: string read FToken write FToken;
    property Url: string read FUrl write FUrl;
  end;

implementation

uses
  System.Net.URLClient;

{ TicRequest }

constructor TicRequest.Create;
begin
  FHttp := THTTPClient.Create;
  FHttp.AuthCallback :=
    procedure(const Sender: TObject; AnAuthTarget: TAuthTargetType; //
      const ARealm, AURL: string; var AUserName, APassword: string; //
      var AbortAuth: Boolean; var Persistence: TAuthPersistenceType)
    begin
      AUserName := Token;
    end;
end;

destructor TicRequest.Destroy;
begin
  FHttp.Free;
  inherited;
end;

end.


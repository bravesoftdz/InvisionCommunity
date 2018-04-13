unit InvisionCommunity.Exceptions;

interface

uses
  System.SysUtils;

type
  TInvisionCommunityExcception = class(Exception)
  private
    FCode: string;
  public
    constructor Create(const Code, Msg: string); overload;
  published
    property Code: string read FCode write FCode;
  end;

implementation

{ TInvisionCommunityExcception }

constructor TInvisionCommunityExcception.Create(const Code, Msg: string);
begin
  inherited Create(Msg);
  FCode := Code;
end;

end.


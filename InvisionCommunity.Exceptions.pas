unit InvisionCommunity.Exceptions;

interface

uses
  System.SysUtils;

type
  TInvisionCommunityExcception = class(Exception)
  private
    FCode: string;
  published
    property Code: string read FCode write FCode;
  end;

implementation

end.


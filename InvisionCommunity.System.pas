unit InvisionCommunity.System;

interface

uses
  InvisionCommunity.System.Types,
  InvisionCommunity.Core.Api;

type
  TicSystem = class(TicRequest)
  private
  public
    function Hello: IicSystemResult;
  end;

implementation

{ TicSystem }

function TicSystem.Hello: IicSystemResult;
var
  x: string;
begin
  x := Get('/api/core/hello');
end;

end.


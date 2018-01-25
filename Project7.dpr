program Project7;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  InvisionCommunity.System in 'InvisionCommunity.System.pas',
  InvisionCommunity.System.Types in 'InvisionCommunity.System.Types.pas',
  InvisionCommunity.Core.JsonBaseClass in 'InvisionCommunity.Core.JsonBaseClass.pas',
  InvisionCommunity.Core.Api in 'InvisionCommunity.Core.Api.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

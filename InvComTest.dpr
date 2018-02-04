program InvComTest;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  InvisionCommunity.System in 'InvisionCommunity.System.pas',
  InvisionCommunity.System.Types in 'InvisionCommunity.System.Types.pas',
  InvisionCommunity.Core.JsonBaseClass in 'InvisionCommunity.Core.JsonBaseClass.pas',
  InvisionCommunity.Core.Api in 'InvisionCommunity.Core.Api.pas',
  InvisionCommunity.Exceptions in 'InvisionCommunity.Exceptions.pas',
  System.Net.HttpClient in 'System.Net.HttpClient.pas';

procedure Test;
var
  icSystem: TicSystem;
begin
  icSystem := TicSystem.Create;
  try
    icSystem.Token := '6a0c2f53657a05dc852637fd6b49ec03';
    icSystem.Url := 'http://fire-monkey.ru';
    Writeln(icSystem.Hello.communityName);
  finally
    icSystem.Free;
  end;
end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    Test;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.


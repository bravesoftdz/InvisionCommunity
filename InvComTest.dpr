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
  InvisionCommunity.Forums in 'InvisionCommunity.Forums.pas',
  InvisionCommunity.Forums.Types in 'InvisionCommunity.Forums.Types.pas',
  InvisionCommunity.Types in 'InvisionCommunity.Types.pas';

procedure Test;
var
  icSystem: IicSystem;
  icForum: IicForums;
  I: Integer;
begin
  icSystem := TicSystem.Create('http://fire-monkey.ru', '6a0c2f53657a05dc852637fd6b49ec03');
  icForum := TicForums.Create('http://fire-monkey.ru', '6a0c2f53657a05dc852637fd6b49ec03');
  try
    with icSystem.Hello do
    begin
      Writeln(communityName);
      Writeln(communityUrl);
      Writeln(ipsVersion);
    end;
    with icForum.GetTopics do
    begin
      for I := Low(Results) to High(Results) do
        Writeln(Results[I].Title);
    end;

  finally
  //  icSystem.Free;
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


unit InvisionCommunity.Forums;

interface

uses
  InvisionCommunity.Core.Api,
  InvisionCommunity.Types,
  InvisionCommunity.Forums.Types;

type
  IicForums = interface(IicRequest)
    ['{4AA39BC9-A179-4C20-9A90-CF1D3A86E34E}']
    function GetForums: IicArray<IicForumObject>;
    function GetTopics(): IicArray<IicTopicObject>;
  end;

  TicForums = class(TicRequest, IicForums)
    function GetForums: IicArray<IicForumObject>;
    function GetTopics(): IicArray<IicTopicObject>;
  end;

implementation

{ TicSystem }

function TicForums.GetForums: IicArray<IicForumObject>;
begin
  Result := TicArray<IicForumObject>.Create(Get('/api/forums/forums'), TicForumObject);
end;

function TicForums.GetTopics: IicArray<IicTopicObject>;
begin
  Result := TicArray<IicTopicObject>.Create(Get('/api/forums/topics'), TicTopicObject);
end;

end.


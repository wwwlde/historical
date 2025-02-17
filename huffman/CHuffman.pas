unit CHuffman;

interface

uses
  SysUtils, Classes, Dialogs;

const
  ALPHABET_SIZE = 256;

type
  TTree = class;
  THuffman = class;

  { Класс узла дерева Хаффмана }
  TTree = class(TObject)
  private
    FChild0: TTree;      // Левый потомок (0)
    FChild1: TTree;      // Правый потомок (1)
    FLeaf: Boolean;      // Является ли узел листом
    FCharacter: Integer; // Символ, представленный в узле
    FWeight: Integer;    // Вес (частота) символа
  public
    procedure InitTree(Character, Weight: Integer; Leaf: Boolean);
    procedure Traverse(Code: string; HuffmanTree: THuffman);

    property Child0: TTree read FChild0 write FChild0;
    property Child1: TTree read FChild1 write FChild1;
    property Leaf: Boolean read FLeaf write FLeaf;
    property Character: Integer read FCharacter write FCharacter;
    property Weight: Integer read FWeight write FWeight;
  end;

  { Класс кодировщика Хаффмана }
  THuffman = class(TObject)
  private
    FWeights: array[0..ALPHABET_SIZE - 1] of Integer; // Частоты символов
    FCode: array[0..ALPHABET_SIZE - 1] of String;     // Закодированные символы
    FTree: array[0..ALPHABET_SIZE - 1] of TTree;      // Массив узлов дерева

    function GetCodeValue(Index: Integer): String;
    function GetTreeValue(Index: Integer): TTree;
    function GetWeightValue(Index: Integer): Integer;
    procedure SetCodeValue(Index: Integer; const Value: String);
    procedure SetTreeValue(Index: Integer; const Value: TTree);
    procedure SetWeightValue(Index: Integer; const Value: Integer);
  public
    procedure BuildCodes;
    procedure GrowTree(const Data: array of Integer);
    function GetLowestTree(Used: Integer): Integer;
    function Encode(const Data: array of Integer): String;
    function Decode(Data: String): String;

    property Weights[Index: Integer]: Integer read GetWeightValue write SetWeightValue;
    property Code[Index: Integer]: String read GetCodeValue write SetCodeValue;
    property Tree[Index: Integer]: TTree read GetTreeValue write SetTreeValue;
  end;

var
  Huffman: THuffman;

implementation

{ TTree }

procedure TTree.InitTree(Character, Weight: Integer; Leaf: Boolean);
begin
  FLeaf := Leaf;
  FCharacter := Character;
  FWeight := Weight;
end;

(* 
  Обход дерева Хаффмана для генерации кодов.
  1. Если узел - лист, записываем его код в массив.
  2. Обходим левое поддерево (добавляем '0' к коду).
  3. Обходим правое поддерево (добавляем '1' к коду).
*)
procedure TTree.Traverse(Code: String; HuffmanTree: THuffman);
begin
  if Leaf then
  begin
    HuffmanTree.Code[Ord(Character)] := Code;
    ShowMessage(Format('Символ: %s  Вес: %d  Код: %s',
      [Chr(Character), Weight, Code]));
  end;
  
  if Child0 <> nil then Child0.Traverse(Code + '0', HuffmanTree);
  if Child1 <> nil then Child1.Traverse(Code + '1', HuffmanTree);
end;

{ THuffman }

(* Находит индекс узла с наименьшим весом в массиве деревьев *)
function THuffman.GetLowestTree(Used: Integer): Integer;
var
  Min, I: Integer;
begin
  Min := 0;
  for I := 1 to Used - 1 do
    if Tree[I].Weight < Tree[Min].Weight then Min := I;

  Result := Min;
end;

(* Кодирование данных в строку из 0 и 1 *)
function THuffman.Encode(const Data: array of Integer): String;
var
  Str: String;
  I: Integer;
begin
  Str := '';
  for I := 0 to High(Data) do
    Str := Str + Code[Data[I]];
  Result := Str;
end;

(* Декодирование строки из 0 и 1 обратно в символы *)
function THuffman.Decode(Data: String): String;
var
  Str: String;
  C: Integer;
begin
  Str := '';
  while Length(Data) > 0 do
  begin
    for C := 0 to ALPHABET_SIZE - 1 do
      if (Weights[C] > 0) and (Code[C] = Copy(Data, 1, Length(Code[C]))) then
      begin
        Data := Copy(Data, Length(Code[C]) + 1, Length(Data));
        Str := Str + Chr(C) + ' - ' + Code[C] + #13;
      end;
  end;
  Result := Str;
end;

(* Построение дерева Хаффмана на основе частот символов *)
procedure THuffman.GrowTree(const Data: array of Integer);
var
  I, C, W, Min, Used, Weight0: Integer;
  Temp: TTree;
begin
  FillChar(FWeights, SizeOf(FWeights), 0);

  // Подсчитываем частоту встречаемости символов
  for I := 0 to High(Data) do
    Inc(FWeights[Data[I]]);

  Used := 0;
  
  // Создаём узлы для символов с ненулевой частотой
  for C := 0 to ALPHABET_SIZE - 1 do
  begin
    W := Weights[C];
    if W > 0 then
    begin
      Inc(Used);
      Tree[Used - 1] := TTree.Create;
      Tree[Used - 1].InitTree(C, W, True);
    end;
  end;

  // Построение дерева
  while Used > 1 do
  begin
    Min := GetLowestTree(Used);
    Weight0 := Tree[Min].Weight;

    Temp := TTree.Create;
    Temp.Child0 := Tree[Min];

    Dec(Used);
    Tree[Min] := Tree[Used];

    Min := GetLowestTree(Used);
    Temp.Child1 := Tree[Min];
    Temp.Weight := Weight0 + Tree[Min].Weight;

    Tree[Min] := Temp;
  end;
end;

(* Генерация кодов Хаффмана *)
procedure THuffman.BuildCodes;
begin
  Tree[0].Traverse('', Self);
end;

(* Методы доступа к данным класса *)
function THuffman.GetCodeValue(Index: Integer): String;
begin
  Result := FCode[Index];
end;

function THuffman.GetTreeValue(Index: Integer): TTree;
begin
  Result := FTree[Index];
end;

function THuffman.GetWeightValue(Index: Integer): Integer;
begin
  Result := FWeights[Index];
end;

procedure THuffman.SetCodeValue(Index: Integer; const Value: String);
begin
  FCode[Index] := Value;
end;

procedure THuffman.SetTreeValue(Index: Integer; const Value: TTree);
begin
  FTree[Index] := Value;
end;

procedure THuffman.SetWeightValue(Index: Integer; const Value: Integer);
begin
  FWeights[Index] := Value;
end;

end.

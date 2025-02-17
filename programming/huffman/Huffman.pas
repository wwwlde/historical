unit Huffman;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CHuffman;

type
  TForm1 = class(TForm)
    EditInput: TLabeledEdit;
    BtnEncode: TButton;
    EditEncoded: TLabeledEdit;
    BtnDecode: TButton;

    procedure BtnEncodeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnDecodeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Huffman: THuffman;

implementation

{$R *.dfm}

(* Создание объекта Huffman при запуске формы *)
procedure TForm1.FormCreate(Sender: TObject);
begin
  Huffman := THuffman.Create;
end;

(* Освобождение памяти при закрытии формы *)
procedure TForm1.FormDestroy(Sender: TObject);
begin
  Huffman.Free;
end;

(* Кодирование введённого текста *)
procedure TForm1.BtnEncodeClick(Sender: TObject);
var
  CharArray: array of Integer;
  I: Integer;
  InputText: String;
begin
  InputText := EditInput.Text;
  
  // Инициализируем массив символов
  SetLength(CharArray, Length(InputText));
  
  // Заполняем массив кодами символов
  for I := 0 to Length(InputText) - 1 do
    CharArray[I] := Ord(InputText[I + 1]); 

  // Генерируем дерево Хаффмана и коды
  Huffman.GrowTree(CharArray);
  Huffman.BuildCodes;

  // Выводим закодированную строку
  EditEncoded.Text := Huffman.Encode(CharArray);
end;

(* Декодирование закодированной строки *)
procedure TForm1.BtnDecodeClick(Sender: TObject);
begin
  ShowMessage(Huffman.Decode(EditEncoded.Text));
end;

end.

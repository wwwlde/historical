program Huffman;

uses
  Forms,
  Huffman in 'Huffman.pas' {Form1},
  CHuffman in 'CHuffman.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

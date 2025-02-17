object Form1: TForm1
  Left = 247
  Top = 108
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Denis Lemeshko (c) 2008 - Huffman'
  ClientHeight = 120
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  
  object EditInput: TLabeledEdit
    Left = 8
    Top = 24
    Width = 180
    Height = 21
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Input:'
    TabOrder = 0
  end
  
  object BtnEncode: TButton
    Left = 200
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Encode'
    TabOrder = 1
    OnClick = BtnEncodeClick
  end
  
  object EditEncoded: TLabeledEdit
    Left = 8
    Top = 72
    Width = 180
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = 'Encoded:'
    TabOrder = 2
  end
  
  object BtnDecode: TButton
    Left = 200
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Decode'
    TabOrder = 3
    OnClick = BtnDecodeClick
  end
end

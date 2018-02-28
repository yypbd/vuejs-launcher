object FormSettings: TFormSettings
  Left = 0
  Top = 0
  Caption = 'FormSettings'
  ClientHeight = 432
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 16
    Top = 23
    Width = 105
    Height = 21
    Caption = 'Nodevars'
    TabOrder = 0
  end
  object EditNodevars: TEdit
    Left = 127
    Top = 24
    Width = 278
    Height = 21
    TabOrder = 1
    Text = 'EditNodevars'
  end
  object ButtonSelectNodevars: TButton
    Left = 411
    Top = 22
    Width = 42
    Height = 25
    Caption = '...'
    TabOrder = 2
    OnClick = ButtonSelectNodevarsClick
  end
  object BitBtnOk: TBitBtn
    Left = 288
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 3
    OnClick = BitBtnOkClick
  end
  object BitBtnCancel: TBitBtn
    Left = 378
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = BitBtnCancelClick
  end
end

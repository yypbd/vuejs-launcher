object FormProject: TFormProject
  Left = 0
  Top = 0
  Caption = 'FormProject'
  ClientHeight = 240
  ClientWidth = 470
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
    Caption = 'Name'
    TabOrder = 0
  end
  object EditName: TEdit
    Left = 127
    Top = 24
    Width = 278
    Height = 21
    TabOrder = 1
    Text = 'EditName'
  end
  object Panel2: TPanel
    Left = 16
    Top = 63
    Width = 105
    Height = 21
    Caption = 'Path'
    TabOrder = 2
  end
  object EditPath: TEdit
    Left = 127
    Top = 64
    Width = 278
    Height = 21
    TabOrder = 3
    Text = 'EditPath'
  end
  object ButtonSelectPath: TButton
    Left = 411
    Top = 62
    Width = 42
    Height = 25
    Caption = '...'
    TabOrder = 4
    OnClick = ButtonSelectPathClick
  end
  object BitBtnOk: TBitBtn
    Left = 288
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 5
    OnClick = BitBtnOkClick
  end
  object BitBtnCancel: TBitBtn
    Left = 378
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 6
    OnClick = BitBtnCancelClick
  end
  object Panel3: TPanel
    Left = 16
    Top = 103
    Width = 105
    Height = 21
    Caption = 'Path'
    TabOrder = 7
  end
  object ComboBoxFrameworkType: TComboBox
    Left = 127
    Top = 103
    Width = 278
    Height = 21
    Style = csDropDownList
    TabOrder = 8
  end
end

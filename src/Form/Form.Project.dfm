object FormProject: TFormProject
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'FormProject'
  ClientHeight = 237
  ClientWidth = 464
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
  object ShapeSep: TShape
    Left = 16
    Top = 160
    Width = 422
    Height = 1
  end
  object PanelName: TPanel
    Left = 16
    Top = 23
    Width = 105
    Height = 21
    BevelInner = bvLowered
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
  object PanelPath: TPanel
    Left = 16
    Top = 63
    Width = 105
    Height = 21
    BevelInner = bvLowered
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
    Width = 22
    Height = 25
    Caption = '...'
    TabOrder = 4
    OnClick = ButtonSelectPathClick
  end
  object BitBtnOk: TBitBtn
    Left = 268
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 5
    OnClick = BitBtnOkClick
  end
  object BitBtnCancel: TBitBtn
    Left = 358
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 6
    OnClick = BitBtnCancelClick
  end
  object PanelFramework: TPanel
    Left = 16
    Top = 103
    Width = 105
    Height = 21
    BevelInner = bvLowered
    Caption = 'Framework'
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

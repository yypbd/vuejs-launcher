object FormSettings: TFormSettings
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'FormSettings'
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
  object PanelNodevars: TPanel
    Left = 16
    Top = 23
    Width = 105
    Height = 21
    BevelInner = bvLowered
    Caption = 'Nodevars.bat'
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
    Width = 22
    Height = 25
    Caption = '...'
    TabOrder = 2
    OnClick = ButtonSelectNodevarsClick
  end
  object BitBtnOk: TBitBtn
    Left = 268
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 3
    OnClick = BitBtnOkClick
  end
  object BitBtnCancel: TBitBtn
    Left = 358
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = BitBtnCancelClick
  end
  object PanelDefaultProjectPath: TPanel
    Left = 16
    Top = 59
    Width = 105
    Height = 21
    BevelInner = bvLowered
    Caption = 'Default Project Path'
    TabOrder = 5
  end
  object EditDefaultProjectPath: TEdit
    Left = 127
    Top = 60
    Width = 278
    Height = 21
    TabOrder = 6
    Text = 'EditNodevars'
  end
  object ButtonDefaultProjectPath: TButton
    Left = 411
    Top = 58
    Width = 22
    Height = 25
    Caption = '...'
    TabOrder = 7
    OnClick = ButtonDefaultProjectPathClick
  end
end

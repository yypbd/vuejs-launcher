object FormVuejsLauncherMain: TFormVuejsLauncherMain
  Left = 0
  Top = 0
  Caption = 'FormVuejsLauncherMain'
  ClientHeight = 409
  ClientWidth = 635
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
  object BitBtnConfig: TBitBtn
    Left = 16
    Top = 12
    Width = 113
    Height = 45
    Caption = 'Config'
    TabOrder = 0
    OnClick = BitBtnConfigClick
  end
  object BitBtn1: TBitBtn
    Left = 324
    Top = 32
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object Panel1: TPanel
    Left = 16
    Top = 116
    Width = 509
    Height = 213
    TabOrder = 2
    object ListViewProject: TListView
      Left = 8
      Top = 55
      Width = 493
      Height = 150
      Columns = <
        item
          Width = 100
        end
        item
          Width = 250
        end
        item
          Width = 100
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnDblClick = ListViewProjectDblClick
    end
    object Panel2: TPanel
      Left = 8
      Top = 8
      Width = 493
      Height = 41
      TabOrder = 1
      object BitBtnProjectAdd: TBitBtn
        Left = 12
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 0
        OnClick = BitBtnProjectAddClick
      end
      object BitBtnProjectUpdate: TBitBtn
        Left = 93
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Update'
        TabOrder = 1
        OnClick = BitBtnProjectUpdateClick
      end
      object BitBtnProjectDelete: TBitBtn
        Left = 174
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 2
        OnClick = BitBtnProjectDeleteClick
      end
    end
  end
end

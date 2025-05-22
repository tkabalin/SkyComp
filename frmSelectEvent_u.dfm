object frmSelectEvent: TfrmSelectEvent
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Select Event'
  ClientHeight = 146
  ClientWidth = 389
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object lblContinue: TLabel
    Left = 32
    Top = 18
    Width = 217
    Height = 16
    Caption = 'Continue one of your previous events:'
  end
  object lblStartNew: TLabel
    Left = 32
    Top = 83
    Width = 208
    Height = 16
    Caption = 'Would you like to start a new event?'
  end
  object btnSelect: TButton
    Left = 255
    Top = 40
    Width = 90
    Height = 25
    Caption = 'Select'
    TabOrder = 1
    OnClick = btnSelectClick
  end
  object btnCreateNew: TButton
    Left = 255
    Top = 80
    Width = 90
    Height = 25
    Hint = 'Create a new event'
    Caption = 'Create Event'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnCreateNewClick
  end
  object cmbEvents: TComboBox
    Left = 32
    Top = 40
    Width = 217
    Height = 24
    TabOrder = 0
  end
end

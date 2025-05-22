object frmQualification: TfrmQualification
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Qualification'
  ClientHeight = 295
  ClientWidth = 442
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
  object lblQualiTime: TLabel
    Left = 24
    Top = 215
    Width = 128
    Height = 16
    Caption = 'Qualification Time (s):'
  end
  object lblHeading: TLabel
    Left = 24
    Top = 11
    Width = 268
    Height = 16
    Caption = 'Enter the qualification time of each participant:'
    WordWrap = True
  end
  object lstSelected: TListBox
    Left = 24
    Top = 40
    Width = 382
    Height = 169
    TabOrder = 0
    OnClick = lstSelectedClick
  end
  object edtQualiTime: TEdit
    Left = 24
    Top = 237
    Width = 128
    Height = 24
    TabOrder = 1
    OnExit = edtQualiTimeExit
  end
  object btnNext: TButton
    Left = 331
    Top = 237
    Width = 75
    Height = 25
    Caption = 'Next'
    TabOrder = 3
    OnClick = btnNextClick
  end
  object btnCancel: TButton
    Left = 250
    Top = 237
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = btnCancelClick
  end
  object btnEnter: TButton
    Left = 158
    Top = 237
    Width = 50
    Height = 25
    Caption = 'Enter'
    TabOrder = 2
    OnClick = btnEnterClick
  end
end

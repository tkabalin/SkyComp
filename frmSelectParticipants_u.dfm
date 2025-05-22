object frmSelectParticipants: TfrmSelectParticipants
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Select Participants'
  ClientHeight = 435
  ClientWidth = 599
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object lblRegistered: TLabel
    Left = 32
    Top = 26
    Width = 136
    Height = 16
    Caption = 'Registered Participants:'
  end
  object lblSelected: TLabel
    Left = 344
    Top = 26
    Width = 195
    Height = 16
    Caption = 'Selected Participants (8 or more):'
  end
  object lstParticipants: TListBox
    Left = 32
    Top = 48
    Width = 220
    Height = 170
    Sorted = True
    TabOrder = 0
    OnDblClick = lstParticipantsDblClick
  end
  object btnDelete: TButton
    Left = 120
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 5
    OnClick = btnDeleteClick
  end
  object lstSelected: TListBox
    Left = 344
    Top = 48
    Width = 220
    Height = 170
    Sorted = True
    TabOrder = 6
    OnDblClick = lstSelectedDblClick
  end
  object btnNext: TButton
    Left = 504
    Top = 250
    Width = 75
    Height = 25
    Hint = 'Proceed to entering qualification times'
    Caption = 'Next'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnNextClick
  end
  object btnSelect: TButton
    Left = 271
    Top = 64
    Width = 50
    Height = 25
    Hint = 'Select'
    Caption = '>'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnSelectClick
  end
  object btnSelectAll: TButton
    Left = 271
    Top = 95
    Width = 50
    Height = 25
    Hint = 'Select all'
    Caption = '>>'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnSelectAllClick
  end
  object btnRemove: TButton
    Left = 271
    Top = 143
    Width = 50
    Height = 25
    Hint = 'Deselect'
    Caption = '<'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnRemoveClick
  end
  object btnRemoveAll: TButton
    Left = 271
    Top = 174
    Width = 50
    Height = 25
    Hint = 'Deselect all'
    Caption = '<<'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnRemoveAllClick
  end
  object btnAddNew: TButton
    Left = 32
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Add New'
    TabOrder = 3
    OnClick = btnAddNewClick
  end
  object pnlCreateAccount: TPanel
    Left = -8
    Top = 281
    Width = 607
    Height = 152
    BevelEdges = []
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWhite
    ParentBackground = False
    TabOrder = 4
    object lblFirstName: TLabel
      Left = 38
      Top = 14
      Width = 67
      Height = 16
      Caption = 'First Name:'
    end
    object lblSurname: TLabel
      Left = 204
      Top = 14
      Width = 57
      Height = 16
      Caption = 'Surname:'
    end
    object lblDateOfBirth: TLabel
      Left = 37
      Top = 90
      Width = 76
      Height = 16
      Caption = 'Date of Birth:'
    end
    object edtFirstName: TEdit
      Left = 38
      Top = 36
      Width = 150
      Height = 24
      TabOrder = 0
    end
    object edtSurname: TEdit
      Left = 204
      Top = 36
      Width = 150
      Height = 24
      TabOrder = 1
    end
    object dtpDateOfBirth: TDatePicker
      Left = 129
      Top = 80
      Width = 132
      Height = 37
      Date = 44746.000000000000000000
      DateFormat = 'dd/MM/yyyy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 2
    end
    object rgpGender: TRadioGroup
      Left = 376
      Top = 16
      Width = 82
      Height = 105
      Caption = 'Gender:'
      Items.Strings = (
        'Male'
        'Female'
        'Other')
      TabOrder = 3
    end
    object btnConfirm: TButton
      Left = 495
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Confirm'
      TabOrder = 4
      OnClick = btnConfirmClick
    end
    object btnCancelCreate: TButton
      Left = 495
      Top = 57
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 5
      OnClick = btnCancelCreateClick
    end
  end
  object btnBack: TButton
    Left = 423
    Top = 250
    Width = 75
    Height = 25
    Caption = 'Back'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = btnBackClick
  end
  object btnCancel: TButton
    Left = 328
    Top = 250
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 11
    OnClick = btnCancelClick
  end
end

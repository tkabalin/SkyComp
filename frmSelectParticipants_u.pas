unit frmSelectParticipants_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, dbmSkyComp_u,
  frmOrganiser_u, Vcl.ExtCtrls, Vcl.WinXPickers, frmQualification_u,
  System.UITypes;

type
  TfrmSelectParticipants = class(TForm)
    lstParticipants: TListBox;
    btnDelete: TButton;
    lstSelected: TListBox;
    btnNext: TButton;
    lblRegistered: TLabel;
    lblSelected: TLabel;
    btnSelect: TButton;
    btnSelectAll: TButton;
    btnRemove: TButton;
    btnRemoveAll: TButton;
    btnAddNew: TButton;
    pnlCreateAccount: TPanel;
    edtFirstName: TEdit;
    edtSurname: TEdit;
    rgpGender: TRadioGroup;
    dtpDateOfBirth: TDatePicker;
    lblFirstName: TLabel;
    lblSurname: TLabel;
    lblDateOfBirth: TLabel;
    btnConfirm: TButton;
    btnCancelCreate: TButton;
    btnBack: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure GetParticipants;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure btnRemoveAllClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnAddNewClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCancelCreateClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure lstParticipantsDblClick(Sender: TObject);
    procedure lstSelectedDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmSelectParticipants: TfrmSelectParticipants;

implementation

uses
  frmSelectEvent_u;

{$R *.dfm}

procedure TfrmSelectParticipants.GetParticipants;
begin
  lstParticipants.Clear;
  // Loop through the database and add each registered participant to the list
  dbmSkyComp.tblParticipants.First;
  while not dbmSkyComp.tblParticipants.Eof do
  begin
    if lstSelected.Items.IndexOf(dbmSkyComp.tblParticipants['FirstName'] + ' ' +
      dbmSkyComp.tblParticipants['Surname']) = -1 then
    begin
      lstParticipants.Items.Add(dbmSkyComp.tblParticipants['FirstName'] + ' ' +
        dbmSkyComp.tblParticipants['Surname']);
    end;
    dbmSkyComp.tblParticipants.Next;
  end;
end;

procedure TfrmSelectParticipants.lstParticipantsDblClick(Sender: TObject);
begin
  // Check if a participant has been selected
  if lstParticipants.ItemIndex = -1 then
  begin
    MessageDlg('Select a participant', mtError, [mbOk], 0)
  end
  // Check that the number selected will not exceed the maximum
  else if ((lstSelected.Items.Count + 1) > 100) then
  begin
    MessageDlg('Cannot have more than 100 participants', mtError, [mbOk], 0);
  end
  else
  begin
    // Move the participant to the selected list
    lstSelected.Items.Add(lstParticipants.Items[lstParticipants.ItemIndex]);
    lstParticipants.Items.Delete(lstParticipants.ItemIndex);
  end;
end;

procedure TfrmSelectParticipants.lstSelectedDblClick(Sender: TObject);
begin
  // Check if a participant has been selected
  if lstSelected.ItemIndex = -1 then
  begin
    MessageDlg('Select a participant', mtError, [mbOk], 0)
  end
  else
  begin
    // Remove the participant from the selected list
    lstParticipants.Items.Add(lstSelected.Items[lstSelected.ItemIndex]);
    lstSelected.Items.Delete(lstSelected.ItemIndex);
  end;
end;

procedure TfrmSelectParticipants.btnAddNewClick(Sender: TObject);
begin
  frmSelectParticipants.Height := 470;
  pnlCreateAccount.Show;
end;

procedure TfrmSelectParticipants.btnBackClick(Sender: TObject);
begin
  frmSelectParticipants.Hide;
  frmSelectEvent.Show;
end;

procedure TfrmSelectParticipants.btnCancelClick(Sender: TObject);
begin
  frmSelectParticipants.Hide;
end;

procedure TfrmSelectParticipants.btnCancelCreateClick(Sender: TObject);
begin
  pnlCreateAccount.Hide;
  frmSelectParticipants.Height := 340;
  edtFirstName.Text := '';
  edtSurname.Text := '';
  rgpGender.ItemIndex := -1;
  dtpDateOfBirth.Date := Date;
end;

procedure TfrmSelectParticipants.btnConfirmClick(Sender: TObject);
var
  sFirstName, sSurname, sFullName: string;
  dtDateOfBirth: TDate;
  cGender: Char;
  bLocate: boolean;
  iCharacter: Integer;
begin
  pnlCreateAccount.Hide;
  frmSelectParticipants.Height := 340;

  // Validate first name for blanks and length
  if (edtFirstName.Text = '') or (length(edtFirstName.Text) > 50) then
  begin
    MessageDlg('Enter a valid first name', mtError, [mbOk], 0);
    exit;
  end
  else
    sFirstName := edtFirstName.Text;

  // Validate surname for blanks and length
  if (edtSurname.Text = '') or (length(edtSurname.Text) > 50) then
  begin
    MessageDlg('Enter a valid surname', mtError, [mbOk], 0);
    exit;
  end
  else
    sSurname := edtSurname.Text;

  sFullName := sFirstName + sSurname;
  for iCharacter := 1 to length(sFullName) do
  begin
    // Check if the character is in valid range
    if not(sFullName[iCharacter] in ['A' .. 'Z', 'a' .. 'z']) then
    begin
      MessageDlg('Name contains invalid character(s)', mtError,
        [mbOk], 0);
      exit;
    end;
  end;

  // Validate the date of birth
  if dtpDateOfBirth.Date >= Date - 365 then
  begin
    MessageDlg('Participant must be at least 1 year old', mtError, [mbOk], 0);
    exit;
  end
  else
    dtDateOfBirth := dtpDateOfBirth.Date;

  // Get the gender from the radio group
  case rgpGender.ItemIndex of
    - 1:
      begin
        MessageDlg('Select a gender', mtError, [mbOk], 0);
        exit;
      end;
    0:
      cGender := 'M';
    1:
      cGender := 'F';
    2:
      cGender := '0';
  end;

  // Validate that the full name is not a duplicate
  bLocate := dbmSkyComp.tblParticipants.Locate('FirstName;Surname',
    VarArrayOf([sFirstName, sSurname]), []);

  if (bLocate = true) then
  begin
    MessageDlg('Participant already exists', mtError, [mbOk], 0);
  end
  else
  begin
    // Add the participant to the database
    with dbmSkyComp do
    begin
      tblParticipants.Append;
      tblParticipants['FirstName'] := sFirstName;
      tblParticipants['Surname'] := sSurname;
      tblParticipants['DateOfBirth'] := dtDateOfBirth;
      tblParticipants['Gender'] := cGender;
      tblParticipants.Post;
      tblParticipants.Refresh;
    end;
    lstSelected.Items.Add(sFirstName + ' ' + sSurname);
    MessageDlg('Participant Created', mtInformation, [mbOk], 0)
  end;

  edtFirstName.Clear;
  edtSurname.Clear;
  rgpGender.ItemIndex := -1;
  dtpDateOfBirth.Date := Date;

end;

procedure TfrmSelectParticipants.btnDeleteClick(Sender: TObject);
var
  iItemIndex: Integer;
  sFirstName, sSurname, sName: string;
begin
  // Check that a participant has been selected
  iItemIndex := lstParticipants.ItemIndex;
  if iItemIndex = -1 then
  begin
    MessageDlg('Select a participant', mtError, [mbOk], 0);
    exit;
  end;
  sName := lstParticipants.Items[iItemIndex];

  // Confirm deletion with the user
  if MessageDlg
    (('This action cannot be undone.'#13'Are you sure you want to delete ' +
    sName + '?'), mtConfirmation, mbYesNoCancel, 0) = mrYes then
  begin
    // Separate the first name and surname
    sFirstName := Copy(sName, 1, Pos(' ', sName) - 1);
    Delete(sName, 1, Pos(' ', sName));
    sSurname := sName;

    // Locate and delete the participant
    with dbmSkyComp do
    begin
      tblParticipants.Locate('FirstName;Surname',
        VarArrayOf([sFirstName, sSurname]), []);
      tblParticipants.Edit;
      tblParticipants.Delete;
      tblParticipants.Edit;
      tblParticipants.Post;
    end;
    GetParticipants;
  end;
end;

procedure TfrmSelectParticipants.btnNextClick(Sender: TObject);
var
  iNumSelected, iItem, iEventID: Integer;
  sFirstName, sSurname, sItem: String;
begin
  sFirstName := '';
  iNumSelected := lstSelected.Items.Count;
  dbmSkyComp.tblEvents.Locate('EventName', frmSelectEvent.sEventName, []);
  iEventID := dbmSkyComp.tblEvents['EventID'];

  // Check that at least 8 participants have been selected
  if iNumSelected < 8 then
  begin
    MessageDlg('Select 8 or more participants', mtError, [mbOk], 0);
  end
  else
  begin
    // Add each participant in lstSelected to the results table
    for iItem := 0 to iNumSelected - 1 do
    begin
      sItem := lstSelected.Items[iItem];
      sFirstName := Copy(sItem, 1, Pos(' ', sItem) - 1);
      Delete(sItem, 1, Pos(' ', sItem));
      sSurname := sItem;
      with dbmSkyComp do
      begin
        tblResults.Append;
        tblParticipants.Locate('FirstName;Surname',
          VarArrayOf([sFirstName, sSurname]), []);
        tblResults['ParticipantID'] := dbmSkyComp.tblParticipants
          ['ParticipantID'];
        tblResults['EventID'] := iEventID;
        tblResults.Post;
      end;
    end;
    frmQualification.Show;
    frmSelectParticipants.Hide;
  end;

end;

procedure TfrmSelectParticipants.btnRemoveAllClick(Sender: TObject);
begin
  lstSelected.Clear;
  GetParticipants;
end;

procedure TfrmSelectParticipants.btnRemoveClick(Sender: TObject);
begin
  // Check that a participant has been selected
  if lstSelected.ItemIndex = -1 then
  begin
    MessageDlg('Select a participant', mtError, [mbOk], 0)
  end
  else
  begin
    // Remove the participant from the selected list
    lstParticipants.Items.Add(lstSelected.Items[lstSelected.ItemIndex]);
    lstSelected.Items.Delete(lstSelected.ItemIndex);
  end;
end;

procedure TfrmSelectParticipants.btnSelectAllClick(Sender: TObject);
var
  iItem: Integer;
begin
  // Validate that no more than 100 participants will be selected
  if ((lstParticipants.Items.Count + lstSelected.Items.Count) > 100) then
  begin
    MessageDlg('Cannot have more than 100 participants', mtError, [mbOk], 0);
  end
  else
  begin
    // Add each participant to the selected list
    for iItem := lstParticipants.Items.Count - 1 downto 0 do
    begin
      lstSelected.Items.Add(lstParticipants.Items[iItem]);
      lstParticipants.Items.Delete(iItem);
    end;
  end;
end;

procedure TfrmSelectParticipants.btnSelectClick(Sender: TObject);
begin
  // Check that a participant has been selected
  if lstParticipants.ItemIndex = -1 then
  begin
    MessageDlg('Select a participant', mtError, [mbOk], 0)
  end
  // Check that the number selected will not exceed the maximum
  else if ((lstSelected.Items.Count + 1) > 100) then
  begin
    MessageDlg('Cannot have more than 100 participants', mtError, [mbOk], 0);
  end
  else
  begin
    // Move the participant to the selected list
    lstSelected.Items.Add(lstParticipants.Items[lstParticipants.ItemIndex]);
    lstParticipants.Items.Delete(lstParticipants.ItemIndex);
  end;
end;

procedure TfrmSelectParticipants.FormActivate(Sender: TObject);
begin
  frmSelectParticipants.Height := 340;
  pnlCreateAccount.Hide;
end;

procedure TfrmSelectParticipants.FormCreate;
begin
  frmSelectParticipants.Height := 340;
  pnlCreateAccount.Hide;
  dtpDateOfBirth.Date := Date;
end;

procedure TfrmSelectParticipants.FormDeactivate(Sender: TObject);
begin
  GetParticipants;
  lstSelected.Clear;
end;

procedure TfrmSelectParticipants.FormShow(Sender: TObject);
begin
  GetParticipants;
end;

end.

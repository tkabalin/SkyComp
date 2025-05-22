unit frmQualification_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  dbmSkyComp_u,
  Vcl.StdCtrls, frmOrganiser_u, System.UITypes;

type
  TfrmQualification = class(TForm)
    lstSelected: TListBox;
    edtQualiTime: TEdit;
    lblQualiTime: TLabel;
    lblHeading: TLabel;
    btnNext: TButton;
    btnCancel: TButton;
    btnEnter: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure lstSelectedClick(Sender: TObject);
    procedure btnEnterClick(Sender: TObject);
    procedure GetSelected;
    procedure btnNextClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EnterTime();
    procedure edtQualiTimeExit(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQualification: TfrmQualification;
  iPartID, iIndex: integer;
  sFirstName, sSurname, sName: string;

implementation

uses
  frmSelectParticipants_u, frmSelectEvent_u;

{$R *.dfm}

procedure TfrmQualification.GetSelected;
begin
  lstSelected.Clear;
  dbmSkyComp.tblResults.First;

  while not dbmSkyComp.tblResults.Eof do
  begin
    // Check if result entry belongs to current event
    if dbmSkyComp.tblResults['EventID'] = frmSelectEvent.iEventID then
    begin
      // Locate the participant ID from the results table in the participants table
      dbmSkyComp.tblParticipants.Locate('ParticipantID',
        dbmSkyComp.tblResults['ParticipantID'], []);

      // Check if qualifying time is blank
      if dbmSkyComp.tblResults['Qualifying'] <> null then
      begin
        // Add the name and qualifying time of the participant
        lstSelected.Items.Add(dbmSkyComp.tblParticipants['FirstName'] + ' ' +
          dbmSkyComp.tblParticipants['Surname'] + ' - ' +
          FloatToStr(dbmSkyComp.tblResults['Qualifying']) + 's');
      end
      else
      begin
        // Add the name of the participant
        lstSelected.Items.Add(dbmSkyComp.tblParticipants['FirstName'] + ' ' +
          dbmSkyComp.tblParticipants['Surname'] + ' ');
      end;
    end;
    dbmSkyComp.tblResults.Next;
  end;
end;

procedure TfrmQualification.btnCancelClick(Sender: TObject);
begin
  frmQualification.Hide;
end;

procedure TfrmQualification.btnEnterClick(Sender: TObject);
begin
  EnterTime;
end;

procedure TfrmQualification.btnNextClick(Sender: TObject);
var
  bNull: boolean;
begin
  // Check that no qualification times are missing
  bNull := false;
  dbmSkyComp.tblResults.First;
  while (not dbmSkyComp.tblResults.Eof) do
  begin
    if (dbmSkyComp.tblResults['EventID'] = frmSelectEvent.iEventID) AND
      (dbmSkyComp.tblResults['Qualifying'] = null) then
    begin
      bNull := true;
    end;
    dbmSkyComp.tblResults.Next;
  end;

  if bNull = true then
  begin
    MessageDlg('Qualification times missing', mtError, [mbOk], 0);
  end
  else
  begin
    frmOrganiser.show;
    frmQualification.Hide;
  end;
end;

procedure TfrmQualification.edtQualiTimeExit(Sender: TObject);
begin
  EnterTime;
end;

procedure TfrmQualification.EnterTime;
var
  rQualiTime: real;
  iCode: integer;
begin
  // Validate the time
  Val(edtQualiTime.Text, rQualiTime, iCode);
  if (iCode <> 0) OR (rQualiTime <= 0) then
  begin
    MessageDlg('Enter a valid number', mtError, [mbOk], 0);
  end
  else
  begin
    // Locate the name in the participants table
    sName := lstSelected.Items[iIndex];
    sFirstName := Copy(sName, 1, Pos(' ', sName) - 1);
    Delete(sName, 1, Pos(' ', sName));
    sSurname := Copy(sName, 1, Pos(' ', sName) - 1);

    dbmSkyComp.tblParticipants.Locate('FirstName;Surname',
      VarArrayOf([sFirstName, sSurname]), []);

    // Get the participant ID
    iPartID := dbmSkyComp.tblParticipants['ParticipantID'];

    // Locate the correct entry in tblResults
    dbmSkyComp.tblResults.Locate('ParticipantID;EventID',
      VarArrayOf([iPartID, frmSelectEvent.iEventID]), []);

    // Add the qualification time to the results time
    dbmSkyComp.tblResults.Edit;
    dbmSkyComp.tblResults['Qualifying'] := rQualiTime;
    dbmSkyComp.tblResults.Post;
    GetSelected;
  end;
end;

procedure TfrmQualification.FormShow(Sender: TObject);
begin
  GetSelected;
end;

procedure TfrmQualification.lstSelectedClick(Sender: TObject);
begin
  sName := '';
  // Check that a participant has been selected
  if lstSelected.ItemIndex = -1 then
  begin
    MessageDlg('Select a participant', mtError, [mbOk], 0);
  end
  else
  begin
    edtQualiTime.Text := '';
    // Locate the name in the participants table
    iIndex := lstSelected.ItemIndex;
    sName := lstSelected.Items[iIndex];
    sFirstName := Copy(sName, 1, Pos(' ', sName) - 1);
    Delete(sName, 1, Pos(' ', sName));
    sSurname := Copy(sName, 1, Pos(' ', sName) - 1);

    dbmSkyComp.tblParticipants.Locate('FirstName;Surname',
      VarArrayOf([sFirstName, sSurname]), []);

    // Get the participant ID
    iPartID := dbmSkyComp.tblParticipants['ParticipantID'];

    // Locate the correct entry in tblResults
    dbmSkyComp.tblResults.Locate('ParticipantID;EventID',
      VarArrayOf([iPartID, frmSelectEvent.iEventID]), []);

    // Display the qualification time (if it is not blank)
    if dbmSkyComp.tblResults['Qualifying'] <> null then
      edtQualiTime.Text := dbmSkyComp.tblResults['Qualifying'];
  end;
end;

end.

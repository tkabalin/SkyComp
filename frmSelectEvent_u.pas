unit frmSelectEvent_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  dbmSkyComp_u, frmOrganiser_u, frmSelectParticipants_u, frmQualification_u,
  System.UITypes;

type
  TfrmSelectEvent = class(TForm)
    btnSelect: TButton;
    btnCreateNew: TButton;
    lblContinue: TLabel;
    cmbEvents: TComboBox;
    lblStartNew: TLabel;
    procedure btnCreateNewClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sEventName: string;
    iEventID: integer;
  end;

var
  frmSelectEvent: TfrmSelectEvent;

implementation

uses
  frmLogin_u;

{$R *.dfm}

procedure TfrmSelectEvent.btnCreateNewClick(Sender: TObject);
var
  iCharacter : integer;
begin
  sEventName := '';

  // Allow the user to enter an event name
  if Inputquery('Event Name', 'Enter the name of your event:', sEventName) = true
  then
  begin
    // Validate the event name for blanks, length and duplicates
    if sEventName = '' then
    begin
      MessageDlg('Event name cannot be blank', mtError, [mbOk], 0);
      exit;
    end;
    if Length(sEventName) > 50 then
    begin
      MessageDlg('Event name cannot be more than 50 characters', mtError,
        [mbOk], 0);
      exit;
    end;
    if dbmSkyComp.tblEvents.Locate('EventName', sEventName, []) = true then
    begin
      MessageDlg('Event already exists', mtError, [mbOk], 0);
      exit;
    end;

    for iCharacter := 1 to Length(sEventName) do
    begin
      // Check if the character is in valid range
      if not(sEventName[iCharacter] in ['0' .. '9', 'A' .. 'Z', 'a' .. 'z',
         '-', '_', '@', '.']) then
      begin
         MessageDlg('Event name contains invalid character(s)', mtError, [mbOk], 0);
         exit;
      end;
    end;

    // Add the event to the database
    with dbmSkyComp do
    begin
      tblEvents.Append;
      tblEvents['EventName'] := sEventName;
      tblEvents['OrganiserEmail'] := frmLogin.sEmail;
      tblEvents['EventCompleted'] := false;
      tblEvents.Post;
      tblEvents.Last;
    end;
    iEventID := dbmSkyComp.tblEvents['EventID'];
    // Proceed to the next stage
    frmSelectEvent.hide;
    frmSelectParticipants.show;

  end;

end;

procedure TfrmSelectEvent.btnSelectClick(Sender: TObject);
var
  bNull: boolean;
begin
  sEventName := cmbEvents.Text;
  bNull := false;

  // Get the Event ID
  dbmSkyComp.tblEvents.Locate('EventName', sEventName, []);
  iEventID := dbmSkyComp.tblEvents['EventID'];

  // Check if event has participants selected
  if dbmSkyComp.tblResults.Locate('EventID', iEventID, []) = true then
  begin
    // Check if there are blank qualification times
    dbmSkyComp.tblResults.First;
    while not dbmSkyComp.tblResults.Eof do
    begin
      if (dbmSkyComp.tblResults['EventID'] = iEventID) AND
        (dbmSkyComp.tblResults['Qualifying'] = null) then
      begin
        bNull := true;
      end;
      dbmSkyComp.tblResults.next;
    end;

    // Allow the user to enter qualification times if their are missing ones
    if bNull = true then
    begin
      frmQualification.show;
    end
    // Allow the user to proceed directly to the organiser form if their are no missing times
    else
      frmOrganiser.show;
  end
  // Allow the user to select participants if they haven't been selected
  else
    frmSelectParticipants.show;

  frmSelectEvent.hide;
end;

procedure TfrmSelectEvent.FormShow(Sender: TObject);
begin
  // Populate the combo box with all of the in-progress events that belong to the current user
  cmbEvents.Clear;
  dbmSkyComp.tblEvents.First;
  while not dbmSkyComp.tblEvents.Eof do
  begin
    // Check if organiser of the event is the current user
    if (dbmSkyComp.tblEvents['OrganiserEmail'] = frmLogin.sEmail) then
    begin
      cmbEvents.Items.Add(dbmSkyComp.tblEvents['EventName']);
    end;
    dbmSkyComp.tblEvents.next;
  end;
end;

end.

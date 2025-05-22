{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit frmOrganiser_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.WinXCtrls, Vcl.ExtCtrls,
  Vcl.WinXPickers, dbmSkyComp_u, Vcl.Imaging.jpeg, Vcl.Buttons,
  Vcl.Imaging.pngimage, math, System.UITypes, strUtils, ADOInt;

type
  TfrmOrganiser = class(TForm)
    pgcOrganiser: TPageControl;
    tbsEdit: TTabSheet;
    tbsView: TTabSheet;
    dbgResults: TDBGrid;
    edtSearch: TEdit;
    tgsQualified: TToggleSwitch;
    lblQualified: TLabel;
    edtFirstName: TEdit;
    edtSurname: TEdit;
    dtpDateOfBirth: TDatePicker;
    rgpGender: TRadioGroup;
    cmbSort: TComboBox;
    btnFirst: TButton;
    btnLast: TButton;
    btnSaveChanges: TButton;
    btnRevert: TButton;
    imgSkyHeader: TImage;
    imgLogoHeader: TImage;
    lblSurname: TLabel;
    lblFirstName: TLabel;
    lblDateOfBirth: TLabel;
    gbNavigation: TGroupBox;
    lblSearch: TLabel;
    lblSort: TLabel;
    bttClose: TBitBtn;
    pnlTournamentPlan: TPanel;
    btnLeaderboard: TButton;
    imgTournamentBracket: TImage;
    lblQuali1: TLabel;
    lblQuali8: TLabel;
    lblQuali4: TLabel;
    lblQuali3: TLabel;
    lblQuali5: TLabel;
    lblQuali6: TLabel;
    lblQuali2: TLabel;
    lblQuali7: TLabel;
    lblR2_1: TLabel;
    lblR2_4: TLabel;
    lblR2_3: TLabel;
    lblR2_2: TLabel;
    lblR3_1: TLabel;
    lblR3_2: TLabel;
    lblWinner: TLabel;
    lblSelect: TLabel;
    gbEvent: TGroupBox;
    cbxEventCompleted: TCheckBox;
    edtEventName: TEdit;
    lblEventName: TLabel;
    btnSaveEvent: TButton;
    gbParticipant: TGroupBox;
    bttSavePlan: TBitBtn;
    procedure tgsQualifiedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgResultsCellClick(Column: TColumn);
    procedure btnFirstClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure PopulateEdt();
    procedure btnRevertClick(Sender: TObject);
    procedure cmbSortChange(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure btnSaveChangesClick(Sender: TObject);
    procedure FilterQualified();
    procedure pgcOrganiserChange(Sender: TObject);
    procedure lblQuali1Click(Sender: TObject);
    procedure lblQuali8Click(Sender: TObject);
    procedure lblQuali4Click(Sender: TObject);
    procedure lblQuali3Click(Sender: TObject);
    procedure lblQuali5Click(Sender: TObject);
    procedure lblQuali6Click(Sender: TObject);
    procedure lblQuali2Click(Sender: TObject);
    procedure lblQuali7Click(Sender: TObject);
    procedure lblR2_1Click(Sender: TObject);
    procedure lblR2_4Click(Sender: TObject);
    procedure lblR2_3Click(Sender: TObject);
    procedure lblR2_2Click(Sender: TObject);
    procedure lblR3_1Click(Sender: TObject);
    procedure lblR3_2Click(Sender: TObject);
    procedure btnSaveEventClick(Sender: TObject);
    procedure btnLeaderboardClick(Sender: TObject);
    procedure DisplayPlan();
    procedure GeneratePlan();
    procedure InputTime(sFullName: string; iRoundNum: integer);
    procedure FormShow(Sender: TObject);
    procedure bttSavePlanClick(Sender: TObject);
    procedure bttCloseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmOrganiser: TfrmOrganiser;
  arrQualified: array [1 .. 8] of string;
  arrR1Times: array [1 .. 8] of real;
  arrRound2: array [1 .. 4] of string;
  arrR2Times: array [1 .. 4] of real;
  arrRound3: array [1 .. 2] of string;
  arrR3Times: array [1 .. 2] of real;
  sWinner: string;

implementation

uses
  frmSelectEvent_u;

{$R *.dfm}

procedure TfrmOrganiser.btnFirstClick(Sender: TObject);
begin
  dbmSkyComp.qryResultsForEvent.First;
end;

procedure TfrmOrganiser.btnLastClick(Sender: TObject);
begin
  dbmSkyComp.qryResultsForEvent.last;
end;

procedure TfrmOrganiser.btnLeaderboardClick(Sender: TObject);
var
  tLeaderboard: TextFile;
  sFileName, sTemp: string;
  bFlag: boolean;
  rTemp: real;
  iPos, iIndex: integer;

  arrRound1_Sort: array [1 .. 8] of string;
  arrR1Times_Sort: array [1 .. 8] of real;
  arrRound2_Sort: array [1 .. 4] of string;
  arrR2Times_Sort: array [1 .. 4] of real;
  arrRound3_Sort: array [1 .. 2] of string;
  arrR3Times_Sort: array [1 .. 2] of real;
begin
  // Copy the contents of the origional arrays to new arrays that can be sorted
  for iIndex := 1 to 8 do
    arrRound1_Sort[iIndex] := arrQualified[iIndex];
  for iIndex := 1 to 8 do
    arrR1Times_Sort[iIndex] := arrR1Times[iIndex];
  for iIndex := 1 to 4 do
    arrRound2_Sort[iIndex] := arrRound2[iIndex];
  for iIndex := 1 to 4 do
    arrR2Times_Sort[iIndex] := arrR2Times[iIndex];
  for iIndex := 1 to 2 do
    arrRound3_Sort[iIndex] := arrRound3[iIndex];
  for iIndex := 1 to 2 do
    arrR3Times_Sort[iIndex] := arrR3Times[iIndex];

  // Create the text file to write to
  sFileName := frmSelectEvent.sEventName + ' - Leaderboard.txt';
  AssignFile(tLeaderboard, sFileName);
  Rewrite(tLeaderboard);
  Writeln(tLeaderboard, 'LEADERBOARD - ' + frmSelectEvent.sEventName);
  Writeln(tLeaderboard, '');
  Writeln(tLeaderboard, 'POSITION' + #9 + 'FULL NAME');

  // Sort the round 3 array by times
  iIndex := 1;
  if arrR3Times_Sort[iIndex] > arrR3Times_Sort[iIndex + 1] then
  begin
    rTemp := arrR3Times_Sort[iIndex];
    arrR3Times_Sort[iIndex] := arrR3Times_Sort[iIndex + 1];
    arrR3Times_Sort[iIndex + 1] := rTemp;

    sTemp := arrRound3_Sort[iIndex];
    arrRound3_Sort[iIndex] := arrRound3_Sort[iIndex + 1];
    arrRound3_Sort[iIndex + 1] := sTemp;
  end;

  // Add first and second place to the text file
  for iPos := 1 to 2 do
  begin
    Writeln(tLeaderboard, IntToStr(iPos) + #9#9 + arrRound3_Sort[iPos]);
  end;

  // Set the participants that made it through to round 3 to blank
  for iIndex := 1 to 4 do
  begin
    if MatchStr(arrRound2_Sort[iIndex], arrRound3_Sort) = true then
    begin
      arrRound2_Sort[iIndex] := '';
      arrR2Times_Sort[iIndex] := -1;
    end;
  end;

  // Sort the round 2 results
  // The blank participants will go to the top and will be ignored when writing to prevent duplicates
  repeat
    bFlag := true;
    for iIndex := 1 to 3 do
    begin
      if arrR2Times_Sort[iIndex] > arrR2Times_Sort[iIndex + 1] then
      begin
        rTemp := arrR2Times_Sort[iIndex];
        arrR2Times_Sort[iIndex] := arrR2Times_Sort[iIndex + 1];
        arrR2Times_Sort[iIndex + 1] := rTemp;

        sTemp := arrRound2_Sort[iIndex];
        arrRound2_Sort[iIndex] := arrRound2_Sort[iIndex + 1];
        arrRound2_Sort[iIndex + 1] := sTemp;

        bFlag := false;
      end;
    end;
  until bFlag = true;

  // Add positions 3 and 4 to the text file
  for iPos := 3 to 4 do
  begin
    Writeln(tLeaderboard, IntToStr(iPos) + #9#9 + arrRound2_Sort[iPos]);
  end;

  // Set the participants that made it through to round 2 to blank
  for iIndex := 1 to 8 do
  begin
    if MatchStr(arrRound1_Sort[iIndex], arrRound2_Sort) = true then
    begin
      arrRound1_Sort[iIndex] := '';
      arrR1Times_Sort[iIndex] := -1;
    end;
  end;

  // Sort the round 1 results
  repeat
    bFlag := true;
    for iIndex := 1 to 7 do
    begin
      if arrR1Times_Sort[iIndex] > arrR1Times_Sort[iIndex + 1] then
      begin
        rTemp := arrR1Times_Sort[iIndex];
        arrR1Times_Sort[iIndex] := arrR1Times_Sort[iIndex + 1];
        arrR1Times_Sort[iIndex + 1] := rTemp;

        sTemp := arrRound1_Sort[iIndex];
        arrRound1_Sort[iIndex] := arrRound1_Sort[iIndex + 1];
        arrRound1_Sort[iIndex + 1] := sTemp;

        bFlag := false;
      end;
    end;
  until bFlag = true;

  // Add the final 4 people that qualified to the text file
  for iPos := 5 to 8 do
  begin
    Writeln(tLeaderboard, IntToStr(iPos) + #9#9 + arrRound1_Sort[iPos]);
  end;

  CloseFile(tLeaderboard);

  MessageDlg('Leaderboard generated', mtInformation, [mbOk], 0);
end;

procedure TfrmOrganiser.btnRevertClick(Sender: TObject);
begin
  PopulateEdt;
end;

procedure TfrmOrganiser.btnSaveChangesClick(Sender: TObject);
var
  sFirstName, sSurname, sOldFirstName, sOldSurname, sOldFullName,
    sFullName: string;
  dtDateOfBirth: TDateTime;
  cGender: Char;
  iNumDuplicates, iCharacter: integer;
begin
  // Validate the first name for length and blanks
  if (edtFirstName.Text = '') or (length(edtFirstName.Text) > 50) then
  begin
    MessageDlg('Enter a valid first name', mtError, [mbOk], 0);
    exit;
  end
  else
    sFirstName := edtFirstName.Text;

  // Validate the surname name for length and blanks
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
      MessageDlg('Name contains invalid character(s)', mtError, [mbOk], 0);
      exit;
    end;
  end;

  // Prevent the user from creating a duplicate participant
  iNumDuplicates := 0;

  // If the user has not changed the first name and surname, decreate the number of duplicates by 1
  // to allow the participant being counted when checking for duplicates

  if (dbmSkyComp.tblParticipants['FirstName'] = sFirstName) AND
    (dbmSkyComp.tblParticipants['Surname'] = sSurname) then
  begin
    Dec(iNumDuplicates);
  end;

  // Count the number of times the name and surname appear
  dbmSkyComp.tblParticipants.First;
  while not dbmSkyComp.tblParticipants.Eof do
  begin
    if (dbmSkyComp.tblParticipants['FirstName'] = sFirstName) AND
      (dbmSkyComp.tblParticipants['Surname'] = sSurname) then
    begin
      inc(iNumDuplicates);
    end;
    dbmSkyComp.tblParticipants.Next;
  end;

  // Check if there are any duplicates found
  if iNumDuplicates > 0 then
  begin
    MessageDlg('Participant already exists', mtError, [mbOk], 0);
    exit;
  end;

  // Validate the date of birth
  if dtpDateOfBirth.Date >= Date - 365 then
  begin
    MessageDlg('Participant must be at least 1 year old', mtError, [mbOk], 0);
    exit;
  end
  else
    dtDateOfBirth := dtpDateOfBirth.Date;

  // Extract the gender from the radio group
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
      cGender := 'O';
  end;

  // Get the old first name and surname so that the correct participant can be located for editing
  sOldFullName := dbmSkyComp.qryResultsForEvent['FullName'];
  sOldFirstName := Copy(sOldFullName, 1, Pos(' ', sOldFullName) - 1);
  Delete(sOldFullName, 1, Pos(' ', sOldFullName));
  sOldSurname := sOldFullName;

  // Add the participant to the database
  with dbmSkyComp do
  begin
    tblParticipants.Locate('FirstName;Surname',
      VarArrayOf([sOldFirstName, sOldSurname]), []);

    tblParticipants.edit;
    tblParticipants['FirstName'] := sFirstName;
    tblParticipants['Surname'] := sSurname;
    tblParticipants['DateOfBirth'] := dtDateOfBirth;
    tblParticipants['Gender'] := cGender;
    tblParticipants.Post;
    tblParticipants.Refresh;

    tblResults.Locate('ParticipantID;EventID',
      VarArrayOf([tblParticipants['ParticipantID'],
      frmSelectEvent.iEventID]), []);

    qryPart_Results_Child.Requery;
    qryResultsForEvent.Requery;
  end;
  MessageDlg('Participant Updated', mtInformation, [mbOk], 0);
end;

procedure TfrmOrganiser.btnSaveEventClick(Sender: TObject);
var
  sNewEventName: string;
  iCharacter: integer;
begin
  sNewEventName := edtEventName.Text;

  // Validate the new event name for blanks, length and duplicates
  if sNewEventName = '' then
  begin
    MessageDlg('Event name cannot be blank', mtError, [mbOk], 0);
    exit;
  end;
  if length(sNewEventName) > 50 then
  begin
    MessageDlg('Event name cannot be more than 50 characters', mtError,
      [mbOk], 0);
    exit;
  end;
  if dbmSkyComp.tblEvents.Locate('EventName', sNewEventName, []) = true then
  begin
    MessageDlg('Event already exists', mtError, [mbOk], 0);
    exit;
  end;

  for iCharacter := 1 to length(sNewEventName) do
  begin
    // Check if the character is in valid range
    if not(sNewEventName[iCharacter] in ['0' .. '9', 'A' .. 'Z', 'a' .. 'z',
      '-', '_', '@', '.']) then
    begin
      MessageDlg('Event name contains invalid character(s)', mtError,
        [mbOk], 0);
      exit;
    end;
  end;

  // If the new name is valid, then update it in the database
  with dbmSkyComp do
  begin
    tblEvents.Locate('EventID', frmSelectEvent.iEventID, []);
    tblEvents.edit;
    tblEvents['EventName'] := sNewEventName;
    tblEvents.Post;
    tblEvents.Refresh;
    qryPart_Results_Child.Requery();
    qryResultsForEvent.Requery();
  end;
  frmSelectEvent.sEventName := sNewEventName;
  edtEventName.Text := sNewEventName;
  frmOrganiser.Caption := frmSelectEvent.sEventName;
  MessageDlg('Event Name Changed', mtInformation, [mbOk], 0)
end;

procedure TfrmOrganiser.bttCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmOrganiser.bttSavePlanClick(Sender: TObject);
var
  dlgSavePlan: tsavedialog;
  bitPlan: tbitmap;
  rectRectange: trect;
begin
  // Create a custom save dialog
  dlgSavePlan := tsavedialog.Create(self);
  with dlgSavePlan do
  begin
    Title := 'Save the tournament plan';
    InitialDir := GetCurrentDir;
    Filter := 'Bitmap file|*.bmp';
    DefaultExt := 'bmp';
    FilterIndex := 1;
    FileName := frmSelectEvent.sEventName + ' - Event Plan';
  end;

  if dlgSavePlan.Execute then
  begin
    // Create a image from the contents of pnlTournamentPlan
    bitPlan := tbitmap.Create;
    try
      rectRectange := pnlTournamentPlan.ClientRect;
      bitPlan.SetSize(rectRectange.Width, rectRectange.Height);
      pnlTournamentPlan.PaintTo(bitPlan.Canvas, 0, 0);
      bitPlan.Canvas.CopyRect(rectRectange, bitPlan.Canvas, rectRectange);

      // Save it in the location and with the name specified by the user
      bitPlan.SaveToFile(dlgSavePlan.FileName);
    finally
      bitPlan.Free;
    end;
  end;

  dlgSavePlan.Free;
end;

procedure TfrmOrganiser.cmbSortChange(Sender: TObject);
begin
  dbmSkyComp.qryResultsForEvent.Sort := cmbSort.Text;
end;

procedure TfrmOrganiser.dbgResultsCellClick(Column: TColumn);
begin
  PopulateEdt;
end;

procedure TfrmOrganiser.DisplayPlan;
begin
  // Populate the labels from the relevant arrays
  lblQuali1.Caption := arrQualified[1];
  lblQuali2.Caption := arrQualified[2];
  lblQuali3.Caption := arrQualified[3];
  lblQuali4.Caption := arrQualified[4];
  lblQuali5.Caption := arrQualified[5];
  lblQuali6.Caption := arrQualified[6];
  lblQuali7.Caption := arrQualified[7];
  lblQuali8.Caption := arrQualified[8];

  lblR2_1.Caption := arrRound2[1];
  lblR2_2.Caption := arrRound2[2];
  lblR2_3.Caption := arrRound2[3];
  lblR2_4.Caption := arrRound2[4];

  lblR3_1.Caption := arrRound3[1];
  lblR3_2.Caption := arrRound3[2];

  lblWinner.Caption := sWinner;
end;

procedure TfrmOrganiser.edtSearchChange(Sender: TObject);
begin
  // Search the query for a partial match of the search entered
  dbmSkyComp.qryResultsForEvent.Locate('FullName', edtSearch.Text,
    [loPartialKey]);
end;

procedure TfrmOrganiser.FilterQualified;
var
  iRecord: integer;
  r8thQuali: real;
begin
  dbmSkyComp.qryResultsForEvent.Sort := 'Qualifying';

  // Find the person with the 8th fastest qualifying time
  dbmSkyComp.qryResultsForEvent.First;
  for iRecord := 1 to 8 do
  begin
    r8thQuali := dbmSkyComp.qryResultsForEvent['Qualifying'];
    dbmSkyComp.qryResultsForEvent.Next;
  end;

  // Filter the query to only show the top 8 partcipants
  // The rest did not qualify for the next stage of the competition
  dbmSkyComp.qryResultsForEvent.Filtered := false;
  dbmSkyComp.qryResultsForEvent.Filter := 'Qualifying <= ' +
    FloatToStr(r8thQuali);
  dbmSkyComp.qryResultsForEvent.Filtered := true;
  cmbSort.ItemIndex := 1;
  lblQualified.Caption := 'Show All';
  tgsQualified.State := tssOff;
end;

procedure TfrmOrganiser.FormActivate(Sender: TObject);
begin
  // Display the event details
  edtEventName.Text := frmSelectEvent.sEventName;
  // Check if the event is already completed or not
  dbmSkyComp.tblEvents.Locate('EventID', frmSelectEvent.iEventID, []);

  if dbmSkyComp.tblEvents['EventCompleted'] = true then
  begin
    cbxEventCompleted.Checked := true;
    btnLeaderboard.Enabled := true
  end
  else
    cbxEventCompleted.Checked := false;
end;

procedure TfrmOrganiser.FormCreate(Sender: TObject);
var
  iIndex: integer;
begin
  imgLogoHeader.Picture.LoadFromFile('SkyComp_Logo_Header.png');
  imgSkyHeader.Picture.LoadFromFile('Night_Sky2_Resized.jpg');
  imgTournamentBracket.Picture.LoadFromFile('Tournament_Bracket_Resized.jpg');
  pgcOrganiser.TabIndex := 0;
  btnLeaderboard.Enabled := false;

  // Initialise the (global) arrays
  for iIndex := 1 to 8 do
    arrR1Times[iIndex] := 0;
  for iIndex := 1 to 4 do
    arrR2Times[iIndex] := 0;
  for iIndex := 1 to 2 do
    arrR3Times[iIndex] := 0;
  for iIndex := 1 to 8 do
    arrQualified[iIndex] := '';
  for iIndex := 1 to 4 do
    arrRound2[iIndex] := '';
  for iIndex := 1 to 2 do
    arrRound3[iIndex] := '';
  sWinner := '';
end;

procedure TfrmOrganiser.FormShow(Sender: TObject);
begin
  frmOrganiser.Caption := frmSelectEvent.sEventName;

  // Create a query based on the child query created in the database module and tblEvents
  // The query shows the full names and results of all the participants of the current event
  with dbmSkyComp do
  begin
    qryResultsForEvent.Close;
    qryResultsForEvent.SQL.Clear;

    qryResultsForEvent.SQL.Add
      ('SELECT qryPart_results_Child.FirstName & " " & qryPart_Results_Child.Surname AS FullName, qryPart_Results_Child.Qualifying, qryPart_Results_Child.Round1, qryPart_Results_Child.Round2, qryPart_Results_Child.Round3');
    qryResultsForEvent.SQL.Add
      ('FROM tblEvents LEFT JOIN qryPart_Results_Child ON tblEvents.EventID = qryPart_Results_Child.EventID');
    qryResultsForEvent.SQL.Add('WHERE (((tblEvents.EventID)=' +
      IntToStr(frmSelectEvent.iEventID) + '))');
    qryResultsForEvent.Open;
  end;

  // Populate the DB grid
  dbgResults.DataSource := dbmSkyComp.dscResultsForEvent;
  dbgResults.Columns.Items[0].Width := 200;

  dbmSkyComp.qryResultsForEvent.GetFieldNames(cmbSort.Items);
  dbmSkyComp.qryResultsForEvent.Sort := 'Qualifying';
  FilterQualified;
  tgsQualified.State := tssOff;
end;

procedure TfrmOrganiser.GeneratePlan;
var
  iRecord: integer;
begin
  FilterQualified;

  // Populate the array with everyone that qualified
  dbmSkyComp.qryResultsForEvent.First;
  for iRecord := 1 to 8 do
  begin
    arrQualified[iRecord] := dbmSkyComp.qryResultsForEvent['FullName'];
    dbmSkyComp.qryResultsForEvent.Next;
  end;

  // Get the round 1 times of everyone that qualified
  dbmSkyComp.qryResultsForEvent.First;
  for iRecord := 1 to 8 do
  begin
    if dbmSkyComp.qryResultsForEvent['Round1'] <> null then
      arrR1Times[iRecord] := dbmSkyComp.qryResultsForEvent['Round1'];

    dbmSkyComp.qryResultsForEvent.Next;
  end;

  // Check times have been recorded for a particiular match
  // Then allow the faster participant to proceed to the next round
  // If their times were the same, their previous times are used

  // Round 1
  if (arrR1Times[1] <> 0) and (arrR1Times[8] <> 0) then
  begin
    if arrR1Times[1] <= arrR1Times[8] then
    begin
      arrRound2[1] := arrQualified[1];
    end
    else
      arrRound2[1] := arrQualified[8];
  end;

  if (arrR1Times[4] <> 0) and (arrR1Times[5] <> 0) then
  begin
    if arrR1Times[4] <= arrR1Times[5] then
    begin
      arrRound2[4] := arrQualified[4];
    end
    else
      arrRound2[4] := arrQualified[5];
  end;

  if (arrR1Times[3] <> 0) and (arrR1Times[6] <> 0) then
  begin
    if arrR1Times[3] <= arrR1Times[6] then
    begin
      arrRound2[3] := arrQualified[3];
    end
    else
      arrRound2[3] := arrQualified[6];
  end;

  if (arrR1Times[2] <> 0) and (arrR1Times[7] <> 0) then
  begin
    if arrR1Times[2] <= arrR1Times[7] then
    begin
      arrRound2[2] := arrQualified[2];
    end
    else
      arrRound2[2] := arrQualified[7];
  end;

  // Round 2
  for iRecord := 1 to 4 do
  begin
    dbmSkyComp.qryResultsForEvent.Locate('FullName', arrRound2[iRecord], []);
    if dbmSkyComp.qryResultsForEvent['Round2'] <> null then
    begin
      arrR2Times[iRecord] := dbmSkyComp.qryResultsForEvent['Round2'];
    end;
  end;

  if (arrR2Times[1] <> 0) and (arrR2Times[4] <> 0) then
  begin
    if arrR2Times[1] <= arrR2Times[4] then
    begin
      arrRound3[1] := arrRound2[1];
    end
    else
      arrRound3[1] := arrRound2[4];
  end;

  if (arrR2Times[2] <> 0) and (arrR2Times[3] <> 0) then
  begin
    if arrR2Times[2] <= arrR2Times[3] then
    begin
      arrRound3[2] := arrRound2[2];
    end
    else
      arrRound3[2] := arrRound2[3];
  end;

  // Round 3
  for iRecord := 1 to 2 do
  begin
    dbmSkyComp.qryResultsForEvent.Locate('FullName', arrRound3[iRecord], []);
    if dbmSkyComp.qryResultsForEvent['Round3'] <> null then
    begin
      arrR3Times[iRecord] := dbmSkyComp.qryResultsForEvent['Round3'];
    end;
  end;

  if (arrR3Times[1] <> 0) and (arrR3Times[2] <> 0) then
  begin
    if arrR3Times[1] <= arrR3Times[2] then
    begin
      sWinner := arrRound3[1];
    end
    else
      sWinner := arrRound3[2];

    // Set the event to complete in tblEvents
    with dbmSkyComp do
    begin
      tblEvents.Locate('EventID;EventName',
        VarArrayOf([frmSelectEvent.iEventID, frmSelectEvent.sEventName]), []);
      tblEvents.edit;
      tblEvents['EventCompleted'] := true;
      // This line is required to prevent the "row cannot be located for updating" error
      tblEvents.Properties['Update Criteria'].Value := adCriteriaKey;
      tblEvents.Post;
      tblEvents.Refresh;
    end;

    cbxEventCompleted.Checked := true;
    btnLeaderboard.Enabled := true;
  end;
end;

procedure TfrmOrganiser.InputTime(sFullName: string; iRoundNum: integer);
var
  sFirstName, sSurname, sTime: string;
  iParticipantID, iError: integer;
  rTime: real;
begin
  sTime := '';
  // Validate that a participant has been assigned to that slot
  if sFullName <> '' then
  begin
    dbmSkyComp.qryResultsForEvent.Locate('FullName', sFullName, []);
    // Allow the user to enter a time for that participant, for that round
    if InputQuery('Round ' + IntToStr(iRoundNum) + ' Time',
      'Enter ' + sFullName + '''s round ' + IntToStr(iRoundNum) + ' time (s)',
      sTime) then
    begin
      // Separate the first name and surname
      sFirstName := Copy(sFullName, 1, Pos(' ', sFullName) - 1);
      Delete(sFullName, 1, Pos(' ', sFullName));
      sSurname := sFullName;

      // Validate that the number is valid
      Val(sTime, rTime, iError);
      if (iError <> 0) OR (rTime < 1) then
      begin
        MessageDlg('Enter a valid number', mtError, [mbOk], 0);
      end
      else
      begin
        with dbmSkyComp do
        begin
          // Locate the participant in the results table
          tblParticipants.Locate('FirstName;Surname',
            VarArrayOf([sFirstName, sSurname]), []);

          iParticipantID := tblParticipants['ParticipantID'];

          tblResults.Locate('ParticipantID;EventID',
            VarArrayOf([iParticipantID, frmSelectEvent.iEventID]), []);

          // Update the results table with the inputted time
          tblResults.edit;
          tblResults['Round' + IntToStr(iRoundNum)] := rTime;
          tblResults.Post;
          tblResults.Refresh;
          qryPart_Results_Child.Requery();
          qryResultsForEvent.Requery();
        end;
        GeneratePlan;
        DisplayPlan;
      end;
    end;
  end;
end;

procedure TfrmOrganiser.lblQuali1Click(Sender: TObject);
begin
  InputTime(lblQuali1.Caption, 1);
end;

procedure TfrmOrganiser.lblQuali2Click(Sender: TObject);
begin
  InputTime(lblQuali2.Caption, 1);
end;

procedure TfrmOrganiser.lblQuali3Click(Sender: TObject);
begin
  InputTime(lblQuali3.Caption, 1);
end;

procedure TfrmOrganiser.lblQuali4Click(Sender: TObject);
begin
  InputTime(lblQuali4.Caption, 1);
end;

procedure TfrmOrganiser.lblQuali5Click(Sender: TObject);
begin
  InputTime(lblQuali5.Caption, 1);
end;

procedure TfrmOrganiser.lblQuali6Click(Sender: TObject);
begin
  InputTime(lblQuali6.Caption, 1);
end;

procedure TfrmOrganiser.lblQuali7Click(Sender: TObject);
begin
  InputTime(lblQuali7.Caption, 1);
end;

procedure TfrmOrganiser.lblQuali8Click(Sender: TObject);
begin
  InputTime(lblQuali8.Caption, 1);
end;

procedure TfrmOrganiser.lblR2_1Click(Sender: TObject);
begin
  InputTime(lblR2_1.Caption, 2);
end;

procedure TfrmOrganiser.lblR2_2Click(Sender: TObject);
begin
  InputTime(lblR2_2.Caption, 2);
end;

procedure TfrmOrganiser.lblR2_3Click(Sender: TObject);
begin
  InputTime(lblR2_3.Caption, 2);
end;

procedure TfrmOrganiser.lblR2_4Click(Sender: TObject);
begin
  InputTime(lblR2_4.Caption, 2);
end;

procedure TfrmOrganiser.lblR3_1Click(Sender: TObject);
begin
  InputTime(lblR3_1.Caption, 3);
end;

procedure TfrmOrganiser.lblR3_2Click(Sender: TObject);
begin
  InputTime(lblR3_2.Caption, 3);
end;

procedure TfrmOrganiser.pgcOrganiserChange(Sender: TObject);
begin
  GeneratePlan;
  DisplayPlan;
  PopulateEdt;
end;

procedure TfrmOrganiser.PopulateEdt;
var
  sFirstName, sSurname, sFullName: string;
begin
  // Get the current participant's information from tblParticipants and display it

  // Separate the first name and the surname
  sFullName := dbmSkyComp.qryResultsForEvent['FullName'];
  sFirstName := Copy(sFullName, 1, Pos(' ', sFullName) - 1);
  Delete(sFullName, 1, Pos(' ', sFullName));
  sSurname := sFullName;

  edtFirstName.Text := sFirstName;
  edtSurname.Text := sSurname;

  dbmSkyComp.tblParticipants.Locate('FirstName;Surname',
    VarArrayOf([sFirstName, sSurname]), []);

  dtpDateOfBirth.Date := dbmSkyComp.tblParticipants['DateOfBirth'];

  if dbmSkyComp.tblParticipants['Gender'] = 'M' then
    rgpGender.ItemIndex := 0;
  if dbmSkyComp.tblParticipants['Gender'] = 'F' then
    rgpGender.ItemIndex := 1;
  if dbmSkyComp.tblParticipants['Gender'] = 'O' then
    rgpGender.ItemIndex := 2;

end;

procedure TfrmOrganiser.tgsQualifiedClick(Sender: TObject);
begin
  // Allow the user to toggle between viewing all participants and just those that qualified
  if tgsQualified.IsOn = true then
  begin
    lblQualified.Caption := 'Show Qualified';
    dbmSkyComp.qryResultsForEvent.Filtered := false
  end
  else
  begin
    FilterQualified;
  end;
end;

end.

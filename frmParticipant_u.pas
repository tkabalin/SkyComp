unit frmParticipant_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dbmSkyComp_u, Vcl.Imaging.jpeg,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.WinXPickers,
  Data.DB, Vcl.Grids, Vcl.DBGrids, frmOrganiser_u, Vcl.DBCtrls, System.UITypes;

type
  TfrmParticipant = class(TForm)
    imgLogoHeader: TImage;
    bttClose: TBitBtn;
    imgSkyHeader: TImage;
    rgpGender: TRadioGroup;
    lblSurname: TLabel;
    edtSurname: TEdit;
    dtpDateOfBirth: TDatePicker;
    lblDateOfBirth: TLabel;
    lblFirstName: TLabel;
    edtFirstName: TEdit;
    dbgResults: TDBGrid;
    gbDetails: TGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bttCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmParticipant: TfrmParticipant;

implementation

uses
  frmLogin_u;

{$R *.dfm}

procedure TfrmParticipant.bttCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmParticipant.FormCreate(Sender: TObject);
begin
  imgLogoHeader.Picture.LoadFromFile('SkyComp_Logo_Header.png');
  imgSkyHeader.Picture.Create.LoadFromFile('Night_Sky2_Resized.jpg');
end;

procedure TfrmParticipant.FormShow(Sender: TObject);
begin
  // Set the caption of the form to the particpant's name
  frmParticipant.Caption := dbmSkyComp.tblParticipants['FirstName'] + ' ' +
    dbmSkyComp.tblParticipants['Surname'];

  // Create a query based on the child query created in the database module and tblEvents
  // The query shows the results for all events that the logged in participant has participated in
  with dbmSkyComp do
  begin
    qryResultsForEvent.Close;
    qryResultsForEvent.SQL.Clear;
    qryResultsForEvent.SQL.Add
      ('SELECT tblEvents.EventName, qryPart_Results_Child.Qualifying, qryPart_Results_Child.Round1, qryPart_Results_Child.Round2, qryPart_Results_Child.Round3');
    qryResultsForEvent.SQL.Add
      ('FROM qryPart_Results_Child INNER JOIN tblEvents ON qryPart_Results_Child.EventID = tblEvents.EventID');
    qryResultsForEvent.SQL.Add('WHERE (((qryPart_Results_Child.ParticipantID)='
      + IntToStr(frmLogin.iID) + '))');
    qryResultsForEvent.Open;
  end;

  // Populate the DB grid
  dbgResults.DataSource := dbmSkyComp.dscResultsForEvent;
  dbgResults.Columns.Items[0].Width := 200;

  // Get the current participant's information from tblParticipants and display it
  with dbmSkyComp do
  begin
    edtFirstName.Text := tblParticipants['FirstName'];
    edtSurname.Text := tblParticipants['Surname'];
    dtpDateOfBirth.Date := tblParticipants['DateOfBirth'];
    if tblParticipants['Gender'] = 'M' then
    begin
      rgpGender.ItemIndex := 0;
      rgpGender.Buttons[1].Enabled := false;
      rgpGender.Buttons[2].Enabled := false;
    end;
    if tblParticipants['Gender'] = 'F' then
    begin
      rgpGender.ItemIndex := 1;
      rgpGender.Buttons[0].Enabled := false;
      rgpGender.Buttons[2].Enabled := false;
    end;
    if tblParticipants['Gender'] = 'O' then
    begin
      rgpGender.ItemIndex := 2;
      rgpGender.Buttons[0].Enabled := false;
      rgpGender.Buttons[1].Enabled := false;
    end;
  end;

end;

end.

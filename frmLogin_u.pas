unit frmLogin_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Math, frmCreateAccount_u, Vcl.Imaging.jpeg,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, strUtils, Vcl.Imaging.pngimage,
  System.UITypes, frmParticipant_u, dbmSkyComp_u, frmOrganiser_u,
  frmSelectEvent_u, frmSelectParticipants_u, frmQualification_u;

type
  TfrmLogin = class(TForm)
    edtEmailID: TEdit;
    edtCaptcha: TEdit;
    btnLogin: TButton;
    bttClose: TBitBtn;
    lblEmail: TLabel;
    lblCaptcha: TLabel;
    lblNoAccount: TLabel;
    lblCreateAccount: TLabel;
    bttRefresh: TBitBtn;
    imgNightSky: TImage;
    lblLogin: TLabel;
    imgLogo: TImage;
    btnPartLog: TButton;
    lblError: TLabel;
    imgCaptcha: TImage;
    procedure lblCreateAccountClick(Sender: TObject);
    procedure bttCloseClick(Sender: TObject);
    procedure bttRefreshClick(Sender: TObject);
    procedure GenerateCaptcha;
    procedure btnLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPartLogClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    sEmail: string;
    iID: integer;

  end;

var
  frmLogin: TfrmLogin;
  sCaptchaAnswer, sInputtedAnswer: String;
  tLoginInfo: TextFile;

const
  sCaptchaCharacters
    : String = 'abcdefghkmnpqrstuvwxyzABCDEFGHMNPRSTUVWXYZ23456789';

implementation

{$R *.dfm}

procedure TfrmLogin.bttCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.bttRefreshClick(Sender: TObject);
begin
  GenerateCaptcha;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var
  sPassword, sLine: String;
begin
  sEmail := edtEmailID.Text;
  sInputtedAnswer := edtCaptcha.Text;
  lblError.Caption := '';

  // Check for blank email
  if sEmail = '' then
  begin
    lblError.Caption := 'Enter your email';
    Beep;
    GenerateCaptcha;
    exit;
  end;

  if inputquery('Password', #31'Enter your Password', sPassword) = false then
  begin
    exit;
  end
  // Check if password is blank
  else if sPassword = '' then
  begin
    MessageDlg('Enter your Password', mtError, [mbOK], 0);
    GenerateCaptcha;
    exit;
  end;

  // Check if the login info is missing
  if FileExists('Organiser_Logins.txt') = false then
  begin
    MessageDlg('Login info missing', mtError, [mbOK], 0);
  end
  // If the login info is not missing, check if the CAPTCHA is incorrect
  else if (sInputtedAnswer <> sCaptchaAnswer) then
  begin
    MessageDlg('Please retry CAPTCHA', mtError, [mbOK], 0);
    GenerateCaptcha;
  end
  else
  begin
    // Open the login info text file for reading
    AssignFile(tLoginInfo, 'Organiser_Logins.txt');
    Reset(tLoginInfo);
    while not Eof(tLoginInfo) do
    begin
      Readln(tLoginInfo, sLine);
      // Check if email and password are both correct
      if (sLine = sEmail + '#' + sPassword) then
      begin
        // If login detail were correct, open the program
        edtEmailID.Clear;
        GenerateCaptcha;
        lblError.Caption := '';
        frmSelectEvent.Show;
        frmOrganiser.Hide;
        frmSelectParticipants.Hide;
        frmQualification.Hide;
        exit;
      end
      // Check if the email has been registered, but password is incorrect
      else if ContainsStr(sLine, sEmail + '#') = true then
      begin
        MessageDlg('Password Incorrect', mtError, [mbOK], 0);
        GenerateCaptcha;
        exit;
      end;
    end; // Once the whole text file has been checked
    // Presume that the email has not been registered
    lblError.Caption := 'Email Incorrect';
    Beep;
    GenerateCaptcha;
  end;
end;

procedure TfrmLogin.btnPartLogClick(Sender: TObject);
var
  iError: integer;
begin
  sInputtedAnswer := edtCaptcha.Text;
  lblError.Caption := '';

  // Check if ID is blank
  if edtEmailID.Text = '' then
  begin
    lblError.Caption := 'Enter your Participant ID';
    GenerateCaptcha;
    exit;
  end;

  Val(edtEmailID.Text, iID, iError);
  // Check if ID is an valid number
  if iError <> 0 then
  begin
    lblError.Caption := 'Participant ID must be a number';
    GenerateCaptcha;
    exit;
  end;

  // Check if CAPTCHA is incorrect
  if (sInputtedAnswer <> sCaptchaAnswer) then
  begin
    MessageDlg('Please retry CAPTCHA', mtError, [mbOK], 0);
    GenerateCaptcha;
    exit;
  end;

  // Check if participant ID is  in the database
  if dbmSkyComp.tblParticipants.Locate('ParticipantID', iID, []) = false then
  begin
    MessageDlg
      ('Participant ID not on system, please contact your event organiser',
      mtError, [mbOK], 0);
    GenerateCaptcha;
  end
  else
  begin
    // If participant ID is in the database, proceed to the participant page
    frmParticipant.Show;
    edtEmailID.Clear;
    GenerateCaptcha;
    lblError.Caption := '';
  end;

end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  edtEmailID.SetFocus;
  imgNightSky.Picture.LoadFromFile('Night_Sky1_Resized.jpg');
  imgLogo.Picture.LoadFromFile('SkyComp_Logo_Standard.png');
  edtEmailID.Clear;
  GenerateCaptcha;
end;

procedure TfrmLogin.GenerateCaptcha;
var
  iCP: integer;
begin
  imgCaptcha.Picture := nil;
  edtCaptcha.Clear;

  // Set the font for the CAPTCHA
  with imgCaptcha.Canvas.Font do
  begin
    Name := 'Tempus Sans ITC';
    Style := [fsBold];
    Color := clBlack;
    Size := 20;
    Orientation := 50;
  end;

  sCaptchaAnswer := '';
  Randomize;

  // Generate the text for the CAPTCHA
  for iCP := 1 to 6 do
  begin
    sCaptchaAnswer := sCaptchaAnswer + sCaptchaCharacters
      [randomrange(1, length(sCaptchaCharacters) + 1)];
  end;

  imgCaptcha.Canvas.TextOut(20, 15, sCaptchaAnswer);

  // Create random lines over the CAPTCHA text
  for iCP := 0 to 15 do
  begin
    imgCaptcha.Canvas.Pen.Color := Random(100000);
    imgCaptcha.Canvas.MoveTo(Random(imgCaptcha.Width),
      Random(imgCaptcha.Height));
    imgCaptcha.Canvas.LineTo(Random(imgCaptcha.Width),
      Random(imgCaptcha.Height));
  end;

end;

procedure TfrmLogin.lblCreateAccountClick(Sender: TObject);
begin
  frmCreateAccount.Show;
end;

end.

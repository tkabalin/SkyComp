unit frmCreateAccount_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  strutils,
  Vcl.Imaging.jpeg, math, Vcl.Mask, System.Actions, Vcl.ActnList, Vcl.ExtActns,
  Vcl.Imaging.pngimage, System.UITypes, frmSelectEvent_u, frmOrganiser_u,
  frmQualification_u, frmSelectParticipants_u;

type
  TfrmCreateAccount = class(TForm)
    lblCreatePassword: TLabel;
    edtCreatePassword: TEdit;
    edtEmail: TEdit;
    lblEnterEmail: TLabel;
    btnCreateAccount: TButton;
    lblVerifyPassword: TLabel;
    edtVerifyPassword: TEdit;
    bttHidePassword: TBitBtn;
    bttShowPassword: TBitBtn;
    bttHideVerifyPassword: TBitBtn;
    bttShowVerifyPassword: TBitBtn;
    bttClose: TBitBtn;
    imgNightSky: TImage;
    lblCreateAccount: TLabel;
    imgCaptcha: TImage;
    lblCaptcha: TLabel;
    edtCaptcha: TEdit;
    bttRefresh: TBitBtn;
    lblEmailValid: TLabel;
    lblPasswordValid: TLabel;
    imgLogo: TImage;
    procedure btnCreateAccountClick(Sender: TObject);
    procedure bttShowPasswordClick(Sender: TObject);
    procedure bttHidePasswordClick(Sender: TObject);
    procedure bttCloseClick(Sender: TObject);
    procedure bttRefreshClick(Sender: TObject);
    procedure bttHideVerifyPasswordClick(Sender: TObject);
    procedure bttShowVerifyPasswordClick(Sender: TObject);
    procedure GenerateCaptcha;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmCreateAccount: TfrmCreateAccount;
  tLoginInfo: TextFile;

const
  sCaptchaCharacters
    : String = 'abcdefghkmnpqrstuvwxyzABCDEFGHMNPRSTUVWXYZ23456789';

implementation

{$R *.dfm}

uses frmLogin_u;

procedure TfrmCreateAccount.bttHidePasswordClick(Sender: TObject);
begin
  // Hide the password
  edtCreatePassword.PasswordChar := '*';
  bttShowPassword.Visible := true;
  bttHidePassword.Visible := false;
end;

procedure TfrmCreateAccount.bttHideVerifyPasswordClick(Sender: TObject);
begin
  // Hide the password
  edtVerifyPassword.PasswordChar := '*';
  bttShowVerifyPassword.Visible := true;
  bttHideVerifyPassword.Visible := false;
end;

procedure TfrmCreateAccount.bttRefreshClick(Sender: TObject);
begin
  GenerateCaptcha;
end;

procedure TfrmCreateAccount.bttShowPasswordClick(Sender: TObject);
begin
  // Show the password
  edtCreatePassword.PasswordChar := #0;
  bttShowPassword.Visible := false;
  bttHidePassword.Visible := true;
end;

procedure TfrmCreateAccount.bttShowVerifyPasswordClick(Sender: TObject);
begin
  // Show the password
  edtVerifyPassword.PasswordChar := #0;
  bttShowVerifyPassword.Visible := false;
  bttHideVerifyPassword.Visible := true;
end;

procedure TfrmCreateAccount.bttCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmCreateAccount.btnCreateAccountClick(Sender: TObject);
var
  sLine, sCreateEmail, sCreatePassword, sInputtedAnswer: String;
  bValid, bDot: Boolean;
  iPosAt, iCharacter, iInvalid, iNumAt: Integer;
begin
  sCreateEmail := edtEmail.Text;
  sInputtedAnswer := edtCaptcha.Text;
  bValid := true;
  bDot := false;
  iInvalid := 0;
  iNumAt := 0;
  lblEmailValid.Caption := '';
  lblPasswordValid.Caption := '';

  // Validate the password (for blanks, length, invalid characters, non-matching passwords)
  if (edtCreatePassword.Text = '') or (length(edtCreatePassword.Text) > 50) then
  begin
    lblPasswordValid.Caption := 'Enter a valid password';
    bValid := false;
  end
  else if ContainsStr(edtCreatePassword.Text, '#') then
  begin
    lblPasswordValid.Caption := 'Password cannot contain a #';
    bValid := false;
  end
  else if not(edtCreatePassword.Text = edtVerifyPassword.Text) then
  begin
    lblPasswordValid.Caption := 'Passwords do not match';
    bValid := false;
  end
  else
  begin
    sCreatePassword := edtCreatePassword.Text;
  end;

  // Validate the email (for blanks, length and format)
  if (sCreateEmail = '') or (length(sCreateEmail) > 50) then
  begin
    lblEmailValid.Caption := 'Enter a valid email address';
    bValid := false
  end
  else
  begin
    iPosAt := pos('@', sCreateEmail);
    if iPosAt > 0 then // If @ is found
    begin
      for iCharacter := iPosAt to length(sCreateEmail) do
      begin
        // Check if there is another @
        if sCreateEmail[iCharacter] = '@' then
        begin
          iNumAt := iNumAt + 1;
        end;
        // Check that there is a . after the @
        if sCreateEmail[iCharacter] = '.' then
        begin
          bDot := true;
        end;
      end;
      // If there is not a . after @
      if bDot = false then
      begin
        lblEmailValid.Caption := 'Enter a valid email address';
        bValid := false
      end;
      // If there are too many @'s
      if iNumAt > 1 then
      begin
        lblEmailValid.Caption := 'Enter a valid email address';
        bValid := false
      end;
      for iCharacter := 1 to length(sCreateEmail) do
      begin
        // Check if the character is in valid range
        if not(sCreateEmail[iCharacter] in ['0' .. '9', 'A' .. 'Z', 'a' .. 'z',
          '+', '-', '_', '~', '@', '.']) then
        begin
          iInvalid := iInvalid + 1;
        end;
      end;
      // If there are any invalid characters
      if iInvalid > 0 then
      begin
        lblEmailValid.Caption := 'Enter a valid email address';
        bValid := false
      end;
    end
    else
    begin
      lblEmailValid.Caption := 'Enter a valid email address';
      bValid := false
    end;
  end;

  // Check if the organsier login text file is missing
  if not FileExists('Organiser_Logins.txt') then
  begin
    MessageDlg('Login info missing', mtError, [mbOk], 0);
  end
  else
  begin
    // Check if the email is already registered
    AssignFile(tLoginInfo, 'Organiser_Logins.txt');
    Reset(tLoginInfo);
    while not Eof(tLoginInfo) do
    begin
      ReadLn(tLoginInfo, sLine);
      if ContainsStr(sLine, sCreateEmail + '#') = true then
      begin
        lblEmailValid.Caption := 'Email already registered';
        bValid := false;
      end;
    end;

    if bValid = true then
    begin
      // Check if CAPTCHA is correct
      if not(sInputtedAnswer = sCaptchaAnswer) then
      begin
        MessageDlg('Please retry CAPTCHA', mtError, [mbOk], 0);
        GenerateCaptcha;
        bValid := false;
      end;
    end;

    // If email is valid, does not already exist, password is valid and CAPTCHA is correct
    if bValid = true then
    begin
      // Add account to list of accounts
      Append(tLoginInfo);
      Writeln(tLoginInfo, sCreateEmail + '#' + sCreatePassword);
      MessageDlg('Account Created, Welcome to SkyComp!', mtInformation,
        [mbOk], 0);
      // Open the organiser page
      frmSelectEvent.show;
      edtCreatePassword.Clear;
      edtEmail.Clear;
      edtVerifyPassword.Clear;
      GenerateCaptcha;
      frmCreateAccount.hide;
      frmOrganiser.hide;
      frmSelectParticipants.hide;
      frmQualification.hide;
    end
    else
      GenerateCaptcha;

    CloseFile(tLoginInfo);
  end;
end;

procedure TfrmCreateAccount.FormShow(Sender: TObject);
begin
  GenerateCaptcha;
  edtEmail.SetFocus;
  imgNightSky.Picture.LoadFromFile('Night_Sky1_Resized.jpg');
  imgLogo.Picture.LoadFromFile('SkyComp_Logo_Standard.png');
end;

procedure TfrmCreateAccount.GenerateCaptcha;
var
  iCP: Integer;
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

end.

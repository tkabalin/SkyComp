program SkyComp_p;

uses
  Vcl.Forms,
  frmLogin_u in 'frmLogin_u.pas' {frmLogin},
  frmCreateAccount_u in 'frmCreateAccount_u.pas' {frmCreateAccount},
  Vcl.Themes,
  Vcl.Styles,
  frmSplashScreen_u in 'frmSplashScreen_u.pas' {frmSplashScreen},
  dbmSkyComp_u in 'dbmSkyComp_u.pas' {dbmSkyComp: TDataModule},
  frmParticipant_u in 'frmParticipant_u.pas' {frmParticipant},
  frmOrganiser_u in 'frmOrganiser_u.pas' {frmOrganiser},
  frmSelectEvent_u in 'frmSelectEvent_u.pas' {frmSelectEvent},
  frmSelectParticipants_u in 'frmSelectParticipants_u.pas' {frmSelectParticipants},
  frmQualification_u in 'frmQualification_u.pas' {frmQualification};

{$R *.res}

begin
  Application.Initialize;
  // Create and display the splash screen
  frmSplashScreen := TfrmSplashScreen.Create(nil);
  frmSplashScreen.ShowModal;
  // Hide the splash screen
  frmSplashScreen.Free;
  frmSplashScreen := nil;
  // Create the rest of the forms
  Application.MainFormOnTaskbar := True;
  Application.HelpFile := 'C:\Users\Thomas\OneDrive - Mahala.Ms\School\Grade 11\Grade 11 IT\PAT\SkyComp\Win32\Debug\SkyComp_HELP.docx';
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmCreateAccount, frmCreateAccount);
  Application.CreateForm(TdbmSkyComp, dbmSkyComp);
  Application.CreateForm(TfrmParticipant, frmParticipant);
  Application.CreateForm(TfrmOrganiser, frmOrganiser);
  Application.CreateForm(TfrmSelectEvent, frmSelectEvent);
  Application.CreateForm(TfrmSelectParticipants, frmSelectParticipants);
  Application.CreateForm(TfrmQualification, frmQualification);
  Application.Run;
end.

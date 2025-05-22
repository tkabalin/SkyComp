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
unit dbmSkyComp_u;

interface

uses
  System.SysUtils, System.Classes, ADODB, DB;

type
  TdbmSkyComp = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    conSkyCompDB: TADOConnection;
    tblParticipants, tblResults, tblEvents: TADOTable;
    dscResultsForEvent, dscResultsForParticipant: TDataSource;
    qryPart_Results_Child, qryResultsForEvent, qryResultsForParticipant: TADOQuery;
  end;

var
  dbmSkyComp: TdbmSkyComp;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdbmSkyComp.DataModuleCreate(Sender: TObject);
begin
  // Create the various components required for the database connection
  conSkyCompDB := TADOConnection.Create(dbmSkyComp);

  tblParticipants := TADOTable.Create(dbmSkyComp);
  tblResults := TADOTable.Create(dbmSkyComp);
  tblEvents := TADOTable.Create(dbmSkyComp);

  qryPart_Results_Child := TADOQuery.Create(dbmSkyComp);
  qryResultsForEvent := TADOQuery.Create(dbmSkyComp);
  qryResultsForParticipant := TADOQuery.Create(dbmSkyComp);

  dscResultsForEvent := TDataSource.Create(dbmSkyComp);
  dscResultsForParticipant := TDataSource.Create(dbmSkyComp);

  conSkyCompDB.Close;
  conSkyCompDB.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;Data Source =' +
    ExtractFilePath(ParamStr(0)) + 'Gr11_PAT_DB.mdb' +
    ';Persist Security Info = False';
  conSkyCompDB.LoginPrompt := false;
  conSkyCompDB.Open;

  // Connect the ADO tables to the database
  tblParticipants.Connection := conSkyCompDB;
  tblParticipants.TableName := 'tblParticipants';
  tblResults.Connection := conSkyCompDB;
  tblResults.TableName := 'tblResults';
  tblEvents.Connection := conSkyCompDB;
  tblEvents.TableName := 'tblEvents';

  // Set the primary keys
  tblParticipants.IndexFieldNames := 'ParticipantID';
  tblResults.IndexFieldNames := 'ResultID';
  tblEvents.IndexFieldNames := 'EventID';

  // Connect the ADO queries to the database
  qryPart_Results_Child.Connection := conSkyCompDB;
  qryResultsForEvent.Connection := conSkyCompDB;
  qryResultsForParticipant.Connection := conSkyCompDB;

  // Connect the datasources to their relavent queries
  dscResultsForEvent.DataSet := qryResultsForEvent;
  dscResultsForParticipant.DataSet := qryResultsForParticipant;

  // Open the tables
  tblParticipants.Open;
  tblResults.Open;
  tblEvents.Open;

  // Create a child query based on tblParticipants and tblResults
  // This is nessesary due to the join types of the relationships between the tables
  qryPart_Results_Child.Close;
  qryPart_Results_Child.SQL.Clear;
  qryPart_Results_Child.SQL.add(
    'SELECT tblParticipants.ParticipantID, tblParticipants.FirstName, tblParticipants.Surname, tblParticipants.Gender,'
    + ' tblParticipants.DateOfBirth, tblResults.ResultID, tblResults.EventID, tblResults.Qualifying, tblResults.Round1, tblResults.Round2, tblResults.Round3');
  qryPart_Results_Child.SQL.Add( 'FROM tblParticipants LEFT JOIN tblResults ON tblParticipants.ParticipantID = tblResults.ParticipantID');
  qryPart_Results_Child.open;
end;

end.

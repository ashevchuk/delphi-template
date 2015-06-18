unit uDMConfig;

interface

uses
  System.SysUtils, System.Classes, IniFiles, Forms;

type
  TConfig = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FIniFile: TIniFile;
    FConfigFileName: string;
    FCurrentDir: string;
    FDebugLevel: Word;
    FDebugState: boolean;
  public
    property CurrentDir: string read FCurrentDir;
    property DebugLevel: Word read FDebugLevel;
    property Debug: Boolean read FDebugState;

    function ReadString(const Section, Ident, Default: String): String;
    procedure WriteString(const Section, Ident, Value: String);

    function ReadInteger(const Section, Ident: String; Default: Integer): Integer;
    procedure WriteInteger(const Section, Ident: String; Value: Integer);

    function ReadBoolean(const Section, Ident: String; Default: Boolean): Boolean;
    procedure WriteBoolean(const Section, Ident: String; Value: Boolean);

    procedure UpdateFile;
  end;

var
  Config: TConfig;

implementation
uses ufmMain;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TConfig.DataModuleCreate(Sender: TObject);
var
  PathLength: integer;
begin
  FCurrentDir := ExtractFilePath(ParamStr(0));
  PathLength := Length(FCurrentDir);
  if (PathLength > 3) and (FCurrentDir[PathLength] <> '\') then FCurrentDir := FCurrentDir + '\';

  FConfigFileName := ChangeFileExt(Application.ExeName,'.ini');

  TfmMain(Application.MainForm).Log('Loading configuration: ' + FConfigFileName);

  FIniFile := TIniFile.Create(FConfigFileName);

  FDebugLevel := FIniFile.ReadInteger('Main', 'Debug', 0);
  FDebugState := FDebugLevel >0;
end;

procedure TConfig.DataModuleDestroy(Sender: TObject);
begin
  FIniFile.UpdateFile;
  FIniFile.Free;
end;

function TConfig.ReadBoolean(const Section, Ident: String; Default: Boolean): Boolean;
begin
  Result := FIniFile.ReadBool(Section, Ident, Default);
end;

function TConfig.ReadInteger(const Section, Ident: String; Default: Integer): Integer;
begin
  Result := FIniFile.ReadInteger(Section, Ident, Default);
end;

function TConfig.ReadString(const Section, Ident, Default: String): String;
begin
  Result := FIniFile.ReadString(Section, Ident, Default);
end;

procedure TConfig.UpdateFile;
begin
  FIniFile.UpdateFile;
end;

procedure TConfig.WriteBoolean(const Section, Ident: String; Value: Boolean);
begin
  FIniFile.WriteBool(Section, Ident, Value);
end;

procedure TConfig.WriteInteger(const Section, Ident: String; Value: Integer);
begin
  FIniFile.WriteInteger(Section, Ident, Value);
end;

procedure TConfig.WriteString(const Section, Ident, Value: String);
begin
  FIniFile.WriteString(Section, Ident, Value);
end;

end.

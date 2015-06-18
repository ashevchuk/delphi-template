unit udmDataBase;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, System.Variants,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  Data.DB, FireDAC.VCLUI.Wait, FireDAC.VCLUI.Script, FireDAC.VCLUI.Async,
  FireDAC.VCLUI.Error, FireDAC.VCLUI.Login, FireDAC.Phys.IBBase,
  FireDAC.Comp.UI, FireDAC.Comp.Client, FireDAC.Phys.SQLiteVDataSet,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Moni.Base,
  FireDAC.Moni.RemoteClient, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdNetworkCalculator, IdIPAddrMon,
  fileinfo, uDMConfig, FireDAC.Phys.IBWrapper;

type
  TTableFieldInfo = class(TObject)
    private
    public
      isNullable: boolean;
      Description: string;
      ID: word;
      Position: word;
      Name: string;
      Table: string;
  end;

type
  TdmDataBase = class(TDataModule)
    FDManager: TFDManager;
    FDSchemaAdapter: TFDSchemaAdapter;
    FDQuery: TFDQuery;
    FDCommand: TFDCommand;
    FDTransaction: TFDTransaction;
    FDUpdateTransaction: TFDTransaction;
    FDEventAlerter: TFDEventAlerter;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDConnection: TFDConnection;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDGUIxScriptDialog: TFDGUIxScriptDialog;
    FDGUIxAsyncExecuteDialog: TFDGUIxAsyncExecuteDialog;
    FDGUIxErrorDialog: TFDGUIxErrorDialog;
    FDGUIxLoginDialog: TFDGUIxLoginDialog;
    DataSource: TDataSource;
    FDCommandTransaction: TFDTransaction;
    FDMoniRemoteClientLink: TFDMoniRemoteClientLink;
    IdTCPClient: TIdTCPClient;
    IdIPAddrMon1: TIdIPAddrMon;
    IdNetworkCalculator1: TIdNetworkCalculator;
    FDTable: TFDTable;
    TableListDataSet: TFDTable;
    FDIBConfig: TFDIBConfig;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FDataSetList: TList;
    FTablesList: TStringList;
    FConnectionDef: IFDStanConnectionDef;
    FFBConnectionDefParams: TFDPhysFBConnectionDefParams;
  public
    function ConnectDataBase: boolean;
    function getFieldInfo(const ATable: string; AField: string; AType: string = 'FIELD_DESCRIPTION') : string;
    function getFields(const ATable: string) : string;
    function getFieldsList(const ATable: string) : TStringList;
    function createDataSet: TFDTable;
    function createQuery: TFDQuery;
    function createTransaction: TFDTransaction;
    function registerDataSet(const ADataSet: TFDTable): boolean;
    function unregisterDataSet(const ADataSet: TFDTable): boolean;
    function notifyDataSets(const ATableName: string): boolean;
    function generateGroups(const ATable: string): boolean;
    function preloadTablesData: boolean;
    function subscribeEvents: boolean;

    function FindDatabaseServer(AHost: string = 'localhost'; APort: Word = 3050; ATimeOut: Word = 100): string;
    function tryLocalDatabaseServer: boolean;

    function getGlobalConfigData(AKeyName: string): variant;
    function checkDataBaseVersion: boolean;
  published
    function getDatabase: TFDConnection;
    function getTransaction: TFDTransaction;
  end;


const
  DBPort: Word = 3050;

const
  DBHost: String = 'localhost';

const
  DBUser: String = 'SYSDBA';

const
  DBPassword: String = 'masterkey';

const
  DBLocation: string = 'C:\Users\user\Documents\Embarcadero\Studio\Projects\Slaver\db\main.fdb';

const
  DBCharset: string = 'UTF8';

const
  MainDataBaseFile: string = 'notar.fdb';

const
  MainDataBaseLocationDrives: array[0..23] of string = (
    'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
    'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  );

const
  MainDataBaseLocations: array[0..4] of string = (
    'db',
    'db\notar',
    'data\notar',
    'Program Files\Notar\data',
    'Users\user\Documents\Embarcadero\Studio\Projects\Slaver\db'
  );

var
  dmDataBase: TdmDataBase;

implementation
uses ufmMain;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdmDataBase.FindDatabaseServer(AHost: string; APort: Word; ATimeOut: Word): string;
var
  I, I2: Integer;
  IdTCPClient: TIdTCPClient;
  IdIPAddrMon: TIdIPAddrMon;
  IdNetworkCalculator: TIdNetworkCalculator;
begin
  Result := AHost;

  IdTCPClient := TIdTCPClient.Create(Self);
  IdTCPClient.ConnectTimeout := ATimeout;
  IdTCPClient.ReadTimeout := ATimeout;

  IdTCPClient.Host := AHost;
  IdTCPClient.Port := APort;

  try
    IdTCPClient.Connect;
  except
  end;

  if IdTCPClient.Connected then
    begin
      Result := AHost;
      IdTCPClient.Disconnect;
      IdTCPClient.Free;

      Exit;
    end else
      begin
        //not connected
      end;

  IdNetworkCalculator := TIdNetworkCalculator.Create(Self);
  IdNetworkCalculator.NetworkMaskLength := 24;

  IdIPAddrMon := TIdIPAddrMon.Create(Self);
  IdIPAddrMon.ForceCheck;

  for I := 0 to IdIPAddrMon.IPAddresses.Count -1 do
    begin
      IdNetworkCalculator.NetworkAddress.AsString := IdIPAddrMon.IPAddresses[I];
      for I2 := 0 to IdNetworkCalculator.ListIP.Count -1 do
        begin
          IdTCPClient.Host := IdNetworkCalculator.ListIP[I2];
          try
            IdTCPClient.Connect;
          except
          end;

          if IdTCPClient.Connected then
            begin
              Result := IdNetworkCalculator.ListIP[I2];
              IdTCPClient.Disconnect;

              Exit;
            end else
              begin
                //not connected
              end;
          Application.ProcessMessages;
        end;
    end;

  IdTCPClient.Free;
  IdIPAddrMon.Free;
  IdNetworkCalculator.Free;
end;

function TdmDataBase.ConnectDataBase: boolean;
var
  I, I2: Word;
  DBServer: string;
  DBLocation: string;
  DBDrive: string;
  isConnected: boolean;
begin
  try
    if tryLocalDatabaseServer then
    begin
      Result := True;

//      FDUpdateTransaction.Active := True;
//      FDTransaction.Active:= True;
      TableListDataSet.Open;

      Exit;
    end;

    DBServer := FindDatabaseServer(DBHost, DBPort);

    isConnected := False;

    TfmMain(Application.MainForm).Log('Database @ ' + DBServer);

    for I := Low(MainDataBaseLocationDrives) to High(MainDataBaseLocationDrives) do
      begin
        if isConnected then break;

        for I2 := Low(MainDataBaseLocations) to High(MainDataBaseLocations) do
          begin
            DBDrive := MainDataBaseLocationDrives[I];
            DBLocation := MainDataBaseLocations[I2];

            FDConnection.Close;

            FConnectionDef := FDManager.ConnectionDefs.AddConnectionDef;
            FConnectionDef.Name := 'DBMain';
            FFBConnectionDefParams := TFDPhysFBConnectionDefParams.Create(FConnectionDef);
            FFBConnectionDefParams.DriverID := FDPhysFBDriverLink.DriverID;
            FFBConnectionDefParams.Server := DBServer;
            FFBConnectionDefParams.Port := DBPort;
            FFBConnectionDefParams.Database := Format('%s:\%s\%s', [DBDrive, DBLocation, MainDataBaseFile]);
            FFBConnectionDefParams.ExtendedMetadata := true;
            FFBConnectionDefParams.MonitorBy := mbRemote;
            FFBConnectionDefParams.Protocol := ipTCPIP;
            FFBConnectionDefParams.CharacterSet := csUTF8;
            FFBConnectionDefParams.UserName := Config.ReadString('Database', 'User', 'SYSDBA');
            FFBConnectionDefParams.Password := Config.ReadString('Database', 'Password', 'masterkey');

//            FConnectionDef.MarkPersistent;
            FConnectionDef.Apply;

            FDConnection.ConnectionDefName := 'DBMain';

            try
              FDConnection.Open;
            except
              TfmMain(Application.MainForm).Log('Database file @ ' + FDConnection.Params.Database + ' is not found on ' + DBServer);
            end;

            if FDConnection.Connected then
              begin
                //FDConnection.AutoReconnect := True;
                isConnected := True;

                Config.WriteString('Database', 'Host', DBServer);
                Config.WriteInteger('Database', 'Port', DBPort);
                Config.WriteString('Database', 'Location', Format('%s:\%s\%s', [DBDrive, DBLocation, MainDataBaseFile]));
                Config.UpdateFile;

                break;
              end;
          end;

      end;
    TfmMain(Application.MainForm).Log('DSN: ' + FDConnection.Params.Database + ' on ' + DBServer);

//    FDUpdateTransaction.Active:= True;
 //   FDTransaction.Active:= True;
    TableListDataSet.Open;
  finally
    Result := FDConnection.Connected;
  end;
end;

function TdmDataBase.createDataSet: TFDTable;
var
  DataSet: TFDTable;
begin
  DataSet := TFDTable.Create(self);
  DataSet.Connection := FDConnection;
  DataSet.Transaction := FDTransaction;
  DataSet.UpdateTransaction := FDUpdateTransaction;
  DataSet.Close;

  registerDataSet(DataSet);

  Result := DataSet;
end;

function TdmDataBase.createQuery: TFDQuery;
var
  DataSet: TFDQuery;
begin
  DataSet := TFDQuery.Create(self);
  DataSet.Connection := FDConnection;
  DataSet.Transaction := FDTransaction;
  DataSet.UpdateTransaction := FDUpdateTransaction;
  DataSet.Close;

  Result := DataSet;
end;

function TdmDataBase.createTransaction: TFDTransaction;
var
  Transaction: TFDTransaction;
begin
  Transaction := TFDTransaction.Create(self);
  Transaction.Connection := FDConnection;
  Result := Transaction;
end;

procedure TdmDataBase.DataModuleCreate(Sender: TObject);
begin
  FDConnection.Close;
  FDataSetList := TList.Create;
  FTablesList := TStringList.Create;
end;

procedure TdmDataBase.DataModuleDestroy(Sender: TObject);
var
  DataSetItem: Pointer;
  iTablesList: word;
  iFieldsList: word;
begin
{  if FDataSetList.Count >0 then
  begin
    for DataSetItem in FDataSetList do
    begin
      try
        if not Assigned(ValidateObj(DataSetItem)) then
        begin
          unregisterDataSet(DataSetItem);
          Continue;
        end;
        TFDTable(DataSetItem).Close;
      except
        unregisterDataSet(DataSetItem);
      end;
    end;
  end;
}

  if FDataSetList.Count >0 then
  begin
    for DataSetItem in FDataSetList do
    begin
      try
        unregisterDataSet(DataSetItem);
        TFDTable(DataSetItem).Close;
      except

      end;
    end;
  end;

  if FTablesList.Count > 0 then
  begin
    for iTablesList := 0 to FTablesList.Count -1 do
      begin
        for iFieldsList := 0 to TStringList(FTablesList.Objects[iTablesList]).Count -1 do
          begin
            try
              TTableFieldInfo(TStringList(FTablesList.Objects[iTablesList]).Objects[iFieldsList]).Free;
            except
            end;
          end;
        try
          TStringList(FTablesList.Objects[iTablesList]).Free;
        except
        end;
      end;
  end;

  FDataSetList.Free;
  FTablesList.Free;

  FDConnection.Close;
end;


{procedure TdmDataBase.FIBEventAlerterEventAlert(Sender: TObject; EventName: string; EventCount: Integer);
var
  TableName: string;
begin
  TfmMain(Application.MainForm).Log('Received event:  ' + EventName);
  if AnsiPos('UPDATE_', EventName) >0 then
  begin
    TableName := EventName;
    Delete(TableName, 1, 7);
    notifyDataSets(TableName);
  end;

end;
}
{
procedure TdmDataBase.FIBSQLMonitorSQL(EventText: string; EventTime: TDateTime);
var
  tmpStr: string;
  tableName: string;
  regex: TRegEx;
  mc: TMatchCollection;
begin
  log(EventText);
  regex := TRegEx.Create('\s\s');
  tmpStr := regex.Replace(EventText, '[\n\r\t]', ' ');

  mc := regex.Matches(tmpStr, '\[Execute\]\s(.*?)$', [roMultiLine, roExplicitCapture]);

  if mc.Count > 0 then
  begin
    tmpStr := mc.Item[0].Value;

    tmpStr := regex.Replace(tmpStr, '\[Execute\]\s', '');
    tmpStr := regex.Replace(tmpStr, '^\s', '');
    tmpStr := regex.Replace(tmpStr, '\s$', '');
    while regex.IsMatch(tmpStr) do
      tmpStr := regex.Replace(tmpStr, '\s\s', ' ');

    tmpStr := UpperCase(tmpStr);

    //INSERT INTO TABLE_NAME
    if Pos('INSERT', tmpStr) = 1 then
    begin
      tmpStr := regex.Replace(tmpStr, '^INSERT\sINTO\s', '');
      tableName := Copy(tmpStr, 1, Pos('(', tmpStr) -1);
      notifyDataSets(tableName);
    end;
    //UPDATE TABLE_NAME
    if Pos('UPDATE', tmpStr) = 1 then
    begin
      tmpStr := regex.Replace(tmpStr, '^UPDATE\s', '');
      tableName := Copy(tmpStr, 1, Pos(' ', tmpStr) -1);
      notifyDataSets(tableName);
    end;
    //DELETE FROM TABLE_NAME
    if Pos('DELETE', tmpStr) = 1 then
    begin
      tmpStr := regex.Replace(tmpStr, '^DELETE\sFROM\s', '');
      tableName := Copy(tmpStr, 1, Pos(' ', tmpStr) -1);
      notifyDataSets(tableName);
    end;
    //SELECT FIELDS FROM TABLE_NAME
    if Pos('SELECT', tmpStr) = 1 then
    begin
      tmpStr := regex.Replace(tmpStr, '^(.*?)\sFROM\s', '');
      tableName := Copy(tmpStr, 1, Pos(' ', tmpStr) -1);
    end;
  end;
end;
}
function TdmDataBase.generateGroups(const ATable: string): boolean;
var
  fields: TStringList;
  i: byte;
  s: string;
begin
  fields := getFieldsList(ATable);
  for I := 0 to fields.Count -1 do
  begin
    s := Format('CREATE OR ALTER VIEW CAT_NOTR_%s(%s) AS SELECT %s FROM CATALOG_NOTARIES GROUP BY %s ORDER BY %s;', [fields[i], fields[i], fields[i], fields[i], fields[i]]);
    //log(s);
  end;

end;

function TdmDataBase.getDatabase: TFDConnection;
begin
  Result := FDConnection;
end;

function TdmDataBase.getFieldInfo(const ATable: string; AField, AType: string): string;
var
  FieldsList: TStringList;
  FieldInfo: TTableFieldInfo;
begin
  FieldsList := getFieldsList(ATable);

  FieldInfo := TTableFieldInfo(FieldsList.Objects[FieldsList.IndexOf(AField)]);

  if AType = 'FIELD_ID' then Result := IntToStr(FieldInfo.ID);
  if AType = 'FIELD_POSITION' then Result := IntToStr(FieldInfo.Position);
  if AType = 'FIELD_NULL_FLAG' then Result := IntToStr(Byte(FieldInfo.isNullable));
  if AType = 'FIELD_DESCRIPTION' then Result := FieldInfo.Description;
end;

function TdmDataBase.getFields(const ATable: string): string;
var
  FieldsList: TStringList;
begin
  FieldsList := getFieldsList(ATable);

  Result := FieldsList.CommaText;
  FieldsList.Free;
end;

function TdmDataBase.getFieldsList(const ATable: string): TStringList;
var
  FieldsListDataSet: TFDTable;
  FieldsList: TStringList;
  FieldsListResult: TStringList;
  FieldInfo: TTableFieldInfo;
begin
  FieldsListResult := TStringList.Create;

  if FTablesList.IndexOf(ATable) <0 then
  begin
    FieldsList := TStringList.Create;
    FieldsListDataSet := createDataSet;

    FieldsListDataSet.SQL.Text := 'SELECT TABLE_NAME, FIELD_NAME, FIELD_POSITION, FIELD_ID, FIELD_DESCRIPTION, FIELD_NULL_FLAG FROM VIEW_TABLE_FIELDS WHERE TABLE_NAME = :TABLE_NAME';
    FieldsListDataSet.ParamByName('TABLE_NAME').AsString := ATable;
    FieldsListDataSet.Open;

    FieldsListDataSet.First;
    while not FieldsListDataSet.Eof do
    begin
      FieldInfo := TTableFieldInfo.Create;

      FieldInfo.Table := ATable;
      FieldInfo.ID := FieldsListDataSet.FieldByName('FIELD_ID').AsLargeInt;
      FieldInfo.Name := FieldsListDataSet.FieldByName('FIELD_NAME').AsString;
      FieldInfo.Description := FieldsListDataSet.FieldByName('FIELD_DESCRIPTION').AsString;
      FieldInfo.Position := FieldsListDataSet.FieldByName('FIELD_POSITION').AsLargeInt;
      FieldInfo.isNullable := not FieldsListDataSet.FieldByName('FIELD_POSITION').AsInteger = 1;

      FieldsList.AddObject(FieldsListDataSet.FieldByName('FIELD_NAME').AsString, FieldInfo);
//      FieldsList.Append(FieldsListDataSet.FieldByName('FIELD_NAME').AsString);
      FieldsListDataSet.Next;
    end;

    FTablesList.AddObject(ATable, FieldsList);

    FieldsListDataSet.Close;
    FieldsListDataSet.Free;
  end;

  FieldsListResult.Assign(TStringList(FTablesList.Objects[FTablesList.IndexOf(ATable)]));

  Result := FieldsListResult;
end;

function TdmDataBase.getGlobalConfigData(AKeyName: string): variant;
begin
  {GlobalConfigurationDataSet.Close;
  GlobalConfigurationDataSet.ParamByName('KEY').AsString := AKeyName;
  GlobalConfigurationDataSet.Open;
  Result := GlobalConfigurationDataSetVALUE_DATA.AsVariant;
  GlobalConfigurationDataSet.Close;}
end;

function TdmDataBase.getTransaction: TFDTransaction;
begin
  Result := FDTransaction;
end;

function TdmDataBase.notifyDataSets(const ATableName: string): boolean;
var
  DataSetItem: Pointer;
begin
{//  log('notifycation: ' + ATableName);
  if FDataSetList.Count =0 then Exit;

  for DataSetItem in FDataSetList do
  begin
    try
      //if not Assigned(ValidateObj(DataSetItem)) then
      if Length(TFDTable(DataSetItem).Description) = 0 then
      begin
        unregisterDataSet(DataSetItem);
        Continue;
      end;

      if UpperCase(TFDTable(DataSetItem).Description) = UpperCase(ATableName) then
      begin
        if TFDTable(DataSetItem).Active then
        begin
          //TFDTable(FDataSetList[iDataSet]).Refresh;
          //TFDTable(DataSetItem).Close;
          //TFDTable(DataSetItem).Open;
          //TFDTable(DataSetItem).CloseOpen(true);
          TFDTable(DataSetItem).FullRefresh;
          //TFDTable(DataSetItem).FetchAll;
          Log('Refresh table ' + ATableName);
        end;
      end;
    except
      Log('Error while table refresh ' + ATableName);
      unregisterDataSet(DataSetItem);
    end;
  end;
 }
end;

function TdmDataBase.preloadTablesData: boolean;
begin
  TableListDataSet.Open;
  while not TableListDataSet.Eof do
  begin
//    getFieldsList(TableListDataSetTABLE_NAME.AsString);
    TableListDataSet.Next;
  end;
  TableListDataSet.Close;
end;

function TdmDataBase.registerDataSet(const ADataSet: TFDTable): boolean;
begin
  FDataSetList.Add(ADataSet);
end;

function TdmDataBase.subscribeEvents: boolean;
begin
  {EventsListDataSet.Open;
  EventsListDataSet.First;
  while not EventsListDataSet.Eof do
  begin
    FIBEventAlerter.Events.Add(EventsListDataSetEVENT_NAME.AsString);
    TfmMain(Application.MainForm).Log('Subscribed to event:  ' + EventsListDataSetEVENT_NAME.AsString);
    EventsListDataSet.Next;
  end;
  EventsListDataSet.Close;
  FIBEventAlerter.AutoRegister := True;    }
end;

function TdmDataBase.tryLocalDatabaseServer: boolean;
var
  I, I2: Word;
  tDBServer: string;
  tDBLocation: string;
  tDBDrive: string;
  isConnected: boolean;
  tDBPort: Word;
  tDBHost: String;
  tDBUser: String;
  tDBPassword: String;
  tDBCharset: string;
begin
  Result := False;

  try
    tDBServer := Config.ReadString('Database', 'Host', 'localhost');
    tDBPort := Config.ReadInteger('Database', 'Port', 3050);

    tDBUser := Config.ReadString('Database', 'User', 'SYSDBA');
    tDBPassword := Config.ReadString('Database', 'Password', 'masterkey');

    tDBLocation := Config.ReadString('Database', 'Location', 'C:\db\notar.fdb');
    tDBCharset := Config.ReadString('Database', 'Charset', 'UTF8');

    isConnected := False;

    FDConnection.Close;

    FConnectionDef := FDManager.ConnectionDefs.AddConnectionDef;
    FConnectionDef.Name := 'DBMain';
    FFBConnectionDefParams := TFDPhysFBConnectionDefParams.Create(FConnectionDef);
    FFBConnectionDefParams.DriverID := FDPhysFBDriverLink.DriverID;
    FFBConnectionDefParams.Server := tDBServer;
    FFBConnectionDefParams.Port := tDBPort;
    FFBConnectionDefParams.Database := Format('%s', [tDBLocation]);
    FFBConnectionDefParams.ExtendedMetadata := true;
    FFBConnectionDefParams.MonitorBy := mbRemote;
    FFBConnectionDefParams.Protocol := ipTCPIP;
    FFBConnectionDefParams.CharacterSet := csUTF8;
    FFBConnectionDefParams.UserName := tDBUser;
    FFBConnectionDefParams.Password := tDBPassword;

//    FConnectionDef.MarkPersistent;
    FConnectionDef.Apply;

    FDConnection.ConnectionDefName := 'DBMain';


//    FDConnection.Params.CharacterSet := tDBCharset;

    //FDConnection.Params.Database := Format('%s/%s:%s', [tDBServer, IntToStr(tDBPort), tDBLocation]);

    TfmMain(Application.MainForm).Log('Database probe from configuration @ ' + FDConnection.Params.Database);

    try
      FDConnection.Open;
    except
      TfmMain(Application.MainForm).Log('Database file from configuration @ ' + FDConnection.Params.Database + ' is not found on ' + tDBServer);
    end;

    if FDConnection.Connected then
      begin
        //FDConnection.AutoReconnect := True;
        Result := True;
        Exit;
      end;

    for I := Low(MainDataBaseLocationDrives) to High(MainDataBaseLocationDrives) do
      begin
        if isConnected then break;

        for I2 := Low(MainDataBaseLocations) to High(MainDataBaseLocations) do
          begin
            tDBDrive := MainDataBaseLocationDrives[I];
            tDBLocation := MainDataBaseLocations[I2];

            FDConnection.Close;

            FConnectionDef := FDManager.ConnectionDefs.AddConnectionDef;
            FConnectionDef.Name := 'DBMain';
            FFBConnectionDefParams := TFDPhysFBConnectionDefParams.Create(FConnectionDef);
            FFBConnectionDefParams.DriverID := FDPhysFBDriverLink.DriverID;
            FFBConnectionDefParams.Server := tDBServer;
            FFBConnectionDefParams.Port := tDBPort;
            FFBConnectionDefParams.Database := Format('%s:\%s\%s', [tDBDrive, tDBLocation, MainDataBaseFile]);
            FFBConnectionDefParams.ExtendedMetadata := true;
            FFBConnectionDefParams.MonitorBy := mbRemote;
            FFBConnectionDefParams.Protocol := ipTCPIP;
            FFBConnectionDefParams.CharacterSet := csUTF8;
            FFBConnectionDefParams.UserName := tDBUser;
            FFBConnectionDefParams.Password := tDBPassword;

//    FConnectionDef.MarkPersistent;
    FConnectionDef.Apply;

    FDConnection.ConnectionDefName := 'DBMain';

            try
              FDConnection.Open;
            except
              TfmMain(Application.MainForm).Log('Database file @ ' + FDConnection.Params.Database + ' is not found on ' + tDBServer);
            end;

            if FDConnection.Connected then
              begin
                //FDConnection.AutoReconnect := True;
                isConnected := True;
                Config.WriteString('Database', 'Host', tDBServer);
                Config.WriteInteger('Database', 'Port', tDBPort);
                Config.WriteString('Database', 'Location', Format('%s:\%s\%s', [tDBDrive, tDBLocation, MainDataBaseFile]));
                Config.UpdateFile;

                break;
              end;
          end;

      end;
    TfmMain(Application.MainForm).Log('DSN: ' + FDConnection.Params.Database);
  finally
    Result := FDConnection.Connected;
  end;
end;

function TdmDataBase.unregisterDataSet(const ADataSet: TFDTable): boolean;
begin
  FDataSetList.Remove(ADataSet);
end;

function TdmDataBase.checkDataBaseVersion: boolean;
var
  V1, V2, V3, V4: Word;
  FileVersion: String;
  DBVersion: String;
begin
 result := true;
 exit;
 GetBuildInfo(V1, V2, V3, V4);
 FileVersion := Format('%s.%s.%s.%s', [IntToStr(V1), IntToStr(V2), IntToStr(V3), IntToStr(V4)]);
 DBVersion := VarToStr(getGlobalConfigData('DB_VERSION'));
 Result := FileVersion = DBVersion;
end;

end.

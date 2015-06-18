object dmDataBase: TdmDataBase
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 682
  Width = 872
  object FDManager: TFDManager
    DriverDefFileName = 
      'C:\Users\user\Documents\Embarcadero\Studio\Projects\Slaver\drive' +
      'r.ini'
    ConnectionDefFileName = 
      'C:\Users\user\Documents\Embarcadero\Studio\Projects\Slaver\datab' +
      'ase.ini'
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    Active = True
    Left = 72
    Top = 48
  end
  object FDSchemaAdapter: TFDSchemaAdapter
    AutoCommitUpdates = True
    Left = 512
    Top = 112
  end
  object FDQuery: TFDQuery
    ConstraintsEnabled = True
    Connection = FDConnection
    SchemaAdapter = FDSchemaAdapter
    SQL.Strings = (
      'select * from test')
    Left = 72
    Top = 304
  end
  object FDCommand: TFDCommand
    Connection = FDConnection
    Transaction = FDCommandTransaction
    Left = 72
    Top = 240
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 168
    Top = 112
  end
  object FDUpdateTransaction: TFDTransaction
    Connection = FDConnection
    Left = 272
    Top = 112
  end
  object FDEventAlerter: TFDEventAlerter
    Connection = FDConnection
    Options.AutoRegister = True
    Left = 168
    Top = 176
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    DriverID = 'libFBclient'
    VendorHome = 'C:\Users\user\Documents\Embarcadero\Studio\Projects\Slaver\lib'
    VendorLib = 'fbclient.dll'
    Embedded = True
    Left = 72
    Top = 176
  end
  object FDConnection: TFDConnection
    ConnectionName = 'Main'
    Params.Strings = (
      'ExtendedMetadata=True'
      'MonitorBy=Remote'
      
        'Database=C:\Users\user\Documents\Embarcadero\Studio\Projects\Sla' +
        'ver\db\MAIN.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=10.100.100.102'
      'Port=3050'
      'CharacterSet=UTF8'
      'DriverID=libFBclient')
    FetchOptions.AssignedValues = [evRecordCountMode]
    FetchOptions.RecordCountMode = cmTotal
    LoginDialog = FDGUIxLoginDialog
    Transaction = FDTransaction
    UpdateTransaction = FDUpdateTransaction
    Left = 72
    Top = 112
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 488
    Top = 456
  end
  object FDGUIxScriptDialog: TFDGUIxScriptDialog
    Provider = 'Forms'
    Left = 376
    Top = 456
  end
  object FDGUIxAsyncExecuteDialog: TFDGUIxAsyncExecuteDialog
    Provider = 'Forms'
    Caption = 'Working'
    Left = 272
    Top = 456
  end
  object FDGUIxErrorDialog: TFDGUIxErrorDialog
    Provider = 'Forms'
    Caption = 'Database Error'
    Left = 168
    Top = 456
  end
  object FDGUIxLoginDialog: TFDGUIxLoginDialog
    Provider = 'Forms'
    Caption = 'Login'
    HistoryEnabled = True
    HistoryKey = '\Software\LCRI\Slaver\Profiles'
    Left = 72
    Top = 456
  end
  object DataSource: TDataSource
    DataSet = FDQuery
    Left = 160
    Top = 304
  end
  object FDCommandTransaction: TFDTransaction
    Connection = FDConnection
    Left = 392
    Top = 112
  end
  object FDMoniRemoteClientLink: TFDMoniRemoteClientLink
    Host = '10.100.100.102'
    Left = 624
    Top = 112
  end
  object IdTCPClient: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 72
    Top = 560
  end
  object IdIPAddrMon1: TIdIPAddrMon
    Active = False
    Left = 168
    Top = 552
  end
  object IdNetworkCalculator1: TIdNetworkCalculator
    NetworkAddress.AsString = '0.0.0.0'
    NetworkMask.AsString = '255.255.255.255'
    Left = 248
    Top = 552
  end
  object FDTable: TFDTable
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'TEST'
    TableName = 'TEST'
    Left = 240
    Top = 304
  end
  object TableListDataSet: TFDTable
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'TEST'
    TableName = 'TEST'
    Left = 312
    Top = 304
  end
  object FDIBConfig: TFDIBConfig
    DriverLink = FDPhysFBDriverLink
    Protocol = ipTCPIP
    Left = 168
    Top = 48
  end
end

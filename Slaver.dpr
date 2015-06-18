program Slaver;

uses
  Vcl.Forms,
  ufmMain in 'ufmMain.pas' {fmMain},
  udmDataBase in 'udmDataBase.pas' {dmDataBase: TDataModule},
  udmFormUtils in 'udmFormUtils.pas' {DataModule1: TDataModule},
  ufmSplash in 'ufmSplash.pas' {fmSplash},
  uLicenseDM in 'uLicenseDM.pas' {LicenseDataModule: TDataModule},
  uDMConfig in 'uDMConfig.pas' {Config: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Slaver';
  Application.MainFormOnTaskbar := False;
  Application.ShowMainForm := False;

  fmSplash := TfmSplash.Create(Application);
  fmSplash.Show;
  fmSplash.Update;

  fmSplash.ShowMessage('Checking registration information...');

  LicenseDataModule := TLicenseDataModule.Create(Application);
  LicenseDataModule.CheckLicense;

  fmSplash.UpdateRegistrationInformation;
  fmSplash.Update;

  fmSplash.ShowMessage('Creating main form...');
  Application.CreateForm(TfmMain, fmMain);

  fmSplash.ShowMessage('Reading configuration...');
  Application.CreateForm(TConfig, Config);

  fmSplash.ShowMessage('Creating data module...');
  Application.CreateForm(TdmDataBase, dmDataBase);

  fmSplash.ShowMessage('Connecting to Database...');
  dmDataBase.ConnectDataBase;

  fmSplash.ShowMessage('Checking Database version...');

  if (not dmDataBase.checkDataBaseVersion) then
  begin
    fmSplash.ShowMessage('Warning! Please, check the Database version.');
    fmSplash.ShowMessage('Database to old! Please, check the Database version.');
  end;

  fmSplash.ShowMessage('Preloading tables data...');
  dmDataBase.preloadTablesData;

  fmSplash.ShowMessage('Subscribe to global events...');
  dmDataBase.subscribeEvents;

  fmSplash.ShowMessage('Starting Application...');
  Application.ShowMainForm := True;

  fmSplash.Hide;
  fmSplash.Close;
  fmSplash.Free;

  Application.Run;
end.

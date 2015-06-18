object LicenseDataModule: TLicenseDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 76
  Width = 79
  object OgDateCode: TOgDateCode
    AutoCheck = False
    OnChecked = OgDateCodeChecked
    OnGetKey = OgDateCodeGetKey
    OnGetCode = OgDateCodeGetCode
    Left = 24
    Top = 16
  end
end

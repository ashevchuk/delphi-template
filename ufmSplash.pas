unit ufmSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TfmSplash = class(TForm)
    SplashImage: TImage;
    VersionLabel: TLabel;
    MessageLabel: TLabel;
    RegistrationLabel: TLabel;
    ExpirationDateLabel: TLabel;
    ExpirationDateCaptionLabel: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ShowMessage(const AMessage: string);
    procedure UpdateRegistrationInformation;
  end;

var
  fmSplash: TfmSplash;

resourcestring
  Str_Registered = 'Registered';
  Str_UnRegistered = 'Unegistered';

const
  RegisterFlipFlop : array[False..True] of string = (Str_UnRegistered, Str_Registered);

implementation
uses fileinfo, uLicenseDM;

{$R *.dfm}

procedure TfmSplash.FormCreate(Sender: TObject);
var V1, V2, V3, V4: Word;
begin
 GetBuildInfo(V1, V2, V3, V4);
 VersionLabel.Caption:='v.'+IntToStr(V1)+'.'+IntToStr(V2)+'.'+IntToStr(V3)+'.'+IntToStr(V4);
end;


procedure TfmSplash.ShowMessage(const AMessage: string);
begin
  MessageLabel.Caption := AMessage;
  MessageLabel.Update;
end;

procedure TfmSplash.UpdateRegistrationInformation;
begin
 RegistrationLabel.Caption := RegisterFlipFlop[LicenseDataModule.IsRegistered];
 ExpirationDateLabel.Caption := DateToStr(LicenseDataModule.ExpireDate);
end;

end.

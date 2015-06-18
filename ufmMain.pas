unit ufmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  udmDataBase, udmFormUtils,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinsdxStatusBarPainter, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.StdCtrls,
  dxStatusBar, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  cxContainer, cxTextEdit, cxMemo, cxSplitter, dxSkinsdxBarPainter, cxPC,
  dxBarBuiltInMenu, dxBar, dxBarApplicationMenu, dxRibbon, dxTabbedMDI;

type
  TfmMain = class(TForm)
    dxStatusBar: TdxStatusBar;
    cxMemoLog: TcxMemo;
    cxSplitterLog: TcxSplitter;
    dxBarManager1: TdxBarManager;
    dxTabbedMDIManager1: TdxTabbedMDIManager;
    dxBarApplicationMenu1: TdxBarApplicationMenu;
    dxBarManager1Bar1: TdxBar;
    dxBarButton1: TdxBarButton;
    procedure dxStatusBarDblClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure OnException(Sender: TObject; E: Exception);
  public
    CurrentDir : string;
    procedure Log(AValue: string);
  end;

var
  fmMain: TfmMain;

implementation
uses ufmGrid;
{$R *.dfm}

procedure TfmMain.dxBarButton1Click(Sender: TObject);
begin
  with TfmGrid.Create(Self) do
  begin
    Show;
  end;
end;

procedure TfmMain.dxStatusBarDblClick(Sender: TObject);
begin
  cxMemoLog.Visible := not cxMemoLog.Visible;
  cxSplitterLog.Visible := cxMemoLog.Visible;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  while TfmMain(self).MDIChildCount > 0 do
  begin
    try
      TfmMain(self).MDIChildren[0].Close;
    finally
      Application.ProcessMessages;
    end;
  end;
  Action := caFree;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
  PathLength       : integer;
begin
 CurrentDir := ExtractFilePath(ParamStr(0));
 PathLength := Length(CurrentDir);
 if (PathLength > 3) and (CurrentDir[PathLength] <> '\') then CurrentDir := CurrentDir + '\';
 Application.OnException := OnException;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  Application.MainForm.BringToFront;
  Application.MainForm.SetFocus;
end;

procedure TfmMain.Log(AValue: string);
begin
  dxStatusBar.SimplePanelStyle.Text := AValue;
  cxMemoLog.Lines.Append(AValue);
end;

procedure TfmMain.OnException(Sender: TObject; E: Exception);
var
  ExceptionLog: TextFile;
  ExceptionInfo: string;
begin
  ExceptionInfo := Format('ClassType.ClassName: "%s", UnitScope: "%s", UnitName: "%s", ClassName: "%s", Message: "%s", Exception: "%s", Stack: "%s"', [Sender.ClassType.ClassName, Sender.UnitScope, Sender.UnitName, Sender.ClassName, E.Message, E.ToString, E.StackTrace]);
  AssignFile(ExceptionLog, CurrentDir + 'Slaver.log');
  Append(ExceptionLog);
  Writeln(ExceptionLog, '=====[EXCEPTION]=====');
  Writeln(ExceptionLog, Format('[%s]', [DateTimeToStr(Now)]));
  Writeln(ExceptionLog, '=====================');
  Writeln(ExceptionLog, ExceptionInfo);
  Writeln(ExceptionLog, '=====================');
  Writeln(ExceptionLog);
  CloseFile(ExceptionLog);

  Log(ExceptionInfo);
  raise E;
end;

end.

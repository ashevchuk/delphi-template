unit udmFormUtils;

interface

uses
  System.SysUtils, System.Classes, cxLookAndFeelPainters, cxGraphics,
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
  dxSkinXmas2008Blue, dxScreenTip, cxStyles, cxGridTableView, dxSkinsForm,
  cxGrid, dxLayoutLookAndFeels, cxLookAndFeels, cxPropertiesStore, dxCustomHint,
  cxHint, cxLocalization, dxAlertWindow, cxEdit, cxClasses, cxContainer,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridDBTableView;

type
  TDataModule1 = class(TDataModule)
    cxEditRepository: TcxEditRepository;
    cxEditStyleController: TcxEditStyleController;
    cxDefaultEditStyleController: TcxDefaultEditStyleController;
    dxAlertWindowManager: TdxAlertWindowManager;
    cxLocalizer: TcxLocalizer;
    cxHintStyleController: TcxHintStyleController;
    cxPropertiesStore: TcxPropertiesStore;
    cxLookAndFeelController: TcxLookAndFeelController;
    dxLayoutLookAndFeelList: TdxLayoutLookAndFeelList;
    dxLayoutCxLookAndFeel1: TdxLayoutCxLookAndFeel;
    dxLayoutSkinLookAndFeel1: TdxLayoutSkinLookAndFeel;
    cxGridViewRepository: TcxGridViewRepository;
    dxSkinController: TdxSkinController;
    cxStyleRepository: TcxStyleRepository;
    cxGridViewRepositoryDBTableView1: TcxGridDBTableView;
    GridTableViewStyleSheetWindowsStandard: TcxGridTableViewStyleSheet;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

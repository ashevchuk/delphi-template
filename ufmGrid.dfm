object fmGrid: TfmGrid
  Left = 0
  Top = 0
  Caption = 'Grid'
  ClientHeight = 417
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 643
    Height = 417
    Align = alClient
    TabOrder = 0
    LookAndFeel.Kind = lfUltraFlat
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      FindPanel.DisplayMode = fpdmAlways
      DataController.DataSource = DataSource1
      DataController.KeyFieldNames = 'ID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      EditForm.ItemHotTrack = True
      FilterRow.Visible = True
      NewItemRow.Visible = True
      OptionsBehavior.AlwaysShowEditor = True
      OptionsBehavior.CellHints = True
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = cxGrid1DBTableView1CAPTION
      OptionsBehavior.NavigatorHints = True
      OptionsBehavior.EditAutoHeight = eahRow
      OptionsCustomize.ColumnHiding = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsCustomize.DataRowSizing = True
      OptionsCustomize.GroupBySorting = True
      OptionsCustomize.GroupRowSizing = True
      OptionsData.Appending = True
      OptionsSelection.MultiSelect = True
      OptionsView.CellEndEllipsis = True
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.FooterAutoHeight = True
      OptionsView.FooterMultiSummaries = True
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      OptionsView.Indicator = True
      Styles.StyleSheet = DataModule1.GridTableViewStyleSheetWindowsStandard
      object cxGrid1DBTableView1ID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
      end
      object cxGrid1DBTableView1CAPTION: TcxGridDBColumn
        DataBinding.FieldName = 'CAPTION'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object FDQuery1: TFDQuery
    Active = True
    Connection = dmDataBase.FDConnection
    SQL.Strings = (
      'select * from test')
    Left = 544
    Top = 208
    object FDQuery1ID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object FDQuery1CAPTION: TWideStringField
      FieldName = 'CAPTION'
      Origin = 'CAPTION'
      FixedChar = True
      Size = 255
    end
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 544
    Top = 263
  end
end

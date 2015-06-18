object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'Slaver'
  ClientHeight = 545
  ClientWidth = 765
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 525
    Width = 765
    Height = 20
    Panels = <>
    PaintStyle = stpsUseLookAndFeel
    SimplePanelStyle.Active = True
    SimplePanelStyle.AutoHint = True
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = 'Office2007Black'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    OnDblClick = dxStatusBarDblClick
  end
  object cxMemoLog: TcxMemo
    Left = 0
    Top = 436
    Align = alBottom
    ParentFont = False
    Properties.ScrollBars = ssVertical
    TabOrder = 1
    Visible = False
    ExplicitLeft = -24
    ExplicitTop = 304
    Height = 89
    Width = 765
  end
  object cxSplitterLog: TcxSplitter
    Left = 0
    Top = 428
    Width = 765
    Height = 8
    AlignSplitter = salBottom
    Visible = False
    ExplicitTop = 0
    ExplicitWidth = 436
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 360
    Top = 136
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 791
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      IsMainMenu = True
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      MultiLine = True
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Grid'
      Category = 0
      Hint = 'Grid'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
  end
  object dxTabbedMDIManager1: TdxTabbedMDIManager
    Active = True
    TabProperties.CustomButtons.Buttons = <>
    Left = 488
    Top = 128
  end
  object dxBarApplicationMenu1: TdxBarApplicationMenu
    BarManager = dxBarManager1
    Buttons = <>
    ExtraPane.Items = <>
    ItemLinks = <>
    UseOwnFont = False
    Left = 248
    Top = 88
  end
end

﻿///////////////////////////////////////////////////////////////////////
// Nom Unite: U_Famillevente
// Description : Gestion des familles de vente
// Créé par Microcelt le 11/08
// Modifié le 11/08
///////////////////////////////////////////////////////////////////////
unit U_Gamme;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  MaskEdit, LCLType, ToolEdit, ExtJvXPButtons,
{$ELSE}
  JvSplit, Mask, JvXPCore, JvXPButtons,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, JvExControls, JvDBLookup,
  JvExComCtrls, JvListView,
{$ENDIF}
  Messages, Graphics, Controls, Classes, ExtCtrls,  Dialogs, DB,
  U_ExtDBNavigator, Buttons, Forms, DBCtrls, Grids,
  DBGrids, u_framework_dbcomponents, u_framework_components,
  ComCtrls, StdCtrls, SysUtils,  TypInfo,  Variants,
  StrUtils, U_OnFormInfoIni,
  U_ExtDBGrid, U_ConstMessage, u_buttons_appli,
  U_FormAdapt,
  U_GroupView, ImgList,fonctions_string, U_DmArticles, Menus, U_DBListView,
  u_buttons_defs, u_reports_components ;

type

  { TF_Gamme }

  TF_Gamme = class(TF_FormAdapt)
    nv_navigator: TExtDBNavigator;
    nv_saisie: TExtDBNavigator;
    lb_code: TFWLabel;
    lb_libelle: TFWLabel;
    ed_code: TFWDBEdit;
    ed_libelle: TFWDBEdit;
    pa_1: TPanel;
    pa_2: TPanel;
    pa_3: TPanel;
    pa_4: TPanel;
    pa_5: TPanel;
    pa_6: TPanel;
    Splitter1: TSplitter;
    SvgFormInfoIni: TOnFormInfoIni;
    spl_1: TSplitter;
    Panel3: TPanel;
    bt_fermer: TFWClose;
    Panel4: TPanel;
    gd_famillevente: TExtDBGrid;
    pc_GroupesGamme: TPageControl;
    ts_ssfam: TTabSheet;
    Panel10: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel1: TPanel;
    Panel5: TPanel;
    bt_abandonner: TFWCancel;
    bt_enregistrer: TFWOK;
    Panel6: TPanel;
    lsv_TypesIn: TDBGroupView;
    Panel2: TPanel;
    bt_in_item: TFWInSelect;
    bt_in_total: TFWInAll;
    bt_out_item: TFWOutSelect;
    bt_out_total: TFWOutAll;
    RbSplitter1: TSplitter;
    lsv_TypesOut: TDBGroupView;
    im_images: TImageList;
    bt_TypePro: TJvXpButton;
    TabSheet1: TTabSheet;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel11: TPanel;
    Panel14: TPanel;
    bt_EnrArt: TFWOK;
    bt_retour: TJvXpButton;
    Panel17: TPanel;
    Panel15: TPanel;
    lv_artin: TDBGroupView;
    Panel16: TPanel;
    bt_in_art: TFWInSelect;
    bt_in_totart: TFWInAll;
    bt_out_art: TFWOutSelect;
    bt_out_totart: TFWOutAll;
    lv_ArtOut: TDBGroupView;
    RbSplitter2: TSplitter;
    bt_AbanArt: TFWCAncel;
    bt_imprimer: TFWPrintGrid;
    procedure bt_fermerClick(Sender: TObject);
    procedure F_FormDicoDataOnCancel(Sender: TObject);
    procedure bt_TypeProClick(Sender: TObject);
    procedure F_FormDicoShow(Sender: TObject);
    procedure F_FormDicoCreate(Sender: TObject);

  private
    { Déclarations privées }

  public
    { Déclarations publiques }
  end;

var
  F_Gamme: TF_Gamme;

implementation

uses U_Main, U_TypeArticle,fonctions_forms;
{$IFNDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TF_Gamme.bt_fermerClick(Sender: TObject);
begin
  Close;
end;



///////////////////////////////////////////////////////////////////////
// Procedure :  F_FormDicoDataOnCancel
// Description : code executé au moment de l'annulation de modif ou d'insert
///////////////////////////////////////////////////////////////////////
procedure TF_Gamme.F_FormDicoDataOnCancel(Sender: TObject);
begin
  // on remet accessible les objets
  pc_GroupesGamme.Enabled := TRUE;

  gd_famillevente.Enabled := TRUE;
  nv_navigator.Enabled := TRUE;
  nv_saisie.Enabled := TRUE;
  pa_6.Enabled := TRUE;
end;

procedure TF_Gamme.bt_TypeProClick(Sender: TObject);
begin
  ffor_CreateUniqueChild ( TF_TypeProduit, fsMDIChild, True, nil );
  if ( lsv_TypesIn.Items.Count > 0 )
  and M_Article.IB_TypProduit.Active Then
    If assigned ( lsv_TypesIn.Selected ) Then
      M_Article.IB_TypProduit.Locate ( 'TYPR_Clep', lsv_TypesIn.Selected.Caption, [] )
    Else
      M_Article.IB_TypProduit.Locate ( 'TYPR_Clep', lsv_TypesIn.Items [0].Caption, [] )
end;

procedure TF_Gamme.F_FormDicoShow(Sender: TObject);
begin
//M_Donn.ds_Gamme.DataSet.Open;
//M_Donn.ds_article.DataSet.Open;
end;


procedure TF_Gamme.F_FormDicoCreate(Sender: TObject);
begin
  F_Gamme:=Self;
  M_Article.ds_Gamme.DataSet.open;
end;

end.



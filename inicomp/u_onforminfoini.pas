﻿{*********************************************************************}
{                                                                     }
{                                                                     }
{             Matthieu Giroux                                         }
{             TOnFormInfoIni :                                       }
{             Objet de sauvegarde d'informations de Forms             }
{             20 Février 2003                                         }
{                                                                     }
{                                                                     }
{*********************************************************************}

unit U_OnFormInfoIni;


{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}


interface
// Listes des informations sauvegardées dans le fichier ini de l'application :
// Les données objets Edit
// La position des Objets (avec l'utilisation des Panels et des RxSplitters et RbSplitter)
// L'index de la pageactive des PageControls (onglets)
// L'index des objets CheckBoxex, RadioBoutons, RadioGroups ,PopupMenus
// les positions de la fenêtre

{$I ..\DLCompilers.inc}
{$I ..\extends.inc}

uses
{$IFDEF FPC}
  LCLIntf, lresources,
{$ELSE}
  RTLConsts,
  Windows, Mask, Consts, ShellAPI, JvToolEdit,
{$ENDIF}
{$IFDEF RX}
  RxLookup,
{$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IniFiles, StdCtrls, ComCtrls, ExtCtrls,
  fonctions_system,
  Variants, Menus, Buttons, DbCtrls,
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  fonctions_init, DBGrids;

// Component properties
const CST_ONFORMINI_DIRECTORYEDIT_DIR  = {$IFDEF FPC} 'Directory' {$ELSE} 'Text' {$ENDIF};
      CST_ONFORMINI_DIRECTORYEDIT      = 'TDirectoryEdit';
      CST_ONFORMINI_FILENAME    = 'FileName' ;
      CST_ONFORMINI_VALUE       = 'Value' ;
      CST_ONFORMINI_DOT         = '.' ;
      CST_ONFORMINI_LINES       = 'Lines' ;
      CST_ONFORMINI_CHECKED     = 'Checked' ;
      CST_ONFORMINI_WIDTH       = 'Width' ;
      CST_ONFORMINI_HEIGHT      = 'Height' ;
      CST_ONFORMINI_TOP         = 'Top' ;
      CST_ONFORMINI_LEFT        = 'Left' ;
      CST_ONFORMINI_WINDOWSTATE = 'WindowState' ;
      CST_ONFORMINI_POSITION    = 'Position' ;
      CST_ONFORMINI_FORMSTYLE   = 'FormStyle' ;
      CST_ONFORMINI_TEXT        = 'Text' ;
      CST_ONFORMINI_INDEX       = 'Index' ;
      CST_ONFORMINI_TABINDEX    = 'TabIndex' ;
      CST_ONFORMINI_PAGEINDEX   = 'PageIndex' ;
      CST_ONFORMINI_DATASOURCE  = 'Datasource'  ;

      // Components
      CST_ONFORMINI_EXTCOLOR    = 'TExtColorCombo' ;
      CST_ONFORMINI_RICHVIEW    = 'TRichView' ;
      CST_ONFORMINI_RICHMEMO    = 'TRichMemo'  ;
      CST_ONFORMINI_XPCHECK     = 'TJvXPCheckbox' ;
      CST_ONFORMINI_FLATCHECK   = 'TFlatCheckBox' ;
      CST_ONFORMINI_PCHECK      = 'TPCheck' ;
      CST_ONFORMINI_JVDIRECTORY = 'TJvDirectoryEdit';
      CST_ONFORMINI_SPINEDIT    = 'TSpinEdit';
      CST_ONFORMINI_SPLITTER    = 'TSplitter';
      CST_ONFORMINI_JVSPLITTER  = 'TJvSplitter';
      CST_ONFORMINI_RXSPLITTER  = 'TRxSplitter';
      CST_ONFORMINI_FWSPINEDIT  = 'TFWSpinEdit';
      CST_ONFORMINI_RXSPINEDIT  = 'TRxSpinEdit';
      CST_ONFORMINI_JVSPINEDIT  = 'TJvSpinEdit';
      CST_ONFORMINI_EXTNUMEDIT  = 'TExtNumEdit';

      // Variables
      CST_ONFORMINI_SCREEN    = 'Screen' ;

      // Events
      CST_ONFORMINI_ONDESTROY   =  'OnDestroy'  ;
      CST_ONFORMINI_ONSHOW      =  'OnShow'  ;
      CST_ONFORMINI_ONCREATE    =  'OnCreate'  ;
{$IFDEF VERSIONS}
      gVer_TSvgFormInfoIni : T_Version = ( Component : 'Composant TOnFormInfoIni' ;
                                           FileUnit : 'U_OnFormInfoIni' ;
                                           Owner : 'Matthieu Giroux' ;
                                           Comment : 'Ini management tu put on a form.' ;
                                           BugsStory : '1.1.1.0 : UTF8 Directory with upgrading.' +#13#10 +
                                                       '1.1.0.2 : Simplifying.' +#13#10 +
                                                       '1.1.0.1 : Optimising.' +#13#10 +
                                                       '1.1.0.0 : Resize on windows with width or height less than 10, sfSaveWeight.' +#13#10 +
                                                       '1.0.6.0 : Adding ListValue, renaming, correct init of ItemIndex.' +#13#10 +
                                                       '1.0.5.0 : Adding Components'' events.' +#13#10 +
                                                       '1.0.4.0 : Adding TSpeedButton.' +#13#10 +
                                                       '1.0.3.1 : Resolving "Optimising" SpinEdit bug.' +#13#10 +
                                                       '1.0.3.0 : Optimising.' +#13#10 +
                                                       '1.0.2.0 : To English, new management of forms not tested.' +#13#10 +
                                                       '1.0.1.6 : UTF 8.' +#13#10 +
                                                       '1.0.1.5 : Testing Memo.' +#13#10 +
                                                       '1.0.1.4 : Freeing ini, erasing before saving.' +#13#10 +
                                                       '1.0.1.3 : Erasing form section after reading ini.' +#13#10 +
                                                       '1.0.1.2 : Testing and creating consts. New form events.' +#13#10 +
                                                       '1.0.1.1 : Testing ColorCombo.' +#13#10 +
                                                       '1.0.1.0 : Testing DirectoryEdit, MaskEdit, on WINDOWS.' +#13#10 +
                                                       '1.0.0.1 : Grouping.' +#13#10 +
                                                       '1.0.0.1 : Lesser Bug, not searching the component in form.' +#13#10 +
                                                       '1.0.0.0 : Gestion de beaucoup de composants.';
                                           UnitType : 3 ;
                                           Major : 1 ; Minor : 1 ; Release : 1 ; Build : 0 );

{$ENDIF}



type
  // Liste des objets dont on veut conserver les donner dans le fichier INI
  TSaveEdit = (feTEdit, feTCheck, feTComboValue, feTComboBox, feTColorCombo,feTCurrencyEdit,feTDateEdit,
        {$IFDEF DELPHI}
        feTDateTimePicker,
        {$ENDIF}
        feTDirectoryEdit,feTFileNameEdit,feTGrid,feTListBox,feTListValue, feTListView, feTMemo,
        feTPageControl, feTPopup, feTRadio, feTRadioGroup, feTRichEdit,feTSpeedButton,
        feTSpinEdit, feTVirtualTrees );
  TLoadOption = (loFreeIni,loAutoUpdate,loAutoLoad,loAutoWrite);
  TLoadOptions = set of TLoadOption;
  TSaveForm = (sfSavePos,sfSaveSize,sfSaveSizes,sfSameMonitor);
  TSavesForm = set of TSaveForm;
  TEventIni = procedure ( const AInifile : TCustomInifile ; var KeepOn : Boolean ) of object;
  TOnIniComponent = procedure ( const AComponent : TComponent ; const AInifile : TCustomInifile ; var KeepOnComponent : Boolean ) of object;
  TOnIniString = procedure ( const AComponent : TComponent ; const AInifile : TCustomInifile ; var Default : String ) of object;
  TSaveEdits = set of TSaveEdit;
const CST_INI_OPTIONS_DEFAULT = [loFreeIni,loAutoUpdate,loAutoLoad,loAutoWrite];

type
  { TOnFormInfoIni }

  TOnFormInfoIni = class(TComponent)
  private
    FSaveEdits: TSaveEdits;
    FSaveForm : TSavesForm;
    FOptions : TLoadOptions;
    FOnReadComponent, FOnWriteComponent : TOnIniComponent;
    FOnFormDestroy,
    FOnFormShow   ,
    FOnFormCreate : TNotifyEvent ;
    FOnIniLoad, FOnIniWrite : TEventIni;
    FDefaultDirectory:TSystemDirectory;
    FOnDefaultDirectory:TOnIniString;
  protected
    FUpdateAll : Boolean;
    FFormOwner:     TCustomForm;
    FormOldDestroy  ,
    FormOldCreate   ,
    FormOldShow     : TNotifyEvent;
//    procedure loaded; override;
    function GetfeSauveEdit(const aSauveObjet:TSaveEdits;const aObjet :TSaveEdit):Boolean ; virtual;
    // traitement de la position de la af_Form mise dans le create
    procedure p_LecturePositionFenetre(const aFiche:TCustomForm); virtual;
    procedure p_EcriturePositionFenetre(const aFiche:TCustomForm); virtual;
    procedure p_Freeini; virtual;
    procedure DoSameMonitor(const aForm: TCustomForm); virtual;
    procedure p_VerifieTailleFenetre(const aFiche: TCustomForm); virtual;

  public
    procedure PlaceForm; virtual;
    Constructor Create(AOwner:TComponent); override;
    procedure ExecuteLecture(aLocal:Boolean); virtual;
    procedure p_ExecuteLecture(const aF_Form: TCustomForm); virtual;
    procedure ReadIniComponent(const acom_Component,af_Form: TComponent); virtual;
    procedure ExecuteEcriture(aLocal: Boolean); virtual;
    procedure p_ExecuteEcriture(const aF_Form: TCustomForm); virtual;
    procedure p_LectureColonnes(const aF_Form: TCustomForm=nil); virtual;
  published
//    property AutoUpdate : Boolean read FAutoUpdate write FAutoUpdate default True;
//    property AutoLoad   : Boolean read FAutoChargeIni write FAutoChargeIni default True;
    // Propriété qui conserve la position des objets d'une form
//    property SavePosObjects: Boolean read FSavePosObjects write FSavePosObjects default False;
    // Propriété qui conserve les données des objets d'une form
    property SaveEdits: TSaveEdits read FSaveEdits write FSaveEdits default [];
    property DefaultDirectory: TSystemDirectory read FDefaultDirectory write FDefaultDirectory default sdUnknown;
    property SaveForm : TSavesForm read FSaveForm write FSaveForm default [];
    property Options  : TLoadOptions read FOptions write FOptions default CST_INI_OPTIONS_DEFAULT;

    // Propriété qui conserve la position(index) des objets PageControl (onglets)
//    property SavePosForm: Boolean read FSavePosForm  write FSavePosForm default False;
//    property SameMonitor: Boolean read FSameMonitor  write FSameMonitor default False;
    property OnIniLoad  : TEventIni read FOnIniLoad write FOnIniLoad ;
    property OnIniWrite : TEventIni read FOnIniWrite write FOnIniWrite;
    property OnWriteComponent : TOnIniComponent read FOnWriteComponent write FOnWriteComponent;
    property OnReadComponent  : TOnIniComponent read FOnReadComponent  write FOnReadComponent;
    property OnFormShow : TNotifyEvent read FOnFormShow write FOnFormShow;
    property OnFormDestroy : TNotifyEvent read FOnFormDestroy write FOnFormDestroy;
    property OnFormCreate : TNotifyEvent read FOnFormCreate write FOnFormCreate;
    property OnDefaultDirectory: TOnIniString read FOnDefaultDirectory write FOnDefaultDirectory;
//    property Freeini : Boolean read FFreeIni write FFreeIni default True;
    procedure LaFormDestroy(Sender: TObject);
    procedure LaFormShow(Sender: TObject);
    procedure LaFormCreate(Sender: TObject);
  end;


implementation

uses TypInfo, Grids,
{$IFDEF FPC}
     EditBtn, FileUtil,
{$ENDIF}
{$IFDEF VIRTUALTREES}
     VirtualTrees ,
{$ENDIF}
  Math,
  fonctions_proprietes;

const INI_VERIFY_MIN_WEIGHT    = 10;
      INI_VERIFY_WEIGHT_TO_PUT = 90;

////////////////////////////////////////////////////////////////////////////////
// Constructeur de l'objet TOnFormInfoIni
////////////////////////////////////////////////////////////////////////////////
constructor TOnFormInfoIni.Create(AOwner: TComponent);
var lmet_MethodToAdd  : TMethod;
begin
  Inherited Create(AOwner);
  FSaveForm      := [];
  FOptions       := CST_INI_OPTIONS_DEFAULT;
  FDefaultDirectory := sdUnknown;
  FOnReadComponent    := nil;
  FOnWriteComponent   := nil;
  FOnDefaultDirectory := nil;
  FOnIniLoad     := nil;
  FOnIniWrite    := nil;
  if not (csDesigning in ComponentState)  //si on est pas en mode conception
  and ( AOwner is TCustomForm ) then
    begin
      lmet_MethodToAdd.Data := Self;
      lmet_MethodToAdd.Code := MethodAddress('LaFormDestroy' );
      FFormOwner           := TCustomForm(AOwner);        // La forme propriétaire de notre composant
      FormOldDestroy       := TNotifyEvent ( fmet_getComponentMethodProperty ( FFormOwner, CST_ONFORMINI_ONDESTROY )); // Sauvegarde de l'événement OnDestroy
      p_SetComponentMethodProperty ( FFormOwner, CST_ONFORMINI_ONDESTROY, lmet_MethodToAdd );        // Idem pour OnDestroy
      FormOldCreate        := TNotifyEvent ( fmet_getComponentMethodProperty ( FFormOwner, CST_ONFORMINI_ONCREATE ));  // Sauvegarde de l'événement OnClose
      lmet_MethodToAdd.Code := MethodAddress('LaFormCreate' );
      p_SetComponentMethodProperty ( FFormOwner, CST_ONFORMINI_ONCREATE, lmet_MethodToAdd );         // Idem pour OnClose
      FormOldShow          := TNotifyEvent ( fmet_getComponentMethodProperty ( FFormOwner, CST_ONFORMINI_ONSHOW ));  // Sauvegarde de l'événement OnShow
      lmet_MethodToAdd.Code := MethodAddress('LaFormShow' );
      p_SetComponentMethodProperty ( FFormOwner, CST_ONFORMINI_ONSHOW, lmet_MethodToAdd );     // Idem pour OnShow
      p_SetComponentObjectProperty( FFormOwner, 'IniComponent', Self );
    End;
end;


////////////////////////////////////////////////////////////////////////////////
// Au chargement de l'objet TOnFormInfoIni, on lit les données dans le fichier ini
////////////////////////////////////////////////////////////////////////////////
{procedure TOnFormInfoIni.loaded;
begin
  inherited;
  if not Assigned(FFormOwner) then
    Exit;
end;
}
////////////////////////////////////////////////////////////////////////////////
// À la fermeture de la form, on écrit les données dans le fichier ini
////////////////////////////////////////////////////////////////////////////////
procedure TOnFormInfoIni.LaFormDestroy ( Sender: TObject );
begin
  if Assigned(FormOldDestroy) then FormOldDestroy(Sender);
  if Assigned(FFormOwner)
  and ( loAutoWrite in FOptions )
   then
    p_ExecuteEcriture(FFormOwner);
  if Assigned(FOnFormDestroy) then FOnFormDestroy(Sender);
end;

procedure TOnFormInfoIni.PlaceForm;
Begin
  f_GetMemIniFile;
  if Assigned(FInifile) then
   with FFormOwner do
    try
      Updating ;
          // Traitement de la position de la af_Form

      if (TFormStyle ( fli_getComponentProperty ( FFormOwner, CST_ONFORMINI_DOT + CST_ONFORMINI_FORMSTYLE )) <> fsMDIChild) then
        p_LecturePositionFenetre(FFormOwner);

    finally
      Updated;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
// À la fermeture de la form, on écrit les données dans le fichier ini
////////////////////////////////////////////////////////////////////////////////
procedure TOnFormInfoIni.LaFormCreate ( Sender: TObject );
begin
  FUpdateAll := False ;
  if Assigned(FormOldCreate) then FormOldCreate(Sender);
  PlaceForm;
  if Assigned(FOnFormCreate) then FOnFormCreate(Sender);
end;

procedure TOnFormInfoIni.DoSameMonitor(const aForm:TCustomForm);
var
  RectMonitor:TRect;
begin //Positionne et redimentionne éventuellement aForm sur le moniteur de FMain
  if not ( sfSameMonitor in FSaveForm )
  or ( aForm = Application.MainForm )
   Then Exit;

  RectMonitor:=Application.MainForm.Monitor.BoundsRect;
  with aForm do
   Begin
    SetPropValue ( aform, 'Position',poDesigned);
    WindowState:=wsNormal;
    if Height>(RectMonitor.Bottom-RectMonitor.Top) then
      Height:=RectMonitor.Bottom-RectMonitor.Top;
    if Top<RectMonitor.Top then
      Top:=RectMonitor.Top;
    if (Top+Height)>RectMonitor.Bottom then
      Top:=RectMonitor.Bottom-Height;
    if Width>(RectMonitor.Right-RectMonitor.Left) then
      Width:=RectMonitor.Right-RectMonitor.Left;
    if Left<RectMonitor.Left then
      Left:=RectMonitor.Left;
    if (Left+Width)>RectMonitor.Right then
      Left:=RectMonitor.Right-Width;
   end;
end;

procedure TOnFormInfoIni.LaFormShow(Sender: TObject);

begin
  try
    if Assigned(FormOldShow)
     then FormOldShow(Sender);
  Except

  end;
  if loAutoLoad in FOptions then
    p_ExecuteLecture(TForm(Self.Owner));

  if Assigned(FOnFormShow) then FOnFormShow(Sender);

end;


////////////////////////////////////////////////////////////////////////////////
// Fonction qui regarde dans la propriété TSaveEdits de TOnFormInfoIni
// et renvoie la valeur de sauvegarde d'un objet de la form
////////////////////////////////////////////////////////////////////////////////
function TOnFormInfoIni.GetfeSauveEdit(const aSauveObjet:TSaveEdits;const aObjet :TSaveEdit):Boolean;
begin
  Result := False;
  if aObjet in aSauveObjet then
    Result := True;
end;

////////////////////////////////////////////////////////////////////////////////
// Lecture des données dans le fichier ini
////////////////////////////////////////////////////////////////////////////////
procedure TOnFormInfoIni.ExecuteLecture ( aLocal:Boolean);
var i: integer;
begin
  // automatisation
  if Assigned(FFormOwner)
   then
    if aLocal Then // Demande si la fiche a été ouverte
     Begin
       for i := 0 to Application.ComponentCount - 1 do //pour chaque fiche de l'application
         if ( Application.Components[i] is TForm )
         and (FFormOwner.Name = (TForm(Application.Components[i])).Name) then
           p_ExecuteLecture(TForm(Application.Components[i])); //fin pour chaque fiche de l'application
     End
    Else  p_ExecuteLecture(FFormOwner);
end;


////////////////////////////////////////////////////////////////////////////////
// Lecture des données dans le fichier INI
////////////////////////////////////////////////////////////////////////////////
procedure TOnFormInfoIni.p_ExecuteLecture(const aF_Form: TCustomForm);
var
  j, li_Taille : integer;
  ab_keepon : Boolean;
  lcom_Component : Tcomponent ;

  function fli_ReadInteger (const as_ComponentName : String; const ali_Default : Longint ):Longint;
  Begin
    Result := FInifile.ReadInteger ( af_Form.Name, as_ComponentName, ali_Default );
  end;

  function fb_ReadHighComponents: Boolean;
  var lal_Align : TAlign;
      ASplit : {$IFDEF FPC}TCustomSplitter{$ELSE}TSplitter{$ENDIF};
  Begin
    Result := False;
    if (lcom_Component is TCustomDBGrid) and
       GetfeSauveEdit(FSaveEdits, feTGrid) then
      begin
        f_IniReadGridFromIni ( FInifile, aF_Form.Name, lcom_Component as TCustomDBGrid );
        // No continue because other use of grid
      end;

    {$IFDEF VIRTUALTREES}
    if (lcom_Component is TBaseVirtualTree )
     and   GetfeSauveEdit(FSaveEdits, feTVirtualTrees) then
        begin
          f_IniReadVirtualTreeFromIni ( FInifile, aF_Form.Name, lcom_Component as TBaseVirtualTree );
        // No continue because other use of tree
      end;
    {$ENDIF}

    if (lcom_Component is TCustomListView)
     and   GetfeSauveEdit(FSaveEdits, feTListView) then
        begin
          f_IniReadListViewFromIni ( FInifile, aF_Form.Name, lcom_Component as TCustomListView );
        // No continue because other use of listview
      end;

    // lecture de la position des objets Panels et Rxsplitters
    if  ( sfSaveSizes in FSaveForm )
     and (   lcom_Component is {$IFDEF FPC}TCustomSplitter{$ELSE}TSplitter{$ENDIF})
     and (   lcom_Component as TControl ).Visible
     then
      begin
        lal_Align := ( lcom_Component as TControl).Align;
  //        ShowMessage( af_Form.Name + ' t ' +  lcom_Component.Name +' ' +IntToStr(fli_ReadInteger ( lcom_Component.Name +CST_ONFORMINI_DOT + CST_ONFORMINI_LEFT , TControl (lcom_Component).Left)));
        ASplit := {$IFDEF FPC}TCustomSplitter{$ELSE}TSplitter{$ENDIF}(lcom_Component);
        case lal_Align of
          alLeft,alRight : ASplit.{$IFDEF FPC}SetSplitterPosition{$ELSE}Left:={$ENDIF}(fli_ReadInteger ( lcom_Component.Name +CST_ONFORMINI_DOT + CST_ONFORMINI_LEFT , TControl (lcom_Component).Left));
          alTop,alBottom : ASplit.{$IFDEF FPC}SetSplitterPosition{$ELSE}Top :={$ENDIF}(fli_ReadInteger ( lcom_Component.Name +CST_ONFORMINI_DOT + CST_ONFORMINI_TOP, TControl (lcom_Component).Top));
        End;
        Result := True;
      end;
  end;


begin
  f_GetMemIniFile;
  if Assigned(FInifile) then
    try
      ab_keepon := True;

      If Assigned ( FOnIniLoad ) Then
        FOnIniLoad ( FInifile, ab_keepon );

      // traitement des composants de la af_Form
      if ab_keepon
      and ( ( sfSaveSizes in FSaveForm ) or (FSaveEdits <> [])) Then
      for j := 0 to af_Form.ComponentCount - 1 do
          begin
            try
              lcom_Component := aF_Form.Components[j];

              if Assigned(FOnReadComponent) Then
               Begin  // filtering event
                 ab_keepon := True;
                 FOnReadComponent(lcom_Component,FIniFile,ab_keepon);
                 if not ab_keepon
                  Then
                   Continue;
               end;

              if fb_ReadHighComponents Then
                continue;
              if (FSaveEdits <> [])
              and not assigned ( fobj_getComponentObjectProperty(lcom_Component,CST_ONFORMINI_DATASOURCE))
               Then
                  ReadIniComponent(lcom_Component,aF_Form);
            except
            end;
        end;

    finally
    end;
 p_Freeini;
end;

procedure TOnFormInfoIni.ReadIniComponent(const acom_Component,af_Form: TComponent);
var ls_Temp : String;
  procedure p_DefaultDirectory ( var as_DefaultDir : String);
  Begin
    if DirectoryExistsUTF8(as_DefaultDir) Then Exit;
    if FDefaultDirectory>sdUnknown
     Then as_DefaultDir := GetDirectory(FDefaultDirectory);
    if Assigned(FOnDefaultDirectory) Then
     FOnDefaultDirectory(acom_Component,FIniFile,as_DefaultDir);
  end;

  function fli_ReadInteger (const as_ComponentName : String; const ali_Default : Longint ):Longint;
  Begin
    Result := FInifile.ReadInteger ( af_Form.Name, as_ComponentName, ali_Default );
  end;

  function fs_ReadString ( const as_ComponentName, as_Default : String ):String;
  Begin
    Result := FInifile.ReadString ( af_Form.Name, as_ComponentName, as_Default );
  end;

  function fb_ReadOptions: Boolean;
  Begin
    Result := False;
    // lecture des CheckBoxes
    if GetfeSauveEdit ( FSaveEdits, feTCheck )
     and (   (acom_Component is TCheckBox)
        or (acom_Component.ClassNameIs( CST_ONFORMINI_XPCHECK ))
        or (acom_Component.ClassNameIs( CST_ONFORMINI_FLATCHECK ))
        or (acom_Component.ClassNameIs( CST_ONFORMINI_PCHECK )))
     then
      begin
        p_SetComponentBoolProperty(acom_Component,CST_ONFORMINI_CHECKED, FInifile.ReadBool(af_Form.name,acom_Component.Name,fb_getComponentBoolProperty(acom_Component, CST_ONFORMINI_CHECKED)));
        Result := True;
      end;
    // lecture des RadioBoutons
    if    GetfeSauveEdit ( FSaveEdits, feTRadio )
     and (acom_Component is TRadioButton) then
      begin
        TRadioButton(acom_Component).Checked:= FInifile.ReadBool(af_Form.name,acom_Component.Name,true);
        Result := True;
      end;
    // lecture des RadioBoutons
    if  GetfeSauveEdit ( FSaveEdits, feTSpeedButton )
    and (acom_Component is TSpeedButton) then
     with TSpeedButton(acom_Component) do
      begin
        Down:= FInifile.ReadBool(af_Form.name,acom_Component.Name,true);
        if Down then Click;
        Result := True;
      end;
    // lecture des groupes de RadioBoutons
    if GetfeSauveEdit ( FSaveEdits, feTRadioGroup )
    and (acom_Component is TRadioGroup) then
      try
        TRadioGroup(acom_Component).ItemIndex:= fli_ReadInteger (acom_Component.Name,0);
        Result := True;
      Except
      end;

  end;

  function fb_ReadEdits: Boolean;
  Begin
    Result := False;
    if GetfeSauveEdit(FSaveEdits ,feTedit) and ((acom_Component is TCustomEdit)
    and not assigned ( fobj_getComponentObjectProperty(acom_Component, CST_DBPROPERTY_DATASOURCE)))
     then
      begin
        p_SetComponentProperty(acom_Component, CST_ONFORMINI_TEXT, fs_ReadString(acom_Component.Name, fs_getComponentProperty(acom_Component, CST_ONFORMINI_TEXT ) ));
        // do not quit after because there are other edits
        Exit;
      end;

    if GetfeSauveEdit(FSaveEdits ,feTDateEdit) Then
      if (acom_Component is {$IFDEF FPC} TDateEdit {$ELSE} TJvCustomDateEdit {$ENDIF}) then
        Begin
          {$IFDEF FPC} TDateEdit {$ELSE} TJvCustomDateEdit {$ENDIF}(acom_Component).Date := StrToDateTime(fs_ReadString(acom_Component.Name,DateToStr(Date)));
          Result := True;
          Exit;
        End;

    if  GetfeSauveEdit(FSaveEdits ,feTEdit)
    and acom_Component.ClassNameIs(CST_ONFORMINI_EXTNUMEDIT) then
        begin
          TCustomEdit(acom_Component).Text := fs_ReadString(acom_Component.Name,' ');
          Result := True;
        end;

  end;
  function fb_ReadFiles: Boolean;
  var ls_FilenameProp : String;
  Begin
    Result := False;
    if GetfeSauveEdit(FSaveEdits ,feTFileNameEdit)
    and (  acom_Component.ClassNameIs ( 'TJvFileNameEdit' )
        or acom_Component.ClassNameIs ( 'TFileNameEdit' ))
      then
        Begin
         if IsPublishedProp(acom_Component, CST_PROPERTY_TEXT )
          Then ls_FilenameProp:=CST_PROPERTY_TEXT
          Else ls_FilenameProp:=CST_ONFORMINI_FILENAME;
         //setting saved or default filename
         ls_Temp:=fs_ReadString ( acom_Component.Name,
                                  fs_getComponentProperty (acom_Component, ls_FilenameProp ));
         p_SetComponentProperty ( acom_Component, ls_FilenameProp,
                                  ls_Temp );
         //setting saved or default directory
         ls_Temp:=fs_ReadString ( acom_Component.Name,
                                  fs_getComponentProperty (acom_Component, CST_PROPERTY_INITIALDIR ));
         p_DefaultDirectory(ls_Temp);
         p_SetComponentProperty ( acom_Component, CST_PROPERTY_INITIALDIR,
                                  ls_Temp );
          Result := True;
        end;

  end;

  function fb_ReadDirectories: Boolean;
  var ls_DirnameProp : String;
  Begin
    Result := False;
    if GetfeSauveEdit(FSaveEdits ,feTDirectoryEdit)
    and (acom_Component.ClassNameIs(CST_ONFORMINI_JVDIRECTORY)
         or (acom_Component.ClassNameIs ( CST_ONFORMINI_DirectoryEdit ))) Then
      Begin
       if IsPublishedProp(acom_Component, CST_ONFORMINI_DIRECTORYEDIT_DIR )
        Then ls_DirnameProp := CST_ONFORMINI_DIRECTORYEDIT_DIR
        Else ls_DirnameProp := CST_PROPERTY_TEXT;
       //setting saved or default directory
       ls_Temp := fs_ReadString(acom_Component.Name, fs_getComponentProperty(acom_Component, ls_DirnameProp));
       p_DefaultDirectory(ls_Temp);
       p_SetComponentProperty (acom_Component, ls_DirnameProp, ls_temp );
       Result := True;
      End;

  end;

  function fb_ReadSpecialEdits: Boolean;
  Begin
    Result := False;
    {$IFDEF DELPHI}
    if GetfeSauveEdit(FSaveEdits ,feTDateTimePicker) Then
      if (acom_Component is TDateTimePicker) then
        begin
          if fs_ReadString(acom_Component.Name,'%ù@à*£')<>'%ù@à*£' then TDateTimePicker(acom_Component).DateTime:=StrToDateTime( fs_ReadString(acom_Component.Name,''));
          Result := True;
        end;
    {$ENDIF}
    if GetfeSauveEdit(FSaveEdits ,feTSpinEdit)
    and (   (acom_Component.ClassNameIs( CST_ONFORMINI_SPINEDIT))
         or (acom_Component.ClassNameIs( CST_ONFORMINI_FWSPINEDIT))
         or (acom_Component.ClassNameIs( CST_ONFORMINI_JVSPINEDIT))
         or (acom_Component.ClassNameIs( CST_ONFORMINI_RXSPINEDIT)))
       then
        begin
          p_SetComponentProperty(acom_Component, CST_ONFORMINI_VALUE, fli_ReadInteger (acom_Component.Name,fli_getComponentProperty(acom_Component, CST_ONFORMINI_VALUE)));
          Result := True;
        end;

  end;

  function fb_ReadMemos: Boolean;
  Begin
    Result := False;
    if GetfeSauveEdit(FSaveEdits ,feTMemo)
    and (acom_Component is TCustomMemo) then
      begin
        LitTstringsDeIni(FInifile, aF_Form.Name + '-' + acom_Component.Name,TCustomMemo(acom_Component).Lines );
        Result := True;
      end;
    if GetfeSauveEdit(FSaveEdits ,feTRichEdit)
    and {$IFDEF FPC}(acom_Component.ClassNameIs(CST_ONFORMINI_RICHVIEW) or acom_Component.ClassNameIs(CST_ONFORMINI_RICHMEMO) {$ELSE} (acom_Component is  TCustomRichEdit {$ENDIF})
    and ( fobj_getComponentObjectProperty(acom_Component, CST_ONFORMINI_LINES ) <> nil)
     then
      begin
        LitTstringsDeIni(FInifile, af_Form.Name + '-' +  acom_Component.Name,fobj_getComponentObjectProperty(acom_Component, CST_ONFORMINI_LINES ) as TStrings );
        Result := True;
      end;
  end;

  function fb_ReadCombosLists: Boolean;
  var ls_Temp : String;
  Begin
    Result := False;
    if GetfeSauveEdit(FSaveEdits ,feTListBox)
    and (acom_Component is TCustomListBox)     then
      try
        LitTstringsDeIni(FInifile, acom_Component.Name,TCustomListBox(acom_Component).Items);
        Result := True;
      except
      end;
    if  GetfeSauveEdit(FSaveEdits ,feTComboBox)
    and (acom_Component is TComboBox)    then
      begin
        p_ReadComboBoxItems(acom_Component, TCustomComboBox(acom_Component).Items );
        Result := True;
      end;
    if (   (GetfeSauveEdit(FSaveEdits ,feTComboValue) and (acom_Component is TCustomComboBox))
        or (GetfeSauveEdit(FSaveEdits ,feTListValue ) and (acom_Component is TCustomListBox )))
     then
      try
        if   assigned ( GetPropInfo ( acom_Component, CST_PROPERTY_TEXT ))
        then SetPropValue    ( acom_Component, CST_PROPERTY_TEXT ,fs_ReadString(acom_Component.Name+CST_ONFORMINI_DOT + CST_PROPERTY_TEXT,
                               fs_getComponentProperty(acom_Component, CST_PROPERTY_TEXT)))
        else if   assigned ( GetPropInfo ( acom_Component, CST_PROPERTY_ITEMINDEX ))
        Then SetPropValue    ( acom_Component, CST_PROPERTY_ITEMINDEX ,fli_ReadInteger(acom_Component.Name+CST_ONFORMINI_DOT + CST_PROPERTY_ITEMINDEX,
                               fli_getComponentProperty(acom_Component, CST_PROPERTY_ITEMINDEX)));
        Exit;
      Except
      End;
    if GetfeSauveEdit(FSaveEdits ,feTColorCombo)
    and (acom_Component.CLassNameIs( CST_ONFORMINI_EXTCOLOR))
     then
      begin
         ls_Temp := fs_ReadString(acom_Component.Name+CST_ONFORMINI_DOT + CST_ONFORMINI_VALUE,'');
         if ls_Temp > '' Then
          p_SetComponentProperty(acom_Component, CST_ONFORMINI_VALUE, ls_Temp );
         Exit;
      End;
  {$IFDEF RX}
    if GetfeSauveEdit(FSaveEdits ,feTComboValue)
    and (acom_Component is {$IFDEF FPC}TRxCustomDBLookupCombo{$ELSE}TRxLookupControl{$ENDIF})
     Then
      begin
        {$IFNDEF FPC}
        if (acom_Component is TRxDBLookupList ) Then
          (acom_Component as TRxDBLookupList).DisplayValue := fs_ReadString(acom_Component.Name + CST_ONFORMINI_DOT + CST_ONFORMINI_VALUE, '')
         else
         {$ENDIF}
          if (acom_Component is TRxDBLookupCombo ) Then
          {$IFDEF FPC}
            (acom_Component as TRxDBLookupCombo).LookupDisplayIndex := fli_ReadInteger (acom_Component.Name + CST_ONFORMINI_DOT + CST_ONFORMINI_INDEX, -1);
          {$ELSE}
           (acom_Component as TRxDBLookupCombo).DisplayValue := fs_ReadString(acom_Component.Name + CST_ONFORMINI_DOT + CST_ONFORMINI_INDEX, '');
           {$ENDIF}
        Exit;
      End;
  {$ENDIF}
  end;

  function fb_ReadInteractivityComponents: Boolean;
  var k : Longint;
      mit: TMenuItem;
  Begin
    Result := False;
    // lecture de la page de contrôle(onglets)
    if GetfeSauveEdit ( FSaveEdits, feTPageControl )
    and ((acom_Component is TCustomTabControl))   then
      begin
        if IsPublishedProp(acom_Component, CST_ONFORMINI_TABINDEX )
         Then p_SetComponentProperty(acom_Component,CST_ONFORMINI_TABINDEX ,fli_ReadInteger ( acom_Component.Name , 0))
         Else p_SetComponentProperty(acom_Component,CST_ONFORMINI_PAGEINDEX,fli_ReadInteger ( acom_Component.Name , 0));
        Result := True;
      end;
    // lecture de PopupMenu
    if GetfeSauveEdit ( FSaveEdits, feTPopup )
    and (acom_Component is TPopupMenu)  then
      begin
        mit := TMenu(acom_Component).Items;
        for k := 0 to mit.Count-1 do
         with mit.Items[k] do
            Checked := FInifile.ReadBool (af_Form.Name, acom_Component.Name+'_'+Name,Checked);
        Result := True;
      end;

  end;
begin
  if fb_ReadOptions  Then
    Exit;

  if fb_ReadEdits Then
    Exit;

  if fb_ReadSpecialEdits  Then
    Exit;

  if fb_ReadFiles Then
    Exit;

  if fb_ReadDirectories  Then
    Exit;

  if fb_ReadCombosLists  Then
    Exit;

  if fb_ReadInteractivityComponents Then
    Exit;
  if fb_ReadMemos Then
    Exit;

end;

procedure TOnFormInfoIni.p_Freeini;
begin
  if ( loFreeIni in FOptions ) Then
    Begin
      FreeAndNil(FIniFile);
    end;
end;
////////////////////////////////////////////////////////////////////////////////
// Ecriture des données dans le fichier ini
////////////////////////////////////////////////////////////////////////////////
procedure TOnFormInfoIni.ExecuteEcriture(aLocal:Boolean);
var i : Integer ;

begin

  if not assigned ( FFormOwner )
  or not ( loAutoWrite in FOptions )
   Then
    Exit ;
  FUpdateAll := True ;
  f_GetMemIniFile;
  try
    For i:=0 to application.ComponentCount-1 do //pour chaque af_Form de l'application
    begin
      if ( application.Components[i] is TCustomForm )
      and ((FFormOwner.Name = ( TForm ( application.Components[i] )).Name) and aLocal) or (Not aLocal)
       Then
        p_ExecuteEcriture ( TCustomForm ( application.Components[i] ));
    end; //fin pour chaque af_Form de l'application
  finally
    FUpdateAll := False ;

    if ( loAutoUpdate in FOptions ) Then
      Begin
        fb_iniWriteFile ( FInifile, False );
        Application.ProcessMessages ;

      End ;
  End ;
  p_Freeini;
end;

////////////////////////////////////////////////////////////////////////////////
// Ecriture des données dans le fichier INI
////////////////////////////////////////////////////////////////////////////////
procedure TOnFormInfoIni.p_ExecuteEcriture(const aF_Form: TCustomForm);
var
  ab_keepon : Boolean ;
  mit: TMenuItem;
  j: integer;
  acom_Component : TComponent;
  procedure p_WriteString ( const as_ComponentName, as_Value : String );
  Begin
    FInifile.WriteString ( af_Form.Name, as_ComponentName, as_Value );
  End;

  procedure p_WriteInteger ( const as_ComponentName : String; const ai_Value : Longint );
  Begin
    FInifile.WriteInteger ( af_Form.Name, as_ComponentName, ai_Value );
  End;

  function fb_WriteHighComponents : Boolean;
  var lal_Align : TAlign;
      ASplit : {$IFDEF FPC}TCustomSplitter{$ELSE}TSplitter{$ENDIF};
  Begin
    Result := False;
    if (acom_Component is TCustomDBGrid) and
       GetfeSauveEdit(FSaveEdits, feTGrid) then
      begin
        p_IniWriteGridToIni ( FInifile, af_Form.Name, acom_Component as TCustomDBGrid );
      end;

    {$IFDEF VIRTUALTREES}
        if (acom_Component is TBaseVirtualTree )
         and   GetfeSauveEdit(FSaveEdits, feTVirtualTrees) then
          begin
            p_IniWriteVirtualTreeToIni ( FInifile, af_Form.Name, acom_Component as TBaseVirtualTree );
          end;
    {$ENDIF}

        if (acom_Component is TListView)
         and   GetfeSauveEdit(FSaveEdits, feTListView) then
          begin
            p_IniWriteListViewToIni ( FInifile, af_Form.Name, acom_Component as TListView );
          end;

    // écriture des positions des objets Panels et RxSplitters
    if  ( sfSaveSizes in FSaveForm )
    and ((   acom_Component is {$IFDEF FPC}TCustomSplitter{$ELSE}TSplitter{$ENDIF}  )
          or acom_Component.ClassNameIs(CST_ONFORMINI_JVSPLITTER)
          or acom_Component.ClassNameIs(CST_ONFORMINI_RXSPLITTER))
    and (   acom_Component as TControl ).Visible
      then
       begin
        lal_Align := ( acom_Component as TControl).Align;
//        WriteLn( af_Form.Name + '  ' +  acom_Component.Name +' ' +IntToStr(TControl (acom_Component).Left));
        case lal_Align of
          alLeft,alRight : p_WriteInteger( acom_Component.Name +CST_ONFORMINI_DOT + CST_ONFORMINI_LEFT , TControl (acom_Component).Left);
          alTop,alBottom : p_WriteInteger( acom_Component.Name +CST_ONFORMINI_DOT + CST_ONFORMINI_TOP, TControl (acom_Component).Top);
        End;
        Result := True;
      end;
  end;
  function fb_WriteEdits : Boolean;
  Begin
    Result := False;
    if GetfeSauveEdit(FSaveEdits ,feTedit)
    and ((acom_Component is TCustomEdit)
    and not assigned ( fobj_getComponentObjectProperty(acom_Component, CST_DBPROPERTY_DATASOURCE)))
     then
      begin
        p_WriteString(acom_Component.Name,fs_getComponentProperty(acom_Component,CST_ONFORMINI_TEXT));
        // do not quit after because there are other edits
        Exit;
      end;
    if GetfeSauveEdit(FSaveEdits ,feTCurrencyEdit)
    and acom_Component.ClassNameIs(CST_ONFORMINI_EXTNUMEDIT)
    and not assigned ( fobj_getComponentObjectProperty(acom_Component, CST_DBPROPERTY_DATASOURCE))then
      begin
        p_WriteString(acom_Component.Name,TCustomEdit(acom_Component).Text);
        Result := True;
        Exit;
      end;
    if GetfeSauveEdit(FSaveEdits ,feTDateEdit)
    and (acom_Component is {$IFDEF FPC} TDateEdit {$ELSE} TJvCustomDateEdit {$ENDIF}) then
      begin
        p_WriteString(acom_Component.Name,DateTimeToStr({$IFDEF FPC} TDateEdit {$ELSE} TJvCustomDateEdit {$ENDIF}(acom_Component).Date));
        Result := True;
      end;
  end;
  function fb_WriteSpecialEdits : Boolean;
  Begin
    Result := False;
    if GetfeSauveEdit(FSaveEdits ,feTSpinEdit)
    and  (   (acom_Component.ClassNameIs(CST_ONFORMINI_SPINEDIT))
          or (acom_Component.ClassNameIs(CST_ONFORMINI_FWSPINEDIT))
          or (acom_Component.ClassNameIs(CST_ONFORMINI_JVSPINEDIT))
          or (acom_Component.ClassNameIs(CST_ONFORMINI_RXSPINEDIT)))
     then
      begin
        p_WriteInteger(acom_Component.Name,fli_getComponentProperty(acom_Component, CST_ONFORMINI_VALUE ));
        Result := True;
      end;

  end;

  function fb_WriteOptions : Boolean;
  Begin
    Result := False;
    if  GetfeSauveEdit(FSaveEdits, feTCheck )
    and (    (acom_Component is TCheckBox)
          or (acom_Component.ClassNameIs( CST_ONFORMINI_XPCHECK ))
          or (acom_Component.ClassNameIs( CST_ONFORMINI_FLATCHECK ))
          or (acom_Component.ClassNameIs( CST_ONFORMINI_PCHECK )))
     then
      begin
        FInifile.WriteBool(af_Form.name,acom_Component.Name,fb_getComponentBoolProperty ( acom_Component, CST_ONFORMINI_CHECKED ));
        Result := True;
      end;
    if GetfeSauveEdit(FSaveEdits, feTRadio )
    and (acom_Component is TRadioButton) then
      begin
        FInifile.WriteBool(af_Form.name,acom_Component.Name,TRadioButton(acom_Component).Checked);
        Result := True;
      end;
    if GetfeSauveEdit(FSaveEdits, feTSpeedButton )
    and (acom_Component is TSpeedButton) then
      begin
        FInifile.WriteBool(af_Form.name,acom_Component.Name,TSpeedButton(acom_Component).Down);
        Result := True;
      end;
    if GetfeSauveEdit(FSaveEdits, feTRadioGroup )
    and (acom_Component is TRadioGroup)   then
      begin
        p_WriteInteger(acom_Component.Name,TRadioGroup(acom_Component).ItemIndex);
        Result := True;
      end;

  end;

  function fb_WriteDirectories : Boolean;
  var ls_DirnameProp : String;
  Begin
    Result := False;
    if  GetfeSauveEdit(FSaveEdits ,feTDirectoryEdit)
    and (acom_Component.ClassNameIs(CST_ONFORMINI_JVDIRECTORY)
        or (acom_Component.ClassNameIs ( CST_ONFORMINI_DirectoryEdit ))) then
      begin
       if IsPublishedProp(acom_Component, CST_ONFORMINI_DIRECTORYEDIT_DIR )
        Then ls_DirnameProp:=CST_ONFORMINI_DIRECTORYEDIT_DIR
        Else ls_DirnameProp:=CST_PROPERTY_TEXT;
        p_WriteString(acom_Component.Name,fs_getComponentProperty(acom_Component,ls_DirnameProp));
        Result := True;
      end;

  end;

  function fb_WriteFiles : Boolean;
  var ls_FilenameProp : String;
  Begin
    Result := False;
    if GetfeSauveEdit(FSaveEdits ,feTFileNameEdit)
    and (  acom_Component.ClassNameIs ( 'TJvFileNameEdit' )
        or acom_Component.ClassNameIs ( 'TFileNameEdit' ))
      then
        Begin
         if IsPublishedProp(acom_Component, CST_PROPERTY_TEXT )
          Then ls_FilenameProp:=CST_PROPERTY_TEXT
          Else ls_FilenameProp:=CST_ONFORMINI_FILENAME;
        p_WriteString( acom_Component.Name,
                       fs_getComponentProperty (acom_Component, ls_FilenameProp ));
        Result:=True;
      End ;

  end;

  function fb_WriteMemos : Boolean;
  Begin
    Result := False;
    if GetfeSauveEdit(FSaveEdits ,feTMemo)
    and (acom_Component is TCustomMemo)     then
      begin
        SauveTStringsDansIni(FInifile, af_Form.Name + '-' +  acom_Component.Name,TCustomMemo(acom_Component).Lines);
        Result := True;
      end;
    if GetfeSauveEdit(FSaveEdits ,feTRichEdit)
    and {$IFDEF FPC}(acom_Component.ClassNameIs(CST_ONFORMINI_RICHVIEW) or acom_Component.ClassNameIs(CST_ONFORMINI_RICHMEMO) {$ELSE} (acom_Component is  TCustomRichEdit {$ENDIF})
    and ( fobj_getComponentObjectProperty(acom_Component, CST_ONFORMINI_LINES ) <> nil)
     then
      begin
        SauveTStringsDansIni(FInifile, af_Form.Name + '-' +  acom_Component.Name,fobj_getComponentObjectProperty(acom_Component, CST_ONFORMINI_LINES ) as TStrings);
        Result := True;
      end;

  end;

  function fb_WriteCombos : Boolean;
  Begin
    Result := False;
    if GetfeSauveEdit(FSaveEdits ,feTComboBox)
    and (acom_Component is TCustomComboBox)        then
      begin
        p_writeComboBoxItems(acom_Component,TCustomComboBox(acom_Component).Items);
        Result := True;
      end;
    if GetfeSauveEdit(FSaveEdits ,feTColorCombo)
    and (acom_Component.CLassNameIs( CST_ONFORMINI_EXTCOLOR))
     then
      begin
        p_WriteInteger(acom_Component.Name+ CST_ONFORMINI_DOT + CST_ONFORMINI_VALUE, fli_getComponentProperty (acom_Component, CST_ONFORMINI_VALUE));
        // No continue : Maybe a customcombo
        Result := True;
        Exit;
      End;
    if (   (GetfeSauveEdit(FSaveEdits ,feTComboValue) and (acom_Component is TCustomComboBox))
        or (GetfeSauveEdit(FSaveEdits ,feTListValue ) and (acom_Component is TCustomListBox )))
     Then
      begin
        if assigned ( GetPropInfo ( acom_Component, CST_PROPERTY_TEXT ))
        then p_WriteString(acom_Component.Name+CST_ONFORMINI_DOT + CST_PROPERTY_TEXT, GetPropValue    ( acom_Component, CST_PROPERTY_TEXT))
        else if   assigned ( GetPropInfo ( acom_Component, CST_PROPERTY_ITEMINDEX ))
        Then p_WriteInteger(acom_Component.Name+CST_ONFORMINI_DOT + CST_PROPERTY_ITEMINDEX, GetPropValue ( acom_Component, CST_PROPERTY_ITEMINDEX ));
          // No continue : Maybe a customcombo
        Result := True;
        Exit;
      End;
  {$IFDEF RX}
    if GetfeSauveEdit(FSaveEdits ,feTComboValue)
    and (acom_Component is {$IFDEF FPC}TRxCustomDBLookupCombo{$ELSE}TRxLookupControl{$ENDIF})
     then
      begin
       {$IFNDEF FPC}
        if (acom_Component is TRxDBLookupList) Then
          p_WriteString(acom_Component.Name + CST_ONFORMINI_DOT + CST_ONFORMINI_VALUE, (acom_Component as TRxDBLookupList).DisplayValue)
         else
        {$ENDIF}
          if (acom_Component is TRxDBLookupCombo) Then
          {$IFDEF FPC}
            p_WriteInteger(acom_Component.Name + CST_ONFORMINI_DOT + CST_ONFORMINI_INDEX, (acom_Component as TRxDBLookupCombo).LookupDisplayIndex);
          {$ELSE}
            p_WriteString(acom_Component.Name + CST_ONFORMINI_DOT + CST_ONFORMINI_VALUE, (acom_Component as TRxDBLookupCombo).DisplayValue);
           {$ENDIF}
          // No continue : Maybe a customcombo
        Result := True;
      End;
  {$ENDIF}
  end;

  function fb_WriteInteractivityComponents : Boolean;
  var k : Cardinal;
  Begin
    Result := False;
    // Écriture de la position des colonnes des grilles
    // Ecriture de la page de contrôle(onglets)
    if GetfeSauveEdit(FSaveEdits, feTPageControl )
    and (acom_Component is TCustomTabControl)    then
      begin
        if IsPublishedProp(acom_Component, CST_ONFORMINI_TABINDEX )
         Then p_WriteInteger(acom_Component.Name,fli_getComponentProperty(acom_Component, CST_ONFORMINI_TABINDEX ))
         Else p_WriteInteger(acom_Component.Name,fli_getComponentProperty(acom_Component, CST_ONFORMINI_PAGEINDEX ));
        Result := True;
      end;
    // Ecriture de PopupMenu
    if GetfeSauveEdit(FSaveEdits, feTPopup )
    and (acom_Component is TPopupMenu )  then
      begin
        mit := TMenu(acom_Component).Items;
        for k := 0 to mit.Count-1 do
          begin
            FInifile.WriteBool (af_Form.Name, acom_Component.Name+'_'+mit.Items[k].Name , mit.Items[k].Checked);
          end;
        Result := True;
      end;
  End;

  function fb_WriteListBoxes : Boolean;
  Begin
    Result := False;
    if GetfeSauveEdit(FSaveEdits ,feTListBox)
    and (acom_Component is TListBox)         then
      begin
        SauveTStringsDansIni(FInifile, acom_Component.Name,TCustomListBox(acom_Component).Items);
        Result := True;
      end;
  {$IFDEF DELPHI}
    if GetfeSauveEdit(FSaveEdits ,feTDateTimePicker)
    and (acom_Component is TDateTimePicker)  then
      begin
        p_WriteString(acom_Component.Name,DateTimeToStr(TDateTimePicker(acom_Component).DateTime));
        Result := True;
      end;
  {$ENDIF}

  End;

begin
  f_GetMemIniFile();
  if not Assigned(FInifile) then Exit;
  //Erasing The current section before saving
  FIniFile.EraseSection(af_Form.Name);

  ab_keepon := True;
  If Assigned ( FOnIniWrite ) Then
    FOnIniWrite ( FInifile, ab_keepon );
  If not ab_keepon Then
    Exit;


      // traitement de la position de la af_Form
  if (TFormStyle ( fli_getComponentProperty ( af_Form, CST_ONFORMINI_DOT + CST_ONFORMINI_FORMSTYLE )) <> fsMDIChild)
  and ( [sfSavePos,sfSaveSize] * FSaveForm <> [] )  then
    p_EcriturePositionFenetre(af_Form);

      // Traitement des composants de la af_Form
  if ( sfSaveSizes in FSaveForm ) or (FSaveEdits <> []) Then
  For j:=0 to af_Form.ComponentCount-1 do
    begin
      acom_Component := af_Form.Components[j];

      if Assigned(FOnWriteComponent) Then
       Begin // filtering event
         ab_keepon := True;
         FOnWriteComponent(acom_Component,FIniFile,ab_keepon);
         if not ab_keepon
          Then
           Continue;
       end;

      Try
        if fb_WriteHighComponents Then
          Continue;

        // écriture des données des objets dans le fichier ini.
        if (FSaveEdits <> [])
        and not assigned ( fobj_getComponentObjectProperty(acom_Component,CST_ONFORMINI_DATASOURCE))
         Then
          begin
            if fb_WriteEdits Then
              Continue;
            if fb_WriteSpecialEdits Then
              Continue;
            if fb_WriteOptions Then
              Continue;
            if fb_WriteDirectories Then
              Continue;
            if fb_WriteFiles Then
              Continue;
            if fb_WriteMemos Then
              Continue;
            if fb_WriteCombos Then
              continue ;
            if fb_WriteListBoxes Then
              Continue;
            if fb_WriteInteractivityComponents Then
              Continue;
          end;
        Except
        end;
      end;
  if not FUpdateAll
  and ( loAutoUpdate in FOptions ) Then
    Begin
      fb_iniWriteFile ( FInifile, False );
    End;

end;

////////////////////////////////////////////////////////////////////////////////
//  Lecture de la position des colonnes des grilles dans le fichier INI
////////////////////////////////////////////////////////////////////////////////
procedure TOnFormInfoIni.p_LectureColonnes(const aF_Form: TCustomForm);

begin
end;

////////////////////////////////////////////////////////////////////////////////
// Lecture des données dans le fichier INI concernant la fenêtre uniquement
// traitement de la position de la af_Form mise dans le create
////////////////////////////////////////////////////////////////////////////////
procedure TOnFormInfoIni.p_VerifieTailleFenetre(const aFiche: TCustomForm);
Begin
  with aFiche do
   begin
     // André Langlet 2011
     if Height< INI_VERIFY_MIN_WEIGHT  then
       Height := INI_VERIFY_WEIGHT_TO_PUT;
     if Height>=Screen.Height then
       begin
         Height:=Screen.Height;
         Top:=0;
       end
      else
       begin
         if ( sfSavePos in FSaveForm ) Then
           Top:=max(0,f_IniReadSectionInt (Name,name+CST_ONFORMINI_DOT + CST_ONFORMINI_TOP,Top));
         if (Top+Height)>Screen.Height then
           Top:=Screen.Height-Height;
       end;
     if Width< INI_VERIFY_MIN_WEIGHT  then
       Width := INI_VERIFY_WEIGHT_TO_PUT;
     if Width>=Screen.Width then
       begin
         Width:=Screen.Width;
         Left:=0;
       end
      else
       begin
         if ( sfSavePos in FSaveForm ) Then
           Left:=max(0,f_IniReadSectionInt (Name,name+CST_ONFORMINI_DOT + CST_ONFORMINI_LEFT,Left));
         if (Left+Width)>Screen.Width then
           Left:=Screen.Width-Width;
       end;
   End;

end;

////////////////////////////////////////////////////////////////////////////////
// Lecture des données dans le fichier INI concernant la fenêtre uniquement
// traitement de la position de la af_Form mise dans le create
////////////////////////////////////////////////////////////////////////////////
procedure TOnFormInfoIni.p_LecturePositionFenetre(const aFiche: TCustomForm);
var li_etat, li_top,li_left,li_next,li_previous,li_ScreenHeight,li_ScreenWidth: integer;
    lr_rect : TRect;
begin
  // résolution de l'écran
  li_ScreenHeight := f_IniReadSectionInt (aFiche.Name,CST_ONFORMINI_SCREEN + CST_ONFORMINI_DOT + CST_ONFORMINI_HEIGHT,Screen.Height);
  li_ScreenWidth := f_IniReadSectionInt (aFiche.Name,CST_ONFORMINI_SCREEN + CST_ONFORMINI_DOT + CST_ONFORMINI_WIDTH,Screen.Width);

  if ([sfSavePos,sfSaveSize] * FSaveForm <> []) Then
  with aFiche do
   begin
    li_etat := f_IniReadSectionInt (Name,name+CST_ONFORMINI_DOT + CST_ONFORMINI_WINDOWSTATE,0);
    case li_etat of
      0 : WindowState := wsNormal;
      1 : begin
            p_SetComponentProperty ( aFiche, CST_ONFORMINI_POSITION, poDefault );
            p_SetComponentProperty ( aFiche, CST_ONFORMINI_WINDOWSTATE, wsMaximized );
          end
      else  p_SetComponentProperty ( aFiche, CST_ONFORMINI_WINDOWSTATE, wsMinimized );
      End;

    if li_etat <> 1 then
    begin
      // positionnement de la fenêtre
      p_SetComponentProperty ( aFiche, CST_ONFORMINI_POSITION, poDesigned );

      Top    := f_IniReadSectionInt (Name,name+CST_ONFORMINI_DOT + CST_ONFORMINI_TOP,Top);
      Left   := f_IniReadSectionInt (Name,name+CST_ONFORMINI_DOT + CST_ONFORMINI_LEFT,Left);
      if (BorderStyle in [bsSizeToolWin,bsSizeable])
      and ( sfSaveSize in FSaveForm ) Then
       Begin
        Width  := f_IniReadSectionInt (Name,name+CST_ONFORMINI_DOT + CST_ONFORMINI_WIDTH,Width);
        Height := f_IniReadSectionInt (Name,name+CST_ONFORMINI_DOT + CST_ONFORMINI_HEIGHT,Height);
       End;

      p_VerifieTailleFenetre(aFiche);

      li_top:=Top+Height div 2; //centre de la fenêtre
      li_left:=Left+Width div 2;
      li_next:=0;
      li_previous:=-1;
      repeat //sur quel écran du bureau se trouve le centre de la fenêtre?
        if Screen.Monitors[li_next].Primary then
          li_previous:=li_next;
        lr_rect:=Screen.Monitors[li_next].BoundsRect;
        if (lr_rect.Left<=li_left)and(lr_rect.Right>li_left)and(lr_rect.Top<=li_top)and(lr_rect.Bottom>li_top)then
        begin
          Break;
        end;
        Inc(li_next);
      until li_next=Screen.MonitorCount;
      if li_next=Screen.MonitorCount then //fenêtre hors du bureau
      begin //retour sur moniteur primaire
        if li_previous>-1 then
          li_next:=li_previous
        else
          li_next:=0;
      end;
      lr_rect:=Screen.Monitors[li_next].BoundsRect;

      //Replacement éventuel sur li_left'écran utilisé
      if (Top+Height)>lr_rect.Bottom then
        Top:=lr_rect.Bottom-Height;
      if Top<lr_rect.Top then
        Top:=lr_rect.Top;
      if (Left+Width)>lr_rect.Right then
        Left:=lr_rect.Right-Width;
      if Left<lr_rect.Left then
        Left:=lr_rect.Left;
     if Screen.Height <> li_ScreenHeight then
      begin
        Width := Width * Screen.Width div li_ScreenWidth;
        Height:= Height * Screen.Height div li_ScreenHeight ;
        Top   := Top * Screen.Height div li_ScreenHeight ;
        Left  := Left * Screen.Width div li_ScreenWidth;
      end;

    end;
   End
  Else
   p_VerifieTailleFenetre(aFiche);
  if Owner is TCustomForm then
    DoSameMonitor(Owner as TCustomForm);
end;

////////////////////////////////////////////////////////////////////////////////
// Ecriture des données dans le fichier ini concernant la fenêtre
////////////////////////////////////////////////////////////////////////////////
procedure TOnFormInfoIni.p_EcriturePositionFenetre ( const aFiche: TCustomForm);
var li_etat: integer;
begin
  with aFiche do
   Begin
    p_IniWriteSectionInt(Name,CST_ONFORMINI_SCREEN + CST_ONFORMINI_DOT + CST_ONFORMINI_HEIGHT,Screen.Height);
    p_IniWriteSectionInt(Name,CST_ONFORMINI_SCREEN + CST_ONFORMINI_DOT + CST_ONFORMINI_WIDTH,Screen.Width);

    // Etat de la fenêtre
    case WindowState of
      wsNormal    : li_etat := 0;
      wsMaximized : li_etat := 1;
      else          li_etat := 2;
      end;
    // sauvegarde de son état
    p_IniWriteSectionInt(Name,name+CST_ONFORMINI_DOT + CST_ONFORMINI_WINDOWSTATE,li_etat);

    // sauvegarde de sa position si la fenêtre n'est pas au Maximum
    if li_etat <> 1 then
      begin
        if sfSavePos in FSaveForm Then
         Begin
          p_IniWriteSectionInt (Name,name+CST_ONFORMINI_DOT + CST_ONFORMINI_TOP,Top);
          p_IniWriteSectionInt (Name,name+CST_ONFORMINI_DOT + CST_ONFORMINI_LEFT,Left);
         end;
        if sfSaveSize in FSaveForm Then
         Begin
          p_IniWriteSectionInt (Name,name+CST_ONFORMINI_DOT + CST_ONFORMINI_WIDTH,Width);
          p_IniWriteSectionInt (Name,name+CST_ONFORMINI_DOT + CST_ONFORMINI_HEIGHT,Height);
         End;
      end;
   end;
end;

{$IFDEF VERSIONS}
initialization
  p_ConcatVersion ( gVer_TSvgFormInfoIni );
{$ENDIF}
end.

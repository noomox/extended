﻿unit u_framework_dbcomponents;

{$I ..\Compilers.inc}
{$I ..\extends.inc}
{$IFDEF FPC}
{$mode Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
   LCLIntf, LCLType,
   SQLDB, lmessages,
   RxDBGrid,
   dbdateedit,
{$ELSE}
   Windows, Mask, DBTables, ActnMan,
{$ENDIF}
{$IFDEF JEDI}
  JvDBGrid,JvDBLookup,jvDBUltimGrid, jvDBControls, JvDBDateTimePicker,
{$ENDIF}
{$IFDEF RX}
  RxLookup,
{$ENDIF}
{$IFDEF EXRX}
  ExRXDBGrid,
{$ENDIF}
{$IFDEF VERSIONS}
  fonctions_version,
{$ENDIF}
  Graphics, Controls, Classes, ExtCtrls, Dialogs, Messages,
  Buttons, Forms, DBCtrls, Grids, DB,
  DBGrids, ComCtrls, StdCtrls, SysUtils,
  TypInfo, Variants, u_extcomponent,
{$IFDEF TNT}
   TntDBGrids, TntStdCtrls, TntDBCtrls,
{$ENDIF}
  fonctions_erreurs, u_framework_components;

{$IFDEF VERSIONS}
const
    gVer_framework_DBcomponents : T_Version = ( Component : 'Composants d''interactivité de données' ;
                                               FileUnit : 'u_framework_dbcomponents' ;
                                               Owner : 'Matthieu Giroux' ;
                                               Comment : 'Composants d''interactivité de U_CustomFrameWork.' ;
                                               BugsStory : '0.9.0.1 : FWDBGrid tested on Delphi, with Controls on Columns.'
                                                         + '0.9.0.0 : Création à partir de u_framework_components.';
                                               UnitType : 3 ;
                                               Major : 0 ; Minor : 9 ; Release : 0 ; Build : 1 );

{$ENDIF}
type

{ TFWDBEdit }

   TFWDBEdit = class ( {$IFDEF TNT}TTntDBEdit{$ELSE}TDBEdit{$ENDIF}, IFWComponent, IFWComponentEdit )
      private
       FBeforeEnter, FBeforeExit : TNotifyEvent;
       FLabel : TFWLabel ;
       FOldColor ,
       FColorFocus ,
       FColorReadOnly,
       FColorEdit ,
       FColorLabel : TColor;
       FAlwaysSame : Boolean;
       FNotifyOrder : TNotifyEvent;
       procedure p_setLabel ( const alab_Label : TFWLabel );
       procedure WMPaint(var Message: {$IFDEF FPC}TLMPaint{$ELSE}TWMPaint{$ENDIF}); message {$IFDEF FPC}LM_PAINT{$ELSE}WM_PAINT{$ENDIF};
      public

       constructor Create ( AOwner : TComponent ); override;
       procedure DoEnter; override;
       procedure DoExit; override;
       procedure Loaded; override;
       procedure SetOrder ; virtual;
      published
       property FWBeforeEnter : TnotifyEvent read FBeforeEnter write FBeforeEnter stored False;
       property FWBeforeExit  : TnotifyEvent read FBeforeExit  write FBeforeExit stored False ;
       property ColorLabel : TColor read FColorLabel write FColorLabel default CST_LBL_SELECT ;
       property ColorFocus : TColor read FColorFocus write FColorFocus default CST_EDIT_SELECT ;
       property ColorEdit : TColor read FColorEdit write FColorEdit default CST_EDIT_STD ;
       property ColorReadOnly : TColor read FColorReadOnly write FColorReadOnly default CST_EDIT_READ ;
       property MyLabel : TFWLabel read FLabel write p_setLabel;
       property AlwaysSame : Boolean read FAlwaysSame write FAlwaysSame default true;
       property OnOrder : TNotifyEvent read FNotifyOrder write FNotifyOrder;
     End;

   TFWDBDateEdit = class ( {$IFDEF FPC}TDBDateEdit{$ELSE}TJvDBDateEdit{$ENDIF}, IFWComponent, IFWComponentEdit )
      private
       FBeforeEnter, FBeforeExit : TNotifyEvent;
       FLabel : TFWLabel ;
       FOldColor ,
       FColorFocus ,
       FColorReadOnly,
       FColorEdit ,
       FColorLabel : TColor;
       FAlwaysSame : Boolean;
       FNotifyOrder : TNotifyEvent;
       procedure p_setLabel ( const alab_Label : TFWLabel );
       procedure WMPaint(var Message: {$IFDEF FPC}TLMPaint{$ELSE}TWMPaint{$ENDIF}); message {$IFDEF FPC}LM_PAINT{$ELSE}WM_PAINT{$ENDIF};
      public

       constructor Create ( AOwner : TComponent ); override;
       procedure DoEnter; override;
       procedure DoExit; override;
       procedure Loaded; override;
       procedure SetOrder ; virtual;
      published
       property FWBeforeEnter : TnotifyEvent read FBeforeEnter write FBeforeEnter stored False;
       property FWBeforeExit  : TnotifyEvent read FBeforeExit  write FBeforeExit stored False ;
       property ColorLabel : TColor read FColorLabel write FColorLabel default CST_LBL_SELECT ;
       property ColorFocus : TColor read FColorFocus write FColorFocus default CST_EDIT_SELECT ;
       property ColorEdit : TColor read FColorEdit write FColorEdit default CST_EDIT_STD ;
       property ColorReadOnly : TColor read FColorReadOnly write FColorReadOnly default CST_EDIT_READ ;
       property MyLabel : TFWLabel read FLabel write p_setLabel;
       property AlwaysSame : Boolean read FAlwaysSame write FAlwaysSame default true;
       property OnOrder : TNotifyEvent read FNotifyOrder write FNotifyOrder;
     End;

{$IFNDEF FPC}

   TFWDBDateTimePicker = class ( TJvDBDateTimePicker, IFWComponent, IFWComponentEdit )
      private
       FBeforeEnter, FBeforeExit : TNotifyEvent;
       FLabel : TFWLabel ;
       FOldColor ,
       FColorFocus ,
       FColorReadOnly,
       FColorEdit ,
       FColorLabel : TColor;
       FAlwaysSame : Boolean;
       FNotifyOrder : TNotifyEvent;
       procedure p_setLabel ( const alab_Label : TFWLabel );
       procedure WMPaint(var Message: {$IFDEF FPC}TLMPaint{$ELSE}TWMPaint{$ENDIF}); message {$IFDEF FPC}LM_PAINT{$ELSE}WM_PAINT{$ENDIF};
      public

       constructor Create ( AOwner : TComponent ); override;
       procedure DoEnter; override;
       procedure DoExit; override;
       procedure Loaded; override;
       procedure SetOrder ; virtual;
      published
       property FWBeforeEnter : TnotifyEvent read FBeforeEnter write FBeforeEnter stored False;
       property FWBeforeExit  : TnotifyEvent read FBeforeExit  write FBeforeExit stored False ;
       property ColorLabel : TColor read FColorLabel write FColorLabel default CST_LBL_SELECT ;
       property ColorFocus : TColor read FColorFocus write FColorFocus default CST_EDIT_SELECT ;
       property ColorEdit : TColor read FColorEdit write FColorEdit default CST_EDIT_STD ;
       property ColorReadOnly : TColor read FColorReadOnly write FColorReadOnly default CST_EDIT_READ ;
       property MyLabel : TFWLabel read FLabel write p_setLabel;
       property AlwaysSame : Boolean read FAlwaysSame write FAlwaysSame default true;
       property OnOrder : TNotifyEvent read FNotifyOrder write FNotifyOrder;
     End;

{$ENDIF}

   { TFWLabel }
   TFWDBLookupCombo = class ( {$IFDEF JEDI}TJvDBLookupCombo{$ELSE}{$IFDEF FPC}TDBLookupComboBox{$ELSE}{$IFDEF RX}TRxDBLookupCombo{$ELSE}TDBLookupComboBox{$ENDIF}{$ENDIF}{$ENDIF}, IFWComponent, IFWComponentEdit )
      private
       FBeforeEnter, FBeforeExit : TNotifyEvent;
       FLabel : TFWLabel ;
       FOldColor ,
       FColorReadOnly,
       FColorFocus ,
       FColorEdit ,
       FColorLabel : TColor;
       FAlwaysSame : Boolean;
       FNotifyOrder : TNotifyEvent;
       procedure p_setLabel ( const alab_Label : TFWLabel );
       procedure WMPaint(var Message: {$IFDEF FPC}TLMPaint{$ELSE}TWMPaint{$ENDIF}); message {$IFDEF FPC}LM_PAINT{$ELSE}WM_PAINT{$ENDIF};
      public

       constructor Create ( AOwner : TComponent ); override;
       procedure DoEnter; override;
       procedure DoExit; override;
       procedure Loaded; override;
       procedure SetOrder ; virtual;
      published
       property FWBeforeEnter : TnotifyEvent read FBeforeEnter write FBeforeEnter stored False;
       property FWBeforeExit  : TnotifyEvent read FBeforeExit  write FBeforeExit stored False ;
       property ColorLabel : TColor read FColorLabel write FColorLabel default CST_LBL_SELECT ;
       property ColorFocus : TColor read FColorFocus write FColorFocus default CST_EDIT_SELECT ;
       property ColorEdit : TColor read FColorEdit write FColorEdit default CST_EDIT_STD ;
       property ColorReadOnly : TColor read FColorReadOnly write FColorReadOnly default CST_EDIT_READ ;
       property MyLabel : TFWLabel read FLabel write p_setLabel;
       property AlwaysSame : Boolean read FAlwaysSame write FAlwaysSame default true;
       property OnOrder : TNotifyEvent read FNotifyOrder write FNotifyOrder;
     End;

   { TFWGridColumn }

   TFWGridColumn = class({$IFDEF TNT}TTntColumn{$ELSE}TRxColumn{$ENDIF})
   private
     FControl : TWinControl ;
     FFieldTag : Integer ;
     procedure SetControl ( AValue : TWinControl );
     function  fi_getFieldTag:Integer;
     procedure p_setFieldTag ( const avalue : Integer );
   public
     constructor Create(ACollection: TCollection); override;
   published
     property SomeEdit : TWinControl read FControl write SetControl;
     property FieldTag : Integer read fi_getFieldTag write p_setFieldTag;
   end;

   { TFWDbGridColumns }

   TFWDbGridColumns = class({$IFDEF TNT}TTntDBGridColumns{$ELSE}TRxDbGridColumns{$ENDIF})
   private
     function GetColumn(Index: Integer): TFWGridColumn;
     procedure SetColumn(Index: Integer; Value: TFWGridColumn);
   public
     function Add: TFWGridColumn;
   public
     property Items[Index: Integer]: TFWGridColumn read GetColumn write SetColumn; default;
   end;

   { TFWDBGrid }

   TFWDBGrid = class ( {$IFDEF TNT}TTntDBGrid{$ELSE}{$IFDEF EXRX}TExRxDBGrid{$ELSE}{$IFDEF JEDI}TJvDBUltimGrid{$ELSE}TRXDBGrid{$ENDIF}{$ENDIF}{$ENDIF}, IFWComponent )
      private
       FBeforeEnter, FBeforeExit : TNotifyEvent;
       FColorEdit     ,
       FColorFocus    ,
       FOldFixedColor : TColor;
       FAlwaysSame : Boolean;
       function GetColumns: TFWDbGridColumns;
       procedure SetColumns(const AValue: TFWDbGridColumns);
       procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure GridRectToScreenRect(GridRect: TGridRect; var ScreenRect: TRect;
      IncludeLine: Boolean);
      protected
       function IsColumnsStored: boolean; virtual;
       procedure DrawCell(aCol,aRow: {$IFDEF FPC}Integer{$ELSE}Longint{$ENDIF}; aRect: TRect; aState:TGridDrawState); override;
       function CanEditShow: Boolean; override;
      public
       constructor Create ( AOwner : TComponent ); override;
       procedure DoEnter; override;
       procedure DoExit; override;
       procedure Loaded; override;
       procedure KeyUp(var ach_Key: Word; ashi_Shift: TShiftState); override;
       function  CreateColumns: {$IFDEF FPC}TGridColumns{$ELSE}TDBGridColumns{$ENDIF}; override;
       {$IFDEF EXRX}
       procedure TitleClick(Column: TColumn); override;
       {$ELSE}
       procedure DoTitleClick(ACol: Longint; AField: TField); override;
       {$ENDIF}
      published
       property Columns: TFWDbGridColumns read GetColumns write SetColumns stored IsColumnsStored;
       property FWBeforeEnter : TnotifyEvent read FBeforeEnter write FBeforeEnter stored False;
       property FWBeforeExit  : TnotifyEvent read FBeforeExit  write FBeforeExit stored False ;
       property ColorEdit : TColor read FColorEdit write FColorEdit default CST_GRILLE_STD ;
       property FixedColor default CST_GRILLE_STD ;
       property ColorFocus : TColor read FColorFocus write FColorFocus default CST_GRILLE_SELECT ;
       property AlwaysSame : Boolean read FAlwaysSame write FAlwaysSame default true;
     End;

   TFWDBMemo = class ( TDBMemo, IFWComponent, IFWComponentEdit )
      private
       FBeforeEnter, FBeforeExit : TNotifyEvent;
       FLabel : TFWLabel ;
       FOldColor ,
       FColorFocus ,
       FColorReadOnly,
       FColorEdit ,
       FColorLabel : TColor;
       FAlwaysSame : Boolean;
       FNotifyOrder : TNotifyEvent;
       procedure p_setLabel ( const alab_Label : TFWLabel );
       procedure WMPaint(var Message: {$IFDEF FPC}TLMPaint{$ELSE}TWMPaint{$ENDIF}); message {$IFDEF FPC}LM_PAINT{$ELSE}WM_PAINT{$ENDIF};
      public

       constructor Create ( AOwner : TComponent ); override;
       procedure DoEnter; override;
       procedure DoExit; override;
       procedure Loaded; override;
       procedure SetOrder ; virtual;
      published
       property FWBeforeEnter : TnotifyEvent read FBeforeEnter write FBeforeEnter stored False;
       property FWBeforeExit  : TnotifyEvent read FBeforeExit  write FBeforeExit stored False ;
       property ColorLabel : TColor read FColorLabel write FColorLabel default CST_LBL_SELECT ;
       property ColorFocus : TColor read FColorFocus write FColorFocus default CST_EDIT_SELECT ;
       property ColorEdit : TColor read FColorEdit write FColorEdit default CST_EDIT_STD ;
       property ColorReadOnly : TColor read FColorReadOnly write FColorReadOnly default CST_EDIT_READ ;
       property MyLabel : TFWLabel read FLabel write p_setLabel;
       property AlwaysSame : Boolean read FAlwaysSame write FAlwaysSame default true;
       property OnOrder : TNotifyEvent read FNotifyOrder write FNotifyOrder;
     End;


implementation

uses fonctions_db, fonctions_proprietes;



{ TFWDBEdit }

procedure TFWDBEdit.p_setLabel(const alab_Label: TFWLabel);
begin
  if alab_Label <> FLabel Then
    Begin
      FLabel := alab_Label;
      FLabel.MyEdit := Self;
    End;
end;

procedure TFWDBEdit.SetOrder;
begin
  if assigned ( FNotifyOrder ) then
    FNotifyOrder ( Self );
end;

constructor TFWDBEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAlwaysSame := True;
  FColorLabel := CST_LBL_SELECT;
  FColorEdit  := CST_EDIT_STD;
  FColorFocus := CST_EDIT_SELECT;
  FColorReadOnly := CST_EDIT_READ;
end;

procedure TFWDBEdit.DoEnter;
begin
  if assigned ( FBeforeEnter ) Then
    FBeforeEnter ( Self );
  // Si on arrive sur une zone de saisie, on met en valeur son tlabel par une couleur
  // de fond bleu et son libellé en marron (sauf si le libellé est sélectionné
  // avec la souris => cas de tri)
  p_setLabelColorEnter ( FLabel, FColorLabel, FAlwaysSame );
  p_setCompColorEnter  ( Self, FColorFocus, FAlwaysSame );
  inherited DoEnter;
end;

procedure TFWDBEdit.DoExit;
begin
  if assigned ( FBeforeExit ) Then
    FBeforeExit ( Self );
  inherited DoExit;
  p_setLabelColorExit ( FLabel, FAlwaysSame );
  p_setCompColorExit ( Self, FOldColor, FAlwaysSame );

end;

procedure TFWDBEdit.Loaded;
begin
  inherited Loaded;
  FOldColor := Color;
  if  FAlwaysSame
   Then
    Color := gCol_Edit ;
end;

procedure TFWDBEdit.WMPaint(var Message: {$IFDEF FPC}TLMPaint{$ELSE}TWMPaint{$ENDIF});
Begin
  p_setCompColorReadOnly ( Self,FColorEdit,FColorReadOnly, FAlwaysSame, ReadOnly );
  inherited;
End;

{$IFNDEF FPC}
{ TFWDBDateTimePicker }

procedure TFWDBDateTimePicker.p_setLabel(const alab_Label: TFWLabel);
begin
  if alab_Label <> FLabel Then
    Begin
      FLabel := alab_Label;
      FLabel.MyEdit := Self;
    End;
end;

procedure TFWDBDateTimePicker.SetOrder;
begin
  if assigned ( FNotifyOrder ) then
    FNotifyOrder ( Self );
end;

constructor TFWDBDateTimePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAlwaysSame := True;
  FColorLabel := CST_LBL_SELECT;
  FColorEdit  := CST_EDIT_STD;
  FColorFocus := CST_EDIT_SELECT;
  FColorReadOnly := CST_EDIT_READ;
end;

procedure TFWDBDateTimePicker.DoEnter;
begin
  if assigned ( FBeforeEnter ) Then
    FBeforeEnter ( Self );
  // Si on arrive sur une zone de saisie, on met en valeur son tlabel par une couleur
  // de fond bleu et son libellé en marron (sauf si le libellé est sélectionné
  // avec la souris => cas de tri)
  p_setLabelColorEnter ( FLabel, FColorLabel, FAlwaysSame );
  p_setCompColorEnter  ( Self, FColorFocus, FAlwaysSame );
  inherited DoEnter;
end;

procedure TFWDBDateTimePicker.DoExit;
begin
  if assigned ( FBeforeExit ) Then
    FBeforeExit ( Self );
  inherited DoExit;
  p_setLabelColorExit ( FLabel, FAlwaysSame );
  p_setCompColorExit ( Self, FOldColor, FAlwaysSame );

end;

procedure TFWDBDateTimePicker.Loaded;
begin
  inherited Loaded;
  FOldColor := Color;
  if  FAlwaysSame
   Then
    Color := gCol_Edit ;
end;

procedure TFWDBDateTimePicker.WMPaint(var Message: {$IFDEF FPC}TLMPaint{$ELSE}TWMPaint{$ENDIF});
Begin
  p_setCompColorReadOnly ( Self,FColorEdit,FColorReadOnly, FAlwaysSame, ReadOnly );
  inherited;
End;

{$ENDIF}

{ TFWDBDateEdit }

procedure TFWDBDateEdit.p_setLabel(const alab_Label: TFWLabel);
begin
  if alab_Label <> FLabel Then
    Begin
      FLabel := alab_Label;
      FLabel.MyEdit := Self;
    End;
end;

procedure TFWDBDateEdit.SetOrder;
begin
  if assigned ( FNotifyOrder ) then
    FNotifyOrder ( Self );
end;

constructor TFWDBDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAlwaysSame := True;
  FColorLabel := CST_LBL_SELECT;
  FColorEdit  := CST_EDIT_STD;
  FColorFocus := CST_EDIT_SELECT;
  FColorReadOnly := CST_EDIT_READ;
end;

procedure TFWDBDateEdit.DoEnter;
begin
  if assigned ( FBeforeEnter ) Then
    FBeforeEnter ( Self );
  // Si on arrive sur une zone de saisie, on met en valeur son tlabel par une couleur
  // de fond bleu et son libellé en marron (sauf si le libellé est sélectionné
  // avec la souris => cas de tri)
  p_setLabelColorEnter ( FLabel, FColorLabel, FAlwaysSame );
  p_setCompColorEnter  ( Self, FColorFocus, FAlwaysSame );
  inherited DoEnter;
end;

procedure TFWDBDateEdit.DoExit;
begin
  if assigned ( FBeforeExit ) Then
    FBeforeExit ( Self );
  inherited DoExit;
  p_setLabelColorExit ( FLabel, FAlwaysSame );
  p_setCompColorExit ( Self, FOldColor, FAlwaysSame );

end;

procedure TFWDBDateEdit.Loaded;
begin
  inherited Loaded;
  FOldColor := Color;
  if  FAlwaysSame
   Then
    Color := gCol_Edit ;
end;

procedure TFWDBDateEdit.WMPaint(var Message: {$IFDEF FPC}TLMPaint{$ELSE}TWMPaint{$ENDIF});
Begin
  p_setCompColorReadOnly ( Self,FColorEdit,FColorReadOnly, FAlwaysSame, ReadOnly );
  inherited;
End;

{ TFWDBLookupCombo }

procedure TFWDBLookupCombo.p_setLabel(const alab_Label: TFWLabel);
begin
  if alab_Label <> FLabel Then
    Begin
      FLabel := alab_Label;
      FLabel.MyEdit := Self;
    End;
end;

procedure TFWDBLookupCombo.SetOrder;
begin
  if assigned ( FNotifyOrder ) then
    FNotifyOrder ( Self );
end;

constructor TFWDBLookupCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAlwaysSame := True;
  FColorLabel := CST_LBL_SELECT;
  FColorEdit  := CST_EDIT_STD;
  FColorFocus := CST_EDIT_SELECT;
  FColorReadOnly := CST_EDIT_READ;
end;

procedure TFWDBLookupCombo.DoEnter;
begin
  if assigned ( FBeforeEnter ) Then
    FBeforeEnter ( Self );
  // Si on arrive sur une zone de saisie, on met en valeur son tlabel par une couleur
  // de fond bleu et son libellé en marron (sauf si le libellé est sélectionné
  // avec la souris => cas de tri)
  p_setLabelColorEnter ( FLabel, FColorLabel, FAlwaysSame );
  p_setCompColorEnter  ( Self, FColorFocus, FAlwaysSame );
  inherited DoEnter;
end;

procedure TFWDBLookupCombo.DoExit;
begin
  if assigned ( FBeforeExit ) Then
    FBeforeExit ( Self );
  inherited DoExit;
  p_setLabelColorExit ( FLabel, FAlwaysSame );
  p_setCompColorExit ( Self, FOldColor, FAlwaysSame );

end;

procedure TFWDBLookupCombo.Loaded;
begin
  inherited Loaded;
  FOldColor := Color;
  if  FAlwaysSame
   Then
    Color := gCol_Edit ;
end;

procedure TFWDBLookupCombo.WMPaint(var Message: {$IFDEF FPC}TLMPaint{$ELSE}TWMPaint{$ENDIF});
Begin
  p_setCompColorReadOnly ( Self,FColorEdit,FColorReadOnly, FAlwaysSame, ReadOnly );
  inherited;
End;

{ TFWGridColumn }

procedure TFWGridColumn.SetControl(AValue: TWinControl);
begin
  If AValue <> FControl Then
   Begin
     FControl := AValue;
     FControl.Parent := Grid;
     FControl.Visible := False;
     p_SetComponentProperty ( FControl, 'DataField', FieldName );
     p_SetComponentObjectProperty ( FControl, 'Datasource', (TDBGrid (Grid)).DataSource );
   end;
end;

function TFWGridColumn.fi_getFieldTag: Integer;
begin
  Result := FFieldTag;
end;

procedure TFWGridColumn.p_setFieldTag( const avalue : Integer );
begin
  FFieldTag := avalue;
end;

constructor TFWGridColumn.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FControl := nil;
  FFieldTag := 0 ;
end;


{ TFWDbGridColumns }

function TFWDbGridColumns.GetColumn(Index: Integer): TFWGridColumn;
begin
  result := TFWGridColumn( inherited Items[Index] );
end;

procedure TFWDbGridColumns.SetColumn(Index: Integer; Value: TFWGridColumn);
begin
  Items[Index].Assign( Value );
end;

function TFWDbGridColumns.Add: TFWGridColumn;
begin
  result := TFWGridColumn (inherited Add);
end;



{ TFWDBGrid }

procedure TFWDBGrid.GridRectToScreenRect(GridRect: TGridRect;
  var ScreenRect: TRect; IncludeLine: Boolean);

  function LinePos(const AxisInfo: TGridAxisDrawInfo; Line: Integer): Integer;
  var
    Start, I: Longint;
  begin
    with AxisInfo do
    begin
      Result := 0;
      if Line < FixedCellCount then
        Start := 0
      else
      begin
        if Line >= FirstGridCell then
          Result := FixedBoundary;
        Start := FirstGridCell;
      end;
      for I := Start to Line - 1 do
      begin
        Inc(Result, GetExtent(I) + EffectiveLineWidth);
        if Result > GridExtent then
        begin
          Result := 0;
          Exit;
        end;
      end;
    end;
  end;

  function CalcAxis(const AxisInfo: TGridAxisDrawInfo;
    GridRectMin, GridRectMax: Integer;
    var ScreenRectMin, ScreenRectMax: Integer): Boolean;
  begin
    Result := False;
    with AxisInfo do
    begin
      if (GridRectMin >= FixedCellCount) and (GridRectMin < FirstGridCell) then
        if GridRectMax < FirstGridCell then
        begin
          FillChar(ScreenRect, SizeOf(ScreenRect), 0); { erase partial results }
          Exit;
        end
        else
          GridRectMin := FirstGridCell;
      if GridRectMax > LastFullVisibleCell then
      begin
        GridRectMax := LastFullVisibleCell;
        if GridRectMax < GridCellCount - 1 then Inc(GridRectMax);
        if LinePos(AxisInfo, GridRectMax) = 0 then
          Dec(GridRectMax);
      end;

      ScreenRectMin := LinePos(AxisInfo, GridRectMin);
      ScreenRectMax := LinePos(AxisInfo, GridRectMax);
      if ScreenRectMax = 0 then
        ScreenRectMax := ScreenRectMin + GetExtent(GridRectMin)
      else
        Inc(ScreenRectMax, GetExtent(GridRectMax));
      if ScreenRectMax > GridExtent then
        ScreenRectMax := GridExtent;
      if IncludeLine then Inc(ScreenRectMax, EffectiveLineWidth);
    end;
    Result := True;
  end;

var
  DrawInfo: TGridDrawInfo;
  Hold: Integer;
begin
  FillChar(ScreenRect, SizeOf(ScreenRect), 0);
  if (GridRect.Left > GridRect.Right) or (GridRect.Top > GridRect.Bottom) then
    Exit;
  CalcDrawInfo(DrawInfo);
  with DrawInfo do
  begin
    if GridRect.Left > Horz.LastFullVisibleCell + 1 then Exit;
    if GridRect.Top > Vert.LastFullVisibleCell + 1 then Exit;

    if CalcAxis(Horz, GridRect.Left, GridRect.Right, ScreenRect.Left,
      ScreenRect.Right) then
    begin
      CalcAxis(Vert, GridRect.Top, GridRect.Bottom, ScreenRect.Top,
        ScreenRect.Bottom);
    end;
  end;
  if UseRightToLeftAlignment and (Canvas.CanvasOrientation = coLeftToRight) then
  begin
    Hold := ScreenRect.Left;
    ScreenRect.Left := ClientWidth - ScreenRect.Right;
    ScreenRect.Right := ClientWidth - Hold;
  end;
end;



procedure TFWDBGrid.WMSetFocus(var Msg: TWMSetFocus);
var Weight, i : Integer ;
    DrawInfo: TGridDrawInfo;
    InvalidRect: TRect;
begin
  SetIme;
  InvalidateDockHostSite(False);
  if not HandleAllocated then Exit;
  GridRectToScreenRect(Selection, InvalidRect, True);
  Windows.InvalidateRect(Handle, @InvalidRect, False);
  CalcDrawInfo(DrawInfo);
  with DrawInfo do
    if  ( Row > 0 )
    and ( Col > 0 )
    and ( Columns [ Col - FixedCols + Vert.FirstGridCell ].SomeEdit <> nil )  Then
      with Columns [ Col - FixedCols + Vert.FirstGridCell ].SomeEdit do
       if ( Msg.FocusedWnd = Columns [ Col - FixedCols + Vert.FirstGridCell ].SomeEdit.Handle ) then
         Begin
          for i := 0 to ColCount - FixedCols - 1 do
            if Columns [ i ].SomeEdit.Visible then
              with Columns [ i ].SomeEdit do
               Begin
                 Update;
                 if i <> col - FixedCols + Vert.FirstGridCell then
                   Visible := False;
                 Exit;
               End
         End
       Else
        Begin
          Visible := True;
          Weight := Vert.FixedBoundary;
          for i := 0 to FixedCols - 1 do
            inc ( Weight , ColWidths  [ i ]);
          for i := Vert.FirstGridCell + FixedCols to Col -1 do
            inc ( Weight , ColWidths  [ i ]);
          Left := Weight;
          Weight := Horz.FixedBoundary;
          for i := 0 to FixedRows - 1 do
            inc ( Weight , RowHeights  [ i ]);
          for i := Horz.FirstGridCell + FixedRows to Row - 1 do
            inc ( Weight , RowHeights  [ i ]);
          Top  := Weight;
          SetFocus;
        End

end;

function TFWDBGrid.CanEditShow: Boolean;
var Weight, i : Integer ;
    DrawInfo: TGridDrawInfo;
begin
  Result := False;
  Exit;
  if  ( Col >= FixedCols )
  and ( Columns [ Col - FixedCols ].SomeEdit <> nil ) then
  with Columns [ Col - FixedCols ].SomeEdit do
    Begin
      for i := 0 to ColCount - FixedCols - 1 do
        if Columns [ i ].SomeEdit.Visible then
          with Columns [ i ].SomeEdit do
           Begin
             Update;
             Visible := False;
             Exit;
           End ;
      Result := False;
      Visible := True;
      Weight := Self.Left;
      for i := 0 to FixedCols - 1 do
        inc ( Weight , ColWidths  [ i ]);
      for i := ColCount - VisibleColCount + FixedCols to Col -1 do
        inc ( Weight , ColWidths  [ i ]);
      Left := Weight;
      Weight := Self.Top;
      for i := 0 to FixedRows - 1 do
        inc ( Weight , RowHeights  [ i ]);
      for i := DataLink.ActiveRecord + FixedRows to Row - 2 do
        inc ( Weight , RowHeights  [ i ]);
      Top  := Weight;
      SetFocus;
    End
  Else
   Result := inherited CanEditShow;

end;

constructor TFWDBGrid.Create( AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAlwaysSame := True;
  FColorFocus := CST_GRILLE_SELECT;
  FColorEdit  := CST_GRILLE_STD;
  FixedColor  := CST_GRILLE_STD;
  FWBeforeEnter:=nil;
  FWBeforeExit :=nil;
end;

procedure TFWDBGrid.Loaded;
begin
  inherited Loaded;
  FOldFixedColor := FixedColor;
  if  FAlwaysSame
   Then
    FixedColor := gCol_Grid ;
End;

function TFWDBGrid.GetColumns: TFWDbGridColumns;
begin
  {$IFDEF FPC}
  Result := TFWDbGridColumns(TCustomDrawGrid(Self).Columns);
  {$ELSE}
  Result := inherited Columns as TFWDBGridColumns;
  {$ENDIF}
end;

procedure TFWDBGrid.SetColumns(const AValue: TFWDbGridColumns);
begin
  {$IFDEF FPC}
  TFWDbGridColumns(TCustomDrawGrid(Self).Columns).Assign(Avalue);
  {$ELSE}
  inherited Columns := AValue;
  {$ENDIF}
end;


procedure TFWDBGrid.DrawCell(aCol, aRow: {$IFDEF FPC}Integer{$ELSE}Longint{$ENDIF}; aRect: TRect;
  aState: TGridDrawState);
var OldActive : Integer;
    FBackground: TColor;
begin
  if  ( ACol > 0  )
  and ( ARow >= {$IFDEF FPC}1{$ELSE}IndicatorOffset{$ENDIF} )
  and assigned (( TFWGridColumn ( Columns [ ACol - 1 ])).SomeEdit ) Then
   with ( TFWGridColumn ( Columns [ ACol - 1 ])).SomeEdit do
     Begin
       {$IFDEF FPC}
       PrepareCanvas(aCol, aRow, aState);
       if Assigned(OnGetCellProps) and not (gdSelected in aState) then
       begin
         FBackground:=Canvas.Brush.Color;
         OnGetCellProps(Self, GetFieldFromGridColumn(aCol), Canvas.Font, FBackground);
         Canvas.Brush.Color:=FBackground;
       end;
       {$ELSE}
       Canvas.Brush.Color := Color;
       {$ENDIF}
       Self.Canvas.FillRect(aRect);
       OldActive := Datalink.ActiveRecord;
       Datalink.ActiveRecord := ARow {$IFDEF FPC}-1{$ELSE}-IndicatorOffset{$ENDIF};
       Width  := aRect.Right - aRect.Left;
       Height := ARect.Bottom - aRect.Top;
       ControlState := ControlState + [csPaintCopy];
       PaintTo(Self.Canvas.Handle,aRect.Left,aRect.Top);
       ControlState := ControlState - [csPaintCopy];
       Datalink.ActiveRecord := OldActive;
     end
    Else
      inherited DrawCell(aCol, aRow, aRect, aState);
end;

function TFWDBGrid.IsColumnsStored: boolean;
begin
  result := True;
end;


procedure TFWDBGrid.KeyUp(var ach_Key: Word; ashi_Shift: TShiftState);
begin
  if  ( ach_Key = VK_DELETE )
  and ( ashi_Shift = [ssCtrl] )
  and assigned ( DataSource )
  and assigned ( Datasource.DataSet ) Then
    Begin
      Datasource.DataSet.Delete;
      ach_Key := 0 ;
    End;
  inherited KeyUp(ach_Key, ashi_Shift);
end;

function TFWDBGrid.CreateColumns: {$IFDEF FPC}TGridColumns{$ELSE}TDBGridColumns{$ENDIF};
begin
  Result := TFWDbGridColumns.Create(Self, TFWGridColumn);
end;

procedure TFWDBGrid.DoEnter;
begin
  if assigned ( FBeforeEnter ) Then
    FBeforeEnter ( Self );
  // Rétablit le focus si on l'a perdu
  if FAlwaysSame
   Then
    FixedColor := gCol_GridSelect
   else
    FixedColor := FColorFocus ;
  inherited DoEnter;
end;

procedure TFWDBGrid.DoExit;
begin
  if assigned ( FBeforeExit ) Then
    FBeforeExit ( Self );
  inherited DoExit;
  // Rétablit la couleur du focus
  if FAlwaysSame
   Then
    FixedColor := gCol_Grid
   else
    FixedColor := FOldFixedColor ;
end;

 // Gestion du click sur le titre
{$IFDEF EXRX}
procedure TFWDBGrid.TitleClick(Column: TColumn);
{$ELSE}
procedure TFWDBGrid.DoTitleClick(ACol: Longint; AField: TField);
{$ENDIF}

var li_Tag , li_i : Integer ;
begin
  // Phase d'initialisation
 li_Tag :=(TFWGridColumn ( {$IFDEF EXRX} Column {$ELSE} Columns [ ACol ]{$ENDIF})).FieldTag ;
 if li_tag > 0 then
   for li_i :=0 to ComponentCount -1 do
      if  ( li_Tag = Components [ li_i ].Tag )
      and Supports( Components [ li_i ], IFWComponentEdit )
      and ( Components [ li_i ] as TWinControl ).Visible  Then
        Begin
          ( Components [ li_i ] as IFWComponentEdit).SetOrder;
        End ;
  SetFocus;
end;


{ TFWDBMemo }

procedure TFWDBMemo.p_setLabel(const alab_Label: TFWLabel);
begin
  if alab_Label <> FLabel Then
    Begin
      FLabel := alab_Label;
      FLabel.MyEdit := Self;
    End;
end;

procedure TFWDBMemo.SetOrder;
begin
  if assigned ( FNotifyOrder ) then
    FNotifyOrder ( Self );
end;

constructor TFWDBMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAlwaysSame := True;
  FColorLabel := CST_LBL_SELECT;
  FColorEdit  := CST_EDIT_STD;
  FColorFocus := CST_EDIT_SELECT;
  FColorReadOnly := CST_EDIT_READ;
end;

procedure TFWDBMemo.DoEnter;
begin
  if assigned ( FBeforeEnter ) Then
    FBeforeEnter ( Self );
  // Si on arrive sur une zone de saisie, on met en valeur son tlabel par une couleur
  // de fond bleu et son libellé en marron (sauf si le libellé est sélectionné
  // avec la souris => cas de tri)
  p_setLabelColorEnter ( FLabel, FColorLabel, FAlwaysSame );
  p_setCompColorEnter  ( Self, FColorFocus, FAlwaysSame );
  inherited DoEnter;
end;

procedure TFWDBMemo.DoExit;
begin
  if assigned ( FBeforeExit ) Then
    FBeforeExit ( Self );
  inherited DoExit;
  p_setLabelColorExit ( FLabel, FAlwaysSame );
  p_setCompColorExit ( Self, FOldColor, FAlwaysSame );

end;

procedure TFWDBMemo.Loaded;
begin
  inherited Loaded;
  FOldColor := Color;
  if  FAlwaysSame
   Then
    Color := gCol_Edit ;
end;

procedure TFWDBMemo.WMPaint(var Message: {$IFDEF FPC}TLMPaint{$ELSE}TWMPaint{$ENDIF});
Begin
  p_setCompColorReadOnly ( Self,FColorEdit,FColorReadOnly, FAlwaysSame, ReadOnly );
  inherited;
End;


{$IFDEF VERSIONS}
initialization
  // Gestion de version
  p_ConcatVersion(gVer_framework_DBcomponents);
{$ENDIF}
end.

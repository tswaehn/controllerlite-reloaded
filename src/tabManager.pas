unit tabManager;

interface

uses Classes, ComCtrls, Controls, Forms;

type TTabManager = class (TPersistent)

  constructor create( pageControl : TPageControl );
  function createTab( caption : string; classStr : string ):TFrame;
  procedure destroyTab( child : TWinControl );

  procedure setActiveTab( child : TWinControl );
  function findTabContaining( child : TWinControl ): TTabSheet;

  protected
    pageControl : TPageControl;

end;

type TFrameClass = class of TFrame;

implementation

uses ProfileFrame, ConnectorFrame, TerminalFrame;

constructor TTabManager.create(pageControl: TPageControl);
begin
  inherited Create();
  self.pageControl := pageControl;

  RegisterClass( TProfileFrame );
  RegisterClass( TConnectorView );
  RegisterClass( TTerminalView );
end;

function TTabManager.createTab(caption: string; classStr : string): TFrame;
var tabsheet : ttabsheet;
    frame : TFrame;
    classType : TPersistentClass;
begin

  // erzeuge tab
  tabsheet := TTabsheet.Create( pagecontrol );
  tabsheet.PageControl := pageControl;
  tabsheet.Caption := caption;

  classType := findClass( classStr );

  frame := TFrame( classType.Create() );
  frame.Create( nil );
  frame.Parent := tabsheet;

  CreateTab := frame;
end;

procedure TTabManager.destroyTab(child: TWinControl);
var tabsheet : TTabSheet;
begin
  tabsheet := findTabContaining( child );
  tabsheet.Free;
  pagecontrol.Repaint;
end;

procedure TTabManager.setActiveTab( child : TWinControl );
var tabsheet: TTabSheet;
begin
  tabsheet:= findTabContaining( child );
  pageControl.ActivePageIndex := tabsheet.TabIndex;
end;


function TTabManager.findTabContaining(child: TWinControl): TTabSheet;
var tabsheet: TTabSheet;
//    i:integer;
begin
  tabsheet := TTabSheet( child.Parent );
//  for I := 0 to pageControl.PageCount - 1 do begin
//    tabsheet := pageControl.Pages[i];
//
//    if (tabsheet. then
//
//
//  end;
  findTabContaining:= tabsheet;
end;

end.

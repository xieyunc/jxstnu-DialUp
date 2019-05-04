unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CnDialUp, ComCtrls, ImgList, CoolTrayIcon, Menus;

type
  TMain = class(TForm)
    btn_Connect: TBitBtn;
    btn_Exit: TBitBtn;
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    edt_User: TEdit;
    edt_Pwd: TEdit;
    lbl3: TLabel;
    cbb_ConnectTo: TComboBox;
    CnDialUp1: TCnDialUp;
    stat1: TStatusBar;
    CoolTrayIcon1: TCoolTrayIcon;
    ImageList1: TImageList;
    pm1: TPopupMenu;
    mniN1: TMenuItem;
    mniN2: TMenuItem;
    mniN3: TMenuItem;
    mniN4: TMenuItem;
    procedure edt_UserChange(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_ConnectClick(Sender: TObject);
    procedure CnDialUp1StatusEvent(Sender: TObject; MessageText: string;
      Error: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mniN1Click(Sender: TObject);
    procedure mniN3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.btn_ConnectClick(Sender: TObject);
begin
  if btn_Connect.Caption = '连接' then
  begin
    CnDialUp1.Username:=edt_User.Text;
    CnDialUp1.Password:=edt_Pwd.Text;
    CnDialUp1.ConnectTo:=cbb_ConnectTo.Text;
    if CnDialUp1.GoOnline then
    begin
      CoolTrayIcon1.IconIndex := 0;
      Self.Hide;
      btn_Connect.Caption := '断开连接';
    end else
    begin
      CoolTrayIcon1.IconIndex := 1;
      btn_Connect.Caption := '连接';
    end;
  end else
  begin
    CnDialUp1.GoOffline;
    btn_Connect.Caption := '连接';
  end;
end;

procedure TMain.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMain.CnDialUp1StatusEvent(Sender: TObject; MessageText: string;
  Error: Boolean);
begin
  if Error then
    CoolTrayIcon1.IconIndex := 1;
  stat1.Panels.Items[1].Text := MessageText;
{
  if Error then
  begin
    btn_Connect.Caption := '连接';
    Application.MessageBox(PAnsiChar('宽带连接失败！'+MessageText), '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end else
  begin
    Application.MessageBox(PAnsiChar('宽带连接成功！外网已接入！'+MessageText), '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    btn_Connect.Caption := '断开连接';
  end;
}
end;

procedure TMain.edt_UserChange(Sender: TObject);
begin
  btn_Connect.Enabled := (edt_User.Text<>'') and (edt_Pwd.Text<>'') and (cbb_ConnectTo.Text<>'');
end;

procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not Self.Showing;
  if Self.Showing then
    Self.Hide;
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  if ParamCount>=3 then
  begin
    edt_User.Text := ParamStr(1);
    edt_Pwd.Text := ParamStr(2);
  end;
  cbb_ConnectTo.Items:= CnDialUp1.PossibleConnections;
  if cbb_ConnectTo.Items.Count>0 then
    cbb_ConnectTo.ItemIndex := 0
  else
    cbb_ConnectTo.Text := '';
  if btn_Connect.Enabled then
  begin
    btn_ConnectClick(Self);
  end;
end;

procedure TMain.mniN1Click(Sender: TObject);
begin
  Self.Show;
end;

procedure TMain.mniN3Click(Sender: TObject);
begin
  Self.Hide;
  Close;
end;

end.

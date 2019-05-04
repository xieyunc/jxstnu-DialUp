program jxstnu_PPPoE;

uses
  Forms,
  uMain in 'uMain.pas' {Main};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := '校园网宽带连接';
  Application.CreateForm(TMain, Main);
  Application.Run;
end.

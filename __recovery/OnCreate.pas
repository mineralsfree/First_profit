unit OnCreate;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,pngimage, Vcl.Dialogs, Vcl.ExtCtrls, SplashScreen, Vcl.StdCtrls, ComObj,  Vcl.Grids;

type

  MainList = record
    StoreNum: Integer;
    SectionNum:Integer;
    Date: TDateTime;
    VendorCode: string[10];
    ProdName: string[15];
    ProdCount: Integer;
    ProdPrice: Integer;


  end;
  TForm1 = class(TForm)
    strngrd1: TStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  introIMG: TImage;
  var Splash:Tsplash;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
png: TPngImage;
begin
  png:= TPngImage(introIMG.Picture);
  Splash := TSplash.Create(png);
  //Splash.Show(true);
  Sleep(200);
  //Splash.Close;
end;

end.

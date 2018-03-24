unit OnCreate;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls,  Vcl.Forms,pngimage, Vcl.Dialogs, Vcl.ExtCtrls, SplashScreen, Vcl.StdCtrls, ComObj,  Vcl.Grids,
  Vcl.Menus, Spravochnik_1;

type
   Tmode = (spr1, spr2, ved1, ved2, main);
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
    imgSplashIMG: TImage;
    mm1: TMainMenu;
    N11: TMenuItem;
    N21: TMenuItem;
    N1: TMenuItem;
    btn1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
      private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  introIMG: TImage;
  var Splash:Tsplash;
  mode:Tmode;
  sectorhead:PSectorList;
  shophead:PShopList;
  producthead:PProductList;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var shoplistkek:TShopInfo;
var prodlistkek:TProductInfo;

begin
case mode of

  spr1:
    begin
         shoplistkek.id:=StrToInt(InputBox('','','12'));
         shoplistkek.name=InputBox('','','kek');
         shoplistkek.adress=InputBox('','','privetlivaya');
         shoplistkek.tel=InputBox('','','37529235232');
         insertShopList(sectorhead,shoplistkek);
        //отрисовать
    end;
  main:
    begin
      //prodlistkek.shopid:=ComboBox;
      //prodlistkek.sectid:=ComboBox;
      prodlistkek.Date:=StrToDate(InputBox('','','12.08.1488'));
      prodlistkek.VendorCode:=InputBox('','','kek');
      prodlistkek.Name:=InputBox('','','kek');
      prodlistkek.Count:=StrToInt(InputBox('','','2'));
      prodlistkek.Price:=StrToCurr(InputBox('','','22.8'));
      insertProdList(producthead,prodlistkek);
      //отрисовать
    end;

end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
png: TPngImage;
begin
png:= TPngImage(imgSplashIMG.Picture);
  Splash := TSplash.Create(png);
  Splash.Show(true);
  Sleep(2000);
  Splash.Close;
  createProdHead(producthead);
  createSectHead(sectorhead);
  createShopHead(shophead);

end;


procedure TForm1.strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
   var i,Acol,Arow:Integer;
   var shopNum,sectnum:Integer;
   var sectlistkek:TsectorInfo;
   var getShopID:Integer;

begin
    case mode of
     spr1:
      begin
        if Acol = 4 then
          shopNum:=strngrd1.Cells[1,Arow];
          //deleteShopNum(head,shopNum);
        if Acol = 5 then

          mode:=spr2;
         sectlistkek.id:=Random(10);
         sectlistkek.shopid:=StrToInt(strngrd1.Cells[0,Arow]);
         sectlistkek.name=InputBox('','','kek');
         sectlistkek.zav=InputBox('','','privetlivaya');
         sectlistkek.tel=InputBox('','','37529235232');
         //Отрисовать второй справочник


      end;
      spr2:
      begin
      if Acol =2 then
        begin

        end;
        if Acol = 4 then
          sectNum:=strngrd1.Cells[1,Arow];
          //deleteSectNum(head,sectNum);



      end;
    end;
end;

end.

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
    N1: TMenuItem;
    btn1: TButton;
    N21: TMenuItem;
    Save1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N11Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
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
  kek:Integer;
  HehID:Integer;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var shoplistkek:TShopInfo;
var prodlistkek:TProductInfo;

begin
case mode of

  spr1:
    begin
         shoplistkek.id:=kek;
         shoplistkek.name:=InputBox('','','kek');
         shoplistkek.adress:=InputBox('','','privetlivaya');
         shoplistkek.tel:=InputBox('','','37529235232');
         insertShopList(shophead,shoplistkek);
         writeShopList(strngrd1,shophead);
         inc(kek);
    end;
  main:
    begin
      //prodlistkek.shopid:=ComboBox;
      //prodlistkek.sectid:=ComboBox;
      prodlistkek.Date:=StrToDate(InputBox('','','12.08.1488'));
      prodlistkek.VendorCode:=InputBox('','','kek');
      prodlistkek.Name:=InputBox('','','kek');
      prodlistkek.Count:=StrToInt(InputBox('','','2'));
      prodlistkek.Price:=StrToCurr(InputBox('','','22,8'));
      insertProdList(producthead,prodlistkek);
      writeProdList(strngrd1,producthead,shophead,sectorhead);

    end;

end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
png: TPngImage;
begin
  kek:=0;
png:= TPngImage(imgSplashIMG.Picture);
  Splash := TSplash.Create(png);
  Splash.Show(true);
  Sleep(2000);
  Splash.Close;
  createProdHead(producthead);
  createSectHead(sectorhead);
  createShopHead(shophead);
  mode:=main;
  readShopFile(shophead);
  readSectFile(sectorhead);
  readProdFile(producthead);
  writeProdList(strngrd1,producthead,shophead,sectorhead);


end;


procedure TForm1.N11Click(Sender: TObject);
begin
 mode:=spr1;
 writeshopList(strngrd1,shophead);
end;



procedure TForm1.N1Click(Sender: TObject);
begin
mode:=main;
writeProdList(strngrd1,producthead,shophead,sectorhead);
end;

procedure TForm1.N21Click(Sender: TObject);
begin
 mode:=spr2;
 writeSectList(strngrd1,sectorhead,shophead);
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
case mode of
  spr1: saveShopList(shophead);
  spr2: saveSectList(sectorhead);
  main: saveProdList(producthead);
end;
end;

{procedure TForm1.N21Click(Sender: TObject);
begin

end; }

procedure TForm1.strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
   var i,Acol,Arow:Integer;
   var shopNum,sectnum:Integer;
   var sectlistkek:TSectorInfo;
   var shoplistkek:TShopInfo;
   var prodlistkek:TProductInfo;
   var getShopID:Integer;
   var id: Integer;
   var id2:string;

begin
  strngrd1.MouseToCell(X,Y,Acol,Arow);

    case mode of
     spr1:       //SHOPLIST
      begin
        case Acol of
          1:
            begin
              id:=StrToInt(strngrd1.Cells[0,Arow]);
              shoplistkek.id:=id;                //red name
             shoplistkek.name:=InputBox('','','kek');
             shoplistkek.adress:=strngrd1.Cells[2,Arow];
             shoplistkek.tel:=strngrd1.Cells[3,Arow];
             editShopList(shophead,id,shoplistkek);
             writeshopList(strngrd1,shophead);
            end;
          2:
            begin
              id:=StrToInt(strngrd1.Cells[0,Arow]);
               shoplistkek.id:=id;                     //red adres
              shoplistkek.name:=strngrd1.Cells[1,Arow];
              shoplistkek.adress:=InputBox('','','privet');
              shoplistkek.tel:=strngrd1.Cells[3,Arow];
              editShopList(shophead,id,shoplistkek);
               writeshopList(strngrd1,shophead);
            end;
          3:
            begin
             id:=StrToInt(strngrd1.Cells[0,Arow]);
              shoplistkek.id:=id;                     //red telefon
              shoplistkek.name:=strngrd1.Cells[1,Arow];
              shoplistkek.adress:=strngrd1.Cells[2,Arow];
              shoplistkek.tel:=InputBox('','','+375296836944');
              editShopList(shophead,id,shoplistkek);
              writeshopList(strngrd1,shophead);
            end;
          4:
            begin
             //mode:=spr2;
              id:=StrToInt(strngrd1.Cells[0,Arow]);
             sectlistkek.id:=id;
             sectlistkek.shopid:=StrToInt(strngrd1.Cells[0,Arow]);
             sectlistkek.name:=InputBox('','','lol');
             sectlistkek.zav:=InputBox('','','privetlivaya');
             sectlistkek.tel:=InputBox('','','37529235232');
             insertSectList(sectorhead,sectlistkek);
             //writeSectList(strngrd1,sectorhead,shophead);
            end;
          5:
            begin
            HehID:=StrToInt(strngrd1.Cells[0,Arow]);
            mode:=spr2;
            writeSectList(strngrd1,sectorhead,shophead);
            end;
          6:
            begin
              id:=StrToInt(strngrd1.Cells[0,Arow]);
             deleteShopList(shophead,sectorhead,producthead,id);
             writeshopList(strngrd1,shophead);
             end;
        end;
      end;
      spr2:
      begin
        case Acol of
          1:
            begin
             id:=StrToInt(strngrd1.Cells[0,Arow]);
             sectlistkek.tel:=strngrd1.Cells[3,Arow];
             sectlistkek.zav:=strngrd1.Cells[1,Arow];
             sectlistkek.name:=inputbox('','','kek');
             editSectList(sectorhead,ID,sectlistkek);
             writeSectList(strngrd1,sectorhead,shophead);
            end;
          2:
            begin
            id:=StrToInt(strngrd1.Cells[0,Arow]);
             sectlistkek.tel:=inputbox('','','37529235232');
             sectlistkek.zav:=strngrd1.Cells[1,Arow];
             sectlistkek.name:=strngrd1.Cells[2,Arow];
             editSectList(sectorhead,ID,sectlistkek);
             writeSectList(strngrd1,sectorhead,shophead);
            end;
          4:
            begin
              deleteSectList(sectorhead,producthead,HehID);
              writeSectList(strngrd1,sectorhead,shophead);
            end;
        end;
      end;
      main:
        begin
          case Acol of
          4:
            begin
             id2:=strngrd1.Cells[0,Arow];
             prodlistkek.shopid:=StrToInt(strngrd1.Cells[2,Arow]);
             prodlistkek.sectid:=StrToInt(strngrd1.Cells[3,Arow]);
             prodlistkek.Date:=StrToDate(InputBox('','','12.02.1243'));
             prodlistkek.VendorCode:=id2;
             prodlistkek.Name:=strngrd1.Cells[1,Arow];
             prodlistkek.Count:=StrToInt(strngrd1.Cells[5,Arow]);
             prodlistkek.Price:=StrToInt(strngrd1.Cells[6,Arow]);
             editProdList(producthead,id2,prodlistkek);
            end;
          5:
            begin
              id2:=strngrd1.Cells[0,Arow];
             prodlistkek.shopid:=StrToInt(strngrd1.Cells[2,Arow]);
             prodlistkek.sectid:=StrToInt(strngrd1.Cells[3,Arow]);
             prodlistkek.Date:=StrToInt(strngrd1.Cells[4,Arow]);
             prodlistkek.VendorCode:=id2;
             prodlistkek.Name:=strngrd1.Cells[1,Arow];
             prodlistkek.Count:=StrToInt(inputbox('','','123'));
             prodlistkek.Price:=StrToInt(strngrd1.Cells[6,Arow]);
             editProdList(producthead,id2,prodlistkek);
            end;
          6:
            begin

            end;


          end;
        end;
    end;
end;

end.

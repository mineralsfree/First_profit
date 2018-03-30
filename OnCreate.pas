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
var flag:Boolean;
begin

case mode of
  spr1:
    begin
         shoplistkek.id:=kek;
         shoplistkek.name:=InputBox('','','Магазин_'+IntToStr(kek));
         shoplistkek.adress:=InputBox('','','платонова');
         shoplistkek.tel:=InputBox('','','+37529235232');
         insertShopList(shophead,shoplistkek);
         writeShopList(strngrd1,shophead);
         inc(kek);
    end;
  main:
    begin

      repeat
        flag:=True;
        try
        prodlistkek.shopid:=StrToInt(InputBox('Введите id магазина','ID:','1'));
        except
           on E:Exception do
           begin
           ShowMessage('Wrong input');
           flag:=false;
           end;

        end;
      until (flag);
      repeat
        flag:=True;
        try
        prodlistkek.sectid:=StrToInt(InputBox('Введите номер сектора','номер:','1'));
        except
           on E:Exception do
           begin
           ShowMessage('Wrong input');
           flag:=false;
           end;

        end;
      until (flag);
      repeat
        flag:=True;
        try
        prodlistkek.Date:=StrToDate(InputBox('введите Дату','Дата',DateToStr(GetTime)));
        except
           on E:Exception do
           begin
           ShowMessage('Wrong input');
           flag:=false;
           end;

        end;
      until (flag);
      repeat
        flag:=True;
       prodlistkek.VendorCode:=InputBox('Введите артикул товара','артикул:',InttoStr(hehid));
       if isProdIDFound(producthead,prodlistkek.VendorCode) then
       begin
       ShowMessage('Артикул занят');
       flag:=False;
       end;
      until flag;

      prodlistkek.Name:=InputBox('Введите название товара','товар','майка');
      repeat
        flag:=True;
        try
        prodlistkek.Count:=StrToInt(InputBox('Введите количество товара','количество','2'));
        except
           on E:Exception do
           begin
           ShowMessage('Wrong input');
           flag:=false;
           end;

        end;
      until (flag);


      repeat
        flag:=True;
        try
        prodlistkek.Price:=StrToCurr(InputBox('введите цену за ед','цена','22,8'));
        except
           on E:Exception do
           begin
           ShowMessage('Wrong input');
           flag:=false;
           end;

        end;
      until (flag);

      insertProdList(producthead,prodlistkek);
      if isShopIDFound(shophead,prodlistkek.shopid)
      and isSectIDFound(sectorhead,prodlistkek.sectid) then

      writeProdList(strngrd1,producthead,shophead,sectorhead)
      else
        ShowMessage('sector or shop do not exsist');

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
  Sleep(200);
  Splash.Close;
  createProdHead(producthead);
  createSectHead(sectorhead);
  createShopHead(shophead);
  mode:=main;
 kek:=readShopFile(shophead);
 HehID:=readSectFile(sectorhead);
  readProdFile(producthead);
  writeProdList(strngrd1,producthead,shophead,sectorhead);


end;


procedure TForm1.N11Click(Sender: TObject);
begin
 mode:=spr1;
 writeshopList(strngrd1,shophead);
 btn1.Visible:=true;
end;



procedure TForm1.N1Click(Sender: TObject);
begin
mode:=main;
writeProdList(strngrd1,producthead,shophead,sectorhead);
btn1.Visible:=true;
end;

procedure TForm1.N21Click(Sender: TObject);
begin
 mode:=spr2;
 writeSectList(strngrd1,sectorhead,shophead);
 btn1.Visible:=False;
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
case mode of
  spr1: begin
         saveShopList(shophead);
        ShowMessage('shoplist saved');
        end;
        spr2:
        begin
          saveSectList(sectorhead);
          ShowMessage('sectorlist saved');
        end;

  main:
    begin
     saveProdList(producthead);
     ShowMessage('productlist saved');
    end;

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
   var flag:Boolean;

begin
  strngrd1.MouseToCell(X,Y,Acol,Arow);
  flag:=False;
  if Arow<>0 then
  begin


    case mode of
     spr1:       //SHOPLIST
      begin
        case Acol of
          1:
            begin
              id:=StrToInt(strngrd1.Cells[0,Arow]);
              shoplistkek.id:=id;                //red name
             shoplistkek.name:=InputBox('Введите название магазина','Название:','kek');
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
              shoplistkek.adress:=InputBox('Введите адрес','Адрес:','Гикало, 4');
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
              shoplistkek.tel:=InputBox('Введите номер телефона','номер:','+375296836944');
              editShopList(shophead,id,shoplistkek);
              writeshopList(strngrd1,shophead);
            end;
          4:
            begin
              id:=StrToInt(strngrd1.Cells[0,Arow]);
             sectlistkek.id:=HehID;
             sectlistkek.shopid:=StrToInt(strngrd1.Cells[0,Arow]);
             sectlistkek.name:=InputBox('Введите имя секора','имя:','Молочные продукты');
             sectlistkek.zav:=InputBox('Заведующий сектором','имя','Вася');
             sectlistkek.tel:=InputBox('Телефон','номер:','+37529235232');
             insertSectList(sectorhead,sectlistkek);
              Inc(hehid);
            end;
          5:
            begin
            id:=StrToInt(strngrd1.Cells[0,Arow]);
             deleteShopList(shophead,sectorhead,producthead,id);
             writeshopList(strngrd1,shophead);
            end;
          6:
            begin

             end;
        end;
      end;
      spr2:
      begin
        case Acol of
          1:
            begin
             id:=StrToInt(strngrd1.Cells[0,Arow]);
             sectlistkek.tel:=strngrd1.Cells[4,Arow];
             sectlistkek.zav:=strngrd1.Cells[3,Arow];
             //sectlistkek.zav:=strngrd1.Cells[3,Arow];\\

             sectlistkek.name:=inputbox('Введите имя','имя секции:','kek');
             editSectList(sectorhead,ID,sectlistkek);
             writeSectList(strngrd1,sectorhead,shophead);
            end;
          2:
            begin

            end;
          4:
            begin
            id:=StrToInt(strngrd1.Cells[0,Arow]);
             sectlistkek.tel:=inputbox('Введите телефон','номер:','+37529235232');
             sectlistkek.zav:=strngrd1.Cells[3,Arow];
             sectlistkek.name:=strngrd1.Cells[1,Arow];
             editSectList(sectorhead,ID,sectlistkek);
             writeSectList(strngrd1,sectorhead,shophead);
            end;
          5:
            begin
              id:=StrToInt(strngrd1.Cells[0,Arow]);
              deleteSectList(sectorhead,producthead,ID);
              writeSectList(strngrd1,sectorhead,shophead);
            end;
        end;
      end;
      main:
        begin
          case Acol of
          5:
            begin

             id2:=strngrd1.Cells[0,Arow];
             prodlistkek.shopid:=StrToInt(strngrd1.Cells[2,Arow]);
             prodlistkek.sectid:=StrToInt(strngrd1.Cells[3,Arow]);
             repeat
             try
              prodlistkek.Date:=StrToDate(InputBox('Введите дату','дата:','12.02.1243'));
              except
              on E:Exception do
              ShowMessage('Wrong input');
             end;
             until flag;
             prodlistkek.VendorCode:=id2;
             prodlistkek.Name:=strngrd1.Cells[1,Arow];
             prodlistkek.Count:=StrToInt(strngrd1.Cells[5,Arow]);
             prodlistkek.Price:=StrToInt(strngrd1.Cells[6,Arow]);
             editProdList(producthead,id2,prodlistkek);
            end;
          6:
            begin
             id2:=strngrd1.Cells[0,Arow];
             prodlistkek.shopid:=StrToInt(strngrd1.Cells[2,Arow]);
             prodlistkek.sectid:=StrToInt(strngrd1.Cells[3,Arow]);
             prodlistkek.Date:=StrToDate(strngrd1.Cells[4,Arow]);
             prodlistkek.VendorCode:=id2;
             prodlistkek.Name:=strngrd1.Cells[1,Arow];
             prodlistkek.Count:=StrToInt(inputbox('Input Count','Count:','123'));
             prodlistkek.Price:=StrToInt(strngrd1.Cells[6,Arow]);
             editProdList(producthead,id2,prodlistkek);
            end;
          7:
            begin
            id2:=strngrd1.Cells[0,Arow];
            deleteProdList(producthead,id2);
            writeProdList(strngrd1,producthead,shophead,sectorhead);
            end;


          end;
        end;
    end;
  end
  else
  case Acol of
    0:
    begin
    sortProdList(producthead,ArtIDsort);
    end;
    2:
    begin
    sortProdList(producthead,ShopIDsort);
    end;
    3:
    begin
    sortProdList(producthead,SectIDsort);
    end;

  end;
end;

end.

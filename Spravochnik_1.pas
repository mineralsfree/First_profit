unit Spravochnik_1;

interface
uses
  SysUtils, Vcl.Grids;

type
TShopInfo = record
  id: integer;
  name: string[30];
  adress: string[30];
  tel: string[30];
end;
PShopList = ^TShopList;
TShopList = record
  Inf: TShopInfo;
  Adr: PShopList;
end;

TSectorInfo = record
  id: integer;
  shopid: integer;
  name: string[30];
  zav: string[30];
  tel: string[30];
end;
PSectorList = ^SectorList;
SectorList = record
  Inf: TSectorInfo;
  Adr: PSectorList;
end;

TProductInfo = record
    shopid: Integer;
    sectid:Integer;
    Date: TDateTime;
    VendorCode: string[10];
    Name: string[40];
    Count: Integer;
    Price: Currency;
end;
PProductList = ^ProductList;
ProductList = record
  Inf: TProductInfo;
  Adr: PProductList;
end;

procedure createShopHead(var head: PShopList);
procedure insertShopList(const head: PShopList; shop: TShopInfo);
procedure editShopList(const head: PShopList; id: integer; shop:TShopInfo);
procedure deleteShopList(const head: PShopList; SectHead: PSectorList; ProdHead: PProductList; id: integer);

procedure createSectHead(var head: PSectorList);
procedure insertSectList(const head: PSectorList; sect: TSectorInfo);
procedure editSectList(const head: PSectorList; id: integer; sect:TShopInfo);
procedure deleteSectList(const head: PSectorList; ProdHead: PProductList; id: integer);
procedure deleteSectListKek(const head: PSectorList; ProdHead: PProductList; kek: integer);


procedure createProdHead(var head: PProductList);
procedure insertProdList(const head: PProductList; prod: PProductList);
procedure editProdList(const head: PProductList; id: string; prod: TProductInfo);
procedure deleteProdList(const head: PProductList; id: string);
procedure deleteProdListKek(const head: PProductList; kek: integer);

implementation

procedure createShopHead(var head: PShopList);
begin
  new(head);
  head.Adr := nil;
end;

procedure createSectHead(var head: PSectorList);
begin
  new(head);
  head.Adr := nil;
end;

procedure createProdHead(var head: PProductList);
begin
  new(head);
  head.Adr := nil;
end;

procedure insertShopList(const head: PShopList; shop: TShopInfo);
var
  temp:PShopList;
begin
  temp := head;
  while temp^.adr <> nil do
  begin
    temp := temp^.adr;
  end;
  new(temp^.adr);
  temp:=temp^.adr;
  temp^.adr:=nil;
  temp^.Inf := shop;
end;

procedure insertSectList(const head: PSectorList; sect: TSectorInfo);
var
  temp:PSectorList;
begin
  temp := head;
  while temp^.adr <> nil do
  begin
    temp := temp^.adr;
  end;
  new(temp^.adr);
  temp:=temp^.adr;
  temp^.adr:=nil;
  temp^.Inf := sect;
end;

procedure insertProdList(const head: PProductList; prod: TProductInfo);
var
  temp:PProductList;
begin
  temp := head;
  while temp^.adr <> nil do
  begin
    temp := temp^.adr;
  end;
  new(temp^.adr);
  temp:=temp^.adr;
  temp^.adr:=nil;
  temp^.Inf := prod;
end;

procedure editShopList(const head: PShopList; id: integer; shop:TShopInfo);
var
  temp: PShopList;
begin
  temp:= head;

  while (temp <> nil)do
  begin
    if temp^.Inf.id = id then
    begin
      temp^.Inf := shop;
      temp^.Inf.id := id;
      exit;
    end;
    temp := temp^.Adr;
  end;
end;

procedure editSectList(const head: PSectorList; id: integer; sect:TShopInfo);
var
  temp: PSectorList;
begin
  temp:= head;

  while (temp <> nil)do
  begin
    if temp^.Inf.id = id then
    begin
      temp^.Inf := sect;
      temp^.Inf.id := id;
      exit;
    end;
    temp := temp^.Adr;
  end;
end;

procedure editProdList(const head: PProductList; id: string; prod: TProductInfo);
var
  temp: PProductList;
begin
  temp:= head;
  while (temp <> nil)do
  begin
    if temp^.Inf.VendorCode = id then
    begin
      temp^.Inf := prod;
      temp^.Inf.VendorCode := id;
      exit;
    end;
    temp := temp^.Adr;
  end;
end;

procedure deleteProdList(const head: PProductList; id: string);
var
  temp,temp2:PProductList;
begin
  temp := head;
  while temp^.adr <> nil do
  begin
    temp2 := temp^.adr;
    if temp2^.Inf.VendorCode = id then
    begin
      temp^.adr := temp2^.adr;
      dispose(temp2);
    end
    else
      temp:= temp^.adr;
  end;
end;

procedure deleteProdListKek(const head: PProductList; kek: integer);
var
  temp,temp2:PProductList;
begin
  temp := head;
  while temp^.adr <> nil do
  begin
    temp2 := temp^.adr;
    if temp2^.Inf.sectid = kek then
    begin
      temp^.adr := temp2^.adr;
      dispose(temp2);
    end
    else
      temp:= temp^.adr;
  end;
end;



procedure deleteSectList(const head: PSectorList; ProdHead: PProductList; id: integer);
var
  temp,temp2:PSectorList;
begin
  deleteProdListKek(ProdHead, id);
  temp := head;
  while temp^.adr <> nil do
  begin
    temp2 := temp^.adr;
    if temp2^.Inf.id = id then
    begin
      temp^.adr := temp2^.adr;
      dispose(temp2);
    end
    else
      temp:= temp^.adr;
  end;
end;

procedure deleteSectListKek(const head: PSectorList; ProdHead: PProductList; kek: integer);
var
  temp,temp2:PSectorList;
begin
  temp := head;
  while temp^.adr <> nil do
  begin
    temp2 := temp^.adr;
    if temp2^.Inf.shopid = kek then
    begin
      deleteProdListKek(ProdHead, temp2^.Inf.id);
      temp^.adr := temp2^.adr;
      dispose(temp2);
    end
    else
      temp:= temp^.adr;
  end;
end;

procedure deleteShopList(const head: PShopList; SectHead: PSectorList; ProdHead: PProductList; id: integer);
var
  temp,temp2:PShopList;
begin
  deleteSectListKek(SectHead, ProdHead, id);
  temp := head;
  while temp^.adr <> nil do
  begin
    temp2 := temp^.adr;
    if temp2^.Inf.id = id then
    begin
      temp^.adr := temp2^.adr;
      dispose(temp2);
    end
    else
      temp:= temp^.adr;
  end;
end;

function getShopName(head: PShopList; id: integer):string;
var
  tmp: PShopList;
begin
  tmp:= head;
  while tmp <> nil do
  begin
    if tmp^.Inf.id = id then
    begin
      Result:= tmp^.Inf.name;
      exit;
    end;

    tmp:= tmp^.Adr;
  end;
end;

function getSectName(head: PSectorList; id: integer):string;
var
  tmp: PSectorList;
begin
  tmp:= head;
  while tmp <> nil do
  begin
    if tmp^.Inf.id = id then
    begin
      Result:= tmp^.Inf.name;
      exit;
    end;

    tmp:= tmp^.Adr;
  end;
end;

procedure writeShopList(Grid:TStringGrid; const head:PShopList);
var
  temp:PShopList;
begin
  Grid.ColCount := 5;
  Grid.RowCount := 2;
  Grid.Cells[0,0] := 'ID';
  Grid.Cells[1,0] := 'Name';
  Grid.Cells[2,0] := 'Adress';
  Grid.Cells[3,0] := 'Tel. number';
  //ShowMessage('kek');
  temp := head^.adr;
  while temp <> nil do
  begin
    Grid.Cells[0,Grid.RowCount - 1] := IntToStr(temp^.Inf.id);
    Grid.Cells[1,Grid.RowCount - 1] := temp^.Inf.name;
    Grid.Cells[2,Grid.RowCount - 1] := temp^.Inf.adress;
    Grid.Cells[3,Grid.RowCount - 1] := temp^.Inf.tel;
    Grid.Cells[4,Grid.RowCount - 1] := 'Delete';
    temp:=temp^.adr;
    Grid.RowCount := Grid.RowCount + 1;
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;


procedure writeSectList(Grid:TStringGrid; const head:PSectorList);
var
  temp:PSectorList;
begin
  Grid.ColCount := 6;
  Grid.RowCount := 2;
  Grid.Cells[0,0] := 'ID';
  Grid.Cells[1,0] := 'Name';
  Grid.Cells[2,0] := 'Shop Name';
  Grid.Cells[3,0] := 'Zav';
  Grid.Cells[4,0] := 'Tel. number';
  //ShowMessage('kek');
  temp := head^.adr;
  while temp <> nil do
  begin
    Grid.Cells[0,Grid.RowCount - 1] := IntToStr(temp^.Inf.id);
    Grid.Cells[1,Grid.RowCount - 1] := temp^.Inf.name;
    Grid.Cells[2,Grid.RowCount - 1] := getShopName(temp^.Inf.shopid);
    Grid.Cells[3,Grid.RowCount - 1] := temp^.Inf.zav;
    Grid.Cells[4,Grid.RowCount - 1] := temp^.Inf.tel;
    Grid.Cells[5,Grid.RowCount - 1] := 'Delete';
    temp:=temp^.adr;
    Grid.RowCount := Grid.RowCount + 1;
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;


procedure writeProdList(Grid:TStringGrid; const head:PProductList);
var
  temp:PProductList;
begin
  Grid.ColCount := 8;
  Grid.RowCount := 2;
  Grid.Cells[0,0] := 'Vendor';
  Grid.Cells[1,0] := 'Name';
  Grid.Cells[2,0] := 'Shop Name';
  Grid.Cells[3,0] := 'Sector Name';
  Grid.Cells[4,0] := 'Date';
  Grid.Cells[5,0] := 'Count';
  Grid.Cells[6,0] := 'Currency';
  //ShowMessage('kek');
  temp := head^.adr;
  while temp <> nil do
  begin
    Grid.Cells[0,Grid.RowCount - 1] := temp^.Inf.VendorCode;
    Grid.Cells[1,Grid.RowCount - 1] := temp^.Inf.Name;
    Grid.Cells[2,Grid.RowCount - 1] := getShopName(temp^.Inf.shopid);
    Grid.Cells[3,Grid.RowCount - 1] := getSectName(temp^.Inf.sectid);
    Grid.Cells[4,Grid.RowCount - 1] := DateToStr( temp^.Inf.Date );
    Grid.Cells[5,Grid.RowCount - 1] := IntToStr(temp^.Inf.Count);
    Grid.Cells[6,Grid.RowCount - 1] := CurrToStr(temp^.Inf.Price);

    Grid.Cells[7,Grid.RowCount - 1] := 'Delete';
    temp:=temp^.adr;
    Grid.RowCount := Grid.RowCount + 1;
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;
end.


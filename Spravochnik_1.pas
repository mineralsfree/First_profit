unit Spravochnik_1;

interface
uses
  SysUtils;

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

procedure insertProdList(const head: PProductList; prod: PProductList);
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

end.


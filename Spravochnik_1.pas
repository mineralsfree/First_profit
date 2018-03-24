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


end.

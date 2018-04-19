unit Vedom2;

interface
uses
  SysUtils, Vcl.Grids, Vcl.Dialogs,Spravochnik_1, DateUtils;
procedure formVedom1(Grid: TStringGrid; ProdHead:PProductList; ShopHead: PShopList; SectHead: PSectorList; id:integer);

implementation

procedure formVedom1(Grid: TStringGrid; ProdHead:PProductList; ShopHead: PShopList; SectHead: PSectorList; id:Integer);
var Shtemp: Pshoplist;Setemp:PSectorList;
begin

  Grid.ColCount := 9;
  Grid.RowCount := 2;
  Grid.Cells[4,0] := 'Date: ' + FormatDateTime('dd.mm.yyyy"-"hh:nn:ss:zzz', Now);
  Grid.Cells[0,1] := 'Num p/p';
  Grid.Cells[1,1] := 'Shop Name';
  Grid.Cells[2,1] := 'Sect Name';
  Grid.Cells[6,1] := 'Number';
  Grid.Cells[7,1] := 'Count';
  Grid.Cells[8,1] := 'Price';
  Shtemp := shophead^.adr;
  Setemp := secthead^.Adr;
  if Setemp.Inf.shopid = id then
  begin
    while shtemp <> nil do
  begin
    {Grid.Cells[0,Grid.RowCount - 1] := shtemp^.Inf.VendorCode;
    Grid.Cells[1,Grid.RowCount - 1] := shtemp^.Inf.Name;
    Grid.Cells[2,Grid.RowCount - 1] := getShopName(ShopHead, shtemp^.Inf.shopid);
    Grid.Cells[3,Grid.RowCount - 1] := getSectName(SectHead, shtemp^.Inf.sectid);
    Grid.Cells[4,Grid.RowCount - 1] := DateToStr( shtemp^.Inf.Date );
    Grid.Cells[5,Grid.RowCount - 1] := IntToStr(shtemp^.Inf.Count);
    Grid.Cells[6,Grid.RowCount - 1] := CurrToStr(shtemp^.Inf.Price);
    Grid.Cells[7,Grid.RowCount - 1] := '-';     }
    shtemp:=shtemp^.adr;
    Grid.RowCount := Grid.RowCount + 1;
  end;
  Grid.RowCount := Grid.RowCount - 1;
  end;




 // Grid.Cells[6,0] := 'Delete';
  //ShowMessage('kek');
 { temp := head^.adr;
  while temp <> nil do
  begin
    Grid.Cells[0,Grid.RowCount - 1] := IntToStr(temp^.Inf.id);
    Grid.Cells[1,Grid.RowCount - 1] := temp^.Inf.name;
    Grid.Cells[2,Grid.RowCount - 1] := temp^.Inf.adress;
    Grid.Cells[3,Grid.RowCount - 1] := temp^.Inf.tel;
    Grid.Cells[4,Grid.RowCount - 1] := '+';
    Grid.Cells[5,Grid.RowCount - 1] := '-';
    Grid.Cells[6,Grid.RowCount - 1] := '';
    temp:=temp^.adr;
    Grid.RowCount := Grid.RowCount + 1;
  end;
  Grid.RowCount := Grid.RowCount - 1;
  }
end;
end.

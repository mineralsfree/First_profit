unit vedom;

interface
uses
  SysUtils, Vcl.Grids, Vcl.Dialogs,Spravochnik_1, DateUtils;
procedure formVedom2(Grid: TStringGrid; ProdHead:PProductList; ShopHead: PShopList; SectHead: PSectorList);

implementation

procedure formVedom2(Grid: TStringGrid; ProdHead:PProductList; ShopHead: PShopList; SectHead: PSectorList);
begin

  Grid.ColCount := 9;
  Grid.RowCount := 2;
  Grid.Cells[4,0] := 'Date: ' + FormatDateTime('dd.mm.yyyy"-"hh:nn:ss:zzz', Now);
  Grid.Cells[0,1] := 'Num p/p';
  Grid.Cells[1,1] := 'Shop ID';
  Grid.Cells[2,1] := 'Shop Name';
  Grid.Cells[3,1] := 'Sect Name';
  Grid.Cells[4,1] := 'Sect ID';
  Grid.Cells[5,1] := 'Articul';
  Grid.Cells[6,1] := 'Name';
  Grid.Cells[7,1] := 'Count';
  Grid.Cells[8,1] := 'Price';


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

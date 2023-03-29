unit usgraph;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TDrawer = class
    public
      x1,y1,x2,y2,r,lineWidth:integer;
      BStyle:TBrushStyle;
      pColour:TColor;
      bColour:TColor;
      function brushStyleFromId(id:integer):TBrushStyle;
      procedure GetInputs(x1s,x2s,y1s,y2s,rs,lws:string;bsid:integer);
      procedure drawLine(cnv:TCanvas);
      procedure drawRectangle(cnv:TCanvas);
      procedure drawEllipse(cnv:TCanvas);
      procedure ClearSpace(cnv:TCanvas; spr:TRect);
  end;


  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ColorDialog1: TColorDialog;
    ComboBox1: TComboBox;
    edLineWidth: TEdit;
    edX1: TEdit;
    edY1: TEdit;
    edX2: TEdit;
    edY2: TEdit;
    edR: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    PaintBox1: TPaintBox;
    Panel1: TPanel;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure GetInputs;
  private

  public

  end;

var
  Form1: TForm1;
  drw:TDrawer;


implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.GetInputs;
begin
  drw.GetInputs( edX1.Text, edX2.Text, edY1.Text, edY2.Text,
                 edR.Text, edLineWidth.Text, ComboBox1.ItemIndex);
end;

function TDrawer.brushStyleFromId(id:integer):TBrushStyle;
begin
  case id of
  0:result:=bsSolid;
  1:result:=bsCross;
  2:result:=bsClear;
  end;
end;

procedure TDrawer.drawLine(cnv:TCanvas);
begin
  with cnv do
  begin
    Pen.Width:=lineWidth;
    Pen.Color:=pColour;
    MoveTo(x1,y1);
    LineTo(x2,y2);
  end;
end;


procedure TDrawer.drawRectangle(cnv:TCanvas);
begin
  with cnv do
  begin
    Pen.Width:=lineWidth;
    Pen.Color:=pColour;
    Brush.Color:=bColour;
    Brush.Style:=BStyle;
    Rectangle(x1,y1,x2,y2);
  end;
end;

procedure TDrawer.drawEllipse(cnv:TCanvas);
begin
  with cnv do
  begin
    Pen.Width:=lineWidth;
    Pen.Color:=pColour;
    Brush.Color:=bColour;
    Brush.Style:=BStyle;
    Ellipse(x1,y1,x2,y2);
  end;
end;


procedure TDrawer.ClearSpace(cnv:TCanvas; spr:TRect);
begin
  with cnv do
  begin
    //brush colour
    Brush.Color:=clSilver; //color constant
    Brush.Color:=RGBToColor(170,170,170);
    //red, green, blue colour in range 0 ..  255

    Brush.Style:=bsCross;

    FillRect(spr);
    //which is equivalent to
    FillRect(Rect(0,0,spr.Right,spr.Bottom));
    //or
    FillRect(0,0,spr.Right,spr.Bottom);
  end;
end;

procedure TDrawer.GetInputs(x1s,x2s,y1s,y2s,rs,lws:string;bsid:integer);
begin
  TryStrToInt(x1s,x1);
  TryStrToInt(x2s,x2);
  TryStrToInt(y1s,y1);
  TryStrToInt(y2s,y2);
  TryStrToInt(rs,r );
  TryStrToInt(lws,lineWidth);
  BStyle:=brushStyleFromId(bsid);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  GetInputs;
  drw.drawLine(PaintBox1.Canvas);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  GetInputs;
  drw.drawRectangle(PaintBox1.Canvas);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  GetInputs;
  drw.drawEllipse(PaintBox1.Canvas);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  ColorDialog1.Color:=drw.pColour;
  if (ColorDialog1.Execute) then
    drw.pColour:=ColorDialog1.Color;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  ColorDialog1.Color:=drw.bColour;
  if (ColorDialog1.Execute) then
    drw.bColour:=ColorDialog1.Color;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  drw:=TDrawer.Create;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  drw.ClearSpace(PaintBox1.Canvas,PaintBox1.ClientRect);
end;

end.


unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    CUDA: TCheckBox;
    Bitratev: TEdit;
    Bitratea: TEdit;
    Container: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label99: TLabel;
    NVENC: TCheckBox;
    Label1: TLabel;
    AAC: TRadioButton;
    Opus: TRadioButton;
    MKV: TRadioButton;
    MP4: TRadioButton;
    Save: TButton;
    procedure AACChange(Sender: TObject);
    procedure BitrateaChange(Sender: TObject);
    procedure BitratevChange(Sender: TObject);
    procedure CUDAChange(Sender: TObject);
    procedure MKVChange(Sender: TObject);
    procedure MP4Change(Sender: TObject);
    procedure NVENCChange(Sender: TObject);
    procedure OpusChange(Sender: TObject);
    procedure SaveClick(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;
 // NVENC2: boolean;

implementation

{$R *.lfm}
 uses
   Unit1;

{ TForm2 }

procedure TForm2.SaveClick(Sender: TObject);
begin
  Close;
end;

procedure TForm2.NVENCChange(Sender: TObject);
begin
  if NVENC.Checked=true then TForm1.NVENC2:=true;
  if NVENC.Checked=false then TForm1.NVENC2:=false;
end;

procedure TForm2.CUDAChange(Sender: TObject);
begin
  if CUDA.Checked=true then TForm1.CUDA2:=true;
  if CUDA.Checked=false then TForm1.CUDA2:=false;
end;

procedure TForm2.MKVChange(Sender: TObject);
begin
   if MKV.Checked=true then TForm1.MKV2:=true;
   if MKV.Checked=false then TForm1.MKV2:=false;
end;

procedure TForm2.MP4Change(Sender: TObject);
begin
   if MP4.Checked=true then TForm1.MP42:=true;
   if MP4.Checked=false then TForm1.MP42:=false;
end;

procedure TForm2.BitratevChange(Sender: TObject);
begin
  TForm1.Bitratev2:=Bitratev.Text;
end;


procedure TForm2.BitrateaChange(Sender: TObject);
begin
  TForm1.Bitratea2:=Bitratea.Text;
end;

procedure TForm2.AACChange(Sender: TObject);
begin
  if AAC.checked=true then TForm1.AAC2:=true;
  if AAC.checked=false then TForm1.AAC2:=false;
end;
procedure TForm2.OpusChange(Sender: TObject);
begin
  if Opus.checked=true then TForm1.Opus2:=true;
  if Opus.checked=false then TForm1.Opus2:=false;
end;



begin
  Tform1.NVENC2:=false;
  Tform1.CUDA2:=false;
  TForm1.Opus2:=false;
  TForm1.MP42:=false;

end.


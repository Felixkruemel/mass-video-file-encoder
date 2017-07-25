unit Unit1;
///////////////////////
//////VERSION 1.1//////
///////////////////////
{$mode objfpc}{$H+}
{$R project.rc}
interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ShellAPI, Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Pfad: TListBox;
    H264: TRadioButton;
    H265: TRadioButton;
    Manual: TRadioButton;
    Start: TButton;
    Directory: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    OpenDialog1: TOpenDialog;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    procedure Button1Click(Sender: TObject);
    procedure DirectoryClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure StartClick(Sender: TObject);
    private


  public

  end;

var
  Form1: TForm1;
  filename : array[0..256] of string;
  command : array [0..256] of String;
  i:longint;
  stringlist: TStringList;
  f:TEXTfile;
  filename1,exe,dir:string;
  check1,check2:boolean ;
  program1:TProcess;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  OpenDialog1.Options := [ofAllowMultiSelect, ofFileMustExist];
  opendialog1.Execute;
  for i:= 0 to OpenDialog1.Files.Count -1 do filename[i]:=OPenDialog1.Files[i];
//  ShowMessage(filename[0]);
//  ShowMessage(filename[1]);
  for i:= 0 to OpenDialog1.files.count -1 do ListBox1.Items.Add(filename[i]);
  check1:=true;



     end;

procedure TForm1.DirectoryClick(Sender: TObject);
begin
   SelectDirectoryDialog1.Execute;
   Pfad.Items.Add(SelectDirectoryDialog1.Filename);
   check2:=true;
 //  ShowMessage(SelectDirectoryDialog1.FileName);

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
   // if Edit1.Text =  '' then check3:=false;
  //showmessage(Edit1.Text);
  Manual.State:=cbChecked;
end;


procedure TForm1.StartClick(Sender: TObject);
begin
  if (check1 = true) and (check2 = true) then
  begin
     filename1:=concat(SelectDirectoryDialog1.Filename,'\start.cmd');
     if Manual.Checked = false then
     begin
          if H264.Checked then for i:= 0 to OpenDialog1.Files.count -1 do command[i]:=concat('ffmpeg -i "',filename[i],'" -vcodec libx264 -acodec libfaac -b:v 8000k -b:a 256k "Datei');
          if H265.Checked then for i:= 0 to OpenDialog1.Files.count -1 do command[i]:=concat('ffmpeg -i "',filename[i],'" -vcodec libx265 -acodec libfaac -b:v 5000k -b:a 256k "Datei');
          AssignFile(f,filename1);
          Rewrite(f);
          for i:=0 to OpenDialog1.Files.count -1 do
          begin
            Writeln(f,command[i],i,'.mkv"');
          end;
 //     writeln (f,'pause');
      CloseFile(f);
     end;

     if Manual.Checked = true then
     begin
       AssignFile(f,filename1);
       Rewrite(f);
       for i:=0 to OpenDialog1.Files.count -1 do
          begin
            Writeln(f,'ffmpeg -i "',filename[i],'" ',Edit1.text,' "File',i,'.mkv"');
          end;
       CloseFile(f);
     end;



      exe:=concat('"',SelectDirectoryDialog1.Filename,'\start.cmd"');
     // ShellExecute(1,nil, PChar('cmd'), PChar(exe), nil, 1);
     // executeprocess('cmd.exe',exe );
     program1:=Tprocess.create(nil);
     program1.Commandline:=exe;
     program1.execute;
     program1.free;
   end;
   if (check1 = false) or (check2= false) then
   showmessage('Bitte zuerst die Dateien und den Pfad auswählen!');
end;



begin
 check1:=false;
 check2:=false;






end.


unit Unit1;
////////////////////////
//////VERSION 1.21//////
////////////////////////
{$mode objfpc}{$H+}
{$R project.rc}
interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Testbutton: TButton;
    Settings: TButton;
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
    procedure SettingsClick(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure TestbuttonClick(Sender: TObject);
    private


  public
     const NVENC2: boolean =true;
     const CUDA2: boolean =true;
     const AAC2: boolean =true;
     const Opus2: boolean =true;
     const Bitratev2: string = '8000k';
     const Bitratea2: string = '256k';
     const MP42: boolean =true;
     const MKV2: boolean =true;
     const Prefix2: string = 'File';
  end;

var
  Form1: TForm1;
  filename : array[0..256] of string;
  command : array [0..256] of String;
  i:longint;
  stringlist: TStringList;
  f:TEXTfile;
  filename1,exe,dir,CODECV,CODECA,cont:string;
  check1,check2:boolean ;
  program1:TProcess;

implementation

{$R *.lfm}
uses
  Unit2;
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

procedure TForm1.SettingsClick(Sender: TObject);
begin
  Form2.ShowModal;
end;


procedure TForm1.StartClick(Sender: TObject);
begin
  if (check1 = true) and (check2 = true) then
  begin
     filename1:=concat(SelectDirectoryDialog1.Filename,'\start.cmd');
     if Manual.Checked = false then
     begin

//////////////////////////////////////////////////////////////////////////////

          if (NVENC2=true) and (H264.Checked) then CODECV:='h264_nvenc';
          if (NVENC2=false) and (H264.Checked) then CODECV:='libx264';
          if (NVENC2=true) and (H265.Checked) then CODECV:='hevc_nvenc';
          if (NVENC2=false) and (H265.Checked) then CODECV:='libx265';
          if AAC2=true then CODECA:='aac';
          if Opus2=true then CODECA:='opus';
          if MKV2= true then Cont:='mkv';
          if MP42= true then Cont:='mp4';

//////////////////////////////////////////////////////////////////////////////

          if CUDA2 = false then
          begin
              if H264.Checked then for i:= 0 to OpenDialog1.Files.count -1 do command[i]:=concat(' -i "',filename[i],'" -vcodec ',CODECV,' -acodec ',CODECA,' -b:v ',Bitratev2,' -b:a ',Bitratea2,' "',Prefix2,'"');
              if H265.Checked then for i:= 0 to OpenDialog1.Files.count -1 do command[i]:=concat(' -i "',filename[i],'" -vcodec ',CODECV,' -acodec ',CODECA,' -b:v ',Bitratev2,' -b:a ',Bitratea2,' "',Prefix2,'"');
          end;
          if CUDA2 = true then
          begin
             if H264.Checked then for i:= 0 to OpenDialog1.Files.count -1 do command[i]:=concat(' -hwaccel cuvid -i "',filename[i],'" -vcodec ',CODECV,' -acodec ',CODECA,' -b:v ',Bitratev2,' -b:a ',Bitratea2,' "',Prefix2,'"');
             if H265.Checked then for i:= 0 to OpenDialog1.Files.count -1 do command[i]:=concat(' -hwaccel cuvid -i "',filename[i],'" -vcodec ',CODECV,' -acodec ',CODECA,' -b:v ',Bitratev2,' -b:a ',Bitratea2,' "',Prefix2,'"');
          end;

//////////////////////////////////////////////////////////////////////////////
          AssignFile(f,filename1);
          Rewrite(f);
          for i:=0 to OpenDialog1.Files.count -1 do
          begin
            Writeln(f,'"',SelectDirectoryDialog1.Filename,'\ffmpeg"', command[i],i,'.',cont,'"');
          end;
      writeln (f,'pause');
      CloseFile(f);
     end;
///////////////////////////////////////////////////////////////////////////////
//////////////////////////MANUAL///////////////////////////////////////////////

     if Manual.Checked = true then
     begin
       AssignFile(f,filename1);
       Rewrite(f);
       for i:=0 to OpenDialog1.Files.count -1 do
          begin
            Writeln(f,'"',SelectDirectoryDialog1.Filename,'\ffmpeg" -i "',filename[i],'" ',Edit1.text,' "',Prefix2,i,'.',cont,'"');
          end;
       CloseFile(f);
     end;

///////////////////////////////////////////////////////////////////////////////


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

procedure TForm1.TestbuttonClick(Sender: TObject);
begin
  if MP42= true then showmessage('true');
  if MP42= false then showmessage('false');
 // showmessage(Bitratev2);
end;



begin
 check1:=false;
 check2:=false;






end.


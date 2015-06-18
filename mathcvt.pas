Unit MathCvt;

Interface

function Power(X,Y:WORD):LongInt;
function Bin2Dec(Bin:string):LongInt;
function Bin2Hex(Bin:string):string;
function Dec2Bin(Dec:LongInt):string;
function Dec2Hex(Dec:LongInt):string;
function Hex2Bin(Hex:string):string;
function Hex2Dec(Hex:string):LongInt;
function Oct2Dec(Oct:string):LongInt;
function Dec2Oct(Dec:LongInt):string;
function HexToStr(hex: string): string;
function StrToHex(source: string): string;

Implementation
uses SysUtils;

function StrToHex(source: string): string;
var
  i: Integer;
  c: Char;
  s: string;
begin
  s := '';
  for i:=1 to Length(source) do begin
    c := source[i];
    s := s +  IntToHex(Integer(c), 2) + ' ';
  end;
  result := s;
end;

function HexToStr(hex: string): string;
var
  i: Integer;
begin
  hex:= StringReplace(hex, ' ', '', [rfReplaceAll]);
  for i:= 1 to Length(hex) div 2 do
    Result:= Result + Char(StrToInt('$' + Copy(hex, (i-1) * 2 + 1, 2)));
end;

function Power(X,Y:Word):LongInt;
var Temp,Teller : LongInt;
begin
 TEMP:=1;
 for Teller:=1 to Y do TEMP:=TEMP*X;
 Power:=Temp;
end;

function Dec2Bin(Dec:LONGINT):string;
var B1:INTEGER;
 Bin,BinDigit:string;
begin
 BinDigit:='01';
 Bin:='';
 repeat
  B1:=DEC mod 2;
  DEC:=DEC div 2;
  Bin:=CONCAT(BinDigit[B1+1],Bin);
 until DEC<1;
 Dec2Bin:=Bin;
end;

function Hex2Dec(Hex:string):LongInt;
var
T1,T2,Dec:LongInt;
Error:Boolean;
begin
 Error:=False;
 T1:=0;T2:=0;DEC:=0;
 for T1:=1 to LENGTH(Hex) do
  begin
   T2:=Length(Hex)-T1;
   case Hex[T1] of
   '0' : DEC:=DEC+0;
   '1' : DEC:=DEC+Power(16,T2);
   '2' : DEC:=DEC+2*Power(16,T2);
   '3' : DEC:=DEC+3*Power(16,T2);
   '4' : DEC:=DEC+4*Power(16,T2);
   '5' : DEC:=DEC+5*Power(16,T2);
   '6' : DEC:=DEC+6*Power(16,T2);
   '7' : DEC:=DEC+7*Power(16,T2);
   '8' : DEC:=DEC+8*Power(16,T2);
   '9' : DEC:=DEC+9*Power(16,T2);
   'A','a' : DEC:=DEC+10*Power(16,T2);
   'B','b' : DEC:=DEC+11*Power(16,T2);
   'C','c' : DEC:=DEC+12*Power(16,T2);
   'D','d' : DEC:=DEC+13*Power(16,T2);
   'E','e' : DEC:=DEC+14*Power(16,T2);
   'F','f' : DEC:=DEC+15*Power(16,T2);
   else Error:=True;
   end;
 end;
 Hex2Dec:=Dec;
 if Error then Hex2Dec:=0;
end;

function Oct2Dec(Oct:string):LongInt;

var  T1,T2,Dec  :    LongInt;
   Error    :    Boolean;

begin
 Error:=False;
 T1:=0;T2:=0;DEC:=0;
 for T1:=1 to LENGTH(Oct) do
 begin
  T2:=Length(Oct)-T1;
  case Oct[T1] of
  '0' : DEC:=DEC+0;
  '1' : DEC:=DEC+Power(8,T2);
  '2' : DEC:=DEC+2*Power(8,T2);
  '3' : DEC:=DEC+3*Power(8,T2);
  '4' : DEC:=DEC+4*Power(8,T2);
  '5' : DEC:=DEC+5*Power(8,T2);
  '6' : DEC:=DEC+6*Power(8,T2);
  '7' : DEC:=DEC+7*Power(8,T2);
  else Error:=True;
  end;
 end;
 Oct2Dec:=Dec;
 if Error then Oct2Dec:=0;
end;

function Bin2Dec(BIN:string):LongInt;

var  T1,T2,Dec  :    LongInt;
   Error    :    Boolean;

begin
 Error:=False;
 T1:=0;T2:=0;DEC:=0;
 for T1:=1 to LENGTH(BIN) do
 begin
  T2:=Length(BIN)-T1;
  case BIN[T1] of
  '1' : DEC:=DEC+Power(2,T2);
  '0' : DEC:=DEC+0;
  else Error:=True;
  end;
 end;
 Bin2Dec:=Dec;
 if Error then Bin2Dec:=0;
end;

function Dec2Hex(DEC:LONGINT):string;

var H1:INTEGER;
  Hex,HexDigit:string;

begin
 HexDigit:='0123456789ABCDEF';
 HEX:='';
 repeat
  H1:=DEC mod 16;
  DEC:=DEC div 16;
  Hex:=CONCAT(Hexdigit[H1+1],Hex);
 until DEC<1;
 Dec2Hex:=Hex;
end;

function Dec2Oct(DEC:LONGINT):string;

var O1:INTEGER;
  Oct,OctDigit:string;

begin
 OctDigit:='01234567';
 Oct:='';
 repeat
  O1:=DEC mod 8;
  DEC:=DEC div 8;
  Oct:=CONCAT(Octdigit[O1+1],Oct);
 until DEC<1;
 Dec2Oct:=Oct;
end;

function Hex2Bin(Hex:string):string;

begin
 Hex2Bin:=Dec2Bin(Hex2Dec(Hex));
end;

function Bin2Hex(Bin:string):string;

begin
 Bin2Hex:=Dec2Hex(Bin2Dec(Bin));
end;

end.

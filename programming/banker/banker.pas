{ 
  Author: Denys Lemeshko  
  Date: May 21, 2007, 15:15  
  Instructor: Dmytro Sinepolskyi  
  Subject: Fundamentals of Operating Systems and Networks  
  Language: Pascal  
}

uses crt;

const
     ProcNum = 6;
     ResNum = 4;

(********************************************************************)

type
    ResMatr = array[1..ProcNum, 1..ResNum] of shortint; {C,R}
    ResVect = array[1..ResNum] of shortint; {A}

    RunProcVect = array[1..ProcNum] of Boolean;

function banker(ProcCount : integer; var C, R: ResMatr; var A: ResVect) : boolean;
var
   i, j, q : integer;
   Work : ResVect;
   Finish : array[1..ProcNum] of Boolean;
   Safe : Boolean;
begin
     for i := 1 to ProcNum do
         Finish[i] := False;

     Work := A;

     Safe := False;
     while not Safe do
     begin
          Safe := True;
          for i := 1 to ProcCount do
          begin
               if not Finish[i] then
               begin
                    q := 0;
                    for j := 1 to ResNum do
                        if R[i, j] <= Work[j] then
                           Inc(q);

                    if q = ResNum then
                    begin
                         for j := 1 to ResNum do
                             Work[j] := Work[j] + C[i, j];
                         Finish[i] := True;
                         Safe := False;
                    end;
               end;
          end;
     end;

     banker := True;
     for i := 1 to ProcCount do
         if not Finish[i] then
         begin
              banker := False;
              Break;
         end;
end;

(********************************************************************)

type
    TProg = record
          Name : char;
          IP : integer;
          Instr : string;
          Res : string;
    end;

const
     Procs : array[1..ProcNum] of TProg = (
           (Name : 'A'; IP : 1; Instr : 'S___R___P_______prs';     Res : ''),
           (Name : 'B'; IP : 1; Instr : 'R____S____Q____P___pqsr'; Res : ''),
           (Name : 'C'; IP : 1; Instr : 'S__________s';            Res : ''),
           (Name : 'D'; IP : 1; Instr : 'Q____S___P_____psq';      Res : ''),
           (Name : 'E'; IP : 1; Instr : 'S__P__________ps';        Res : ''),
           (Name : 'F'; IP : 1; Instr : 'S____________s';          Res : '')
     );
     Resources : string = 'PQRS';

function Res2Num(res: char): integer;
begin
     Res2Num := Ord(res) - Ord('P') + 1;
end;

function RunBanker : boolean;
var
   C, R : ResMatr;
   A : ResVect;
   i, proc, j:integer;
   x : char;

begin
     proc := 0;
     for i := 1 to ProcNum do
         if Procs[i].IP <= Length(Procs[i].Instr) then begin
            inc(proc);
            {C}
            for j := 1 to ResNum do c[proc,j] := 0;
            for j := 1 to length(Procs[i].Res) do
                inc(C[proc, Res2Num(Procs[i].Res[j])]);
            {R}
            for j := 1 to ResNum do r[proc,j] := 0;
            for j := Procs[i].IP to Length(Procs[i].Instr) do begin
                x := Procs[i].Instr[j];
                if x in ['A'..'Z'] then
                   Inc(R[proc, Res2Num(x)]);
            end;
         end;
         {A}
         for j:=1 to ResNum do
         A[j]:=0;
         for j:=1 to length(Resources) do
         Inc(A[Res2Num(Resources[j])]);
         RunBanker := banker(proc, C, R, A);
end;

function ExecuteInstraction(Instr: char; proc : integer): boolean;
var
   i, j : integer;
   BakPRes, BakRes: string;
   BakIP : integer;
begin
     i := Pos(Upcase(Instr), Resources);
     j := Pos(Upcase(Instr), Procs[proc].Res);
     case Instr of
          '_' : begin
                 Inc(Procs[proc].IP);
                 ExecuteInstraction := true;
          end;
          'a'..'z' : begin
                   if j <> 0 then begin
                     Delete(Procs[proc].Res, j, 1);
                     Inc(Procs[proc].IP);
                     Resources := Resources + Upcase(Instr);
                   end else
                     ExecuteInstraction := false;
          end;
          'A'..'Z' : begin
              if i <> 0 then begin
                 BakPRes := Procs[proc].Res;
                 BakRes := Resources;
                 BakIP := Procs[proc].IP;
                 Inc(Procs[proc].IP);
                 Delete(Resources, i, 1);
                 Procs[proc].Res := Procs[proc].Res + Upcase(Instr);
                 if RunBanker then
                    ExecuteInstraction := true
                 else begin
                    Procs[proc].Res := BakPRes;
                    Resources := BakRes;
                    Procs[proc].IP := BakIP;
                    ExecuteInstraction := false;
                 end;
              end else
                 ExecuteInstraction := false;
          end;
     end;
end;

(********************************************************************)

var
    A, X, R : boolean;
    i : integer;
BEGIN
     ClrScr;
     writeln('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
     repeat
           writeln('****');
           A := false;
           X := false;
           for i := 1 to ProcNum do begin
               if Procs[i].IP <= Length(Procs[i].Instr) then begin
                  A := true;
                  R := ExecuteInstraction(Procs[i].Instr[Procs[i].IP], i);
                  if (Procs[i].Instr[Procs[i].IP] <> '_') and R then
                     writeln('Process ', Procs[i].Name,
                          ' executed instruction ', Procs[i].Instr[Procs[i].IP],
                          ' with result ', R,
                          ' and resources ', Procs[i].Res);
                  if R then begin
                     X := true;
                  end;
               end;
           end;
     until not X;
     if A then
        writeln('Deadlock detected')
     else
        writeln('All processes completed');
END.

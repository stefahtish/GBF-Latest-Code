table 50597 "Sample Test Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Code[20])
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Sample Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Products";
        }
        field(3; Results; Code[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Specification; Code[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Remarks; Code[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Done By"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sample Test Header"."Done By No." WHERE("Sample Code"=FIELD("Sample ID")));
        }
        field(7; "Checked By"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sample Test Header"."Checked By No." WHERE("Sample Code"=FIELD("Sample ID")));
        }
        field(8; "Sample ID"; Code[100])
        {
            Caption = 'Sample Code';
            DataClassification = ToBeClassified;
        }
        field(9; Lab; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Lab section to test"));
        }
        field(10; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Test; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Test Setup".Test where(Lab=field(Lab));
        }
        field(12; "Last No. Used"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Submission DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Cannot be done"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Comment; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "To be tested"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Sample ID", "Entry No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Sample ID")
        {
        }
    }
    trigger OnInsert()
    var
        NextNo: Code[50];
        SampleReception: Record "Sample Reception Header";
    begin
        "Line No.":=GetNextLineNo();
        SampleReception.Get("Entry No.");
        "Entry Date":=SampleReception.Date;
        "Sample Name":=SampleReception."Sample Name";
        "Sample ID":=SampleReception.SampleID;
    // "Sample ID" := format(Date2DMY("Entry Date", 3)) + format("Entry Date", 0, '<Month,2>') + GetNextNo;
    end;
    procedure GetNextLineNo(): Integer var
        TestLines: Record "Sample Test Lines";
    begin
        TestLines.RESET;
        TestLines.SETRANGE(TestLines."Entry No.", "Entry No.");
        TestLines.SetAscending("Line No.", true);
        IF TestLines.FINDLAST THEN EXIT(TestLines."Line No." + 1)
        ELSE
            EXIT(1);
    END;
    local procedure GetNextNo(): Code[50]var
        SampleReceptionRec: Record "Sample Test Lines";
        StartMonth: Date;
        EndMonth: Date;
        NextNo: Code[50];
        Count: Integer;
        LabProducts: Record "Laboratory Products";
        LastNoCode: code[50];
        LastNo: code[50];
    begin
        Count:=0;
        StartMonth:=DMY2DATE(1, DATE2DMY("Entry Date", 2), DATE2DMY("Entry Date", 3));
        EndMonth:=CALCDATE('<1M>', StartMonth);
        SampleReceptionRec.Reset();
        SampleReceptionRec.SetRange("Entry No.", "Entry No.");
        SampleReceptionRec.SetRange("Sample Name", "Sample Name");
        SampleReceptionRec.SetRange("Entry Date", StartMonth, EndMonth);
        if SampleReceptionRec.FindLast()then begin
            NextNo:=CopyStr(SampleReceptionRec."Sample ID", 7, 4);
        end
        else
        begin
            SampleReceptionRec.Reset();
            SampleReceptionRec.SetRange("Entry Date", StartMonth, EndMonth);
            SampleReceptionRec.SetAscending("Sample ID", true);
            if SampleReceptionRec.FindLast()then begin
                LastNoCode:=CopyStr(SampleReceptionRec."Sample ID", 7, 4);
                // Message('%1', LastNoCode);
                NextNo:=format(IncStr(LastNoCode));
            end
            else
                NextNo:='0001';
        end;
        exit(NextNo);
    end;
}

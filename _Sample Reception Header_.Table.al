table 50587 "Sample Reception Header"
{
    Caption = 'Sample Reception and registration';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Code[20])
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Entry No." <> '' THEN NoSeriesMgt.TestManual(LabSetup."Sample Reception  Nos");
            end;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Testing Time"; Time)
        {
            Caption = 'Time';
            DataClassification = ToBeClassified;
        }
        field(4; Client; Text[100])
        {
            Caption = 'Client';
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger Onvalidate()
            var
                Cust: Record Customer;
            begin
                Cust.Reset();
                Cust.SetRange("No.", Client);
                if Cust.FindFirst()then "Client Name":=Cust.Name;
            end;
        }
        field(5; "Sampling officer"; Text[100])
        {
            Caption = 'Sampling officer';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(6; Branch; Code[50])
        {
            Caption = 'Branch';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));
        }
        field(7; County; Code[50])
        {
            Caption = 'County';
            DataClassification = ToBeClassified;
            TableRelation = CountyNew."County Code";

            trigger OnValidate()
            var
                cty: Record CountyNew;
            begin
                cty.SetRange("County Code", County);
                if cty.FindFirst()then "County Name":=cty.County;
            end;
        }
        field(8; Location; Code[50])
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;
            TableRelation = Locations."Location Code" where("Sub-County Code"=field(Subcounty));
        }
        field(9; Market; Code[50])
        {
            Caption = 'Market';
            DataClassification = ToBeClassified;
        }
        field(10; "Lab section to test"; Code[100])
        {
            Caption = 'Lab section to test';
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Lab section to test"));
        }
        field(11; "Entry officer"; Text[100])
        {
            Caption = 'Entry officer';
            DataClassification = ToBeClassified;
        }
        field(12; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; SampleID; Code[50])
        {
            Caption = 'Sample Code';
            DataClassification = ToBeClassified;
        }
        field(14; "Sent to Lab"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Sampling officer No."; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get("Sampling officer No.")then "Sampling officer":=Employee."First Name" + ' ' + Employee."Last Name";
            end;
        }
        field(16; "County Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Sub-County Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Subcounty; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sub-County"."Sub-County Code" where("County Code"=field(County));

            trigger OnValidate()
            var
                subc: Record "Sub-County";
            begin
                subc.SetRange("Sub-County Code", Subcounty);
                if subc.FindFirst()then "Sub-County Name":=subc.Name;
            end;
        }
        field(19; "Sample Category"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Nature of Testing"));
        }
        field(20; "Sample Source"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Sample Source"));
        }
        field(21; Description; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Human Resource Unit of Measure";
        }
        field(24; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Last No. Used"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Sample Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Products";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                InsertPossibleTests();
            end;
        }
        field(27; "COA No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Sample Type"; Option)
        {
            OptionMembers = " ", "From Schedule", Client;
            OptionCaption = ' ,From Schedule,Client';
            DataClassification = ToBeClassified;
        }
        field(29; "Schedule No."; Code[10])
        {
            TableRelation = "Lab Annual Testing Schedule" where(Tested=const(false));
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            var
                Schedule: Record "Lab Annual Testing Schedule";
                Allocation: Record "Testing Resorce Allocation";
                AllocationLines: Record "Testing Target Dairy Product";
                ReceptionLines: Record "Sample Test Lines";
                LabSetup: Record "Laboratory Products";
            begin
                Schedule.SetRange(Code, "Schedule No.");
                if Schedule.Find('-')then begin
                    Branch:=Schedule.Branch;
                    County:=Schedule.County;
                    "Cluster Option":=Schedule."Cluster Option";
                    Cluster:=Schedule.Cluster;
                    "County Name":=Schedule."County Name";
                    Location:=Schedule.Location;
                    Market:=Schedule.Market;
                    "Sample Category":=Schedule."Nature of Testing";
                    Allocation.SetRange("Annual Schedule", "Schedule No.");
                    if Allocation.FindFirst()then begin
                        AllocationLines.SetRange(AllocationNo, Allocation.AllocationNo);
                        if AllocationLines.Find('-')then begin
                            repeat LabSetup.SetRange(Product, AllocationLines."Target dairy product");
                                if LabSetup.Find('-')then repeat ReceptionLines.Init();
                                        ReceptionLines."Entry No.":="Entry No.";
                                        ReceptionLines."Sample ID":=SampleID;
                                        ReceptionLines."Sample Name":=LabSetup.Product;
                                        ReceptionLines.Lab:=LabSetup."Lab Section";
                                        ReceptionLines."Line No.":=ReceptionLines.GetNextLineNo();
                                        ReceptionLines.Insert(true);
                                    until LabSetup.Next() = 0;
                            until AllocationLines.Next() = 0;
                        end;
                    end;
                end;
            end;
        }
        field(30; "Name of Sampled Outlet"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "KDB License number"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Product Source"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Sample Retention Conditions"));
        }
        field(33; "Retention Required"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ", Yes, No;
        }
        field(34; "Manufacture Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Client Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Sample Retention Period"; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Sample Disposal Date":=CalcDate("Sample Retention Period", Today)end;
        }
        field(38; "Sample Disposal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(39; Disposed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(40; Cluster; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cluster Regions";
        }
        field(41; "Cluster Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Cluster;
            OptionCaption = ' ,Cluster';
        }
        field(42; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Entry Officer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Sampling Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Batch Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Single Sample", "Multiple Samples";
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        NextNo: Code[50];
    begin
        if not LabSetup.Get()then begin
            LabSetup.Init();
            LabSetup.Insert();
        end;
        Date:=Today;
        "Testing Time":=Time;
        // LabSetup.TESTFIELD("COA Nos");
        //LabSetup.TestField("Sample ID");
        // NoSeriesMgt.InitSeries(Labsetup."COA Nos", xRec."No. Series", TODAY, "COA No.", "No. Series");
        SampleID:=format(Date2DMY(Today, 3)) + format(Date2DMY(Today, 2)) + GetNextNo;
        NoSeriesMgt.InitSeries(Labsetup."Sample Reception  Nos", xRec."No. Series", TODAY, "Entry No.", "No. Series");
        IF UserSetup.GET(USERID)THEN BEGIN
            UserSetup.TESTFIELD("Employee No.");
            IF Employee.GET(UserSetup."Employee No.")THEN BEGIN
                "Entry Officer No.":=Employee."No.";
                "Entry officer":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            END;
        END;
    end;
    local procedure GetNextNo(): Code[50]var
        SampleReceptionRec: Record "Sample Reception Header";
        StartMonth: Date;
        EndMonth: Date;
        NextNo: Code[50];
    begin
        StartMonth:=DMY2DATE(1, DATE2DMY(Today, 2), DATE2DMY(Today, 3));
        EndMonth:=CALCDATE('<1M>', StartMonth);
        SampleReceptionRec.Reset();
        SampleReceptionRec.SetRange(Date, StartMonth, EndMonth);
        if not SampleReceptionRec.FindLast()then begin
            NextNo:=getLastNo();
            "Last No. Used":=NextNo;
            exit(NextNo);
        end
        else
        begin
            NextNo:=IncStr(SampleReceptionRec."Last No. Used");
            "Last No. Used":=NextNo;
            exit(NextNo);
        end;
    end;
    var LabSetup: Record "Lab Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    Employee: Record Employee;
    procedure MarkAnnualSchedule()
    var
        AnnualSchedule: Record "Lab Annual Testing Schedule";
    begin
        AnnualSchedule.SetRange(Code, "Schedule No.");
        if AnnualSchedule.FindFirst()then begin
            AnnualSchedule.Tested:=true;
            AnnualSchedule.Modify();
        end;
    end;
    procedure getLastNo(): Code[50]var
        SampleTests: Record "Sample Test Lines";
        LastNoCode: code[50];
        NextNo: Code[50];
    begin
        SampleTests.Reset();
        if SampleTests.FindLast()then begin
            LastNoCode:=CopyStr(SampleTests."Sample ID", 7, 4);
            // Message('%1', LastNoCode);
            NextNo:=format(IncStr(LastNoCode));
        end;
    end;
    procedure InsertPossibleTests()
    var
        SampleTests: Record "Sample Test Lines";
        PossibleTest: Record "Products Test Setup2";
        LineNo: Integer;
    begin
        SampleTests.Reset();
        SampleTests.SetRange("Entry No.", "Entry No.");
        if SampleTests.Find('-')then SampleTests.DeleteAll();
        LineNo:=1;
        PossibleTest.Reset();
        PossibleTest.SetRange(Product, "Sample Name");
        if PossibleTest.Find('-')then repeat PossibleTest.CalcFields(Lab);
                SampleTests.Init();
                SampleTests."Sample ID":=SampleID;
                SampleTests."Entry No.":="Entry No.";
                SampleTests."Sample Name":="Sample Name";
                SampleTests.Test:=PossibleTest.Test;
                SampleTests.Lab:=PossibleTest.Lab;
                SampleTests."Line No.":=LineNo;
                SampleTests.Insert();
                LineNo+=1;
            until PossibleTest.Next() = 0;
    end;
}

table 50578 "Sample Test Header"
{
    Caption = 'Sample Test Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Test No."; Code[20])
        {
            Caption = 'Test No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Test No." <> '' THEN NoSeriesMgt.TestManual(Labsetup."Test No.");
            end;
        }
        field(2; "Done By"; Code[100])
        {
            Caption = 'Done By';
            DataClassification = ToBeClassified;
        }
        field(3; "Checked By"; Code[100])
        {
            Caption = 'Checked By';
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(5; Time; Time)
        {
            Caption = 'Time';
            DataClassification = ToBeClassified;
        }
        field(6; Submitted; Boolean)
        {
            Caption = 'Submitted';
            DataClassification = ToBeClassified;
        }
        field(7; "Lab section"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Lab section to test"));
        }
        field(8; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Test;enum LabTests)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "TestForm";enum LabTestForms)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Test to be conducted"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Test Setup";

            trigger OnValidate()
            var
                TestSetup: Record "Test Setup";
            begin
                TestSetup.SetRange(test, "Test to be conducted");
                if TestSetup.Find('-')then TestForm:=TestSetup."Test Form";
            end;
        }
        field(12; Phosphatase; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; MilkPreservation; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Butterfat; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; PreliminaryTest; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; AntibioticResidue; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; Viscosity; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Density; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Brix; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Organoleptic; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; FreeFatty; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Moisture; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; Coliform; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; StaphAurea; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; Ecoli; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Salmonella; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; TotalViable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; Others; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; Moulds; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; Conventional; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; YeastMould; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(32; Resazurin; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(33; MoistureAnalyzer; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; Aflatoxin; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Sample Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Sample Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(37; Disposed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; Remarks; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Done By No."; Code[100])
        {
            Caption = 'Done By';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                Emp.Reset();
                Emp.SetRange("No.", "Done By No.");
                if Emp.FindFirst()then "Done By":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(40; "Checked By No."; Code[100])
        {
            Caption = 'Checked By';
            DataClassification = ToBeClassified;
        }
        field(41; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Sample Reception No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Test Option"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Freezing Point"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(45; AcidityA; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(46; AcidityB; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Test No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if not Labsetup.Get()then begin
            Labsetup.Init();
            Labsetup.Insert();
        end;
        Date:=Today;
        Time:=Time;
        Labsetup.TESTFIELD("Test No.");
        NoSeriesMgt.InitSeries(Labsetup."Test No.", xRec."No. Series", TODAY, "Test No.", "No. Series");
    // IF UserSetup.GET(USERID) THEN BEGIN
    //     UserSetup.TESTFIELD("Employee No.");
    //     IF Employee.GET(UserSetup."Employee No.") THEN BEGIN
    //         // "Testing officer No." := Employee."No.";
    //         "Done By" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
    //     END;
    // END;
    end;
    trigger OnDelete()
    var
        TestLines: Record "Sample Test";
    begin
        TestLines.Reset();
        TestLines.SetRange("Test No.", "Test No.");
        if TestLines.FindSet()then TestLines.DeleteAll();
    end;
    var Employee: Record Employee;
    UserSetup: Record "User Setup";
    Labsetup: Record "Lab Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}

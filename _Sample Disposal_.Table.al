table 50608 "Sample Disposal"
{
    Caption = 'Sample Disposal';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "No." <> '' THEN NoSeriesMgt.TestManual(Labsetup."Sample Disposal Nos");
            end;
        }
        field(2; "Sample Reception No."; Code[20])
        {
            Caption = 'Sample Reception No.';
            DataClassification = ToBeClassified;
            TableRelation = "Sample Reception Header";

            trigger OnValidate()
            var
                RecHeader: Record "Sample Disposal";
                RecLines: Record "Sample Disposal Lines";
                RecLines2: Record "Sample Disposal Lines";
                SampleLines: Record "Sample Test Lines";
                LineNo: integer;
            begin
                RecHeader.reset;
                RecHeader.SetFilter("No.", '<>%1', "No.");
                RecHeader.SetRange("Sample Reception No.", "Sample Reception No.");
                RecHeader.SetRange(Disposed, true);
                if RecHeader.FindFirst()then Error('This sample is already disposed');
                RecHeader.reset;
                RecHeader.SetFilter("No.", '<>%1', "No.");
                RecHeader.SetRange("Sample Reception No.", "Sample Reception No.");
                RecHeader.SetRange(Disposed, false);
                if RecHeader.FindFirst()then Error('This sample is selected for disposal in another entry');
                RecLines2.Reset();
                RecLines2.SetRange("No.", "No.");
                if RecLines2.Find('-')then RecLines2.DeleteAll();
                LineNo:=1000;
                SampleLines.Reset();
                SampleLines.SetRange("Entry No.", "Sample Reception No.");
                if SampleLines.Find('-')then repeat RecLines.Init();
                        RecLines."Sample Code":=SampleLines."Sample ID";
                        RecLines."Sample Name":=SampleLines."Sample Name";
                        RecLines."No.":="No.";
                        RecLines."Line No.":=LineNo;
                        RecLines.Insert();
                        LineNo+=1000;
                    until SampleLines.Next() = 0;
            end;
        }
        field(3; "User ID"; Code[100])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(4; "Disposal Date"; Date)
        {
            Caption = 'Disposal Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Disposal Time"; Time)
        {
            Caption = 'Disposal Time';
            DataClassification = ToBeClassified;
        }
        field(6; "No. series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Disposed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        LabSetup.Get();
        LabSetup.TestField("Sample Disposal Nos");
        if not Labsetup.Get()then begin
            Labsetup.Init();
            Labsetup.Insert();
        end;
        "Disposal Date":=Today;
        "Disposal Time":=Time;
        Labsetup.TESTFIELD("Test No.");
        NoSeriesMgt.InitSeries(Labsetup."Sample Disposal Nos", xRec."No. Series", TODAY, "No.", "No. Series");
        IF UserSetup.GET(USERID)THEN BEGIN
            UserSetup.TESTFIELD("Employee No.");
            IF Employee.GET(UserSetup."Employee No.")THEN BEGIN
                "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                "Employee No.":=Employee."No.";
            END;
        END;
    end;
    var Employee: Record Employee;
    UserSetup: Record "User Setup";
    LabSetup: Record "Lab Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}

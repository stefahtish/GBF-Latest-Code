table 50720 "Committee Members Setup"
{
    Caption = 'Committee Members Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Members; Integer)
        {
            Caption = 'Members';
            CalcFormula = Count("Committee Member Lines" WHERE("Batch No."=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(5; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = CustomerContent;
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
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
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Committee Nos");
            NoSeriesMgt.InitSeries(HRSetup."Committee Nos", xRec."No. series", 0D, "No.", "No. series");
        end;
        "Date Created":=Today;
        "Created By":=UserId;
    end;
    var HRSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}

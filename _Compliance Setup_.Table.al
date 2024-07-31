table 50626 "Compliance Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Compliance Req Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(3; "App Enterprise No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(4; "App Dairy managers No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(5; "Enforcement Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6; "Attachments Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "License/Permit App No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(8; "Monthly Returns No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(9; "License No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(10; "License Renewal No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(11; "Compliance Notification Time"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Notes"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Body"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "License Background image"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(15; "Enforce Workflow"; Boolean)
        {
            Caption = 'Enforce Workflow on registrations';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    var myInt: Integer;
    trigger OnInsert()
    begin
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}

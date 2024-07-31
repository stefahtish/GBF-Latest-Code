table 50399 "Trustee Payment Reversal"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.Get;
                    HRSetup.TestField("Trustee Reversal Nos");
                    NoSeries.TestManual(HRSetup."Trustee Reversal Nos");
                end;
            end;
        }
        field(2; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open, "Pending Approval", Released, Rejected;
        }
        field(5; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,By Entry No.,By Document No.';
            OptionMembers = " ", "By Entry No", "By Document No";
        }
        field(8; "Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(9; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Posted Date-Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Trustee Reversal Nos");
            NoSeries.InitSeries(HRSetup."Trustee Reversal Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Created Date":=CurrentDateTime;
        "User ID":=UserId;
    end;
    var NoSeries: Codeunit NoSeriesManagement;
    HRSetup: Record "Human Resources Setup";
}

table 50659 Facilitators
{
    DataClassification = ToBeClassified;
    LookupPageId = Facilitators;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Name / Description"; Text[100])
        {
            Caption = 'Name / Decription';
        }
        field(4; "Area"; code[30])
        {
            Caption = 'Area';
            TableRelation = Destination;
        }
        field(5; "No. of days"; Integer)
        {
            Caption = 'No. of days';

            trigger OnValidate()
            begin
                UpdateAmount();
            end;
        }
        field(6; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rates';

            trigger OnValidate()
            begin
                UpdateAmount();
            end;
        }
        field(7; "Transport"; Option)
        {
            Caption = 'Transport';
            ObsoleteState = Removed;
            DataClassification = ToBeClassified;
            OptionMembers = " ", "Personal Vehicle", Transport, "Board Vehicle";
            OptionCaption = ' ,Personal Vehicle,Transport,Board Vehicle';
        }
        field(8; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(10; "No of Facilitator"; Integer)
        {
            Caption = 'No of Facilitator';

            trigger OnValidate()
            begin
                UpdateAmount();
            end;
        }
        field(11; "Transport."; Decimal)
        {
            Caption = 'Transport Amount';

            trigger OnValidate()
            begin
                UpdateAmount();
            end;
        }
    }
    keys
    {
        key(PK; "No.", "Line No.")
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
    local procedure UpdateAmount()
    begin
        if("No. of days" <> 0) and ("Daily Rate" <> 0) and ("No of Facilitator" <> 0)then Amount:=("No. of days" * "Daily Rate" * "No of Facilitator") + "Transport.";
    end;
}

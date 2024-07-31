table 50158 "Apportion Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CashSetup.Get;
                    CashSetup.TestField("Apportionment Nos");
                    NoSeries.TestManual(CashSetup."Apportionment Nos");
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
        field(8; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Apportion Lines".Amount WHERE("No."=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
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
            CashSetup.Get;
            CashSetup.TestField("Apportionment Nos");
            NoSeries.InitSeries(CashSetup."Apportionment Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Created Date":=CurrentDateTime;
        "User ID":=UserId;
    end;
    var CashSetup: Record "Cash Management Setups";
    NoSeries: Codeunit NoSeriesManagement;
}

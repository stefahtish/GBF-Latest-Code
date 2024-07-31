table 50603 "Cess and Levy setup"
{
    Caption = 'Cess and Levy setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Levy rate"; Decimal)
        {
            Caption = 'Levy rate';
            DataClassification = ToBeClassified;
        }
        field(3; "Cess rate"; Decimal)
        {
            Caption = 'Cess rate';
            DataClassification = ToBeClassified;
        }
        field(4; "Levy Penalty rate- Initial"; Decimal)
        {
            Caption = 'Levy Penalty rate- Initial';
            DataClassification = ToBeClassified;
        }
        field(5; "Levy Penalty rate- subsequent"; Decimal)
        {
            Caption = 'Levy Penalty rate- subsequent';
            DataClassification = ToBeClassified;
        }
        field(6; "Cess Penalty rate- Initial"; Decimal)
        {
            Caption = 'Cess Penalty rate- Initial';
            DataClassification = ToBeClassified;
        }
        field(7; "Cess Penalty rate- subsequent"; Decimal)
        {
            Caption = 'Cess Penalty rate- subsequent';
            DataClassification = ToBeClassified;
        }
        field(8; "Cess Receivables"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(9; "Levy Receivables"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(10; "Cess Penalty Receivables"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(11; "Levy Penalty Receivables"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(12; "Percentage of cost"; Decimal)
        {
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
}

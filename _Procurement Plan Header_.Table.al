table 50198 "Procurement Plan Header"
{
    Caption = 'Procurement Plan Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Name; Code[10])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(4; "Total Budget Allocation"; Decimal)
        {
            Caption = 'Total Budget Allocation';
            DataClassification = ToBeClassified;
        }
        field(5; Status;enum "Approval Status-custom")
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }
}

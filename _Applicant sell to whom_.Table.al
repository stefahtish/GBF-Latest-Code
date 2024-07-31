table 50621 "Applicant sell to whom"
{
    DataClassification = ToBeClassified;
    ObsoleteState = removed;

    fields
    {
        field(1; "Applicant No"; Code[50])
        {
            Caption = 'Applicant No';
            DataClassification = ToBeClassified;
        }
        field(2; Outlet; Code[50])
        {
            Caption = 'Name of Premise';
            DataClassification = ToBeClassified;
        }
        field(3; Product; Text[100])
        {
            Caption = 'Product';
            DataClassification = ToBeClassified;
        }
        field(4; "Sell to Whom"; Code[50])
        {
            Caption = 'Area of sale';
            TableRelation = "Sale to whom Setup";
        }
    }
    keys
    {
        key(PK; "Applicant No", Outlet, Product, "Sell to Whom")
        {
            Clustered = true;
        }
    }
}

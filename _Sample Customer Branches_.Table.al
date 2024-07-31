table 50598 "Sample Customer Branches"
{
    Caption = 'Sample Customer Brands';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Customer No"; Code[20])
        {
            Caption = 'Customer No';
            DataClassification = ToBeClassified;
        }
        field(3; Branch; Code[20])
        {
            Caption = 'Branch';
            DataClassification = ToBeClassified;
        // TableRelation = "Sample Brand";
        // trigger OnValidate()
        // var
        //     Brand: Record "Sample Brand";
        // begin
        //     Brand.Get(Branch);
        //     if Brand.Branch = Branch then begin
        //         "Branch name" := Brand."Branch name";
        //     end;
        // end;
        }
        field(4; "Branch name"; Code[20])
        {
            Caption = 'Branch name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", "Customer No", Branch)
        {
            Clustered = true;
        }
    }
}

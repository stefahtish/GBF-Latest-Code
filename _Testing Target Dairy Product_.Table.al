table 50566 "Testing Target Dairy Product"
{
    Caption = 'Testing Resource allocation target products';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; AllocationNo; Code[20])
        {
            Caption = 'AllocationNo';
            DataClassification = ToBeClassified;
        }
        field(2; "Target dairy product"; Text[50])
        {
            Caption = 'Target dairy product';
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Products";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                Lab: Record "Laboratory Products";
            begin
                if Lab.Get("Target dairy product")then Description:=lab.SubCategory;
            end;
        }
        field(3; "Description"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; AllocationNo, "Target dairy product")
        {
            Clustered = true;
        }
    }
}

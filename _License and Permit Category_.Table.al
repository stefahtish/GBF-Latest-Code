table 50557 "License and Permit Category"
{
    fields
    {
        field(1; "License/Permit Category"; Code[200])
        {
            NotBlank = true;
            Caption = 'Permit category';
        }
        field(2; "Description"; Text[2048])
        {
        }
        field(3; "Annual fees(Ksh)"; Decimal)
        {
            trigger OnValidate()
            begin
                Total:="Annual fees(Ksh)" + "Application fees(Ksh)";
            end;
        }
        field(4; "Application fees(Ksh)"; Decimal)
        {
            trigger OnValidate()
            begin
                Total:="Annual fees(Ksh)" + "Application fees(Ksh)";
            end;
        }
        field(5; Total; Decimal)
        {
        }
        field(6; "License/Permit"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = License, Permit;
        }
        field(7; "Receivables G/L Account"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(8; "Import or Export"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "License Code"; Code[4])
        {
            NotBlank = true;
        }
    }
    keys
    {
        key(Key1; "License/Permit", "License/Permit Category")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "License/Permit Category", Description)
        {
        }
    }
    var PostCode: Record "Post Code";
}

table 50643 "Strategic Issue"
{
    Caption = 'Strategic Issue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[1500])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "KRA Code"; Code[20])
        {
            Caption = 'KRA Code';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code, "KRA Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Description)
        {
        }
    }
}

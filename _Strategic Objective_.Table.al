table 50644 "Strategic Objective"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[30])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[1500])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "KRA Code"; Code[30])
        {
            Caption = 'KRA Code';
            DataClassification = ToBeClassified;
        }
        field(4; "Issue Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "KRA Code", "Issue Code", Code)
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

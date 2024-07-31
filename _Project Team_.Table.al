table 50664 "Project Team"
{
    fields
    {
        field(1; "Project No"; Code[50])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Project Header";
            Caption = 'Contract No';
        }
        field(2; "Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "ID No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Company; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Project No", "ID No", "Full Name")
        {
            Clustered = true;
        }
        key(key2; "ID NO")
        {
            UNIQUE = TRUE;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Full Name", "ID No", Company)
        {
        }
    }
}

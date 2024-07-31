table 50574 "Enforcement Lines"
{
    Caption = 'Enforcement Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; Designation; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Witnesses, Items, Reasons;
        }
        field(5; Instituition; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Contact; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Huduma Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", Name)
        {
            Clustered = true;
        }
    }
}

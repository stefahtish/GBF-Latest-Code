table 50383 "Email Header"
{
    fields
    {
        field(1; No; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Created By"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Last Modified By"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Total Items"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Total Sent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Complete';
            OptionMembers = Pending, Complete;
        }
    }
    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

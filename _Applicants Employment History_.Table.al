table 50310 "Applicants Employment History"
{
    fields
    {
        field(1; "Application No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Institution/Company"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(4; From; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "To"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Position; Code[60])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Application No", "Line No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

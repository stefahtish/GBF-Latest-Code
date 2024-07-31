table 50262 "Applicants Shortlist"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "First Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Middle Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Last Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = Single, Married, Separated, Divorced, "Widow(er)", Other;
        }
        field(7; "ID Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Citizenship; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Total Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Applicant Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Internal,External';
            OptionMembers = Internal, External;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

table 50668 ProjectManagementSponsors
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(6; "Project No."; Code[50])
        {
            DataClassification = tobeclassified;
        }
        field(2; FullName; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Contact; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; EmailAddress; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; SponsorType; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Employee,Trustee,Other';
            OptionMembers = Employee, Trustee, Other;
        }
    }
    keys
    {
        key(Key1; "No.", "Project No.")
        {
            Clustered = true;
        }
    }
    var myInt: Integer;
    trigger OnInsert()
    begin
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}

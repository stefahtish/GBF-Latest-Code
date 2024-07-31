table 50679 ProjectDisseminationPlan
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Project No."; Code[50])
        {
            NotBlank = false;
        }
        field(3; DisseminationCode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Content; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Mode of Dissemination"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Mode of Marketing"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Target Group"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; MyField)
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

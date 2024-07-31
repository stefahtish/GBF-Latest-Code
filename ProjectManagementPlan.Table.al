table 50677 ProjectManagementPlan
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; PersonelNumber; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Project No."; Code[50])
        {
            NotBlank = false;
        }
        field(3; Abstractcode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Content; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Project Personel"; Text[50])
        {
            DataClassification = ToBeClassified;
        // Tablerelation = ProjectManagementImplCommittee."ID Number";
        // trigger ONVALIDATE()
        // var
        //     projimplcom: Record ProjectManagementImplCommittee;
        // Begin
        //     "Project Personel" := projimplcom."Full Name";
        // End;
        }
        field(6; "Project Resposibilities"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Responsibilities';
        }
    }
    keys
    {
        key(Key1; PersonelNumber, "Project No.")
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

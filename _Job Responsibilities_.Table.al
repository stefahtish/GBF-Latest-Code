table 50747 "Job Responsibilities"
{
    Caption = 'Job Responsibility';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job ID"; Code[80])
        {
            Caption = 'Job ID';
            DataClassification = ToBeClassified;
        }
        field(2; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            TableRelation = "Job Responsibility";

            trigger OnValidate()
            var
                JobResponsibility: Record "Job Responsibility";
            begin
                if JobResponsibility.Get(Code)then Description:=JobResponsibility.Description;
            end;
        }
        field(3; Description; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Job ID", Code)
        {
            Clustered = true;
        }
    }
}

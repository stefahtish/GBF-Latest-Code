table 50209 "Job Requirements"
{
    fields
    {
        field(1; "Job Id"; Code[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Company Job"."Job ID";
        }
        field(2; "Qualification Type"; Option)
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ", Academic, Professional, Technical, Experience, "Personal Attributes";
        }
        field(3; "Qualification Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            NotBlank = true;

            trigger OnValidate()
            begin
                QualificationSetUp.Reset;
                QualificationSetUp.SetRange(Code, "Qualification Code");
                if QualificationSetUp.Find('-')then Qualification:=QualificationSetUp.Description;
            end;
        }
        field(4; Qualification; Text[200])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(5; "Job Requirements"; Text[250])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(6; Priority; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,High,Medium,Low';
            OptionMembers = " ", High, Medium, Low;
        }
        field(7; "Job Specification"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Academic,Professional,Technical,Experience';
            OptionMembers = " ", Academic, Professional, Technical, Experience;
        }
        field(8; "Score ID"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Job Id", "Qualification Type", "Qualification Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var QualificationSetUp: Record Qualification;
}

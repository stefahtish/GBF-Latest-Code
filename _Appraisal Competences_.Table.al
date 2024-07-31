table 50280 "Appraisal Competences"
{
    fields
    {
        field(1; "Appraisal No."; Code[20])
        {
            DataClassification = ToBeClassified;
        // trigger OnValidate()
        // var
        //     qualsetp: Record "Core Values/Competences setup";
        // begin
        //     if qualsetp.Get("Appraisal No.") then
        //         Score := qualsetp."Max Weight";
        //     Description := qualsetp.Description;
        // end;
        }
        field(2; "Core Value/Competence"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Core Values/Competences", "Core Managerial Values/Competence";
        }
        field(3; Description; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Max Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Comments (Negative)"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "SNo."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Core Values/Competences setup" where(Type=const("Managerial Core Values/Competence"));

            trigger OnValidate()
            var
                qualsetp: Record "Core Values/Competences setup";
            begin
                qualsetp.SetRange("SNo.", "SNo.");
                if qualsetp.FindFirst()then begin
                    //"Max Score" := qualsetp."Max Weight";
                    Description:=qualsetp.Description;
                end;
            end;
        }
        field(9; "Does not Demonstrate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Fairly Demonstrates"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Demonstrates"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Self Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "SNo.", "Appraisal No.", "Core Value/Competence")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

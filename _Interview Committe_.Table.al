table 50724 "Interview Committe"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Recruitment Needs";

            trigger OnValidate()
            var
                recNeeds: Record "Recruitment Needs";
            begin
                if recNeeds.get("Job ID")then "Job Description":=recNeeds.Description;
            end;
        }
        field(3; "Job Description"; text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "General Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Processed; Boolean)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(7; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    var HRSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Interview Committee No.s");
            NoSeriesMgt.InitSeries(HRSetup."Interview Committee No.s", xRec."No. Series", 0D, "No.", "No. Series");
            "Creation Date":=Today;
        end;
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

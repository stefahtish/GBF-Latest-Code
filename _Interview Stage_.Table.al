table 50248 "Interview Stage"
{
    fields
    {
        field(1; "Applicant No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Panel; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Interview Panel Members"."Panel Member Code";
            trigger OnValidate()
            var
                PanelMemberRecord: Record "Interview Panel Members";
            begin
                PanelMemberRecord.SetRange("Panel Member Code", Panel);
                if PanelMemberRecord.FindFirst() then
                    "Panel Name" := PanelMemberRecord."Panel Member Name"

                else
                    "Panel Name" := '';
            end;
        }
        field(4; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Marks Awarded"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Marks Awarded" > "Maximum Marks" then Error('Marks awarded cannot be higher than maximum marks');
            end;
        }
        field(6; "Test Parameter"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Test Parameters".Code;

            trigger OnValidate()
            begin
                Parameters.Reset;
                Parameters.SetRange(code, "Test Parameter");
                if Parameters.Find('-') then begin
                    "Maximum Marks" := Parameters."Max Marks";
                    "Pass Mark" := Parameters."Pass Mark";
                end;
            end;
        }
        field(7; "Maximum Marks"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Pass Mark"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Interview Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Oral 1,Oral 2,Oral 3,Practical';
            OptionMembers = "Oral 1","Oral 2","Oral 3",Practical;
        }
        field(10; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Interviewer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Interviwer Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Panel Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false; // Ensuring the field is not editable
        }

    }
    keys
    {
        key(Key1; "Applicant No", Panel, "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var
        Parameters: Record "Test Parameters";
}

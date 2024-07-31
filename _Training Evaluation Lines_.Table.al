table 50521 "Training Evaluation Lines"
{
    fields
    {
        field(1; "Training Evaluation No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Personal No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Evaluation Line Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Course,Utilization,Expectation,Impact,TrainingTechniques,TrainingVenueFood,Recommendation,PersonlActionPlans,Barriers,OvercomingBarriers,ResourceReq,ImprovingWeakness,RecommendationNo';
            OptionMembers = " ", Course, Utilization, Expectation, Impact, TrainingTechniques, TrainingVenueFood, Recommendation, PersonlActionPlans, Barriers, OvercomingBarriers, ResourceReq, ImprovingWeakness, RecommendationNo;
        }
        field(5; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetNextLineNo;
            end;
        }
        field(6; "Action Plan"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "How To achieve"; Blob)
        {
            Caption = 'How to achieve the action Plan';
            DataClassification = ToBeClassified;
        }
        field(8; "Results to be achieved"; Blob)
        {
            Caption = 'Results to be achieved (Targets)';
            DataClassification = ToBeClassified;
        }
        field(9; Timeline; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Training Evaluation No.", "Evaluation Line Type", "Personal No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
    local procedure GetNextLineNo(): Integer var
        EvaluationLines: Record "Training Evaluation Lines";
    begin
        EvaluationLines.RESET;
        EvaluationLines.SETRANGE("Training Evaluation No.", "Training Evaluation No.");
        EvaluationLines.SETRANGE("Evaluation Line Type", "Evaluation Line Type");
        IF EvaluationLines.FINDLAST THEN EXIT(EvaluationLines."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;
}

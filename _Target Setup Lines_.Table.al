table 50716 "Target Setup Lines"
{
    Caption = 'Target setup Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SNo."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Max Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Target No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Employee No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Appraisal Period"; Code[20])
        {
        }
        field(7; "Total Rating"; Decimal)
        {
            CalcFormula = Sum("Strategic Imp Initiatives"."Self Rating" WHERE(ObjectiveCode=Field("SNo."), "Employee No."=FIELD("Employee No"), "Appraisal Period"=field("Appraisal Period"), "Target No."=field("Target No")));
            FieldClass = FlowField;
        }
        field(8; "Performance Appraisal Score"; Decimal)
        {
            CalcFormula = Sum("Strategic Imp Initiatives"."Performance Appraisal Score" WHERE(ObjectiveCode=Field("SNo."), "Employee No."=FIELD("Employee No"), "Appraisal Period"=field("Appraisal Period"), "Target No."=field("Target No")));
            FieldClass = FlowField;
        }
        field(9; "Moderated Score"; Decimal)
        {
            CalcFormula = Sum("Strategic Imp Initiatives"."Moderated Score" WHERE(ObjectiveCode=Field("SNo."), "Employee No."=FIELD("Employee No"), "Appraisal Period"=field("Appraisal Period"), "Target No."=field("Target No")));
            FieldClass = FlowField;
        }
        field(10; "Appraisal No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "SNo.", "Target No", "Employee No", "Appraisal Period")
        {
            Clustered = true;
        }
    }
}

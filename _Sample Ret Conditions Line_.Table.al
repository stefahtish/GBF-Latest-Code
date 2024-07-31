table 50588 "Sample Ret Conditions Line"
{
    Caption = 'Sample Retention Conditions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Code[20])
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; Code; Code[300])
        {
            Caption = 'Condition';
            DataClassification = ToBeClassified;
            TableRelation = "Laboratory Setup Type" where(Type=const("Sample Retention Conditions"));
        }
        field(3; Description; Code[2000])
        {
            DataClassification = ToBeClassified;
            TableRelation = if(Option=const(true))"Sample Condition Options".Option where(Condition=field(Code));
        }
        field(4; Option; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Laboratory Setup Type".Options WHERE(Name=FIELD(Code)));
        }
        field(5; "Retention period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.", Code)
        {
            Clustered = true;
        }
    }
}

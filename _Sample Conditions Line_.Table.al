table 50573 "Sample Conditions Line"
{
    Caption = 'Sample Conditions';
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
            TableRelation = "Laboratory Setup Type" where(Type=const("Sample Conditions"));

            trigger OnValidate()
            var
                LabSetup: Record "Laboratory Setup Type";
            begin
                LabSetup.Reset();
                LabSetup.SetRange(Name, Code);
                LabSetup.SetRange("Has Unit of Measure", true);
                if LabSetup.FindFirst()then "Unit of Measure":=LabSetup."Unit of Measure";
            end;
        }
        field(3; Description; Code[2000])
        {
            DataClassification = ToBeClassified;
            TableRelation = if(Option=const(true))"Sample Condition Options".Option where(Condition=field(Code));
        }
        field(4; Lab; Code[2000])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sample Condition Options".Option where(Condition=field(Code));
        }
        field(5; "Additional Information"; Code[100])
        {
            Caption = 'Explanation';
            DataClassification = ToBeClassified;
        }
        field(6; Option; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Laboratory Setup Type".Options WHERE(Name=FIELD(Code)));
        }
        field(7; "Batch Number needed"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sample Condition Options"."Batch Number needed" WHERE(Option=FIELD(Description), Condition=field(Code)));
        }
        field(8; "Expiry date needed"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sample Condition Options"."Expiry date needed" WHERE(Option=FIELD(Description), Condition=field(Code)));
        }
        field(9; "Explanation Needed"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sample Condition Options"."Explanation Needed" WHERE(Option=FIELD(Description), Condition=field(Code)));
        }
        field(10; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Batch Number"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Unit of Measure"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(13; "Manufacturing date needed"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sample Condition Options"."Has Manufacturing Date" WHERE(Option=FIELD(Description), Condition=field(Code)));
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

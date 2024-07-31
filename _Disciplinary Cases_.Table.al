table 50211 "Disciplinary Cases"
{
    DrillDownPageID = "Disciplinary Cases";
    LookupPageID = "Disciplinary Cases";

    fields
    {
        field(1; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Recommended Action"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Recommended Actions".Code;

            trigger OnValidate()
            var
                RAction: Record "Recommended Actions";
            begin
                RAction.Reset;
                RAction.SetRange(Code, "Recommended Action");
                if RAction.Find('-')then begin
                    "Action Description":=RAction.Description;
                end;
            end;
        }
        field(4; "Action Description"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

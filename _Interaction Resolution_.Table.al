table 50463 "Interaction Resolution"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Description; Text[200])
        {
            CalcFormula = Lookup("Interaction Type".Description WHERE("No."=FIELD("Interaction No.")));
            FieldClass = FlowField;
        }
        field(3; Cause; Text[200])
        {
        }
        field(4; "Interaction No."; Code[10])
        {
            TableRelation = "Interaction Type";

            trigger OnValidate()
            begin
                recInteractionType.Get("Interaction No.");
                Description:=recInteractionType.Description;
            end;
        }
        field(5; "Cause No."; Code[10])
        {
            TableRelation = "Interaction Cause" WHERE("Interaction No."=FIELD("Interaction No."));

            trigger OnValidate()
            begin
                recInteractionCause.Get("Cause No.");
                Cause:=recInteractionCause.Description;
            end;
        }
        field(6; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "No.", "Interaction No.")
        {
            Clustered = true;
        }
        key(Key2; "Cause No.", "Interaction No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            //     recInteractionSetup.FINDFIRST THEN BEGIN
            recInteractionSetup.Get;
            recInteractionSetup.TestField(recInteractionSetup."Interaction Resolution Nos.");
            NoSeriesMgt.InitSeries(recInteractionSetup."Interaction Resolution Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        //  END;
        end;
    end;
    var ComplaintSetup: Record "Interaction Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    recInteractionType: Record "Interaction Type";
    recInteractionCause: Record "Interaction Cause";
    recInteractionSetup: Record "Interaction Setup";
}

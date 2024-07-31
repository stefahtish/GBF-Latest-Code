table 50469 "Interaction Cause"
{
    DrillDownPageID = "Interaction Cause";
    LookupPageID = "Interaction Cause";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Interaction No."; Code[20])
        {
            TableRelation = "Interaction Type";
        }
        field(3; Description; Text[250])
        {
        }
        field(4; "No. Series"; Code[20])
        {
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Interaction No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            CRMSetup.Get;
            CRMSetup.TestField(CRMSetup."Client Interaction Cause Nos.");
            NoSeriesMgt.InitSeries(CRMSetup."Client Interaction Cause Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;
    var CRMSetup: Record "Interaction Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}

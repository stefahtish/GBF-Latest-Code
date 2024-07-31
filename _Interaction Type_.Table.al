table 50470 "Interaction Type"
{
    DrillDownPageID = "Interaction Type List";
    LookupPageID = "Interaction Type List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Description = 'Specifies the default unique code of the Interaction Case';
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Interaction Type";enum "CRM Interaction Types")
        {
            DataClassification = ToBeClassified;
        }
        field(4; "No. Series"; Code[20])
        {
        }
        field(5; "Exit Reason"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Specifies the Type of Exit Reason if the Interaction Type is a Lodge Claim';

            trigger OnValidate()
            begin
                if "Exit Reason" <> '' then "Documents Can Be Attached":=true
                else
                    "Documents Can Be Attached":=false;
            end;
        }
        field(6; "Documents Can Be Attached"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Specifies that Documents can be added to the Interaction/Case';

            trigger OnValidate()
            begin
                if("Documents Can Be Attached" = false) and ("Exit Reason" <> '')then "Exit Reason":='';
            end;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Interaction Type")
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
            CRMSetup.TestField(CRMSetup."Client Interaction Type Nos.");
            NoSeriesMgt.InitSeries(CRMSetup."Client Interaction Type Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;
    var CRMSetup: Record "Interaction Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}

table 50714 "Surrender Mandatory Docs"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Surrender No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Document Name"; Text[150])
        {
            TableRelation = "Surrender Docs Setup"."Document Name";

            trigger OnValidate()
            begin
                if SurrenderDocsSetup.Get("Document Name")then Mandatory:=SurrenderDocsSetup.Mandatory;
            end;
        }
        field(4; Checked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Mandatory; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Surrender No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        IntRecord();
    end;
    procedure IntRecord()
    var
        SurDocs: Record "Surrender Mandatory Docs";
    begin
        if not("Line No." = 0)then exit;
        SurDocs.Reset();
        SurDocs.SetCurrentKey("Line No.");
        SurDocs.SetFilter("Surrender No.", '%1', Rec."Surrender No.");
        if SurDocs.FindLast()then "Line No.":=SurDocs."Line No." + 1000
        else
            "Line No.":=1000;
    end;
    var SurrenderDocsSetup: Record "Surrender Docs Setup";
}

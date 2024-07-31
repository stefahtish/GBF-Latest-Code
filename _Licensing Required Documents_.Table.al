table 50612 "Licensing Required Documents"
{
    Caption = 'Required Documents';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Document; Text[100])
        {
            Caption = 'Document';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetRecID();
            end;
        }
        field(3; Attachments; Integer)
        {
            Caption = 'Attachments';
            FieldClass = FlowField;
            CalcFormula = count("Record Link" where("Record ID"=field(RecID)));
        }
        field(4; RecID; RecordId)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", Document)
        {
            Clustered = true;
        }
    }
    // trigger OnInsert()
    // var
    //     RecordIDStore: Record "Licensing Required Documents";
    // begin
    //     RecordIDStore.SetRange("No.", "No.");
    //     RecordIDStore.SetRange(Document, Document);
    //     if RecordIDStore.FindFirst() then
    //         RecID := RecordIDStore.RecordId;
    // end;
    procedure GetRecID()
    var
        RecordIDStore: Record "Licensing Required Documents";
    begin
        RecordIDStore.SetRange("No.", "No.");
        RecordIDStore.SetRange(Document, Document);
        if RecordIDStore.FindFirst()then RecID:=RecordIDStore.RecordId;
    end;
}

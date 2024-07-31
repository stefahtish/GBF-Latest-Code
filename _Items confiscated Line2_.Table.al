table 50589 "Items confiscated Line2"
{
    Caption = 'Items confiscated Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Item; Code[50])
        {
            Caption = 'Item';
            DataClassification = ToBeClassified;
        }
        field(3; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(4; "Reason for seizure"; Code[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Unit of measure"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
    }
    keys
    {
        key(PK; "No.", Item)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        Header: Record "Enforcement Header";
    begin
        Header.SetRange("No.", "No.");
        if Header.FindFirst()then "Unit of measure":=Header."Unit of Measure";
    end;
}

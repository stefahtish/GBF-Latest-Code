table 50163 "Procurement Committee"
{
    Caption = 'Procurement Committee';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Members "; Integer)
        {
            Caption = 'Members ';
            FieldClass = FlowField;
            CalcFormula = count("Committee Members" where(Committee=field(code)));
            Editable = false;
        }
        field(4; Permanent; Boolean)
        {
            Caption = 'Permanent';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}

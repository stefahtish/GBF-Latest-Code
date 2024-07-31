table 50155 "Proposed Budget Header"
{
    fields
    {
        field(1; Name; Code[10])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Posted By"; Code[70])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Date-Time Posted"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(11; Approvals; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Document No."=FIELD(Name)));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

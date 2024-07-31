table 50156 "Apportionment Entry"
{
    fields
    {
        field(1; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Company; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Company.Name;
        }
        field(3; Allocation; Decimal)
        {
            Caption = 'Allocation (%)';
            DataClassification = ToBeClassified;
        }
        field(4; "Posted Doc No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Expense Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Apportioned Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "G/L Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(55; "Document Date"; Date)
        {
            Caption = 'Document Date';
            ClosingDates = true;
            DataClassification = ToBeClassified;
        }
        field(56; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = ToBeClassified;
        }
        field(57; "Amount To Post"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Apportion Doc No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Processed Date-Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
            //ShowDimensions;
            end;
        }
        field(481; "Prepared Date-Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(482; "From Company"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Company.Name;
        }
    }
    keys
    {
        key(Key1; "Document No.", Company, "G/L Entry No", "Apportion Doc No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

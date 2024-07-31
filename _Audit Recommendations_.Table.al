table 50513 "Audit Recommendations"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Audit Observation"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Audit Recommendation"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Management Response"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Implementation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Department Responsible"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Department Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Implemented,Under Implementation,Not Yet Implemented';
            OptionMembers = " ", Implemented, "Under Implementation", "Not Yet Implemented";
        }
        field(10; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "New Recommendation"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(14; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
            //ShowDimensions;
            end;
            trigger OnValidate()
            begin
            //DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var //DimMgt: Codeunit DimensionManagement;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    //DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

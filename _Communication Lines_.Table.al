table 50299 "Communication Lines"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Category; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Vendor,Customer,Staff,Contact,Department';
            OptionMembers = " ", Vendor, Customer, Staff, Contact, Department;
        }
        field(3; "Recipient No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Recipient Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Recipient E-Mail"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Recipient Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "E-Mail Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "SMS Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Shortcut Dimension 1 Code"; Code[20])
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
        field(10; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                DimValue.Reset;
                DimValue.SetRange(Code, "Shortcut Dimension 2 Code");
                if DimValue.Find('-')then "Department Name":=DimValue.Name;
            end;
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
            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(481; "Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.", Category, "Recipient No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var DimMgt: Codeunit DimensionManagement;
    DimValue: Record "Dimension Value";
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

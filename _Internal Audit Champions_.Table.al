table 50502 "Internal Audit Champions"
{
    fields
    {
        field(1; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Risk,Incident,Audit';
            OptionMembers = " ", Risk, Incident, Audit;
        }
        field(2; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Employee.GET("Employee No.")THEN BEGIN
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "E-Mail":=Employee."E-Mail";
                    "Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                    if Employee."User ID" <> '' then "User ID":=Employee."User ID"
                    else
                    begin
                        //Get UserName
                        UserSetup.RESET;
                        UserSetup.SETRANGE("Employee No.", Employee."No.");
                        IF UserSetup.FINDFIRST THEN "User ID":=UserSetup."User ID";
                    end;
                END;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false), "Dimension Value Type"=filter(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(6; "Shortcut Dimension 2 Code"; Code[20])
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
        field(7; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(8; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Escalator ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
    }
    keys
    {
        key(Key1; Type, "Employee No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
    DimMgt: Codeunit DimensionManagement;
    UserSetup: Record "User Setup";
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

table 50514 Projects
{
    fields
    {
        field(1; "Project Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Project Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Project Manager"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Employee.GET("Project Manager")THEN BEGIN
                    "Project Manager Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Project Manager E-Mail":=Employee."Company E-Mail";
                END;
                UserSetup.RESET;
                UserSetup.SETRANGE("Employee No.", "Project Manager");
                IF UserSetup.FIND('-')THEN BEGIN
                    "PM User ID":=UserSetup."User ID";
                END;
            end;
        }
        field(4; "Project Manager Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Project Manager E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(False));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(7; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                DimValue.RESET;
                DimValue.SETRANGE(Code, "Shortcut Dimension 2 Code");
                IF DimValue.FIND('-')THEN "Department Name":=DimValue.Name;
            end;
        }
        field(8; "Department Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "PM User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Date Time Created"; DateTime)
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
            trigger OnValidate()
            begin
            //DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
    }
    keys
    {
        key(Key1; "Project Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        RiskSetup.GET;
        RiskSetup.TESTFIELD("Project Nos.");
        NoSeriesMgt.InitSeries(RiskSetup."Project Nos.", xRec."No. Series", 0D, "Project Code", "No. Series");
        "Created By":=USERID;
        "Date Time Created":=CREATEDATETIME(TODAY, TIME);
    end;
    var DimMgt: Codeunit DimensionManagement;
    DimValue: Record "Dimension Value";
    UserSetup: Record "User Setup";
    Employee: Record Employee;
    NoSeriesMgt: Codeunit NoSeriesManagement;
    RiskSetup: Record "Audit Setup";
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

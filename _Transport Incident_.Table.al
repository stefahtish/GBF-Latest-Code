table 50350 "Transport Incident"
{
    Caption = 'Transport Incident';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Incident Reference"; Code[20])
        {
            Caption = 'Incident Reference';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Incident Reference" <> '' THEN NoSeriesMgt.TestManual(AuditSetup."Incident Reporting Nos.");
            end;
        }
        field(2; "Incident Description"; Text[250])
        {
            Caption = 'Incident Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Incident date"; Date)
        {
            Caption = 'Incident date';
            DataClassification = ToBeClassified;
        }
        field(4; "Incident Status"; Option)
        {
            Caption = 'Incident Status';
            OptionCaption = 'Unresolved,Resolved';
            OptionMembers = Unresolved, Resolved;
            DataClassification = ToBeClassified;
        }
        field(5; "No. series"; Code[20])
        {
            Caption = 'No. series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(6; "Action taken"; Text[250])
        {
            Caption = 'Action taken';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Action By":=UserId;
            end;
        }
        field(7; "Action Date"; Date)
        {
            Caption = 'Action Date';
            DataClassification = ToBeClassified;
        }
        field(8; User; Code[20])
        {
            Caption = 'User';
            DataClassification = ToBeClassified;
            TableRelation = User;
        }
        field(9; "System Support Email Address"; Text[80])
        {
            Caption = 'System Support Email Address';
            DataClassification = ToBeClassified;
        }
        field(10; "User Email Address"; Text[80])
        {
            Caption = 'User Email Address';
            DataClassification = ToBeClassified;
        }
        field(11; "User Remarks"; Text[250])
        {
        }
        field(12; "File No"; Code[20])
        {
            Caption = 'File No';
            DataClassification = ToBeClassified;
        }
        field(13; "Incident Time"; Time)
        {
            Caption = 'Incident Time';
            DataClassification = ToBeClassified;
        }
        field(14; "Action Time"; Time)
        {
            Caption = 'Action Time';
            DataClassification = ToBeClassified;
        }
        field(15; "Employee No"; Code[30])
        {
            Caption = 'Driver Employee No';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Employee.GET("Employee No")THEN BEGIN
                    "Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code":=Employee."Global Dimension 2 Code";
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    FixedAsset.Reset();
                    FixedAsset.SetRange("Fixed Asset Type", FixedAsset."Fixed Asset Type"::Fleet);
                    FixedAsset.SetRange("Responsible Employee", Employee."No.");
                    if FixedAsset.FindFirst()then begin
                        "Vehicle Registration":=FixedAsset."Registration No";
                        Validate("Vehicle Registration");
                    end;
                END;
            end;
        }
        field(16; "Employee Name"; Text[100])
        {
            Caption = 'Driver Name';
            DataClassification = ToBeClassified;
        }
        field(17; Sent; Boolean)
        {
            Caption = 'Sent';
            DataClassification = ToBeClassified;
        }
        field(18; "Incident Reported"; Boolean)
        {
            Caption = 'Incident Reported';
            DataClassification = ToBeClassified;
        }
        field(19; "Incident Location"; Code[10])
        {
            Caption = 'Incident Location';
            DataClassification = ToBeClassified;
        }
        field(20; "Incident Location Name"; Text[100])
        {
            Caption = 'Incident Location Name';
            DataClassification = ToBeClassified;
        }
        field(21; "Incident Outcome"; Option)
        {
            Caption = 'Incident Outcome';
            OptionCaption = '  ,Dangerous,Serious bodily injury,Work caused illness,Serious electrical incident,Dangerous electrical event,MajorAccident under the OSHA Act';
            OptionMembers = "  ", Dangerous, "Serious bodily injury", "Work caused illness", "Serious electrical incident", "Dangerous electrical event", "MajorAccident under the OSHA Act";
            DataClassification = ToBeClassified;
        }
        field(22; "Remarks HR"; Text[250])
        {
            Caption = 'Remarks HR';
            DataClassification = ToBeClassified;
        }
        field(23; Priority; Option)
        {
            Caption = 'Priority';
            OptionCaption = ' ,Low,Medium,High';
            OptionMembers = " ", Low, Medium, High;
            DataClassification = ToBeClassified;
        }
        field(24; "Vehicle Registration"; Code[50])
        {
            Caption = 'Vehicle Registration';
            DataClassification = ToBeClassified;

            // TableRelation = "Fixed Asset" where("Fixed Asset Type" = const(fleet));
            trigger Onvalidate()
            var
                FA: Record "Fixed Asset";
            begin
                FA.Reset();
                Fa.SetRange("Registration No", "Vehicle Registration");
                if FA.FindFirst()then begin
                    "Insurance Policy":=FA."Policy No";
                    "Insurance Company":=FA."Insurance Company";
                    "Insurance Commencement Date":=format(FA."Date of Commencement");
                    "Insurance Expiry Date":=Format(FA."Expiry Date");
                    "Hotline Number":=FA."Hotline No";
                    "Inspection Due Date":=format(FA."Inspection Due Date");
                end;
            end;
        }
        field(25; "Incident Rating"; Option)
        {
            Caption = 'Incident Rating';
            OptionCaption = 'Low,Medium,High';
            OptionMembers = Low, Medium, High;
            DataClassification = ToBeClassified;
        }
        field(26; "Escalate To"; Code[20])
        {
            Caption = 'Escalate To';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(27; "Escalation Date"; Date)
        {
            Caption = 'Escalation Date';
            DataClassification = ToBeClassified;
        }
        field(28; "Action By"; Code[30])
        {
            Caption = 'Action By';
            DataClassification = ToBeClassified;
        }
        field(29; "Delegated To"; Code[50])
        {
            Caption = 'Delegated To';
            DataClassification = ToBeClassified;
        }
        field(30; "Delagated User ID"; Code[50])
        {
            Caption = 'Delagated User ID';
            DataClassification = ToBeClassified;
        }
        field(31; "Shortcut Dimension 1 Code"; Code[20])
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
        field(32; "Shortcut Dimension 2 Code"; Code[20])
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
        field(33; "Dimension Set ID"; Integer)
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
        field(34; Accident; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            var
                FA: Record "Fixed Asset";
            begin
                FA.Reset();
                Fa.SetRange("Registration No", "Vehicle Registration");
                if FA.FindFirst()then begin
                    "Insurance Policy":=FA."Policy No";
                    "Insurance Company":=FA."Insurance Company";
                    "Insurance Commencement Date":=format(FA."Date of Commencement");
                    "Insurance Expiry Date":=Format(FA."Expiry Date");
                    "Hotline Number":=FA."Hotline No";
                end;
            end;
        }
        field(35; "Insurance details"; Code[500])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Transport Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Travel Requests";
        }
        field(37; Reported; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; Abstract; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(39; Image; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(40; "Insurance Policy"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Insurance Company"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Inspection Due Date"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Insurance Expiry Date"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Insurance Commencement Date"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Hotline Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(46; Status;Enum "Approval Status-custom")
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Incident Reference")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if not AuditSetup.Get()then begin
            AuditSetup.Init();
            AuditSetup.Insert();
        end;
        AuditSetup.TESTFIELD("Incident Reporting Nos.");
        NoSeriesMgt.InitSeries(AuditSetup."Incident Reporting Nos.", xRec."No. Series", TODAY, "Incident Reference", "No. Series");
        IF UserSetup.GET(USERID)THEN BEGIN
            UserSetup.TESTFIELD("Employee No.");
            IF Employee.GET(UserSetup."Employee No.")THEN BEGIN
                "Employee No":=Employee."No.";
                Validate("Employee No");
            END;
        END;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    Employee: Record Employee;
    DimMgt: Codeunit DimensionManagement;
    AuditSetup: Record "Audit Setup";
    FixedAsset: Record "Fixed Asset";
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

table 50298 "Communication Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                case Type of Type::Communication: begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(ICTSetup."Communication Nos");
                end;
                Type::"Audit Notification": begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(AuditSetup."Audit Notification Nos.");
                end;
                Type::Audit: begin
                    if "No." <> xRec."No." then NoSeriesMgt.TestManual(AuditSetup."Risk Reporting Nos.");
                end;
                end;
            end;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Last Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Sent,Complete';
            OptionMembers = Pending, Sent, Complete;
        }
        field(6; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Communication Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,E-Mail,SMS,Email and SMS';
            OptionMembers = " ", "E-Mail", SMS, "Email and SMS";
        }
        field(8; "E-Mail Body"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "SMS Text"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "E-Mail Subject"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Attachment; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Communication,Audit,Audit Notification';
            OptionMembers = " ", Communication, Audit, "Audit Notification";
        }
        field(13; "Sender Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Sent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Receipient; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get(Receipient)then begin
                    "Receipient Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Receipient E-Mail":=Employee."E-Mail";
                end;
            end;
        }
        field(16; "Receipient Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Receipient E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Sender; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get(Sender)then begin
                    "Sender Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Sender Email":=Employee."E-Mail";
                end;
            end;
        }
        field(19; "Sender Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Auditer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Audit Firm"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Shortcut Dimension 1 Code"; Code[20])
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
        field(23; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            /*
                DimValue.RESET;
                DimValue.SETRANGE(Code,"Shortcut Dimension 2 Code");
                IF DimValue.FIND('-') THEN
                  "Department Name" := DimValue.Name;
                */
            end;
        }
        field(24; "Dimension Set ID"; Integer)
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
        field(25; "Notify Department"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        ICTSetup.Get;
        AuditSetup.Get;
        if "No." = '' then begin
            case Type of Type::Communication: begin
                ICTSetup.TestField("Communication Nos");
                if "No." = '' then NoSeriesMgt.InitSeries(ICTSetup."Communication Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;
            Type::"Audit Notification": begin
                AuditSetup.TestField("Audit Notification Nos.");
                if "No." = '' then NoSeriesMgt.InitSeries(AuditSetup."Audit Notification Nos.", xRec."No. Series", Today, "No.", "No. Series");
            end;
            Type::Audit: begin
                AuditSetup.TestField("Risk Reporting Nos.");
                if "No." = '' then NoSeriesMgt.InitSeries(AuditSetup."Risk Reporting Nos.", xRec."No. Series", Today, "No.", "No. Series");
            end;
            end;
        end;
        "Created By":=UserId;
        if UserSetup.Get(UserId)then if Employee.Get(UserSetup."Employee No.")then begin
                Sender:=Employee."No.";
                "Sender Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                "Sender Email":=Employee."E-Mail";
                "Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                Validate("Shortcut Dimension 1 Code");
                "Shortcut Dimension 2 Code":=Employee."Global Dimension 2 Code";
                Validate("Shortcut Dimension 2 Code");
            end;
    end;
    trigger OnModify()
    begin
        "Last Modified By":=UserId;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    ICTSetup: Record "ICT Setup";
    SelectedFile: Text;
    FileManagement: Codeunit "File Management";
    FileName: Text[250];
    UserSetup: Record "User Setup";
    Employee: Record Employee;
    AuditSetup: Record "Audit Setup";
    DimMgt: Codeunit DimensionManagement;
    DimValue: Record "Dimension Value";
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

table 50296 "User Support Incident"
{
    fields
    {
        field(1; "Incident Reference"; Code[20])
        {
            Caption = 'Reference No.';

            trigger OnValidate()
            begin
                if(Type = Type::AUDIT)then begin
                    if "Incident Reference" <> xRec."Incident Reference" then NoSeriesMgt.TestManual(AuditSetup."Incident Reporting Nos.");
                end;
                if(Type = Type::ICT)then begin
                    if "Incident Reference" <> xRec."Incident Reference" then NoSeriesMgt.TestManual(ICTSetup."incidence Nos");
                end;
            end;
        }
        field(2; "Incident Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(3; "Incident Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; "Incident Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Unresolved,Resolved';
            OptionMembers = Unresolved, Resolved;
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(6; "Action taken"; Text[250])
        {
            trigger OnValidate()
            begin
                "Action By":=UserId;
            end;
        }
        field(7; "Action Date"; Date)
        {
        }
        field(8; User; Code[50])
        {
            TableRelation = User;
        }
        field(9; "System Support Email Address"; Text[80])
        {
        }
        field(10; "User email Address"; Text[80])
        {
        }
        field(11; Type; Option)
        {
            OptionCaption = 'ICT,ADM,REGISTRY,KEYS,AUDIT';
            OptionMembers = ICT, ADM, REGISTRY, "KEYS", AUDIT;
        }
        field(12; "File No"; Code[30])
        {
        }
        field(13; "Incident Time"; Time)
        {
            Caption = 'Time of occurenece';
        }
        field(14; "Action Time"; Time)
        {
        }
        field(15; "Employee No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Employee.GET("Employee No")THEN BEGIN
                    "Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code":=Employee."Global Dimension 2 Code";
                END;
            end;
        }
        field(16; "Employee Name"; Text[100])
        {
        }
        field(17; Sent; Boolean)
        {
        }
        field(18; "Incidence Resolved"; Boolean)
        {
        }
        field(19; "Work place Controller"; Code[10])
        {
            TableRelation = Employee;
        }
        field(20; "Work place Controller Name"; Text[100])
        {
        }
        field(21; "Incidence Location"; Code[10])
        {
        }
        field(22; "Incidence Location Name"; Text[100])
        {
        }
        field(23; "Incidence Outcome"; Option)
        {
            OptionCaption = '  ,Dangerous,Serious bodily injury,Work caused illness,Serious electrical incident,Dangerous electrical event,MajorAccident under the OSHA Act';
            OptionMembers = "  ", Dangerous, "Serious bodily injury", "Work caused illness", "Serious electrical incident", "Dangerous electrical event", "MajorAccident under the OSHA Act";
        }
        field(24; "Incident Outcome"; Option)
        {
            Caption = 'Outcome';
            OptionCaption = '  ,Yes,No';
            OptionMembers = "  ", Yes, No;
        }
        field(25; "Remarks HR"; Text[250])
        {
        }
        field(26; "User Informed?"; Boolean)
        {
        }
        field(27; Priority; Option)
        {
            OptionMembers = "", High, Medium, Low;
            OptionCaption = ' ,High,Medium,Low';
        }
        field(28; "Expected Action Date"; Date)
        {
        }
        field(29; "User Remarks"; Text[250])
        {
        }
        field(30; "Incident Rating"; Option)
        {
            Caption = 'Rating';
            OptionCaption = 'Low,Medium,High';
            OptionMembers = Low, Medium, High;
        }
        field(31; "Incident Type"; Option)
        {
            OptionMembers = General, Transport;
        }
        field(32; Status; Option)
        {
            caption = 'Stage';
            OptionCaption = 'Open,Pending,Solved,Escalated,Closed';
            OptionMembers = Open, Pending, Solved, Escalated, Closed;

            trigger OnValidate()
            begin
            end;
        }
        field(33; "Escalate To"; Code[50])
        {
            TableRelation = Employee;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.get("Escalate To")then begin
                    "Escalate To Name":=Employee."First Name" + '' + Employee."Middle Name" + '' + Employee."Last Name";
                    "Escalation email Address":=Employee."Company E-Mail";
                    UserSetup.reset;
                    if UserSetup.get(Employee."No.")then "Escalation User ID":=UserSetup."User ID";
                end;
            end;
        }
        field(34; "Ecalation Date"; Date)
        {
        }
        field(35; "Screen Shot"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(36; "Action By"; Code[30])
        {
        }
        field(37; "Delegated To"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: Record Employee;
                Usersetup: Record "User Setup";
            begin
                if Emp.Get("Delegated To")then "Delegated To Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                Usersetup.Reset();
                Usersetup.SetRange("Employee No.", "Delegated To");
                if Usersetup.FindFirst()then "Delegated User ID":=Usersetup."User ID";
            end;
        }
        field(38; "Delegated To Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Delegated User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Incident Cause"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Shortcut Dimension 1 Code"; Code[20])
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
        field(42; "Shortcut Dimension 2 Code"; Code[20])
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
        field(43; "Dimension Set ID"; Integer)
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
        field(44; "Linked Risk"; Code[50])
        {
            TableRelation = "Risk Header";
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                RiskHeader: Record "Risk Header";
            begin
                IF RiskHeader.GET(Rec."Linked Risk")THEN BEGIN
                    "Linked Risk Description":=RiskHeader."Risk Description";
                END;
            end;
        }
        field(45; "Rejection reason"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Linked Risk Description"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Mitigation Plan"; Code[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Incident Priority"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Incident Priority Setup";

            trigger OnValidate()
            var
                PrioritySetup: Record "Incident Priority Setup";
            begin
                PrioritySetup.Reset();
                PrioritySetup.SetRange(Code, "Incident Priority");
                if PrioritySetup.FindFirst()then begin
                    "Priority":=PrioritySetup.Priority;
                    "Mitigation Plan":=PrioritySetup."Mitigation Plan";
                    Modify();
                end;
            end;
        }
        field(49; "New Escalator No."; Code[20])
        {
            Caption = 'Escalator No.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(50; "Escalation option"; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Internal, External;
            OptionCaption = ' ,Internal,External';
        }
        field(51; "Escalation email Address"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Escalate To Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Escalation Time"; time)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Escalation User ID"; Code[50])
        {
            Caption = 'Escalated to user ID';
            DataClassification = ToBeClassified;
        }
        field(55; "E-Mail Body"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Asset No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset" where(Computer=const(true));

            trigger OnValidate()
            var
                myInt: Integer;
                FixedAsset: Record "Fixed Asset";
            begin
                if FixedAsset.get("Asset No.")then begin
                    "Asset Description":=FixedAsset.Description;
                    "Serial Number":=FixedAsset."Serial No.";
                    "Tag Number":=FixedAsset."Tag Number";
                end;
            end;
        }
        field(57; "Asset Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Tag Number"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Serial Number"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60; Asset; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Service Provider"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if Vendor.get("Service Provider")then "Service provider Name":=Vendor.Name;
            end;
        }
        field(62; "Service provider Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Feedback on Completion"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Service provided"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Support Service Request"; Text[10])
        {
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(66; Category; Code[20])
        {
            ObsoleteState = Removed;
            DataClassification = ToBeClassified;
        // OptionMembers = "","Network Issue","System Issues","Hardware Issues","Software Issues";
        // OptionCaption = ' ,Network Issue,System Issues,Hardware Issues,Software Issues';
        }
        field(67; Category2; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ICT Issue Categories";

            trigger OnValidate()
            var
                Categ: record "ICT Issue Categories";
            begin
                Categ.Reset();
                Categ.SetRange(Category, Category2);
                if Categ.FindFirst()then begin
                    "Category Description":=Categ."Category Description";
                end;
            end;
        }
        field(68; Issue; Text[500])
        {
            Caption = 'Issue';
            DataClassification = ToBeClassified;
            TableRelation = "ICT Issue Setup2".Issue where(Category=field(Category2));

            trigger OnValidate()
            var
                Categ: record "ICT Issue Setup2";
            begin
            // Categ.Reset();
            // Categ.SetRange(Category, Category2);
            // Categ.SetRange(Issue, Issue);
            // if Categ.FindFirst() then begin
            //     Priority := Categ.Priority;
            // end;
            end;
        }
        field(69; "Category Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Approval Status";Enum "Approval Status-custom")
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Incident Reference")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Incident Reference", "Incident Description")
        {
        }
    }
    trigger OnInsert()
    begin
        if not ICTSetup.Get then begin
            ICTSetup.Init();
            ICTSetup.Insert();
        end;
        if not AuditSetup.Get then begin
            AuditSetup.Init();
            AuditSetup.Insert();
        end;
        case Type of Type::AUDIT: begin
            AuditSetup.TestField("Incident Reporting Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Incident Reporting Nos.", xRec."No. Series", Today, "Incident Reference", "No. Series");
        end
        else
            NoSeriesMgt.InitSeries(ICTSetup."Incidence Nos", xRec."No. Series", 0D, "Incident Reference", "No. Series");
        end;
        User:=UserId;
        ;
        if UserSetup.Get(UserId)then begin
            if Employee.Get(UserSetup."Employee No.")then begin
                "Employee No":=Employee."No.";
                "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                VALIDATE("Employee No");
                "User email Address":=Employee."E-Mail";
                "Incident Date":=Today;
                "Incident Time":=Time;
                "Incident Status":="Incident Status"::Unresolved;
                case Type of Type::AUDIT: begin
                    "Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                    "Shortcut Dimension 2 Code":=Employee."Global Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                end;
                Type::ICT: begin
                    FASubclasses.Reset();
                    FASubclasses.SetRange(Computer, true);
                    if FASubclasses.FindFirst()then begin
                        FA.SetRange("FA Subclass Code", FASubclasses.Code);
                        FA.SetRange("Responsible Employee", Employee."No.");
                        if FA.FindFirst()then "Asset No.":=FA."No.";
                        Validate("Asset No.");
                    end;
                end;
                end;
            end;
        end;
    end;
    var ICTSetup: Record "ICT Setup";
    CommentLine: Record "Comment Line";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    CompanyInformation: Record "Company Information";
    UserSetup: Record "User Setup";
    Employee: Record Employee;
    emp2: Record Employee;
    DimMgt: Codeunit DimensionManagement;
    AuditSetup: Record "Audit Setup";
    FASubclasses: Record "FA Subclass";
    FA: Record "Fixed Asset";
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

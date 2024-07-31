table 50497 "Audit Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CASE Type OF Type::Audit: BEGIN
                    IF "No." <> xRec."No." THEN NoSeriesMgt.TestManual(AuditSetup."Audit Nos.");
                END;
                Type::"Audit WorkPlan": BEGIN
                    IF "No." <> xRec."No." THEN NoSeriesMgt.TestManual(AuditSetup."Audit Workplan Nos.");
                END;
                Type::Risk: BEGIN
                    IF "No." <> xRec."No." THEN NoSeriesMgt.TestManual(AuditSetup."Risk Nos.");
                END;
                Type::"Audit Record Requisition": BEGIN
                    IF "No." <> xRec."No." THEN NoSeriesMgt.TestManual(AuditSetup."Audit Record Requisition Nos.");
                END;
                Type::"Audit Plan": BEGIN
                    IF "No." <> xRec."No." THEN NoSeriesMgt.TestManual(AuditSetup."Audit Plan Nos.");
                END;
                Type::"Work Paper": BEGIN
                    IF "No." <> xRec."No." THEN NoSeriesMgt.TestManual(AuditSetup."Work Paper Nos.");
                END;
                Type::"Audit Report": BEGIN
                    IF "No." <> xRec."No." THEN NoSeriesMgt.TestManual(AuditSetup."Audit Report Nos.");
                END;
                Type::Inspection: BEGIN
                    IF "No." <> xRec."No." THEN NoSeriesMgt.TestManual(AuditSetup."Inspection Report Nos.");
                END;
                Type::"Risk Survey": BEGIN
                    IF "No." <> xRec."No." THEN NoSeriesMgt.TestManual(AuditSetup."Risk Survey Nos.");
                END;
                Type::"Department Register": BEGIN
                    IF "No." <> xRec."No." THEN NoSeriesMgt.TestManual(AuditSetup."Risk Register Nos");
                END;
                Type::"Audit Program": BEGIN
                    IF "No." <> xRec."No." THEN NoSeriesMgt.TestManual(AuditSetup."Audit Program Nos.");
                END;
                Type::Compliance: BEGIN
                    IF "No." <> xRec."No." THEN NoSeriesMgt.TestManual(AuditSetup."Compliance Nos.");
                END;
                END;
            end;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF UserSetup.GET(USERID)THEN IF Employee.GET(UserSetup."Employee No.")THEN BEGIN
                        "Employee No.":=Employee."No.";
                        "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                        Validate("Employee No.");
                    END;
            end;
        }
        field(4; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open, "Pending Approval", Released, Rejected;
        }
        field(5; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                DimValue.RESET;
                DimValue.SETRANGE("Global Dimension No.", 1);
                DimValue.SETRANGE(Code, "Shortcut Dimension 1 Code");
                IF DimValue.FINDFIRST THEN "Department Name":=DimValue.Name;
            end;
        }
        field(9; "Shortcut Dimension 2 Code"; Code[20])
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
        field(12; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Audit,Risk,Audit WorkPlan,Audit Record Requisition,Audit Plan,Work Paper,Audit Report,Risk Survey,Department Register,Audit Program,Compliance,Audit Recommendation Follow-up,Inspection,Strategic Plan,Quarterly Audit';
            OptionMembers = " ", Audit, Risk, "Audit WorkPlan", "Audit Record Requisition", "Audit Plan", "Work Paper", "Audit Report", "Risk Survey", "Department Register", "Audit Program", Compliance, "Audit Recommendation Follow-up", Inspection, "Strategic Plan", "Quarterly Audit";
        }
        field(13; "Risk Category"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Risk Rating"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Rating";
        }
        field(15; "Risk Likelihood"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Risk Impact"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Audit Firm"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Audit Manager"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Reviewed By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";

            trigger OnValidate()
            begin
                CASE Type OF Type::"Work Paper": BEGIN
                    IF Employee.GET("Reviewed By")THEN BEGIN
                        "Reviewed By Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                        "Date Reviewed":=TODAY;
                    END;
                END;
                END;
            end;
        }
        field(20; "Cut-Off Period"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Title; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Audit Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Department Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Audit Plan No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Audit Header" WHERE(Type=FILTER("Audit Plan")); // "Shortcut Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code"), "Shortcut Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code"));

            trigger OnValidate()
            begin
                CASE Type OF Type::"Audit Program": BEGIN
                    IF AuditHeader.GET("Audit Plan No.")THEN BEGIN
                        "Shortcut Dimension 1 Code":=AuditHeader."Shortcut Dimension 1 Code";
                        VALIDATE("Shortcut Dimension 1 Code");
                        "Shortcut Dimension 2 Code":=AuditHeader."Shortcut Dimension 2 Code";
                        VALIDATE("Shortcut Dimension 2 Code");
                        "Audit Manager":=AuditHeader."Audit Manager";
                        "Audit Period Start Date":=AuditHeader."Audit Period Start Date";
                        Description:=AuditHeader.Description;
                        AuditHeader."Audit Status":=AuditHeader."Audit Status"::"In - Progress";
                        AuditHeader."Document Status":=AuditHeader."Document Status"::"Audit Program";
                        AuditHeader.MODIFY;
                        //Insert Scope
                        AuditLines.RESET;
                        AuditLines.SETRANGE("Document No.", AuditHeader."No.");
                        AuditLines.SETRANGE("Audit Line Type", AuditLines."Audit Line Type"::"Audit Plan");
                        IF AuditLines.FIND('-')THEN BEGIN
                            REPEAT GlobalAuditLine.INIT;
                                GlobalAuditLine."Document No.":="No.";
                                GlobalAuditLine."Audit Line Type":=GlobalAuditLine."Audit Line Type"::Scope;
                                GetNextLineNo;
                                GlobalAuditLine."Line No.":=NextLineNo;
                                AuditLines.CALCFIELDS(Description);
                                GlobalAuditLine.Description:=AuditLines.Description;
                                GlobalAuditLine.VALIDATE(Description);
                                GlobalAuditLine.INSERT;
                            UNTIL AuditLines.NEXT = 0;
                        END;
                    END;
                END;
                END;
                AuditMgt.GetAuditPlanStatus(Rec);
            end;
        }
        field(25; "Send Attachment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Employee.GET("Employee No.")THEN BEGIN
                    "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Sender E-Mail":=Employee."Company E-Mail";
                    "Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                END;
            end;
        }
        field(28; "Notification Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Date Completed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Date Reviewed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Audit Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Not Done,In - Progress,Done';
            OptionMembers = "Not Done", "In - Progress", Done;
        }
        field(32; "Audit Notification No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Communication Header" WHERE(Type=FILTER("Audit Notification"), Sent=FILTER(true));
        }
        field(33; "Reviewed By Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Audit Program No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Audit Header" WHERE(Type=FILTER("Audit Program"));

            trigger OnValidate()
            begin
                AuditMgt.InsertReportObjectivesFromProgram(Rec, "Audit Program No.");
                AuditMgt.InsertScopeFromProgram(Rec, "Audit Program No.");
                AuditMgt.GetAuditPlanStatus(Rec);
                IF AuditHeader.GET("Audit Program No.")THEN BEGIN
                    CASE Type OF Type::"Work Paper": BEGIN
                        "Done By":=AuditHeader."Created By";
                        "Done By Name":=AuditHeader."Employee Name";
                        "Audit Manager":=AuditHeader."Audit Manager";
                        "Shortcut Dimension 1 Code":=AuditHeader."Shortcut Dimension 1 Code";
                        "Shortcut Dimension 2 Code":=AuditHeader."Shortcut Dimension 2 Code";
                    END;
                    Type::"Audit Report": BEGIN
                        "Audit Manager":=AuditHeader."Audit Manager";
                        "Audit Period Start Date":=AuditHeader."Audit Period Start Date";
                        "Shortcut Dimension 1 Code":=AuditHeader."Shortcut Dimension 1 Code";
                        "Shortcut Dimension 2 Code":=AuditHeader."Shortcut Dimension 2 Code";
                    END;
                    END;
                END;
            end;
        }
        field(35; "Audit WorkPaper No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Type=CONST("Audit Report"))"Audit Header" WHERE(Type=CONST("Work Paper"), "Audit Program No."=FIELD("Audit Program No."))
            ELSE
            "Audit Header" WHERE(Type=FILTER("Work Paper"));
        // trigger OnLookup()
        // begin
        //     CASE Type OF
        //         Type::"Audit Report":
        //             BEGIN
        //                 AuditHeader2.RESET;
        //                 AuditHeader2.SETRANGE(Type, AuditHeader2.Type::"Work Paper");
        //                 AuditHeader2.SETRANGE("Audit Program No.", "Audit Program No.");
        //                 SelectMultipleWorkpapers;
        //             END;
        //     END;
        // end;
        }
        field(36; "Sender E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(37; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Done By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Done By Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(40; Reviewed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(41; Auditee; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Employee.GET(Auditee)THEN BEGIN
                    "Name of Auditee":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    UserSetup.RESET;
                    UserSetup.SETRANGE("Employee No.", Employee."No.");
                    IF UserSetup.FINDFIRST THEN BEGIN
                        "Auditee User ID":=UserSetup."User ID";
                    END;
                END;
            end;
        }
        field(42; "User Reviewed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Document Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Audit Plan,Audit Program,Working Paper,Audit Report';
            OptionMembers = " ", "Audit Plan", "Audit Program", "Working Paper", "Audit Report";
        }
        field(44; "Cut Off Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Cut Off End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Auditee User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Report Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Audit,Auditee';
            OptionMembers = " ", Audit, Auditee;
        }
        field(48; "Working Paper Scope"; Text[2048])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                CASE Type OF Type::"Work Paper": BEGIN
                    AuditMgt.GetWorkPaperScope(Rec);
                END;
                END;
            end;
        }
        field(49; "Name of Auditee"; Text[100])
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
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(50; "Audit Period Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accounting Period" where(Closed=const(false));
        }
        field(51; "Sent for review"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Audit Manager No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger Onvalidate()
            var
                Emp: Record Employee;
            begin
                if Emp.get("Audit Manager No.")then "Audit Manager":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(53; Introduction; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Objectives Statement"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Total Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Audit Lines"."Total Amount" where("Document No."=field("No.")));
        }
        field(56; "Interviewee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Audit Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Audit Period";
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
    trigger OnDelete()
    begin
        IF Status <> Status::Open THEN ERROR(DeleteErr);
    end;
    trigger OnInsert()
    begin
        AuditSetup.GET;
        CASE Type OF Type::Audit: BEGIN
            AuditSetup.TESTFIELD("Audit Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Audit Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
        Type::"Audit WorkPlan": BEGIN
            AuditSetup.TESTFIELD("Audit Workplan Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Audit Workplan Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
        Type::Risk: BEGIN
            AuditSetup.TESTFIELD("Risk Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Risk Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
        Type::"Audit Record Requisition": BEGIN
            AuditSetup.TESTFIELD("Audit Record Requisition Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Audit Record Requisition Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
        Type::"Audit Plan": BEGIN
            AuditSetup.TESTFIELD("Audit Plan Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Audit Plan Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
        Type::"Work Paper": BEGIN
            AuditSetup.TESTFIELD("Work Paper Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Work Paper Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
        Type::"Audit Report": BEGIN
            AuditSetup.TESTFIELD("Audit Report Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Audit Report Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
        Type::Inspection: BEGIN
            AuditSetup.TESTFIELD("Inspection Report Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Inspection Report Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
        Type::"Risk Survey": BEGIN
            AuditSetup.TESTFIELD("Risk Survey Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Risk Survey Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
        Type::"Department Register": BEGIN
            AuditSetup.TESTFIELD("Risk Register Nos");
            NoSeriesMgt.InitSeries(AuditSetup."Risk Register Nos", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
        Type::"Audit Program": BEGIN
            AuditSetup.TESTFIELD("Audit Program Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Audit Program Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
            "Document Status":="Document Status"::"Audit Plan";
        END;
        Type::Compliance: BEGIN
            AuditSetup.TESTFIELD("Compliance Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Compliance Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
        Type::"Strategic Plan": BEGIN
            AuditSetup.TESTFIELD("Strategic Audit Plan Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Strategic Audit Plan Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
            "Document Status":="Document Status"::"Audit Plan";
        END;
        Type::"Quarterly Audit": BEGIN
            AuditSetup.TESTFIELD("Quarterly Audit Plan Nos.");
            NoSeriesMgt.InitSeries(AuditSetup."Quarterly Audit Plan Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
        END;
        "Created By":=USERID;
        Date:=TODAY;
        //Insert User E-Mail
        CASE Type OF Type::"Risk Survey": BEGIN
            IF UserSetup.GET(USERID)THEN IF Employee.GET(UserSetup."Employee No.")THEN "Sender E-Mail":=Employee."E-Mail";
        END;
        END;
        IF UserSetup.GET(USERID)THEN IF Employee.GET(UserSetup."Employee No.")THEN BEGIN
                "Employee No.":=Employee."No.";
                "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                "Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                "Shortcut Dimension 2 Code":=Employee."Global Dimension 2 Code";
                Validate("Shortcut Dimension 2 Code");
            END;
    end;
    var AuditSetup: Record "Audit Setup";
    DeleteErr: Label 'You cannot Delete documents that have already been processed';
    UserSetup: Record "User Setup";
    Employee: Record Employee;
    Rating: Record "Risk Rating";
    DimValue: Record "Dimension Value";
    AuditHeader: Record "Audit Header";
    AuditHeader2: Record "Audit Header";
    AuditLines: Record "Audit Lines";
    GlobalAuditLine: Record "Audit Lines";
    NextLineNo: Integer;
    Inst: InStream;
    ScopeNote: BigText;
    ScopeNotesText: Text;
    Outst: OutStream;
    SelectionFilter: Text;
    ProgScopeList: Page "Audit Scope";
    AuditMgt: Codeunit "Internal Audit Management";
    DimMgt: Codeunit DimensionManagement;
    NoSeriesMgt: Codeunit NoSeriesManagement;
    WorkpaperList: Page "Reviewed Audit Work Papers";
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
    local procedure GetEmployeeName()
    begin
    end;
    local procedure GetNextLineNo()
    begin
        GlobalAuditLine.LOCKTABLE;
        GlobalAuditLine.SETRANGE("Document No.", "No.");
        GlobalAuditLine.SETRANGE("Audit Line Type", GlobalAuditLine."Audit Line Type"::Scope);
        IF GlobalAuditLine.FINDLAST THEN NextLineNo:=GlobalAuditLine."Line No." + 10000
        ELSE
            NextLineNo:=10000;
    end;
    procedure SelectMultipleWorkpapers()
    var
        AuditLineRec: Record "Audit Lines";
        AuditLineRec2: Record "Audit Lines";
    begin
        SelectionFilter:=WorkpaperList.SelectActiveWorkpapersForReport;
        IF SelectionFilter <> '' THEN AddWorkingPapersPart(SelectionFilter);
    end;
    local procedure AddWorkingPapersPart(SelectionFilter: Text)
    var
        AuditRec: Record "Audit Header";
        AuditLineRec: Record "Audit Lines";
        LocalAuditLine: Record "Audit Lines";
    begin
        AuditHeader.SETFILTER("No.", SelectionFilter);
        IF AuditHeader.FINDSET THEN REPEAT AuditLineRec.INIT;
                AuditLineRec."Document No.":="No.";
                AuditLineRec."Audit Line Type":=AuditLineRec."Audit Line Type"::"Report Workpapers";
                AuditLineRec."Line No.":=InitNewLine;
                AuditLineRec."Report Workpaper No.":=AuditHeader."No.";
                AuditLineRec.VALIDATE("Report Workpaper No.");
                AuditLineRec."Report Workpaper Description":=AuditHeader.Description;
                AuditLineRec.INSERT(TRUE);
                GlobalAuditLine.RESET;
                GlobalAuditLine.SETRANGE("Document No.", AuditHeader."No.");
                GlobalAuditLine.SETRANGE("Audit Line Type", GlobalAuditLine."Audit Line Type"::"WorkPaper Conclusion");
                IF GlobalAuditLine.FIND('-')THEN BEGIN
                    REPEAT LocalAuditLine.INIT;
                        LocalAuditLine."Document No.":="No.";
                        IF GlobalAuditLine.Favourable THEN BEGIN
                            LocalAuditLine."Audit Line Type":=LocalAuditLine."Audit Line Type"::"Report Observation";
                            LocalAuditLine."Line No.":=AuditMgt.GetFavObservationNo("No.");
                        END
                        ELSE
                        BEGIN
                            LocalAuditLine."Audit Line Type":=LocalAuditLine."Audit Line Type"::"Report Recommendation";
                            LocalAuditLine."Line No.":=AuditMgt.GetUnFavObservationNo("No.");
                        END;
                        GlobalAuditLine.CALCFIELDS(Description);
                        LocalAuditLine.Description:=GlobalAuditLine.Description;
                        LocalAuditLine.INSERT;
                    UNTIL GlobalAuditLine.NEXT = 0;
                END;
                OnAfterInsertWorkingPapers(AuditLineRec);
            UNTIL AuditHeader.NEXT = 0;
    end;
    local procedure InitNewLine(): Integer var
        AuditLinesRec: Record "Audit Lines";
        NextLineNo: Integer;
    begin
        AuditLinesRec.SETRANGE("Document No.", "No.");
        AuditLinesRec.SETRANGE("Audit Line Type", AuditLinesRec."Audit Line Type"::"Report Workpapers");
        IF AuditLinesRec.FINDLAST THEN NextLineNo:=AuditLinesRec."Line No." + 10000
        ELSE
            NextLineNo:=10000;
        EXIT(NextLineNo);
    end;
    procedure SelectMultipleProgScope()
    begin
        AuditHeader2.RESET;
        AuditHeader2.SETRANGE(Type, AuditHeader2.Type::"Audit Program");
        AuditHeader2.SETRANGE("No.", "Audit Program No.");
        SelectionFilter:=ProgScopeList.SelectActiveScopeForWorkpaper(Rec);
        IF SelectionFilter <> '' THEN AddProgramScope(SelectionFilter);
    end;
    local procedure AddProgramScope(SelectionFilter: Text)
    var
        AuditRec: Record "Audit Header";
        AuditLineRec: Record "Audit Lines";
    begin
        AuditLines.SETFILTER("Document No.", SelectionFilter);
        IF AuditLines.FIND('-')THEN REPEAT AuditLineRec.INIT;
                AuditLineRec."Document No.":="No.";
                AuditLineRec."Audit Line Type":=AuditLineRec."Audit Line Type"::"WorkPaper Scope";
                AuditLineRec."Line No.":=InitNewScopeLine;
                AuditLines.CALCFIELDS(Description);
                AuditLineRec.Description:=AuditLines.Description;
                AuditLineRec.VALIDATE(Description);
                AuditLineRec.INSERT(TRUE);
            UNTIL AuditLines.NEXT = 0;
    end;
    local procedure InitNewScopeLine(): Integer var
        AuditLinesRec: Record "Audit Lines";
        NextLineNo: Integer;
    begin
        AuditLinesRec.SETRANGE("Document No.", "No.");
        AuditLinesRec.SETRANGE("Audit Line Type", AuditLinesRec."Audit Line Type"::"WorkPaper Scope");
        IF AuditLinesRec.FINDLAST THEN NextLineNo:=AuditLinesRec."Line No." + 10000
        ELSE
            NextLineNo:=10000;
        EXIT(NextLineNo);
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterInsertWorkingPapers(AuditLineRec: Record "Audit Lines")
    begin
    end;
}

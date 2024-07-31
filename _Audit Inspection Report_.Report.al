report 50350 "Audit Inspection Report"
{
    caption = 'Special Investigation report';
    DefaultLayout = Word;
    RDLCLayout = './AuditInspectionReport.rdl';
    WordLayout = './AuditInspectionReport.docx';
    ApplicationArea = All;

    dataset
    {
        dataitem("Audit Header"; "Audit Header")
        {
            DataItemTableView = WHERE(Type = FILTER(Inspection));

            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompCity; CompanyInfo.City)
            {
            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompLogo; CompanyInfo.Picture)
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(No_AuditHeader; "Audit Header"."No.")
            {
            }
            column(ShortcutDimension1Code; "Audit Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; GetDepartmentName("Audit Header"."Shortcut Dimension 2 Code"))
            {
            }
            column(AuditPeriod; "Audit Header"."Audit Period Start Date")
            {
            }
            column(Date; Date)
            {
            }
            column(Type; "Audit Header".Type)
            {
            }
            column(Risk_Likelihood; "Risk Likelihood")
            {
            }
            column(Employee_Name; "Interviewee Name")
            {
            }
            column(Audit_WorkPaper_No_; "Audit WorkPaper No.")
            {
            }
            column(DepartmentName; "Audit Header"."Department Name")
            {
            }
            column(AuditStatus; "Audit Header"."Document Status")
            {
            }
            column(Introduction; IntroNotesText)
            {
            }
            column(ObjectivesStatement; ObjectivesNotesText)
            {
            }
            column(Title; Title)
            {
            }
            column(CreatedBy; GetUserNameFromUserID("Audit Header"."Created By"))
            {
            }
            column(Created_By_date; Date)
            {
            }
            column(Created_By_Signature; UserSetup2.signature)
            {
            }
            column(ApproverName; GetUserNameFromUserID(Approver[2]))
            {
            }
            column(ApproverDate; format(ApproverDate[2], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Approver_By_Signature; UserSetup1.Signature)
            {
            }
            dataitem(Findings; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER(Findings));

                column(Line_No_; Number)
                {
                }
                column(Description_2; "Description 2")
                {
                }
            }
            dataitem(Recommendations; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER("Report Recommendation"));

                column(Recommendation; "Audit Description")
                {
                }
            }
            dataitem(Worksheet; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER(Queries));

                column(WNumber; Number)
                {
                }
                column(WQuestion; "Description 2")
                {
                }
                column(WComment; "Audit Description")
                {
                }
                column(WInitials; "Done By")
                {
                }
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                CALCFIELDS(Introduction, "Objectives Statement");
                Introduction.CREATEINSTREAM(Instr);
                IntroNote.READ(Instr);
                IntroNotesText := Format(IntroNote);
                "Objectives Statement".CREATEINSTREAM(Instr);
                ObjectivesNote.READ(Instr);
                ObjectivesNotesText := Format(ObjectivesNote);
                ApprovalEntry.RESET;
                ApprovalEntry.SETCURRENTKEY("Document No.", "Sequence No.");
                ApprovalEntry.SETRANGE("Document No.", "Audit Header"."No.");
                IF ApprovalEntry.FIND('-') THEN BEGIN
                    if ApprovalEntry."Sequence No." = 1 then BEGIN
                        Approver[1] := ApprovalEntry."Sender ID";
                        ApproverDate[1] := DT2DATE(ApprovalEntry."Date-Time Sent for Approval");
                        UserSetup2.Reset();
                        UserSetup2.SetRange("User ID", Approver[1]);
                        if UserSetup2.FindFirst() then UserSetup2.CalcFields(Signature);
                    END;
                END;
                ApprovalEntry.RESET;
                ApprovalEntry.SETCURRENTKEY("Document No.", "Sequence No.");
                ApprovalEntry.SETRANGE("Document No.", "Audit Header"."No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                IF ApprovalEntry.FIND('-') THEN BEGIN
                    REPEAT
                        CASE TRUE OF
                            ApprovalEntry."Sequence No." = 1:
                                BEGIN
                                    Approver[2] := ApprovalEntry."Last Modified By User ID";
                                    ApproverDate[2] := DT2DATE(ApprovalEntry."Last Date-Time Modified");
                                    UserSetup1.Reset();
                                    UserSetup1.SetRange("User ID", Approver[2]);
                                    if UserSetup1.FindFirst() then UserSetup1.CalcFields(Signature);
                                END;
                            ApprovalEntry."Sequence No." = 2:
                                BEGIN
                                    Approver[3] := ApprovalEntry."Last Modified By User ID";
                                    ApproverDate[3] := DT2DATE(ApprovalEntry."Last Date-Time Modified");
                                END;
                        END;
                    UNTIL ApprovalEntry.NEXT = 0;
                END;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Instr: InStream;
        DNotes: BigText;
        DNotesText: Text;
        OutStr: OutStream;
        AuditLine: Record "Audit Lines";
        DimensionVal: Record "Dimension Value";
        AuditFile: Text[250];
        TotalDays: Text[200];
        IntroNote: BigText;
        IntroNotesText: Text;
        ObjectivesNote: BigText;
        ObjectivesNotesText: Text;
        ApprovalEntry: Record "Approval Entry";
        Approver: array[100] of Code[50];
        ApproverDate: array[100] of Date;
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";

    local procedure GetDepartmentName(DeptCode: Code[20]): Text[150]
    begin
        DimensionVal.Reset;
        DimensionVal.SetRange(Code, DeptCode);
        if DimensionVal.Find('-') then exit(DimensionVal.Name);
    end;

    procedure GetFinancialYear(): Code[20]
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.get;
        exit(GLSetup."Current Budget");
    end;

    local procedure GetUserNameFromUserID(UserName: Code[50]): Text
    begin
        IF UserSetup.GET(UserName) THEN BEGIN
            IF Employee.GET(UserSetup."Employee No.") THEN EXIT(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
        END;
    end;
}

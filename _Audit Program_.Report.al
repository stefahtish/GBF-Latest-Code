report 50359 "Audit Program"
{
    DefaultLayout = Word;
    RDLCLayout = './AuditProgram.rdl';
    WordLayout = './AuditProgram.docx';
    Caption = 'Audit Program';
    ApplicationArea = All;

    dataset
    {
        dataitem("Audit Header"; "Audit Header")
        {
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompLogo; CompanyInfo.Picture)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompAddr2; CompanyInfo."Address 2")
            {
            }
            column(CompCity; CompanyInfo.City)
            {
            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
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
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(No_AuditHeader; "Audit Header"."No.")
            {
            }
            column(Title; UPPERCASE(Title))
            {
            }
            column(Date_AuditHeader; Format("Audit Header".Date, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Description_AuditHeader; "Audit Header".Description)
            {
            }
            column(ShortcutDimension1Code; "Audit Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; AuditMgt.GetDimensionValue("Audit Header"."Shortcut Dimension 2 Code"))
            {
            }
            column(CreatedBy; GetUserNameFromUserID("Audit Header"."Created By"))
            {
            }
            column(ApproverName; GetUserNameFromUserID(Approver[2]))
            {
            }
            column(ApproverDate; format(ApproverDate[2], 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(AuditFirm_AuditHeader; "Audit Header"."Audit Firm")
            {
            }
            column(AuditManager_AuditHeader; "Audit Header"."Audit Manager")
            {
            }
            dataitem("Audit Lines"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Audit Line Type", "Audit Code", "Line No.") ORDER(Ascending);

                column(AuditDescription2; "Audit Lines"."Audit Description")
                {
                }
                column(WorkPlanRef; "Audit Lines"."WorkPlan Ref")
                {
                }
                column(DoneBy; "Audit Lines"."Done By")
                {
                }
                column(Date; "Audit Lines".Date)
                {
                }
                column(AuditLineType; "Audit Lines"."Audit Line Type")
                {
                }
                column(AuditDescription; DNotesText)
                {
                }
                column(Auditor_AuditLines; "Audit Lines".Auditor)
                {
                }
                column(AuditorName_AuditLines; "Audit Lines"."Auditor Name")
                {
                }
                column(Approver; GetUserNameFromUserID(Approver[1]))
                {
                }
                column(ProgramScope_AuditLines; DNotesText)
                {
                }
                column(Review_AuditLines; "Audit Lines".Review)
                {
                }
                column(Review_Scope_No; "Audit Lines"."Review Scope No.")
                {
                }
                column(Procedures_Prepared_By; "Audit Lines"."Procedure Prepared By.")
                {
                }
                column(ReviewProcedure_AuditLines; DNotesTextReviewProcedure)
                {
                }
                trigger OnAfterGetRecord()
                begin
                end;
            }
            dataitem(AuditScope; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER(Scope));
            }
            dataitem(AuditObjectives; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER(objectives));

                column(Objective; "Description 2")
                {
                }
                column(Line_No_; "Line No.")
                {
                }
            }
            dataitem(AuditScope2; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER(Scope), "Scope Selected" = const(true));

                column(Scope; "Description 2")
                {
                }
            }
            //Pre-field work 
            dataitem(Prefieldwork; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER(Planning));

                column(Prefieldwork_Step; "Audit Description")
                {
                }
                column(Prefieldwork_Description; DNotesText)
                {
                }
                column(Prefieldwork_DoneBy; "Done By")
                {
                }
                column(Prefieldwork_WorkPlan; "WorkPlan Ref")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //Convert Description to Text
                    Prefieldwork.CALCFIELDS(Description);
                    Prefieldwork.Description.CREATEINSTREAM(Instr);
                    DNotes.READ(Instr);
                    DNotesText := FORMAT(DNotes);
                    //End of Conversion
                end;
            }
            dataitem(AuditStep; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER("Field work step"));

                column(AuditStep_Description; "Audit Description")
                {
                }
                column(AuditStep_DoneBy; "Done By")
                {
                }
                column(AuditStep_WorkPlan; "WorkPlan Ref")
                {
                }
            }
            dataitem(ReviewProcedures; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER(Review));

                column(Review; Review)
                {
                }
                column(ReviewScope; DNotesText2)
                {
                }
                column(Review_Procedure_Blob; DNotesTextReviewProcedure)
                {
                }
                column(Done_By; "Done By")
                {
                }
                column(WorkPlan_Ref; "WorkPlan Ref")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //Convert Description to Text
                    ReviewProcedures.CALCFIELDS("Review Procedure Blob");
                    ReviewProcedures."Review Procedure Blob".CREATEINSTREAM(Instr);
                    DNotesReviewProcedure.READ(Instr);
                    DNotesTextReviewProcedure := FORMAT(DNotesReviewProcedure);
                    //End of Conversion
                    //Convert Description to Text
                    ReviewProcedures.CALCFIELDS(Description);
                    ReviewProcedures.Description.CREATEINSTREAM(Instr);
                    DNotes2.READ(Instr);
                    DNotesText2 := FORMAT(DNotes2);
                    //End of Conversion
                end;
            }
            dataitem(ReportingResults; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER("Post Reveiw"));

                column(ReportingResult_Description; "Audit Description")
                {
                }
                column(ReportingResult_DoneBy; "Done By")
                {
                }
                column(ReportingResult_WorkPlanRef; "WorkPlan Ref")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                ApprovalEntry.RESET;
                ApprovalEntry.SETCURRENTKEY("Document No.", "Sequence No.");
                ApprovalEntry.SETRANGE("Document No.", "Audit Header"."No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                IF ApprovalEntry.FIND('-') THEN BEGIN
                    REPEAT
                        CASE TRUE OF
                            ApprovalEntry."Sequence No." = 1:
                                BEGIN
                                    Approver[1] := ApprovalEntry."Sender ID";
                                    ApproverDate[1] := DT2DATE(ApprovalEntry."Date-Time Sent for Approval");
                                    Approver[2] := ApprovalEntry."Last Modified By User ID";
                                    ApproverDate[2] := DT2DATE(ApprovalEntry."Last Date-Time Modified");
                                END;
                        //  ApprovalEntry."Sequence No." = 2:
                        // BEGIN
                        //Approver[2] := ApprovalEntry."Last Modified By User ID";
                        //ApproverDate[2] := DT2DATE(ApprovalEntry."Last Date-Time Modified");
                        // END;
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
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Instr: InStream;
        DNotes: BigText;
        DNotesText: Text;
        OutStr: OutStream;
        AuditLine: Record "Audit Lines";
        AuditMgt: Codeunit "Internal Audit Management";
        ApprovalEntry: Record "Approval Entry";
        Approver: array[100] of Code[50];
        ApproverDate: array[100] of Date;
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        DNotesReviewProcedure: BigText;
        InstrReviewProcedure: InStream;
        DNotesTextReviewProcedure: Text;
        OutStrReviewProcedure: OutStream;
        DNotes2: BigText;
        Instr2: InStream;
        DNotesText2: Text;
        OutStr2: OutStream;

    local procedure GetUserNameFromUserID(UserName: Code[50]): Text
    begin
        IF UserSetup.GET(UserName) THEN BEGIN
            IF Employee.GET(UserSetup."Employee No.") THEN EXIT(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
        END;
    end;
}

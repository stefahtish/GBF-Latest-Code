page 50411 "Appraisal Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Appraisal';
    SourceTable = "Employee Appraisal";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Caption = 'Appraisal No';
                    Editable = false;
                }
                label("Period Under Review:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Period Start"; Rec."Period Start")
                {
                    Caption = 'From';
                }
                field("Period End"; Rec."Period End")
                {
                    Caption = 'To';
                }
                label("PERSONAL PARTICULARS:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Caption = 'Appraisee No';
                }
                field("Appraisee Name"; Rec."Appraisee Name")
                {
                    Editable = false;
                }
                field("Appraisee's Job Title"; Rec."Appraisee's Job Title")
                {
                    Editable = false;
                }
                field("Job Grade"; Rec."Job Group")
                {
                    Editable = false;
                }
                label("Appraiser:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Appraisal Type"; Rec.AppraisalType)
                {
                }
                field("Appraiser ID"; Rec."Appraiser ID")
                {
                    Editable = false;
                }
                field("Appraiser No"; Rec."Appraiser No")
                {
                }
                field("Appraisers Name"; Rec."Appraisers Name")
                {
                    Editable = false;
                }
                field("Appraiser's Job Title"; Rec."Appraiser's Job Title")
                {
                    Editable = false;
                }
                label("Performance Score")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Values Total"; Rec."Values Total")
                {
                    Editable = false;
                }
                field("Values Mean"; Rec."Values Mean")
                {
                    Editable = false;
                }
                field("Competences Total"; Rec."Competences Total")
                {
                    Editable = false;
                }
                field("Competences Mean"; Rec."Competences Mean")
                {
                    Editable = false;
                }
                field("Curriculum Total"; Rec."Curriculum Total")
                {
                    Editable = false;
                }
                field("Curriculum Mean"; Rec."Curriculum Mean")
                {
                    Editable = false;
                }
                field("Research Total"; Rec."Research Total")
                {
                    Editable = false;
                }
                field("Research Mean"; Rec."Research Mean")
                {
                    Editable = false;
                }
                field("Initiative Total"; Rec."Initiative Total")
                {
                    Editable = false;
                }
                field("Initiative Mean"; Rec."Initiative Mean")
                {
                    Editable = false;
                }
                field("Managerial Total"; Rec."Managerial Total")
                {
                    Editable = false;
                }
                field("Managerial  Mean"; Rec."Managerial  Mean")
                {
                    Editable = false;
                }
                label("Performance Targets:")
                {
                    Caption = 'Performance Targets';
                    Style = Strong;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field("Target Score"; Rec."Target Score")
                {
                    Caption = 'Total Score';
                    Editable = false;
                    Visible = false;
                }
                field("Target Avg"; Rec."Target Avg")
                {
                    Caption = 'Mean Score';
                    Editable = false;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                }
            }
            part("Performance Rating"; "Performance Plan")
            {
                Caption = 'Performance Rating';
                Editable = (Rec."Appraisal Status" = Rec."Appraisal Status"::Setting) OR (Rec."Appraisal Status" = Rec."Appraisal Status"::Review);
                Enabled = (Rec."Appraisal Status" = Rec."Appraisal Status"::Setting) OR (Rec."Appraisal Status" = Rec."Appraisal Status"::Review);
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
            }
            part(Control13; "Appraiser & Appraisee Comments")
            {
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                Visible = false;
            }
            label("Value/Core Competencies:")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            // part("<Values>"; "Appraisal Values")
            // {
            //     Caption = '<Values>';
            //     SubPageLink = "Appraisal No." = FIELD("Appraisal No");
            //     SubPageView = WHERE("" = FILTER(Values));
            // }
            // part("Core Competences"; "Core Value/Competence")
            // {
            //     Caption = 'Core Competences';
            //     SubPageLink = "Appraisal No." = FIELD("Appraisal No");
            //     SubPageView = WHERE("Value/Core Competence" = FILTER("Core Competences"));
            // }
            // part("Curriculum Delivery"; "Appraisal Curriculum Delivery")
            // {
            //     Caption = 'Curriculum Delivery';
            //     SubPageLink = "Appraisal No." = FIELD("Appraisal No");
            //     SubPageView = WHERE("Value/Core Competence" = FILTER("Curriculum Delivery"));
            // }
            // part(Research; "Appraisal Research")
            // {
            //     Caption = 'Research';
            //     SubPageLink = "Appraisal No." = FIELD("Appraisal No");
            //     SubPageView = WHERE("Value/Core Competence" = FILTER(Research));
            // }
            // part("Initiative & Willingness"; "Initiative & Willingness")
            // {
            //     Caption = 'Initiative & Willingness';
            //     SubPageLink = "Appraisal No." = FIELD("Appraisal No");
            //     SubPageView = WHERE("Value/Core Competence" = FILTER("Initiative & Willingness"));
            // }
            // part("Managerial & Supervisory"; "Managerial Values/Competence")
            // {
            //     Caption = 'Managerial & Supervisory';
            //     SubPageLink = "Appraisal No." = FIELD("Appraisal No");
            //     SubPageView = WHERE( = FILTER(""));
            // }
            label("Appraisal Comments:")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(Control37; "Appraisee's Appraisal Comments")
            {
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = FILTER(Appraisee));
            }
            part("Comments by Second Supervisor"; "Second Supervisor Comments")
            {
                Caption = 'Comments by Second Supervisor';
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = FILTER("Second Supervisor"));
            }
            part(Control39; "HR Appraisal Comments")
            {
                SubPageLink = "Appraisal No." = FIELD("Appraisal No");
                SubPageView = WHERE(Person = FILTER(HR));
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Preview)
            {
                Caption = 'Preview';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    /*
                        EmployeeApp.RESET;
                        EmployeeApp.SETRANGE("Appraisal No","Appraisal No");
                          IF EmployeeApp.FIND('-') THEN
                            REPORT.RUNMODAL(000000,TRUE,FALSE,EmployeeApp);
                        */
                end;
            }
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckEmployeeAppraisalWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendEmployeeAppraisalRequestforApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelEmployeeAppraisalApprovalRequest(Rec);
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Batch Contributions","Multi-Period Contributions",Claims,"New Members","Interest Allocation","Change Requests","Bulk Change Requests","Batch Claims","Payment Voucher",Imprest,"Imprest Surrender","Petty Cash","Petty Cash Surrender","Store Requisitions","Purchase Requisitions","Staff Claim","Bank Transfer","Staff Advance",Quotation,QuoteEvaluation,LeaveAdjustment,TrainingRequest,LeaveApplication,"Travel Requests",Recruitment,"Employee Transfer","Employee Appraisal","Leave Recall","Maintenance Registration","Payroll Change","Payroll Request",LoanApplication,"Employee Acting","Employee Promotion","Medical Item Issue","Semester Registration",Budget,"Proposed Budget","Bank Rec",Audit,Risk,"Audit WorkPlan","Audit Record Requisition","Audit Plan","Work Paper","Audit Report","Risk Survey","Audit Program","FA Disposal",Equity,Money_Market,Property,TPS;
                begin
                    DocumentType := DocumentType::"Employee Appraisal";
                    ApprovalEntries.SetRecordFilters(DATABASE::"Employee Appraisal", DocumentType, Rec."Appraisal No");
                    ApprovalEntries.Run;
                end;
            }
            action("Lock Performance")
            {
                Image = CheckJournal;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Set;
                    Message('Performance Locked');
                end;
            }
            action("Review Targets")
            {
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Review;
                    Message('Appraisal has been opened for Review');
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        HRManagement.UpdateAppraisalScores(Rec."Appraisal No", Rec."Employee No");
        CurrPage.Update;
    end;

    trigger OnOpenPage()
    begin
        HRManagement.UpdateAppraisalScores(Rec."Appraisal No", Rec."Employee No");
        CurrPage.Update;
    end;

    var
        Employee: Record Employee;
        Jobs: Record "Company Job";
        EmployeeApp: Record "Employee Appraisal";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        AppraisalCompetences: Record "Appraisal Competences";
        HRManagement: Codeunit "HR Management";
}

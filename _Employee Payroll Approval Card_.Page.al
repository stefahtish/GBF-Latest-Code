page 50699 "Employee Payroll Approval Card"
{
    Caption = 'Payroll Approval Card';
    PageType = Card;
    SourceTable = "Payroll Approval";
    PromotedActionCategories = 'New,Process,Report,Approval,Account Schedules';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = (Rec.Status = Rec.Status::Open);

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Period field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Total Earning"; Rec."Total Earning")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Earning field';
                }
                field("Total Allowances"; Rec."Total Allowances")
                {
                    Caption = 'Gross earnings';
                    ApplicationArea = All;
                }
                field("Net Pay"; Rec."Net Pay")
                {
                    ApplicationArea = All;
                }
                field("Total Arrears"; Rec."Total Arrears")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Arrears field';
                }
                field("Total Deduction"; Rec."Total Deduction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Deduction field';
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Net Amount field';
                }
                field(MonthlyDiff; MonthlyDiff)
                {
                    Caption = 'Monthly Difference';
                    ApplicationArea = All;
                }
                field("Estimated Charges"; Rec."Estimated Charges")
                {
                    ApplicationArea = All;
                }
                field("Payroll S2b generated"; Rec."Payroll S2b generated")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Interbank S2b generated"; Rec."Interbank S2b generated")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field';
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Modified Date field';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
            part(PayrollLines; "HR Payroll Approval Lines")
            {
                Editable = false;
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
            part("Bank references"; "Bank references")
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Functions)
            {
                action("Update Lines")
                {
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Update Lines action';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CreatePayrollApprovalLine(Rec."No.", Rec."Payroll Period");
                    end;
                }
                group("Preview S2B files")
                {
                    action("Preview Bank Transfer")
                    {
                        Image = Refresh;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            GenerateInterbankS2B: report "Generate Employee Interbank";
                        begin
                            Rec.Preview := true;
                            Rec.Modify();
                            Commit();
                            Rec.SetRange("No.", Rec."No.");
                            GenerateInterbankS2B.SetTableView(Rec);
                            GenerateInterbankS2B.Run();
                        end;
                    }
                    action("Preview Payroll Payments Excel To S2B")
                    {
                        Image = Refresh;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            GenerateS2B: report "Generate Employee Files";
                            PayMgmt: Codeunit "Payments Management";
                        begin
                            Rec.Preview := true;
                            Rec.Modify();
                            Commit();
                            Rec.SetRange("No.", Rec."No.");
                            GenerateS2B.SetTableView(Rec);
                            GenerateS2B.Run();
                        end;
                    }
                    action("Preview Payments To S2B")
                    {
                        Image = Refresh;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        Caption = 'Preview Payroll Payments To S2B';

                        trigger OnAction()
                        var
                            GenerateS2B: report "GenerateEFTFile";
                            PayMgmt: Codeunit "Payments Management";
                        begin
                            Rec.Preview := true;
                            Rec.Modify();
                            Commit();
                            Rec.SetRange("No.", Rec."No.");
                            GenerateS2B.SetTableView(Rec);
                            GenerateS2B.Run();
                        end;
                    }
                }
                group("Generate EFT files")
                {
                    action("Initiate Bank Transfer")
                    {
                        Image = Refresh;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ToolTip = 'Executes the generate S2B Lines action';
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            GenerateInterbankS2B: report "Generate Employee Interbank";
                            UncommitTxt: Label 'Are you sure you want to generate %1 payroll interbank s2b file';
                            UncommitTxt2: Label 'S2B has already been generated for %1 payroll interbank s2b file, do you wish to generate it again?';
                        begin
                            if Rec."Interbank S2b generated" = false then begin
                                if Confirm(UncommitTxt, false, Rec."Payroll Period") = true then begin
                                    Rec.Preview := false;
                                    Commit();
                                    Rec.SetRange("No.", Rec."No.");
                                    GenerateInterbankS2B.SetTableView(Rec);
                                    GenerateInterbankS2B.Run();
                                    Rec."Interbank S2b generated" := true;
                                end;
                            end;
                        end;
                    }
                    action("Generate Payroll Payments To S2B")
                    {
                        Image = Refresh;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        Caption = 'Generate Payroll Payments  Excel To S2B';

                        trigger OnAction()
                        var
                            GenerateS2B: report "Generate Employee Files";
                            PayMgmt: Codeunit "Payments Management";
                            UncommitTxt: Label 'Are you sure you want to generate %1 payroll s2b file';
                            UncommitTxt2: Label 'S2B has already been generated for %1 payroll s2b file, do you wish to generate it again?';
                        begin
                            if Rec."Payroll S2b generated" = false then begin
                                if Confirm(UncommitTxt, false, Rec."Payroll Period") = true then begin
                                    Rec.Preview := false;
                                    Rec.Modify();
                                    Commit();
                                    Rec.SetRange("No.", Rec."No.");
                                    GenerateS2B.SetTableView(Rec);
                                    GenerateS2B.Run();
                                    Rec."Payroll S2b generated" := true;
                                end;
                            end
                            else begin
                                if Confirm(UncommitTxt2, false, Rec."Payroll Period") = true then begin
                                    Rec.Preview := false;
                                    Rec.Modify();
                                    Commit();
                                    Rec.SetRange("No.", Rec."No.");
                                    GenerateS2B.SetTableView(Rec);
                                    GenerateS2B.Run();
                                end;
                            end;
                        end;
                    }
                    action("Generate  Payments To S2B")
                    {
                        Image = Refresh;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            GenerateS2B: report "GenerateEFTFile";
                            PayMgmt: Codeunit "Payments Management";
                            UncommitTxt: Label 'Are you sure you want to generate %1 payroll s2b file';
                            UncommitTxt2: Label 'S2B has already been generated for %1 payroll s2b file, do you wish to generate it again?';
                        begin
                            if Rec."Payroll S2b generated" = false then begin
                                if Confirm(UncommitTxt, false, Rec."Payroll Period") then begin
                                    Rec.Preview := false;
                                    Rec.Modify();
                                    Commit();
                                    Rec.SetRange("No.", Rec."No.");
                                    GenerateS2B.SetTableView(Rec);
                                    GenerateS2B.Run();
                                    Rec."Payroll S2b generated" := true;
                                end;
                            end
                            else begin
                                if Confirm(UncommitTxt2, false, Rec."Payroll Period") then begin
                                    Rec.Preview := false;
                                    Rec.Modify();
                                    Commit();
                                    Rec.SetRange("No.", Rec."No.");
                                    GenerateS2B.SetTableView(Rec);
                                    GenerateS2B.Run();
                                end;
                            end;
                        end;
                    }
                }
                action("Create PV")
                {
                    //Visible = false;
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PayMgmt: Codeunit "Payments Management";
                    begin
                        Rec.reset;
                        Rec.SetRange("No.", Rec."No.");
                        PayMgmt.CreatePVPayrollransfer2(Rec);
                    end;
                }
                action("Clear Lines")
                {
                    // Visible = false;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Clear Lines action';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Text001: Label 'Are you sure you want clear lines for this document?';
                    begin
                        if Confirm(Text001, false) = true then Rec.ClearPayrollApprovalLine(Rec."No.");
                    end;
                }
                action("Consolidated Transfer To Journal")
                {
                    //RunObject = Report "Transfer Journal to GL-New";
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Transfer To Journal action';

                    trigger OnAction()
                    var
                        TransferToJournal: Report "Transfer Journal to GL-New";
                        EmpPostingGroup: Record "Employee Posting GroupX";
                    begin
                        EmpPostingGroup.reset;
                        EmpPostingGroup.setrange("Pay Period Filter", Rec."Payroll Period");
                        TransferToJournal.SetTableView(EmpPostingGroup);
                        TransferToJournal.UseRequestPage(false);
                        TransferToJournal.Run();
                    end;
                }
                action("Payroll Run")
                {
                    Visible = Rec.Status = Rec.Status::Open;
                    Image = Report;
                    Promoted = true;
                    //  PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Payroll Run action';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PayrollRun: Report "Payroll Run1";
                    begin
                        Rec.TestField("Payroll Period");
                        PayrollRun.SetPayPeriod(Rec."Payroll Period");
                        PayrollRun.Run();
                        Rec.CreatePayrollApprovalLine(Rec."No.", Rec."Payroll Period");
                    end;
                }
                action("Generate Employee Paye")
                {
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Transfer to Journal action';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GeneratePAYE: Report "Generate Employee Paye";
                    begin
                        Rec.SetRange("No.", Rec."No.");
                        GeneratePAYE.SetTableView(Rec);
                        GeneratePAYE.UseRequestPage(false);
                        GeneratePAYE.Run();
                    end;
                }
            }
            group(Approvals)
            {
                group(ApprovalProcess)
                {
                    Caption = 'Approval';

                    action(Approve)
                    {
                        ApplicationArea = All;
                        Caption = 'Approve';
                        Image = Approve;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        ToolTip = 'Approve the requested changes.';
                        Visible = OpenApprovalEntriesExistForCurrUser;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            Commit();
                            ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                            CurrPage.Update();
                        end;
                    }
                    action(Reject)
                    {
                        ApplicationArea = All;
                        Caption = 'Reject';
                        Image = Reject;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        ToolTip = 'Reject the approval request.';
                        Visible = OpenApprovalEntriesExistForCurrUser;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            Commit();
                            ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                            CurrPage.Update();
                        end;
                    }
                    action(Delegate)
                    {
                        ApplicationArea = All;
                        Caption = 'Delegate';
                        Image = Delegate;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedOnly = true;
                        ToolTip = 'Delegate the approval to a substitute approver.';
                        Visible = OpenApprovalEntriesExistForCurrUser;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            Commit();
                            ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                            CurrPage.Update();
                        end;
                    }
                    action(Comment)
                    {
                        ApplicationArea = All;
                        Caption = 'Comments';
                        Image = ViewComments;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedOnly = true;
                        ToolTip = 'View or add comments for the record.';
                        Visible = OpenApprovalEntriesExistForCurrUser;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.GetApprovalComment(Rec);
                        end;
                    }
                }
                action(SendApproval)
                {
                    Caption = 'Send Approval Request';
                    Visible = (Rec.Status = Rec.Status::Open);
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Send Approval Request action';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Text001: label 'Are you sure you want to send %1 for approval?';
                    begin
                        if Confirm(Text001, false, Rec."No.") then if ApprovalsMngt.CheckPayrollApprovalApprovalsWorkflowEnabled(Rec) then ApprovalsMngt.OnSendPayrollApprovalForApproval(Rec);
                    end;
                }
                action(CancelApproval)
                {
                    Caption = 'Cancel Approval Request';
                    Visible = (Rec.Status = Rec.Status::"Pending Approval");
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Cancel Approval Request action';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Text001: label 'Are you sure you want to cancel approval request for %1?';
                    begin
                        if Confirm(Text001, false, Rec."No.") then ApprovalsMngt.OnCancelPayrollApprovalApprovalRequest(Rec);
                    end;
                }
                action(Approval)
                {
                    Caption = 'View Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the View Approvals action';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        DocType: Enum "Approval Document Type";
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.Setfilters2(DATABASE::"Payroll Approval", Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
            group("Mail Payslips")
            {
                action("Mail Payslip")
                {
                    //Visible = false;
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Mail Payslip action';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Employee: record Employee;
                        MailBulkPayslips: Report "Mail Bulk Payslips";
                        Text0001: Label 'Do you want to mail the payslips?';
                    begin
                        if Confirm(Text0001, false) = true then begin
                            //Mail single
                            MailBulkPayslips.SetTableView(Employee);
                            MailBulkPayslips.SetPayPeriod(Rec."Payroll Period");
                            MailBulkPayslips.Run;
                        end
                        else
                            exit;
                    end;
                }
            }
        }
        area(Reporting)
        {
            action("Master Roll Report")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the Master Roll Report action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Commit();
                    EmpRec.Reset();
                    EmpRec.SetFilter("Employment Type", '<>%1', EmpRec."Employment Type"::Trustee);
                    EmpRec.SetRange("Pay Period Filter", Rec."Payroll Period");
                    if EmpRec.Find('-') then begin
                        Clear(MasterRoll);
                        MasterRoll.SetTableView(EmpRec);
                        MasterRoll.Run();
                    end;
                end;
            }
            action("Monthly PAYE Report")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the Monthly PAYE Report action';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Commit();
                    EmpRec.Reset();
                    EmpRec.SetFilter("Employment Type", '<>%1', EmpRec."Employment Type"::Trustee);
                    EmpRec.SetRange("Pay Period Filter", Rec."Payroll Period");
                    if EmpRec.Find('-') then begin
                        Clear(MonthlyPAYE);
                        // MonthlyPAYE.GetDefaults("Payroll Period");
                        MonthlyPAYE.SetTableView(EmpRec);
                        MonthlyPAYE.Run();
                    end;
                end;
            }
            group("Management Reports ")
            {
                action("New Payslips")
                {
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ApplicationArea = BasicHR;
                    ToolTip = 'Executes the New Payslips  action';

                    trigger OnAction()
                    begin
                        Commit();
                        EmpRec.Reset();
                        EmpRec.SetFilter("Employment Type", '<>%1', EmpRec."Employment Type"::Trustee);
                        EmpRec.SetRange("Pay Period Filter", Rec."Payroll Period");
                        if EmpRec.Find('-') then begin
                            Clear(Payslips);
                            Payslips.SetTableView(EmpRec);
                            Payslips.Run();
                        end;
                    end;
                }
                action("Earnings Report")
                {
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ApplicationArea = BasicHR;
                    ToolTip = 'Executes the Earnings Report action';

                    trigger OnAction()
                    begin
                        Commit();
                        PayrollPeriodX.Reset();
                        PayrollPeriodX.SetRange("Pay Period Filter", Rec."Payroll Period");
                        if PayrollPeriodX.Find('-') then begin
                            Clear(Earnings);
                            Earnings.SetTableView(PayrollPeriodX);
                            Earnings.Run();
                        end;
                    end;
                }
                action("Deductions Reports")
                {
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ApplicationArea = BasicHR;
                    ToolTip = 'Executes the Deductions Report action';

                    trigger OnAction()
                    begin
                        Commit();
                        PayrollPeriodX.Reset();
                        PayrollPeriodX.SetRange("Pay Period Filter", Rec."Payroll Period");
                        if PayrollPeriodX.Find('-') then begin
                            Clear(Deductions);
                            Deductions.SetTableView(PayrollPeriodX);
                            Deductions.Run();
                        end;
                    end;
                }
                action("Net Pay Bank Transfer")
                {
                    //NetpayBank
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ApplicationArea = BasicHR;
                    ToolTip = 'Executes the Net Pay Bank Transfer action';

                    trigger OnAction()
                    begin
                        Commit();
                        EmpRec.Reset();
                        EmpRec.SetFilter("Employment Type", '<>%1', EmpRec."Employment Type"::Trustee);
                        EmpRec.SetRange("Pay Period Filter", Rec."Payroll Period");
                        if EmpRec.Find('-') then begin
                            Clear(NetpayBank);
                            NetpayBank.SetTableView(EmpRec);
                            NetpayBank.Run();
                        end;
                    end;
                }
                action("Employee Below Pay")
                {
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Employee Below Pay  action';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Commit();
                        AssgnMatrix.Reset();
                        AssgnMatrix.SetRange("Payroll Period", Rec."Payroll Period");
                        if AssgnMatrix.Find('-') then begin
                            Clear(EmployeesBelowPay);
                            EmployeesBelowPay.SetTableView(AssgnMatrix);
                            EmployeesBelowPay.Run();
                        end;
                    end;
                }
                action("SACCO  Reports")
                {
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ApplicationArea = BasicHR;
                    ToolTip = 'Executes the SACCO Reports action';

                    trigger OnAction()
                    begin
                        Commit();
                        EmpRec.Reset();
                        EmpRec.SetFilter("Employment Type", '<>%1', EmpRec."Employment Type"::Trustee);
                        EmpRec.SetRange("Pay Period Filter", Rec."Payroll Period");
                        if EmpRec.Find('-') then begin
                            Clear(SaccoReport);
                            SaccoReport.SetTableView(EmpRec);
                            SaccoReport.Run();
                        end;
                    end;
                }
                action("Employer Earnings & Deductions")
                {
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ApplicationArea = BasicHR;
                    ToolTip = 'Executes the Deductions Report action';

                    trigger OnAction()
                    begin
                        Commit();
                        PayrollPeriodX.Reset();
                        PayrollPeriodX.SetRange("Pay Period Filter", Rec."Payroll Period");
                        if PayrollPeriodX.Find('-') then begin
                            Clear(EmployerDed);
                            EmployerDed.SetTableView(PayrollPeriodX);
                            EmployerDed.Run();
                        end;
                    end;
                }
            }
            group("Statutory Reports")
            {
                action("Monthly Earnings Report")
                {
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ApplicationArea = BasicHR;
                    ToolTip = 'Executes the Monthly Earnings Report action';

                    trigger OnAction()
                    begin
                        Commit();
                        PayrollPeriodX.Reset();
                        PayrollPeriodX.SetRange("Pay Period Filter", Rec."Payroll Period");
                        if PayrollPeriodX.Find('-') then begin
                            Clear(Earnings);
                            Earnings.SetTableView(PayrollPeriodX);
                            Earnings.Run();
                        end;
                    end;
                }
                action("NSSF Report")
                {
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the NSSF Report action';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        DefCode: Code[20];
                    begin
                        Commit();
                        Clear(NSSFReport);
                        DefCode := NSSFReport.GetDefaults();
                        AssgnMatrix.Reset();
                        AssgnMatrix.SetRange("Payroll Period", Rec."Payroll Period");
                        AssgnMatrix.setrange(Code, DefCode);
                        if AssgnMatrix.Find('-') then begin
                            NSSFReport.SetTableView(AssgnMatrix);
                            NSSFReport.Run();
                        end;
                    end;
                }
                action("NHIF Report")
                {
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the NHIF Report action';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        DefCode: code[20];
                    begin
                        Commit();
                        Clear(NHIFReport);
                        DefCode := NHIFReport.GetDefaults();
                        AssgnMatrix.Reset();
                        AssgnMatrix.SetRange("Payroll Period", Rec."Payroll Period");
                        AssgnMatrix.SetRange(Code, DefCode);
                        if AssgnMatrix.Find('-') then begin
                            NHIFReport.SetTableView(AssgnMatrix);
                            NHIFReport.Run();
                        end;
                    end;
                }
                action("Pension Report")
                {
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Pension Report action';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Commit();
                        AssgnMatrix.Reset();
                        AssgnMatrix.SetRange("Payroll Period", Rec."Payroll Period");
                        if AssgnMatrix.Find('-') then begin
                            Clear(PensionReport);
                            // PensionReport.GetDefaults(Code);
                            PensionReport.SetTableView(AssgnMatrix);
                            PensionReport.Run();
                        end;
                    end;
                }
                action("P9A Report ")
                {
                    Image = ResourcePlanning;
                    RunObject = Report "P9A Report";
                    ApplicationArea = BasicHR;
                    ToolTip = 'Executes the P9 action';
                }
            }
            group("Reconciliation Reports")
            {
                action("Monthly Difference Report")
                {
                    RunObject = Report "Payroll Reconciliation";
                    ApplicationArea = BasicHR;
                    ToolTip = 'Executes the Monthly Difference Report action';
                }
                action("Employees Removed ")
                {
                    Image = ChangeCustomer;
                    RunObject = Report "Employees Removed";
                    ApplicationArea = BasicHR;
                    ToolTip = 'Executes the Employees Removed  action';
                }
                action("Summary By Centre")
                {
                    RunObject = Report "Summary By Center_1";
                    ApplicationArea = BasicHR;
                    ToolTip = 'Executes the Summary By Centre action';
                }
                action("Payroll Reconciliation Summary")
                {
                    Image = Reconcile;
                    RunObject = Report "Payroll Reconciliation Summary";
                    ApplicationArea = BasicHR;
                    ToolTip = 'Executes the Payroll Reconciliation Summary action';
                }
                action("Payroll Reconciliation Detailed")
                {
                    trigger OnAction()
                    var
                        GrossEarnings: Report "Gross Earnings & Deductions";
                        PayPeriod: Record "Payroll PeriodX";
                    begin
                        PayPeriod.Reset();
                        PayPeriod.SetRange("Pay Period Filter", Rec."Payroll Period");
                        GrossEarnings.SetDefaults(Rec."No.", Rec."Estimated Charges");
                        GrossEarnings.SetTableView(PayPeriod);
                        //   GrossEarnings.UseRequestPage(false);
                        GrossEarnings.Run();
                    end;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        Rec."Payroll Type" := Rec."Payroll Type"::Employee;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        Rec."Payroll Type" := Rec."Payroll Type"::Employee;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetPageControl();
    end;

    var
        ApprovalsMngt: Codeunit ApprovalMgtCuExtension;
        OpenEmployee: Boolean;
        ApprovedEmployee: Boolean;
        PayApproval: Record "Payroll Approval";
        EmpRec: Record Employee;
        MasterRoll: Report "Master Roll Report";
        MonthlyPAYE: Report "Monthly PAYE Reportx";
        NSSFReport: Report "NSSF Reporting";
        Payslips: Report "New Payslipx";
        NHIFReport: Report NHIF;
        Earnings: Report Earnings;
        Deductions: Report Deductions;
        EmployerDed: report "Employer Earnings & Deductions";
        NetpayBank: Report "Net Pay Bank Transfer";
        EmployeesBelowPay: Report "Employee Below A Third";
        SaccoReport: Report "Sacco Report";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        MonthlyDiff: Decimal;
        LastMonthGross: Decimal;
        ThisMonthGross: Decimal;
        Diff: Decimal;
        AssignMatrix: Record "Assignment Matrix-X";
        PensionReport: Report "Pension Report";
        AssgnMatrix: Record "Assignment Matrix-X";
        PayrollPeriodX: Record "Payroll PeriodX";
        ApprovalMgmt: Codeunit "Approvals Mgmt.";

    local procedure SetPageControl()
    var
        myInt: Integer;
    begin
        if Rec."Payroll Period" <> 0D then begin
            OpenEmployee := false;
            ApprovedEmployee := false;
            AssignMatrix.Reset();
            AssignMatrix.SetRange("Payroll Period", CalcDate('-1M', Rec."Payroll Period"));
            AssignMatrix.SetRange("Non-Cash Benefit", false);
            AssignMatrix.SetRange("Tax Relief", false);
            if AssgnMatrix.Find('-') then begin
                AssgnMatrix.CalcSums(Amount);
                LastMonthGross := AssgnMatrix.Amount;
            end;
            AssignMatrix.Reset();
            AssignMatrix.SetRange("Payroll Period", Rec."Payroll Period");
            AssignMatrix.SetRange("Non-Cash Benefit", false);
            AssignMatrix.SetRange("Tax Relief", false);
            if AssgnMatrix.Find('-') then begin
                AssgnMatrix.CalcSums(Amount);
                ThisMonthGross := AssgnMatrix.Amount;
            end;
            MonthlyDiff := ThisMonthGross - LastMonthGross;
        end;
        case Rec."Payroll Type" of
            Rec."Payroll Type"::Employee:
                begin
                    case Rec.Status of
                        Rec.Status::Open:
                            OpenEmployee := true;
                        Rec.Status::Approved:
                            ApprovedEmployee := true;
                    end;
                end;
        end;
        OpenApprovalEntriesExistForCurrUser := ApprovalMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
    end;
}

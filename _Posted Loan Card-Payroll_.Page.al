page 50682 "Posted Loan Card-Payroll"
{
    Caption = 'Loan Application Form';
    // DelayedInsert = false;
    // DeleteAllowed = false;
    // InsertAllowed = false;
    // ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Loan Application";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Loan No"; Rec."Loan No")
                {
                    Editable = false;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                }
                // field(Instalment; Instalment)
                // {
                //     Editable = true;
                // }
                field(Installments2; Rec.Installments2)
                {
                    Caption = 'Installments';
                    Editable = true;
                }
                group(Control12)
                {
                    //ditable = false;
                    ShowCaption = false;

                    field("Amount Requested"; Rec."Amount Requested")
                    {
                        Editable = false;
                    }
                    field("Issued Date"; Rec."Issued Date")
                    {
                        Editable = false;
                    }
                    field("Approved Amount"; Rec."Approved Amount")
                    {
                        Editable = false;
                    }
                    field("Interest Calculation Method"; Rec."Interest Calculation Method")
                    {
                        //Editable = false;
                    }
                    // field(Repayment; Repayment)
                    // {
                    //     Caption = 'Repayment';
                    //     Editable = false;
                    // }
                    field(Repayment2; Rec.Repayment2)
                    {
                        Caption = 'Repayment';
                        Editable = false;
                    }
                    field("Interest Rate"; Rec."Interest Rate")
                    {
                        Editable = false;
                    }
                    field("Stop Loan"; Rec."Stop Loan")
                    {
                        Editable = false;

                        trigger OnValidate()
                        begin
                            if Rec."Stop Loan" = true then begin
                                AssMatrix.SetRange(AssMatrix."Employee No", Rec."Employee No");
                                AssMatrix.SetRange(Type, AssMatrix.Type::Deduction);
                                AssMatrix.SetRange("Reference No", Rec."Loan No");
                                AssMatrix.SetRange(AssMatrix.Closed, false);
                                AssMatrix.DeleteAll;
                                Message('Loan Stopped');
                            end;
                            /*IF xRec."Stop Loan" THEN
                                BEGIN
                                GetPayPeriod;
                                IF  "Stop Loan"=FALSE THEN
                                BEGIN
                                AssMatrix.INIT;
                                AssMatrix."Employee No":="Employee No";
                                AssMatrix.Type:=AssMatrix.Type::Deduction;
                                AssMatrix."Reference No":="Loan No";
                                IF "Deduction Code"='' THEN
                                ERROR('Loan %1 must be associated with a deduction',"Loan Product Type")
                                ELSE
                                AssMatrix.Code:="Deduction Code";
                                AssMatrix."Payroll Period":=BeginDate;

                                AssMatrix.Description:=Description;
                                AssMatrix."Payroll Group":=Emp."Posting Group";
                                AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                                AssMatrix.Amount:=Repayment;
                                AssMatrix."Next Period Entry":=TRUE;
                                AssMatrix.VALIDATE(AssMatrix.Amount);
                                AssMatrix.INSERT;



                                 MESSAGE('Loan Reactivated');
                                 END ELSE BEGIN

                                Emp.GET("Employee No");
                                AssMatrix.INIT;
                                AssMatrix."Employee No":="Employee No";
                                AssMatrix.Type:=AssMatrix.Type::Deduction;
                                AssMatrix.Code:="Deduction Code";
                                AssMatrix."Payroll Period":=BeginDate;
                                AssMatrix."Reference No":="Loan No";
                                AssMatrix.Description:=Description;
                                AssMatrix."Payroll Group":=Emp."Posting Group";
                                AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                                AssMatrix.Amount:=Repayment;
                                AssMatrix.VALIDATE(AssMatrix.Amount);
                                AssMatrix."Next Period Entry":=TRUE;
                                AssMatrix.INSERT;


                                 MODIFY;
                                 MESSAGE('Loan re-activated');

                                 END;



                                END; */
                        end;
                    }
                    group(Control10)
                    {
                        ShowCaption = false;
                        Visible = Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Flat Rate";

                        field("Flat Rate Principal"; Rec."Flat Rate Principal")
                        {
                        }
                        field("Flat Rate Interest"; Rec."Flat Rate Interest")
                        {
                        }
                    }
                    field("Paying Bank"; Rec."Paying Bank")
                    {
                    }
                    field("Bank Name"; Rec."Bank Name")
                    {
                    }
                    field("Payment Date"; Rec."Payment Date")
                    {
                    }
                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                    }
                    field("Payroll Group"; Rec."Payroll Group")
                    {
                        Editable = false;
                    }
                    field("Opening Loan"; Rec."Opening Loan")
                    {
                    }
                    field("Total Repayment"; Rec."Total Repayment")
                    {
                    }
                    field("Period Repayment"; Rec."Period Repayment")
                    {
                    }
                    field("Debtors Code"; Rec."Debtors Code")
                    {
                    }
                    field(Receipts; Rec.Receipts)
                    {
                        Visible = true;
                    }
                    field("External Document No"; Rec."External Document No")
                    {
                        Visible = false;
                    }
                    field("HELB No."; Rec."HELB No.")
                    {
                        Visible = false;
                    }
                    field("University Name"; Rec."University Name")
                    {
                        Visible = false;
                    }
                    field("Interest Deduction Code"; Rec."Interest Deduction Code")
                    {
                        Editable = false;
                    }
                    field("Deduction Code"; Rec."Deduction Code")
                    {
                        Editable = false;
                    }
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Issue)
            {
                Caption = 'Issue';

                action("Create Schedule")
                {
                    Caption = 'Create Schedule';
                    Image = SuggestLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    // Visible = false;
                    trigger OnAction()
                    begin
                        if Rec."Opening Loan" = false then begin
                            //if loan has already been issued don't create new schedule
                            PreviewShedule.SetRange(PreviewShedule."Employee No", Rec."Employee No");
                            PreviewShedule.SetRange("Loan Category", Rec."Loan Product Type");
                            PreviewShedule.SetRange("Loan No", Rec."Loan No");
                            PreviewShedule.DeleteAll;
                            if Rec."Issued Date" = 0D then Error('You must Issue date');
                            if Rec."Loan Status" = Rec."Loan Status"::Issued then RunningDate := Rec."Issued Date";
                            // if "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Balance" then
                            //     CreateAnnuityLoan;
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Flat Rate" then Rec.CreateFlatRateSchedule;
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Reducing Balance" then Rec.CreateSaccoReducing;
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::Amortised then Rec.CreateAmortizedLoan;
                        end;
                    end;
                }
                separator(Action1000000028)
                {
                }
                action("Preview Schedule")
                {
                    Caption = 'Preview Schedule';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Rec."Opening Loan" = false then begin
                            PreviewShedule.SetRange(PreviewShedule."Employee No", Rec."Employee No");
                            PreviewShedule.SetRange(PreviewShedule."Loan Category", Rec."Loan Product Type");
                            PreviewShedule.SetRange(PreviewShedule."Loan No", Rec."Loan No");
                            REPORT.Run(Report::"Loan Repayment Schedule-HR", true, false, PreviewShedule);
                        end
                        else
                            Error('Loan is Part of opening balance no schedule');
                    end;
                }
                separator(Action1000000036)
                {
                }
                action("Issue Loan")
                {
                    Caption = 'Issue Loan';
                    Image = CalculateSalesTax;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to issue Loan %1', false, Rec."Loan No") = true then Payroll.PostInternalLoan(Rec);
                    end;
                }
                action("Non Payroll Receipts")
                {
                    Caption = 'Non Payroll Receipts';
                    Image = WageLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                }
                action(SendApproval)
                {
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = false;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if ApprovalsMngt.CheckLoanApplicationWorkflowEnabled(Rec) then ApprovalsMngt.OnSendLoanApplicationRequestforApproval(Rec);
                    end;
                }
                action(CancelApproval)
                {
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ApprovalsMngt.OnCancelLoanApplicationRequestApproval(Rec);
                    end;
                }
                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetCurrentKey("Document No.");
                        ApprovalEntry.SetRange("Document No.", Rec."Loan No");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.LookupMode(true);
                        ApprovalEntries.Run;
                    end;
                }
                action(UpdateSchedule)
                {
                    Image = UpdateDescription;

                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        if Rec."Opening Loan" = false then begin
                            //if loan has already been issued don't create new schedule
                            PreviewShedule.SetRange(PreviewShedule."Employee No", Rec."Employee No");
                            PreviewShedule.SetRange("Loan Category", Rec."Loan Product Type");
                            PreviewShedule.SetRange("Loan No", Rec."Loan No");
                            PreviewShedule.DeleteAll;
                            if Rec."Issued Date" = 0D then Error('You must Issue date');
                            if Rec."Loan Status" = Rec."Loan Status"::Issued then RunningDate := Rec."Issued Date";
                            // if "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Balance" then
                            //     CreateAnnuityLoan;
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Flat Rate" then Rec.CreateFlatRateSchedule;
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Reducing Balance" then Rec.CreateSaccoReducing;
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::Amortised then Rec.CreateAmortizedLoan;
                        end;
                        //Update Payroll Period
                        AssMatrix.Reset;
                        AssMatrix.SetRange(AssMatrix.Code, Rec."Deduction Code");
                        AssMatrix.SetRange(AssMatrix."Employee No", Rec."Employee No");
                        if AssMatrix.Find('-') then begin
                            repeat
                                PreviewShedule.Reset;
                                PreviewShedule.SetRange(PreviewShedule."Loan No", Rec."Loan No");
                                PreviewShedule.SetRange(PreviewShedule."Repayment Date", AssMatrix."Payroll Period");
                                if PreviewShedule.FindFirst then begin
                                    AssMatrix.Amount := -PreviewShedule."Principal Repayment";
                                    AssMatrix."Loan Interest" := -PreviewShedule."Monthly Interest";
                                    AssMatrix.Modify;
                                end;
                            until AssMatrix.Next = 0;
                        end;
                    end;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if LoanProduct.Get(Rec."Loan Product Type") then begin
            Rec.Instalment := LoanProduct."No of Instalment";
            Rec."Interest Rate" := LoanProduct."Interest Rate";
            Rec."Interest Calculation Method" := LoanProduct."Interest Calculation Method";
            Rec.Description := LoanProduct.Description;
        end;
    end;

    var
        LoanProduct: Record "Loan Product Type";
        EmpRec: Record Employee;
        PreviewShedule: Record "Repayment Schedule";
        RunningDate: Date;
        AssMatrix: Record "Assignment Matrix-X";
        Schedule: Record "Repayment Schedule";
        Emp: Record Employee;
        GetGroup: Codeunit Payroll;
        GroupCode: Code[20];
        CUser: Code[20];
        PayPeriod: Record "Payroll PeriodX";
        PayPeriodtext: Text[30];
        BeginDate: Date;
        InterestAmt: Decimal;
        Payroll: Codeunit Payroll;
        ApprovalsMngt: Codeunit ApprovalMgtCuExtension;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Payment Voucher",Imprest,"Imprest Surrender","Petty Cash","Petty Cash Surrender","Store Requisitions","Purchase Requisitions","Staff Claim","Bank Transfer","Staff Advance",Quotation,QuoteEvaluation,LeaveAdjustment,TrainingRequest,LeaveApplication,"Travel Requests",Recruitment,"Employee Transfer","Employee Appraisal","Leave Recall","Maintenance Registration","Payroll Change","Payroll Request",LoanApplication;
        ApprovalEntries: Page "Approval Entries";

    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-') then begin
            PayPeriodtext := PayPeriod.Name;
            BeginDate := PayPeriod."Starting Date";
        end;
    end;
}

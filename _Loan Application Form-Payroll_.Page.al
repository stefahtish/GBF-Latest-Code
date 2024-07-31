page 50654 "Loan Application Form-Payroll"
{
    Caption = 'Loan Application Form';
    PageType = Card;
    SourceTable = "Loan Application";
    PromotedActionCategories = 'New,Process,Report,Approvals';
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
                    Enabled = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Enabled = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Enabled = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Loan Product Name';
                    Enabled = false;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    Enabled = false;
                }
                field(Installments2; Rec.Installments2)
                {
                    Caption = 'Installments';
                    ApplicationArea = All;
                }
                field(Installments; Rec.Instalment)
                {
                    Visible = false;
                    Enabled = true;
                }
                field("Amount Requested"; Rec."Amount Requested")
                {
                }
                field("Issued Date"; Rec."Issued Date")
                {
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    Enabled = false;
                }
                // field(Repayment; Repayment)
                // {
                //     Enabled = false;
                // }
                field(Repayment2; Rec.Repayment2)
                {
                    Caption = 'Repayment';
                    Enabled = false;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field("Stop Loan"; Rec."Stop Loan")
                {
                    Visible = Rec."Loan Status" = Rec."Loan Status"::Issued;

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
                group("Loan Disbursement Details")
                {
                    field("Paying Bank"; Rec."Paying Bank")
                    {
                        ShowMandatory = true;
                    }
                    field("Bank Name"; Rec."Bank Name")
                    {
                        Enabled = false;
                    }
                    field("Payment Date"; Rec."Payment Date")
                    {
                        ShowMandatory = true;
                    }
                }
                group(Dimensions)
                {
                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                    }
                }
                field("Payroll Group"; Rec."Payroll Group")
                {
                    Enabled = false;
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
                    //Enabled = false;
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
                    Enabled = false;
                }
                field("Deduction Code"; Rec."Deduction Code")
                {
                    Caption = 'Principle Deduction Code';
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Schedule")
            {
                Caption = 'Create Schedule';
                Image = SuggestLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

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
            action("Issue Loan")
            {
                Caption = 'Issue Loan';
                Image = CalculateSalesTax;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

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
            }
            action(SendApproval)
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                begin
                    if ApprovalsMngt.CheckLoanApplicationWorkflowEnabled(Rec) then ApprovalsMngt.OnSendLoanApplicationRequestforApproval(Rec);
                end;
            }
            action(CancelApproval)
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalsMngt.OnCancelLoanApplicationRequestApproval(Rec);
                end;
            }
            action(Approval)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AppEntry.Reset();
                    AppEntry.SetRange("Table ID", Database::"Loan Application");
                    AppEntry.SetRange("Document No.", Rec."Loan No");
                    ApprovalEntries.SetTableView(AppEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
                end;
            }
        }
        area(Reporting)
        {
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
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::"Loan Application";
        Rec."Loan Customer Type" := Rec."Loan Customer Type"::Staff;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::"Loan Application";
        Rec."Loan Customer Type" := Rec."Loan Customer Type"::Staff;
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
        AppEntry: Record "Approval Entry";

    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-') then begin
            PayPeriodtext := PayPeriod.Name;
            BeginDate := PayPeriod."Starting Date";
        end;
    end;
}

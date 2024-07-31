report 50269 "Transfer Journal to GL-New"
{
    ProcessingOnly = true;
    UseRequestPage = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Employee Posting GroupX"; "Employee Posting GroupX")
        {
            RequestFilterFields = "Pay Period Filter", "Code";

            column(Employee_Posting_GroupX_Code; Code)
            {
            }
            column(Employee_Posting_GroupX_Pay_Period_Filter; "Pay Period Filter")
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemLink = "Posting Group" = FIELD(Code), "Pay Period Filter" = FIELD("Pay Period Filter");
                DataItemTableView = WHERE("Employment Type" = FILTER(<> Trustee));

                column(COMPANYNAME; CompanyName)
                {
                }
                column(Employee_Posting_GroupX__Description; "Employee Posting GroupX".Description)
                {
                }
                column(Employee_Posting_GroupX__Code; "Employee Posting GroupX".Code)
                {
                }
                column(Payroll_Journal_summary_reportCaption; Payroll_Journal_summary_reportCaptionLbl)
                {
                }
                column(Employee_No_; "No.")
                {
                }
                column(Employee_Posting_Group; "Posting Group")
                {
                }
                column(Employee_Pay_Period_Filter; "Pay Period Filter")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Employee.CalcFields("Total Allowances", "Total Deductions", "Loan Interest");
                    TotalNetPay := TotalNetPay + (Employee."Total Allowances" + Employee."Total Deductions" + Employee."Loan Interest");
                end;

                trigger OnPostDataItem()
                begin
                    TotalCredits := TotalCredits + TotalNetPay;
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("No.");
                end;
            }
            dataitem(EarningsX; EarningsX)
            {
                DataItemLink = "Posting Group Filter" = FIELD(Code), "Pay Period Filter" = FIELD("Pay Period Filter");
                DataItemTableView = SORTING(Code);

                column(EarningsX_Description; Description)
                {
                }
                column(EarningsX__Total_Amount_; "Total Amount")
                {
                }
                column(EarningsX_Code; Code)
                {
                }
                column(EarningsX_Posting_Group_Filter; "Posting Group Filter")
                {
                }
                column(EarningsX_Pay_Period_Filter; "Pay Period Filter")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Counter := Counter + 1;
                    Percentage := Round(Counter / TotalCount * 10000, 1);
                    Window.Update(2, Percentage);
                    EarningsX.CalcFields("Total Amount");
                    //EarningsCopy.SETRANGE(EarningsCopy."Pay Period Filter",DateSpecified,CALCDATE('1M',DateSpecified)-1);
                    TotalDebits := TotalDebits + "Total Amount";
                    if EarningsX."Total Amount" = 0 then CurrReport.Skip;
                    LineNumber := LineNumber + 10000;
                    if EarningsX."Account No." <> '' then begin
                        //EarningsX.TestField(EarningsX."Account No.");
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := BatchTemplate;
                        GenJnlLine."Journal Batch Name" := BatchName;
                        GenJnlLine."Line No." := LineNumber;
                        GenJnlLine."Account Type" := EarningsX."Account Type";
                        GenJnlLine."Account No." := EarningsX."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Posting Date" := Payday;
                        GenJnlLine.Description := EarningsX.Description + ' ' + Format(DateSpecified, 0, '<month text> <year4>');
                        GenJnlLine."Document No." := Payperiodtext;
                        GenJnlLine."Shortcut Dimension 1 Code" := Employee."Global Dimension 1 Code";
                        GenJnlLine.Amount := Round(EarningsX."Total Amount", 0.01, '=');
                        GenJnlLine.Validate(Amount);
                        if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    EarningsX.SetRange(EarningsX."Non-Cash Benefit", false);
                    EarningsX.SetRange(Gratuity, false);
                    TotalCount := Count;
                    Counter := 0;
                end;
            }
            dataitem(DeductionsX; DeductionsX)
            {
                DataItemLink = "Posting Group Filter" = FIELD(Code);

                //DataItemTableView = SORTING(Code) WHERE(Loan = CONST(false));
                column(DeductionsX_Description; Description)
                {
                }
                column(DeductionsX__Total_Amount_; "Total Amount")
                {
                }
                column(DeductionsX_Code; Code)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Counter := Counter + 1;
                    Percentage := Round(Counter / TotalCount * 10000, 1);
                    Window.Update(2, Percentage);
                    DeductionsX.CalcFields(DeductionsX."Total Amount", DeductionsX."Total Amount Employer");
                    if (DeductionsX."Total Amount" = 0) and (DeductionsX."Total Amount Employer" = 0) then CurrReport.Skip;
                    LineNumber := LineNumber + 10000;
                    TotalCredits := Abs(TotalCredits) + Abs("Total Amount");
                    //modified for KPPF
                    /*  if not DeductionsX."PAYE Code" then begin*/
                    DeductionsX.TestField(DeductionsX."Account No.");
                    GenJnlLine."Journal Template Name" := BatchTemplate;
                    GenJnlLine."Journal Batch Name" := BatchName;
                    GenJnlLine."Line No." := LineNumber;
                    GenJnlLine."Account Type" := DeductionsX."Account Type";
                    GenJnlLine."Account No." := DeductionsX."Account No.";
                    GenJnlLine.Validate("Account No.");
                    GenJnlLine."Posting Date" := Payday;
                    GenJnlLine.Description := DeductionsX.Description + ' ' + Format(DateSpecified, 0, '<month text> <year4>');
                    GenJnlLine."Document No." := Payperiodtext;
                    GenJnlLine.Amount := Round(DeductionsX."Total Amount", 0.01, '=');
                    GenJnlLine.Validate(Amount);
                    if (GenJnlLine.Amount <> 0) and (not TransferLoans) then GenJnlLine.Insert;
                    /*
                        End else begin
                            DeductionsX.TestField(DeductionsX."Account No.");
                            "Employee Posting GroupX".TestField("PAYE Account");

                            GenJnlLine."Journal Template Name" := BatchTemplate;
                            GenJnlLine."Journal Batch Name" := BatchName;
                            GenJnlLine."Line No." := LineNumber;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine."Account No." := "Employee Posting GroupX"."PAYE Account";
                            GenJnlLine.Validate("Account No.");
                            GenJnlLine."Posting Date" := Payday;
                            GenJnlLine.Description := DeductionsX.Description + ' ' + Format(DateSpecified, 0, '<month text> <year4>');
                            GenJnlLine."Document No." := Payperiodtext;
                            GenJnlLine.Amount := Round(DeductionsX."Total Amount");
                            GenJnlLine.Validate(Amount);
                            if (GenJnlLine.Amount <> 0) and (not TransferLoans) then
                                GenJnlLine.Insert;
                        end;
                        */
                    if DeductionsX."Total Amount Employer" <> 0 then begin
                        //TotalSSF := ABS(DeductionsX."Total Amount") + ABS(DeductionsX."Total Amount Employer");
                        TotalSSF := Abs(DeductionsX."Total Amount Employer");
                        DeductionsX.TestField(DeductionsX."Account No. Employer");
                        LineNumber := LineNumber + 10000;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := BatchTemplate;
                        GenJnlLine."Journal Batch Name" := BatchName;
                        GenJnlLine."Line No." := LineNumber;
                        GenJnlLine."Account Type" := DeductionsX."Account Type";
                        GenJnlLine."Account No." := DeductionsX."Account No.";
                        GenJnlLine.Validate("Account No.");
                        GenJnlLine."Posting Date" := Payday;
                        GenJnlLine.Description := DeductionsX.Description + '-Employer ' + Format(DateSpecified, 0, '<month text> <year4>');
                        GenJnlLine."Document No." := Payperiodtext;
                        GenJnlLine.Amount := -Round(TotalSSF, 0.01, '=');
                        GenJnlLine.Validate(Amount);
                        GenJnlLine.Insert;
                        EmployerAmount := EmployerAmount + DeductionsX."Total Amount Employer";
                        TotalDebits := TotalDebits + Abs(DeductionsX."Total Amount Employer");
                        TotalCredits := TotalCredits + TotalSSF;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    DeductionsX.SetRange(DeductionsX."Pay Period Filter", DateSpecified);
                    DeductionsX.SetFilter("Employee Type Filter", '<>%1', DeductionsX."Employee Type Filter"::Trustee);
                    DeductionsX.SetFilter("Account No.", '<>%1', '');
                    TotalCount := Count;
                    Counter := 0;
                end;
            }
            dataitem(LoansRec; DeductionsX)
            {
                DataItemLink = "Posting Group Filter" = FIELD(Code);
                DataItemTableView = SORTING(Code) WHERE(Loan = CONST(true), "Sacco Deduction" = CONST(false));

                column(LoansRec_Description; Description)
                {
                }
                column(LoansRec__Total_Amount_; "Total Amount")
                {
                }
                column(LoansRec_Code; Code)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Counter := Counter + 1;
                    Percentage := Round(Counter / TotalCount * 10000, 1);
                    Window.Update(2, Percentage);
                    LoansRec.CalcFields("Total Amount");
                    TotalCredits := Abs(TotalCredits) + Abs("Total Amount") + Abs("Loan Interest");
                    /*
                                        //Internal Loans
                                        AssignmentMat.Reset;
                                        AssignmentMat.SetRange(AssignmentMat.Type, AssignmentMat.Type::Deduction);
                                        AssignmentMat.SetRange(AssignmentMat.Code, LoansRec.Code);
                                        AssignmentMat.SetRange(AssignmentMat."Payroll Period", DateSpecified);
                                        if AssignmentMat.Find('-') then begin
                                            repeat
                                                LoanApp.Reset;
                                                LoanApp.SetRange(LoanApp."Loan No", AssignmentMat."Reference No");
                                                if LoanApp.Find('+') then
                                                    if Loanproduct.Get(LoanApp."Loan Product Type") then
                                                        if Loanproduct.Internal then begin
                                                            Loanproduct.TestField("Interest Posting Group");
                                                            //Principal Repayment
                                                            LineNumber := LineNumber + 10000;

                                                            GenJnlLine.Init;
                                                            GenJnlLine."Journal Template Name" := BatchTemplate;
                                                            GenJnlLine."Journal Batch Name" := BatchName;
                                                            GenJnlLine."Line No." := LineNumber;
                                                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                                            LoanApp.Reset;
                                                            LoanApp.SetRange(LoanApp."Loan No", AssignmentMat."Reference No");
                                                            if LoanApp.Find('+') then
                                                                GenJnlLine."Account No." := LoanApp."Debtors Code";
                                                            GenJnlLine.Validate("Account No.");
                                                            GenJnlLine."Posting Date" := Payday;
                                                            GenJnlLine.Description := LoansRec.Description + ' ' + Format(DateSpecified, 0, '<month text> <year4>');
                                                            GenJnlLine."Document No." := Payperiodtext;
                                                            GenJnlLine.Amount := Round(AssignmentMat.Amount);
                                                            GenJnlLine.Validate(Amount);
                                                            GenJnlLine."Loan No" := AssignmentMat."Reference No";
                                                            // GenJnlLine."Loan Transaction Type" := GenJnlLine."Loan Transaction Type"::"Principal Repayment";
                                                            GenJnlLine."Applies-to Doc. No." := AssignmentMat."Reference No";
                                                            GenJnlLine.Validate("Applies-to Doc. No.");
                                                            GenJnlLine."Employee Code" := AssignmentMat."Employee No";
                                                            GenJnlLine."Emp Payroll Period" := DateSpecified;
                                                            GenJnlLine."Emp Payroll Code" := AssignmentMat.Code;
                                                            if (GenJnlLine.Amount <> 0) and not (InsertedinJournal(BatchTemplate, BatchName, AssignmentMat."Employee No",
                                                                    DateSpecified, GenJnlLine.Amount, GenJnlLine."Document No.", AssignmentMat.Code)) then
                                                                GenJnlLine.Insert;

                                                            //Interest Repayment
                                                            LineNumber := LineNumber + 10000;

                                                            GenJnlLine.Init;
                                                            GenJnlLine."Journal Template Name" := BatchTemplate;
                                                            GenJnlLine."Journal Batch Name" := BatchName;
                                                            GenJnlLine."Line No." := LineNumber;
                                                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                                            LoanApp.Reset;
                                                            LoanApp.SetRange(LoanApp."Loan No", AssignmentMat."Reference No");
                                                            if LoanApp.Find('+') then
                                                                GenJnlLine."Account No." := LoanApp."Debtors Code";
                                                            GenJnlLine."Posting Date" := Payday;
                                                            GenJnlLine.Description := LoansRec.Description + ' Interest ' + Format(DateSpecified, 0, '<month text> <year4>');
                                                            GenJnlLine."Document No." := Payperiodtext;
                                                            GenJnlLine.Amount := Round(AssignmentMat."Loan Interest");
                                                            GenJnlLine.Validate(Amount);
                                                            GenJnlLine."Loan No" := AssignmentMat."Reference No";
                                                            GenJnlLine."Period Reference" := AssignmentMat."Payroll Period";
                                                            // GenJnlLine."Loan Transaction Type" := GenJnlLine."Loan Transaction Type"::"Interest Repayment";
                                                            GenJnlLine."Employee Code" := AssignmentMat."Employee No";
                                                            GenJnlLine."Emp Payroll Period" := DateSpecified;
                                                            GenJnlLine."Emp Payroll Code" := AssignmentMat.Code + '-INT';
                                                            GenJnlLine."Posting Group" := Loanproduct."Interest Posting Group";
                                                            //Post Interest Application
                                                            if LoansRec.Loan then begin
                                                                if GetPayPeriodLoanInterestDocNo(GenJnlLine."Account No.", GenJnlLine."Period Reference") <> '' then
                                                                    GenJnlLine."Applies-to Doc. No." := GetPayPeriodLoanInterestDocNo(GenJnlLine."Account No.", GenJnlLine."Period Reference");
                                                                GenJnlLine.Validate("Applies-to Doc. No.");
                                                            end;
                                                            if (GenJnlLine.Amount <> 0) and not (InsertedinJournal(BatchTemplate, BatchName, AssignmentMat."Employee No",
                                                                    DateSpecified, GenJnlLine.Amount, GenJnlLine."Document No.", GenJnlLine."Emp Payroll Code")) then
                                                                GenJnlLine.Insert;
                                                        end;
                                            until AssignmentMat.Next = 0;
                                        end;
                                        */
                    TotalDebits := TotalDebits + Abs(LoansRec."Total Amount Employer");
                    TotalCredits := TotalCredits + LoansRec."Total Amount";
                end;

                trigger OnPreDataItem()
                begin
                    LoansRec.SetRange(LoansRec."Pay Period Filter", DateSpecified);
                    TotalCount := Count;
                    Counter := 0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                TotalncomeTax := 0;
                TotalBasic := 0;
                Totalgross := 0;
                "Employee Posting GroupX".TestField("Net Salary Payable");
                PayablesAccType := "Employee Posting GroupX"."Net Salary Account Type";
                PayablesAcc := "Employee Posting GroupX"."Net Salary Payable";
                EmployerAcc := "Employee Posting GroupX"."Pension Employer Acc";
            end;
        }
        dataitem(Summary; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            column(TotalDebits; TotalDebits)
            {
            }
            column(TotalCredits; TotalCredits)
            {
            }
            column(TotalNetPay; TotalNetPay)
            {
            }
            column(Net_PayCaption; Net_PayCaptionLbl)
            {
            }
            column(Summary_Number; Number)
            {
            }
            trigger OnAfterGetRecord()
            begin
                LineNumber := LineNumber + 10000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := BatchTemplate;
                GenJnlLine."Journal Batch Name" := BatchName;
                GenJnlLine."Line No." := LineNumber;
                GenJnlLine."Account Type" := PayablesAccType;
                GenJnlLine."Account No." := PayablesAcc;
                GenJnlLine.Validate("Account No.");
                GenJnlLine."Posting Date" := Payday;
                GenJnlLine.Description := 'Net Salary payable' + ' ' + Format(DateSpecified, 0, '<month text> <year4>');
                GenJnlLine."Document No." := Payperiodtext;
                GenJnlLine.Amount := -Round(TotalNetPay);
                GenJnlLine.Validate(Amount);
                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                LineNumber := LineNumber + 10000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := BatchTemplate;
                GenJnlLine."Journal Batch Name" := BatchName;
                GenJnlLine."Line No." := LineNumber;
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Account No." := EmployerAcc;
                GenJnlLine.Validate("Account No.");
                GenJnlLine."Posting Date" := Payday;
                GenJnlLine.Description := 'Employer Amounts for ' + ' ' + Format(DateSpecified, 0, '<month text> <year4>');
                GenJnlLine."Document No." := Payperiodtext;
                GenJnlLine.Amount := Abs(EmployerAmount);
                GenJnlLine.Validate(Amount);
                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
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
    trigger OnPostReport()
    var
        ConfirmOpenJournal: Label 'The Payroll Journal for %1 has been Generated to Template %3 - Batch %2. Do you want to Open the Journal? ';
    begin
        Window.Close;
        if Confirm(ConfirmOpenJournal, false, Payperiodtext, BatchTemplate, BatchName) then begin
            if Batch.Get(BatchTemplate, BatchName) then GenJnlManagement.TemplateSelectionFromBatch(Batch);
        end;
    end;

    trigger OnPreReport()
    begin
        PostingPeriod := "Employee Posting GroupX".GetRangeMin("Employee Posting GroupX"."Pay Period Filter");
        Payperiodtext := Format(PostingPeriod, 0, '<Month Text,3> <Year4>');
        GetPeriodFilter := "Employee Posting GroupX".GetRangeMin("Employee Posting GroupX"."Pay Period Filter");
        DateSpecified := "Employee Posting GroupX".GetRangeMin("Employee Posting GroupX"."Pay Period Filter");
        if PayrollPeriod.Get(DateSpecified) then Payday := PayrollPeriod."Pay Date";
        if Payday = 0D then Error(Text002, DateSpecified);
        LineNumber := 0;
        TotalCount := 0;
        Counter := 0;
        GetCurrentPeriod;
        if PeriodStartDate <> PayrollPeriod."Starting Date" then if not Confirm(Text001, false) then CurrReport.Quit;
        AdjustPostingGr;
        Window.Open('Generating Entries: #1###############' + 'Progress : @2@@@@@@@@@@@@@@@');
        Window.Update(1, Payperiodtext);
        HRSetup.Get;
        HRSetup.TestField("Payroll Journal Template");
        HRSetup.TestField("Payroll Journal Batch");
        BatchTemplate := HRSetup."Payroll Journal Template";
        BatchName := HRSetup."Payroll Journal Batch";
        /*
        HRSetup.GET;
        HRSetup.TESTFIELD("Payroll Journal Template");
        CASE HRSetup."Generate Payroll Batch" OF
          HRSetup."Generate Payroll Batch"::" ",
          HRSetup."Generate Payroll Batch"::Yes:
            BEGIN
              JName := 'PAY';
              MonDate := FORMAT(PeriodStartDate);
              JName := JName + COPYSTR(MonDate,3,7);
            END;
          HRSetup."Generate Payroll Batch"::No:
            BEGIN
              HRSetup.TESTFIELD("Payroll Journal Batch");
              JName := HRSetup."Payroll Journal Batch";
            END;
        END;
        */
        //Delete Journal Entries
        Batch.Init;
        Batch."Journal Template Name" := BatchTemplate;
        Batch.Name := BatchName;
        if not Batch.Get(Batch."Journal Template Name", Batch.Name) then Batch.Insert;
        GenJnlLine.Reset;
        GenJnlLine.SetRange("Journal Template Name", BatchTemplate);
        GenJnlLine.SetRange("Journal Batch Name", BatchName);
        if GenJnlLine.FindSet then GenJnlLine.DeleteAll;
    end;

    var
        Vendor: Record Vendor;
        GratuityVNo: Code[20];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TaxableAmount: Decimal;
        IncomeTax: Decimal;
        NetPay: Decimal;
        RightBracket: Boolean;
        AmountRemaining: Decimal;
        EmployerAmount: Decimal;
        EmployerAcc: code[20];
        Company: Record "Company Information";
        Companyz: Code[10];
        "Posting Date": Date;
        BatchName: Text[30];
        DocumentNo: Code[10];
        Description: Text[30];
        Amount: Decimal;
        "G/LAccount": Code[10];
        TotalncomeTax: Decimal;
        GrossPay: Decimal;
        Totalgross: Decimal;
        TotalNetPay: Decimal;
        Payday: Date;
        GenJnlLine: Record "Gen. Journal Line";
        LineNumber: Integer;
        TotalBasic: Decimal;
        PayrollPeriod: Record "Payroll PeriodX";
        PostingGroup: Record "Employee Posting GroupX";
        TaxAccount: Code[10];
        SalariesAcc: Code[10];
        PayablesAcc: Code[20];
        First: Code[10];
        Last: Code[10];
        EmployeeTemp: Record Employee temporary;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
        AssignmentMat: Record "Assignment Matrix-X";
        Batch: Record "Gen. Journal Batch";
        Found: Boolean;
        TotalSSF: Decimal;
        PeriodStartDate: Date;
        EmpRec: Record Employee;
        DateSpecified: Date;
        Payperiodtext: Text[30];
        TransferLoans: Boolean;
        TaxCode: Code[10];
        BasicSalary: Decimal;
        PAYE: Decimal;
        HRSetup: Record "Human Resources Setup";
        HseLimit: Decimal;
        ExcessRetirement: Decimal;
        CfMpr: Decimal;
        relief: Decimal;
        GetPeriodFilter: Date;
        ActivityRec: Record "Dimension Value";
        EarningsCopy: Record EarningsX;
        LoanApp: Record "Loan Application";
        Loanproduct: Record "Loan Product Type";
        EmpName: Text[70];
        Text000: Label 'There is no G/L Account setup for %1 %2 %3';
        Text001: Label 'You are about to transfer the payroll summary for the wrong period, you want to continue?';
        Text002: Label 'The pay date must be specified for the period %1';
        Payroll_Journal_summary_reportCaptionLbl: Label 'Payroll Journal summary report';
        Net_PayCaptionLbl: Label 'Net Pay';
        JName: Text;
        MonDate: Text[10];
        BatchTemplate: Code[20];
        PostingPeriod: Date;
        GenJnlManagement: Codeunit GenJnlManagement;
        Window: Dialog;
        Percentage: Integer;
        Counter: Integer;
        TotalCount: Integer;
        PayablesAccType: enum "Gen. Journal Account Type";
        EmpNo: code[50];

    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record BracketsX;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
        AmountRemaining := TaxableAmount;
        AmountRemaining := AmountRemaining;
        AmountRemaining := PayrollRounding(AmountRemaining);
        EndTax := false;
        TaxTable.SetRange("Table Code", TaxCode);
        if TaxTable.Find('-') then begin
            repeat
                if AmountRemaining <= 0 then
                    EndTax := true
                else begin
                    if (TaxableAmount) > TaxTable."Upper Limit" then
                        Tax := TaxTable."Taxable Amount" * TaxTable.Percentage / 100
                    else begin
                        Tax := AmountRemaining * TaxTable.Percentage / 100;
                        TotalTax := TotalTax + Tax;
                        EndTax := true;
                    end;
                    if not EndTax then begin
                        AmountRemaining := AmountRemaining - TaxTable."Taxable Amount";
                        TotalTax := TotalTax + Tax;
                    end;
                end;
            until (TaxTable.Next = 0) or EndTax = true;
        end;
        TotalTax := TotalTax;
        TotalTax := PayrollRounding(TotalTax);
        IncomeTax := -TotalTax;
        if not Employee."Pays tax?" then IncomeTax := 0;
    end;

    procedure GetPayPeriod(var PayPeriods: Record "Payroll PeriodX")
    begin
        PayrollPeriod := PayPeriods;
    end;

    procedure GetCurrentPeriod()
    var
        PayPeriodRec: Record "Payroll PeriodX";
    begin
        PayPeriodRec.SetRange(PayPeriodRec.Closed, false);
        if PayPeriodRec.Find('-') then PeriodStartDate := PayPeriodRec."Starting Date";
    end;

    procedure AdjustPostingGr()
    begin
        AssignmentMat.Reset;
        AssignmentMat.SetRange("Payroll Period", DateSpecified);
        if AssignmentMat.Find('-') then begin
            repeat
                if EmpRec.Get(AssignmentMat."Employee No") then AssignmentMat."Posting Group Filter" := EmpRec."Posting Group";
                AssignmentMat.Modify;
            until AssignmentMat.Next = 0;
        end;
    end;

    procedure PayrollRounding(var Amount: Decimal) PayrollRounding: Decimal
    var
        HRsetup: Record "Human Resources Setup";
    begin
        HRsetup.Get;
        if HRsetup."Payroll Rounding Precision" = 0 then Error('You must specify the rounding precision under HR setup');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;
    // procedure GetPayPeriodLoanInterestDocNo(CustomerNo: Code[50]; PayPeriod: Date): Code[100]
    // var
    //     CustLedgEntry: Record "Cust. Ledger Entry";
    // begin
    //     CustLedgEntry.Reset;
    //     CustLedgEntry.SetRange("Customer No.", CustomerNo);
    //     CustLedgEntry.SetRange("Period Reference", PayPeriod);
    //     CustLedgEntry.SETRANGE("Loan Transaction Type", CustLedgEntry."Loan Transaction Type"::"Interest Due");
    //     CustLedgEntry.SetRange(Reversed, false);
    //     if CustLedgEntry.FindFirst then
    //         exit(CustLedgEntry."Document No.");
    // end;
    procedure IsGratuity(Earn: Code[30]): Boolean
    begin
    end;
    // local procedure GetGratuityVendorNo(StaffNo: Code[50]): Code[100]
    // var
    //     Emp: Record Employee;
    // begin
    //     if Emp.get(StaffNo) then begin
    //         if Emp."Gratuity Vendor No." <> '' then
    //             exit(Emp."Gratuity Vendor No.")
    //         else
    //             ERROR('Kindly define Gratuity Vendor No. for StaffNo %1 in the Employee Card', StaffNo);
    //     end;
    // end;
    // local procedure InsertedinJournal(GenTemplate: Code[50]; GenBatch: Code[50]; EmpCode: Code[50]; DatePeriod: Date; Amt: Decimal; DocNo: Code[50]; DedCode: Code[50]): Boolean
    // var
    //     GenJournal: Record "Gen. Journal Line";
    // begin
    //     GenJournal.Reset();
    //     GenJournal.SetRange("Journal Template Name", GenTemplate);
    //     GenJournal.SetRange("Journal Batch Name", GenBatch);
    //     GenJournal.SetRange("Document No.", DocNo);
    //     GenJournal.SetRange("Employee Code", EmpCode);
    //     GenJournal.SetRange("Emp Payroll Period", DatePeriod);
    //     GenJournal.SetRange("Emp Payroll Code", DedCode);
    //     if GenJournal.FindFirst() then
    //         exit(true)
    //     else
    //         exit(false)
    // end;
}

report 50255 "Summary By Center_1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SummaryByCenter1.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
        {
            RequestFilterFields = "Payroll Period";

            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Employee_No; "Assignment Matrix-X"."Employee No")
            {
            }
            column(Payroll_Period; Format("Assignment Matrix-X"."Payroll Period", 0, '<Month Text>,<Year4>'))
            {
            }
            column(Revenue_Center; "Assignment Matrix-X"."Global Dimension 1 Code")
            {
            }
            column("Code"; "Assignment Matrix-X".Code)
            {
            }
            column(Type; "Assignment Matrix-X".Type)
            {
            }
            column(Amount; PayrollRounding("Assignment Matrix-X".Amount))
            {
            }
            column(Interest; PayrollRounding("Assignment Matrix-X"."Loan Interest"))
            {
            }
            column(Decription; GetCodeName("Assignment Matrix-X".Code))
            {
            }
            column(Gross_Pay; GrossPay)
            {
            }
            column(Deductions; Deduct)
            {
            }
            column(Net_Pay; Abs(GrossPay) - Abs(TotalDedcut) - Abs(TotalRelief))
            {
            }
            column(Employee; EmpCount)
            {
            }
            column(Retirement; "Assignment Matrix-X".Retirement)
            {
            }
            column("Area"; "Assignment Matrix-X".Area)
            {
            }
            column(Taxable; "Assignment Matrix-X".Taxable)
            {
            }
            column(Employer_Amount; "Assignment Matrix-X"."Employer Amount")
            {
            }
            column(Tax_Deductible; "Assignment Matrix-X"."Tax Deductible")
            {
            }
            column(Tax_Relief; "Assignment Matrix-X"."Tax Relief")
            {
            }
            column(EarningType; Ea."Earning Type")
            {
            }
            column(Normal_Earnings; "Assignment Matrix-X"."Normal Earnings")
            {
            }
            column(GrossPay; GrossPay)
            {
            }
            column(TotalGross; Abs(TotalGross) - Abs(TotalRelief))
            {
            }
            column(TotalDeduct; PayrollRounding(TotalDedcut))
            {
            }
            column(TotalRelief; PayrollRounding(TotalRelief))
            {
            }
            column(Today; Today)
            {
            }
            trigger OnAfterGetRecord()
            begin
                GrossPay := 0;
                Deduct := 0;
                TotalRelief := 0;
                CheckPayment := false;
                // gross pay
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Payroll Period", "Assignment Matrix-X"."Payroll Period");
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                if AssignMatrix.Find('-') then begin
                    AssignMatrix.CalcSums(Amount);
                    GrossPay := AssignMatrix.Amount;
                    TotalGross := TotalGross + GrossPay;
                    TotalGross := PayrollRounding(TotalGross);
                end;
                // total deductions
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Payroll Period", "Assignment Matrix-X"."Payroll Period");
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Deduction);
                if AssignMatrix.Find('-') then begin
                    AssignMatrix.CalcSums(Amount);
                    Deduct := (Abs(AssignMatrix.Amount));
                    TotalDedcut := TotalDedcut + Deduct;
                end;
                TotalRelief := 0;
                // Relief
                Earn.Reset;
                Earn.SetRange("Pay Period Filter", "Assignment Matrix-X"."Payroll Period");
                Earn.SetRange("Reduces Tax", true);
                if Earn.Find('-') then begin
                    repeat
                        EarnCount := Earn.Count;
                        Earn.Calcfields("Total Amount");
                        TotalRelief := TotalRelief + Earn."Total Amount";
                        TotalRelief := PayrollRounding(TotalRelief);
                    until Earn.Next() = 0;
                end;
                // empcount
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Payroll Period", "Assignment Matrix-X"."Payroll Period");
                AssignMatrix.SetCurrentKey("Employee No");
                AssignMatrix.SetRange("Global Dimension 1 Code", "Assignment Matrix-X"."Global Dimension 1 Code");
                if AssignMatrix.Find('-') then EmpCount := AssignMatrix.Count;
            end;

            trigger OnPreDataItem()
            begin
                //AssignMatrix.SETRANGE("Payroll Period","Assignment Matrix-X"."Payroll Period");
            end;
        }
        dataitem(Employee; Employee)
        {
            column(No_Employee; "No.")
            {
            }
            column(UkulimaNetPay; PayrollRounding(UkulimaNetPay))
            {
            }
            column(BankNetPay; PayrollRounding(BankNetPay))
            {
            }
            column(checkPayment; CheckPayment)
            {
            }
            trigger OnAfterGetRecord()
            begin
                // ukulima and bank net pay
                UkulimaNetPay := 0;
                BankNetPay := 0;
                checkPayment := False;
                EmpRec.Reset();
                EmpRec.SetRange("Pay Period Filter", "Assignment Matrix-X"."Payroll Period");
                If EmpRec.Get(Employee."No.") then begin
                    EmpBank.Reset();
                    if EmpBank.Get(EmpRec."Employee's Bank") then begin
                        //Ukulima
                        // if EmpBank."Cheque Payments" then begin
                        CheckPayment := True;
                        EmpRec.CalcFields("Total Deductions", "Total Allowances", "Relief Amount", "Loan Interest");
                        UkulimaNetPay := EmpRec."Total Allowances" + EmpRec."Total Deductions" + EmpRec."Loan Interest" + EmpRec."Relief Amount";
                        // end
                        // else begin
                        EmpRec.CalcFields("Total Deductions", "Total Allowances", "Relief Amount", "Loan Interest");
                        BankNetPay := EmpRec."Total Allowances" + EmpRec."Total Deductions" + EmpRec."Loan Interest" + EmpRec."Relief Amount";
                        // end;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
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
        Period := "Assignment Matrix-X".GetFilter("Payroll Period");
        if Period = '' then Error(PayPeriodErr);
    end;

    var // Employee: Record Employee;
        EmpCount: Integer;
        AssignMatrix: Record "Assignment Matrix-X";
        GrossPay: Decimal;
        PayCode: Code[20];
        DedCode: Code[20];
        Payments: Decimal;
        Deduct: Decimal;
        Ea: Record EarningsX;
        Ded: Record DeductionsX;
        Deduction: Decimal;
        CompanyInfo: Record "Company Information";
        Period: Text;
        PayPeriodErr: Label 'Kindly Specify a Payperiod';
        TotalGross: Decimal;
        Matrix: Record "Assignment Matrix-X";
        TotalDedcut: Decimal;
        LoanInterest: Decimal;
        Earn: Record EarningsX;
        TotalRelief: Decimal;
        Relief: Decimal;
        EarnCount: Decimal;
        checkPayment: Boolean;
        EmpBank: Record Banks;
        BankNetPay: Decimal;
        UkulimaNetPay: Decimal;
        EmpRec: Record Employee;

    procedure GetCodeName("Code": Code[20]): Text[200]
    var
        Earn: Record EarningsX;
        Ded: Record DeductionsX;
    begin
        if Earn.Get(Code) then exit(Earn.Description);
        if Ded.Get(Code) then exit(Ded.Description);
    end;

    procedure PayrollRounding(Amount: Decimal) PayrollRounding: Decimal
    var
        HRsetup: Record "Human Resources Setup";
    begin
        HRsetup.Get;
        if HRsetup."Payroll Rounding Precision" = 0 then Error('You must specify the rounding precision under HR setup');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;

    procedure GetTotals(Codes: Code[20]; Dimension: Code[20]): Decimal
    var
        Matrix: Record "Assignment Matrix-X";
        Total: Decimal;
    begin
        Matrix.Reset;
        Matrix.SetRange(Code, Codes);
        Matrix.SetRange("Payroll Period", "Assignment Matrix-X"."Payroll Period");
        if Matrix.Find('-') then Matrix.CalcSums(Amount);
        Total := Round(Matrix.Amount, 0.05);
        exit(Total);
        //MESSAGE(FORMAT(Total));
    end;
}

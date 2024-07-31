report 50441 "Validate Payroll Run"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Validate Payroll Data';
    ProcessingOnly = true;

    dataset
    {
        dataitem(AssignMatrix; "Assignment Matrix-X")
        {
            RequestFilterFields = "Employee No", "Payroll Period";

            trigger OnAfterGetRecord()
            var
                Formula: Code[50];
                ScaleBenefits: Record "Scale Benefits";
                HouseAllowances: Record "House Allowances";
            begin
                GetSetup;
                GetEmployee;
                Window.Update(1, AssignMatrix."Employee No");
                if AssMatrix.Get("Employee No", Type, Code, "Payroll Period", "Reference No")then begin
                    if Type = Type::Payment then begin
                        Payments.SetRange(Code, Code);
                        if Payments.Find('-')then begin
                            // Check If Blocked---//
                            AssMatrix."Time Sheet":=Payments."Time Sheet";
                            AssMatrix.Description:=Payments.Description;
                            AssMatrix.Frequency:=Payments."Pay Type";
                            if Payments."Earning Type" = Payments."Earning Type"::"Tax Relief" then AssMatrix."Tax Relief":=true;
                            AssMatrix."Non-Cash Benefit":=Payments."Non-Cash Benefit";
                            AssMatrix.Quarters:=Payments.Quarters;
                            //Paydeduct:=Payments."End Date";
                            AssMatrix.Taxable:=Payments.Taxable;
                            AssMatrix."Tax Deductible":=Payments."Reduces Tax";
                            AssMatrix.Gratuity:=Payments.Gratuity;
                            if Payments."Pay Type" = Payments."Pay Type"::Recurring then AssMatrix."Next Period Entry":=true;
                            AssMatrix."Basic Salary Code":=Payments."Basic Salary Code";
                            AssMatrix."Basic Pay Arrears":=Payments."Basic Pay Arrears";
                            if Payments."Earning Type" = Payments."Earning Type"::"Normal Earning" then AssMatrix."Normal Earnings":=true;
                        end
                        else
                            AssMatrix."Normal Earnings":=false;
                        AssMatrix."House Allowance Code":=Payments."House Allowance Code";
                        //Added LAPFUND
                        AssMatrix."Commuter Allowance Code":=Payments."Commuter Allowance Code";
                        AssMatrix."Salary Arrears Code":=Payments."Salary Arrears Code";
                        if Payments."Reduces Tax" then begin
                            AssMatrix.Amount:=PayrollRounding(Amount);
                        end;
                    end;
                    //------------------Deductions-------------------
                    if Type = Type::Deduction then begin
                        Deductions.SetRange(Code, Code);
                        if Deductions.FindFirst()then begin
                            AssMatrix.Description:=Deductions.Description;
                            AssMatrix."G/L Account":=Deductions."Account No.";
                            AssMatrix."Tax Deductible":=Deductions."Tax deductible";
                            AssMatrix.Retirement:=Deductions."Pension Scheme";
                            AssMatrix.Shares:=Deductions.Shares;
                            AssMatrix.Paye:=Deductions."PAYE Code";
                            AssMatrix."Secondary PAYE":=Deductions."Secondary PAYE";
                            AssMatrix."Insurance Code":=Deductions."Insurance Code";
                            AssMatrix."Main Deduction Code":=Deductions."Main Deduction Code";
                            AssMatrix.Voluntary:=Deductions.Voluntary;
                            AssMatrix.Frequency:=Deductions.Type;
                            //Added
                            AssMatrix."Sacco Deduction":=Deductions."Sacco Deduction";
                            if Deductions.Type = Deductions.Type::Recurring then AssMatrix."Next Period Entry":=true;
                            AssMatrix.Amount:=PayrollRounding(Amount);
                            AssMatrix."Employer Amount":=PayrollRounding("Employer Amount");
                        end;
                        if Type = Type::Deduction then AssMatrix.Amount:=-Amount;
                    end;
                    AssMatrix.Modify();
                end;
            //----------------Allowances Calculation------------------//
            end;
            trigger OnPreDataItem()
            begin
                Window.HideSubsequentDialogs;
                Window.Open(ProgressTxt);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnPostReport()
    begin
        Window.close();
    end;
    var ProgressTxt: Label 'Updating Entries for ##1############################';
    Error002: Label 'Earning %1 %2 is Blocked';
    Error003: Label 'Deduction %1 %2 is Blocked';
    Text003: Label 'Deduction %1 %2 is Blocked';
    Employee: Record Employee;
    PayStartDate: Date;
    PayPeriodText: Text[30];
    Payments: Record EarningsX;
    HRSetup: Record "Human Resources Setup";
    Deductions: Record DeductionsX;
    PayrollMgt: Codeunit Payroll;
    OtherEarnings: Record "Other Earnings";
    AssgnMatrix: Record "Assignment Matrix-X";
    TotalOtherEarnings: Decimal;
    OtherDeductions: Record "Other Deductions";
    TotalOtherDeductions: Decimal;
    TrusteePayPeriod: Record "Payroll Period Trustees";
    Window: Dialog;
    Employees: record Employee temporary;
    AssMatrix: record "Assignment Matrix-X";
}

report 50286 "Trustee Summary By Center_1"
{
    Caption = 'Board members Summary By Center';
    DefaultLayout = RDLC;
    RDLCLayout = './TrusteeSummaryByCenter1.rdl';
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
            column(Amount; Round("Assignment Matrix-X".Amount, 0.05))
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
            column(Net; GrossPay - Deduct)
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
            trigger OnAfterGetRecord()
            begin
                case "Assignment Matrix-X".Type of
                    "Assignment Matrix-X".Type::Payment:
                        if Ea.Get("Assignment Matrix-X".Code) then;
                end;
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Payroll Period", "Assignment Matrix-X"."Payroll Period");
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                AssignMatrix.SetRange("Global Dimension 1 Code", "Assignment Matrix-X"."Global Dimension 1 Code");
                if AssignMatrix.Find('-') then begin
                    AssignMatrix.CalcSums(Amount);
                    GrossPay := Round(AssignMatrix.Amount, 0.05);
                end;
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Payroll Period", "Assignment Matrix-X"."Payroll Period");
                AssignMatrix.SetRange(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SetRange("Global Dimension 1 Code", "Assignment Matrix-X"."Global Dimension 1 Code");
                if AssignMatrix.Find('-') then begin
                    AssignMatrix.CalcSums(Amount);
                    Deduct := Round((Abs(AssignMatrix.Amount)), 0.05);
                end;
                AssignMatrix.Reset;
                AssignMatrix.SetRange("Payroll Period", "Assignment Matrix-X"."Payroll Period");
                AssignMatrix.SetCurrentKey("Employee No");
                AssignMatrix.SetRange("Global Dimension 1 Code", "Assignment Matrix-X"."Global Dimension 1 Code");
                if AssignMatrix.Find('-') then EmpCount := AssignMatrix.Count;
                /*
                    Employee.RESET;
                    Employee.SETRANGE("No.","Assignment Matrix-X"."Employee No");
                    IF Employee.FIND('-') THEN
                      BEGIN
                        EmpCount:=Employee.COUNT;
                      END;
                    */
            end;

            trigger OnPreDataItem()
            begin
                //AssignMatrix.SETRANGE("Payroll Period","Assignment Matrix-X"."Payroll Period");
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

    var
        Employee: Record Employee;
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

    procedure GetCodeName("Code": Code[20]): Text[200]
    var
        Earn: Record EarningsX;
        Ded: Record DeductionsX;
    begin
        if Earn.Get(Code) then exit(Earn.Description);
        if Ded.Get(Code) then exit(Ded.Description);
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

report 50228 "Payroll Reconciliation Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollReconciliationSummary.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(AssignmentMatrix; "Assignment Matrix-X")
        {
            DataItemTableView = SORTING("Payroll Period", Type, Code) WHERE("Tax Relief" = CONST(false), "Non-Cash Benefit" = CONST(false));
            RequestFilterFields = "Payroll Period", Type, "Code";
            RequestFilterHeading = 'Payroll';

            column(TIME; Time)
            {
            }
            column(USERID; UserId)
            {
            }
            column(UPPERCASE_FORMAT__Payroll_Period__0___month_text___year4____; UpperCase(Format("Payroll Period", 0, '<month text> <year4>')))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(PERIOD_Caption; PERIOD_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(COMPANY_SUMMARYCaption; COMPANY_SUMMARYCaptionLbl)
            {
            }
            column(CURRENT_AMOUNTCaption; CURRENT_AMOUNTCaptionLbl)
            {
            }
            column(PREVIOUS_MONTH_AMOUNTCaption; PREVIOUS_MONTH_AMOUNTCaptionLbl)
            {
            }
            column(VARIANCECaption; VARIANCECaptionLbl)
            {
            }
            column(DESCRIPTIONCaption; DESCRIPTIONCaptionLbl)
            {
            }
            column(CODECaption; CODECaptionLbl)
            {
            }
            column(Assignment_Matrix_X_Employee_No; "Employee No")
            {
            }
            column(Assignment_Matrix_X_Type; Type)
            {
            }
            column(Assignment_Matrix_X_Code; Code)
            {
            }
            column(Assignment_Matrix_X_Payroll_Period; "Payroll Period")
            {
            }
            column(Assignment_Matrix_X_Reference_No; "Reference No")
            {
            }
            trigger OnAfterGetRecord()
            begin
                if AssignmentMatrix.Type = AssignmentMatrix.Type::Payment then begin
                    if Earning.Get(AssignmentMatrix.Code) then begin
                        if not Earning."Non-Cash Benefit" then TotalNetPay := TotalNetPay + AssignmentMatrix.Amount;
                    end;
                end
                else
                    TotalNetPay := TotalNetPay + AssignmentMatrix.Amount + AssignmentMatrix."Loan Interest";
                Assmatrix.Reset;
                Assmatrix.SetRange(Type, AssignmentMatrix.Type);
                Assmatrix.SetRange(Code, AssignmentMatrix.Code);
                Assmatrix.SetRange("Employee No", AssignmentMatrix."Employee No");
                Assmatrix.SetRange("Payroll Period", PreviousMonth);
                if Assmatrix.Find('-') then begin
                    PreviousAmount := PreviousAmount + Assmatrix.Amount + Assmatrix."Loan Interest";
                    if Assmatrix.Type = Assmatrix.Type::Payment then begin
                        if Earning.Get(Assmatrix.Code) then begin
                            if not Earning."Non-Cash Benefit" then PrevTotalNetPay := PrevTotalNetPay + Assmatrix.Amount;
                        end;
                    end
                    else
                        PrevTotalNetPay := PrevTotalNetPay + Assmatrix.Amount + Assmatrix."Loan Interest";
                end;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo(Code);
                TotalNetPay := 0;
                PrevTotalNetPay := 0;
                PreviousAmount := 0;
            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number);

            column(ABS_CurrAmount_Number___ABS_PrevAmount_Number__; (CurrAmount[Number]) - (PrevAmount[Number]))
            {
            }
            column(PrevAmount_Number_; PrevAmount[Number])
            {
            }
            column(CurrAmount_Number_; CurrAmount[Number])
            {
            }
            column(Desc_Number_; Desc[Number])
            {
            }
            column(Ref_Number_; Ref[Number])
            {
            }
            column(NoOfEmployees_PrevNoOfEmployees; NoOfEmployees - PrevNoOfEmployees)
            {
            }
            column(PrevNoOfEmployees; PrevNoOfEmployees)
            {
            }
            column(ABS_PrevTotalEarnings__ABS_PrevTotalDeductions_; Abs(PrevTotalEarnings) - Abs(PrevTotalDeductions))
            {
            }
            column(ABS_CurrTotalEarnings__ABS_CurrTotalDeductions____ABS_PrevTotalEarnings__ABS_PrevTotalDeductions__; (Abs(CurrTotalEarnings) - Abs(CurrTotalDeductions)) - (Abs(PrevTotalEarnings) - Abs(PrevTotalDeductions)))
            {
            }
            column(NoOfEmployees; NoOfEmployees)
            {
            }
            column(ABS_CurrTotalEarnings__ABS_CurrTotalDeductions_; Abs(CurrTotalEarnings) - Abs(CurrTotalDeductions))
            {
            }
            column(No_of_Employees_; 'No of Employees')
            {
            }
            column(Text002; Text002)
            {
            }
            column(Integer_Number; Number)
            {
            }
            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, i);
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
        EmpRec.Reset;
        EmpRec.SetRange(EmpRec."Pay Period Filter", AssignmentMatrix.GetRangeMin(AssignmentMatrix."Payroll Period"));
        if EmpRec.Find('-') then
            repeat
                EmpRec.CalcFields(EmpRec."Total Allowances", EmpRec."Total Deductions", EmpRec."Loan Interest");
                if (EmpRec."Total Allowances" + EmpRec."Total Deductions" + EmpRec."Loan Interest") <> 0 then NoOfEmployees := NoOfEmployees + 1;
            until EmpRec.Next = 0;
        //Previous Month
        PreviousMonth := CalcDate('-1M', AssignmentMatrix.GetRangeMin(AssignmentMatrix."Payroll Period"));
        EmpRec.Reset;
        EmpRec.SetRange(EmpRec."Pay Period Filter", PreviousMonth);
        if EmpRec.Find('-') then
            repeat
                EmpRec.CalcFields(EmpRec."Total Allowances", EmpRec."Total Deductions", EmpRec."Loan Interest");
                if (EmpRec."Total Allowances" + EmpRec."Total Deductions" + EmpRec."Loan Interest") <> 0 then PrevNoOfEmployees := PrevNoOfEmployees + 1;
            until EmpRec.Next = 0;
        //Get the earnings and deductions
        PrevTotalEarnings := 0;
        CurrTotalEarnings := 0;
        PrevTotalDeductions := 0;
        CurrTotalDeductions := 0;
        i := 1;
        Desc[i] := Text003;
        i := i + 1;
        Earning.Reset;
        Earning.SetRange(Earning."Non-Cash Benefit", false);
        if Earning.Find('-') then
            repeat //Previous Month
                Earning.SetRange("Pay Period Filter");
                Earning.SetRange("Pay Period Filter", PreviousMonth);
                Earning.CalcFields("Total Amount");
                PrevAmount[i] := Earning."Total Amount";
                Desc[i] := Earning.Description;
                Ref[i] := Earning.Code;
                PrevTotalEarnings := PrevTotalEarnings + PrevAmount[i];
                //Current Month
                Earning.SetRange("Pay Period Filter");
                Earning.SetRange("Pay Period Filter", AssignmentMatrix.GetRangeMin(AssignmentMatrix."Payroll Period"));
                Earning.CalcFields("Total Amount");
                CurrAmount[i] := Earning."Total Amount";
                Desc[i] := Earning.Description;
                Ref[i] := Earning.Code;
                CurrTotalEarnings := CurrTotalEarnings + CurrAmount[i];
                //Increase Counter
                if (CurrAmount[i] <> 0) or (PrevAmount[i] <> 0) then i := i + 1;
            until Earning.Next = 0;
        //Get Total Earnings
        Desc[i] := Text000;
        PrevAmount[i] := PrevTotalEarnings;
        CurrAmount[i] := CurrTotalEarnings;
        i := i + 1;
        //
        Desc[i] := Text004;
        i := i + 1;
        DeductionRec.Reset;
        if DeductionRec.Find('-') then
            repeat //Previous Month
                DeductionRec.SetRange("Pay Period Filter");
                DeductionRec.SetRange("Pay Period Filter", PreviousMonth);
                DeductionRec.CalcFields("Total Amount", "Loan Interest");
                PrevAmount[i] := DeductionRec."Total Amount" + DeductionRec."Loan Interest";
                Desc[i] := DeductionRec.Description;
                Ref[i] := DeductionRec.Code;
                PrevTotalDeductions := PrevTotalDeductions + PrevAmount[i];
                //Current Month
                DeductionRec.SetRange("Pay Period Filter");
                DeductionRec.SetRange("Pay Period Filter", AssignmentMatrix.GetRangeMin(AssignmentMatrix."Payroll Period"));
                DeductionRec.CalcFields("Total Amount", "Loan Interest");
                CurrAmount[i] := DeductionRec."Total Amount" + DeductionRec."Loan Interest";
                Desc[i] := DeductionRec.Description;
                Ref[i] := DeductionRec.Code;
                CurrTotalDeductions := CurrTotalDeductions + CurrAmount[i];
                //Increase Counter
                if (CurrAmount[i] <> 0) or (PrevAmount[i] <> 0) then i := i + 1;
            until DeductionRec.Next = 0;
        //
        //Get Total Deductions
        Desc[i] := Text001;
        PrevAmount[i] := PrevTotalDeductions;
        CurrAmount[i] := CurrTotalDeductions;
        //
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalNetPay: Decimal;
        Earning: Record EarningsX;
        NoOfEmployees: Integer;
        EmpRec: Record Employee;
        PreviousMonth: Date;
        PrevAmount: array[100] of Decimal;
        Assmatrix: Record "Assignment Matrix-X";
        PrevTotalNetPay: Decimal;
        PrevNoOfEmployees: Integer;
        DeductionRec: Record DeductionsX;
        i: Integer;
        CurrAmount: array[100] of Decimal;
        Desc: array[200] of Text[100];
        PreviousAmount: Decimal;
        Ref: array[200] of Code[20];
        CurrTotalEarnings: Decimal;
        PrevTotalEarnings: Decimal;
        CurrTotalDeductions: Decimal;
        PrevTotalDeductions: Decimal;
        TotalFor: Label 'Total for ';
        Text000: Label 'Total Earnings';
        Text001: Label 'Total Deductions';
        Text002: Label 'Net Salary';
        Text003: Label 'Earnings';
        Text004: Label 'Deductions';
        PERIOD_CaptionLbl: Label 'PERIOD:';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        COMPANY_SUMMARYCaptionLbl: Label 'COMPANY SUMMARY';
        CURRENT_AMOUNTCaptionLbl: Label 'CURRENT AMOUNT';
        PREVIOUS_MONTH_AMOUNTCaptionLbl: Label 'PREVIOUS MONTH AMOUNT';
        VARIANCECaptionLbl: Label 'VARIANCE';
        DESCRIPTIONCaptionLbl: Label 'DESCRIPTION';
        CODECaptionLbl: Label 'CODE';
}

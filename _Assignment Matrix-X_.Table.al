table 50364 "Assignment Matrix-X"
{
    DataCaptionFields = "Employee No", Description;
    DrillDownPageID = "Payments & Deductions";
    LookupPageID = "Payments & Deductions";

    fields
    {
        field(1; "Employee No"; Code[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    "Posting Group Filter" := Employee."Posting Group";
                    "Department Code" := Employee."Global Dimension 1 Code";
                    "Salary Grade" := Employee."Salary Scale";
                    "Salary Pointer" := Employee.Present;
                    if Employee."Posting Group" = '' then;
                    //ERROR(Error000,Employee."First Name",Employee."Last Name");
                    if Employee.Status <> Employee.Status::Active then;
                    //ERROR(Error001,Employee."First Name",Employee."Last Name");
                    if Employee."Employment Type" <> Employee."Employment Type"::Trustee then begin
                        if EmpContract.Get(Employee."Nature of Employment") then "Employee Type" := EmpContract."Employee Type";
                    end
                    else
                        "Employee Type" := Employee."Employment Type";
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    Area := Employee.Area;
                end;
            end;
        }
        field(2; Type; Option)
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            OptionCaption = 'Payment,Deduction,Saving Scheme,Loan';
            OptionMembers = Payment,Deduction,"Saving Scheme",Loan;
        }
        field(3; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = IF (Type = CONST(Payment)) EarningsX
            ELSE IF (Type = CONST(Deduction)) DeductionsX
            ELSE IF (Type = CONST(Loan)) "Loan Application"."Loan No" WHERE("Employee No" = FIELD("Employee No"));

            trigger OnValidate()
            var
                Formula: Code[50];
                ScaleBenefits: Record "Scale Benefits";
                HouseAllowances: Record "House Allowances";
            begin
                GetPayPeriod;
                "Payroll Period" := PayStartDate;
                "Pay Period" := PayPeriodText;
                GetSetup;
                GetEmployee;
                // ----------------Allowances Calculation------------------
                if Type = Type::Payment then begin
                    Payments.SetRange(Code, Code);
                    if Payments.Find('-') then begin
                        // Check If Blocked
                        if Payments.Block = true then Error(Error002, Payments.Code, Payments.Description);
                        "Time Sheet" := Payments."Time Sheet";
                        Description := Payments.Description;
                        Frequency := Payments."Pay Type";
                        if Payments."Earning Type" = Payments."Earning Type"::"Tax Relief" then "Tax Relief" := true;
                        "Non-Cash Benefit" := Payments."Non-Cash Benefit";
                        Quarters := Payments.Quarters;
                        //Paydeduct:=Payments."End Date";
                        Taxable := Payments.Taxable;
                        "Tax Deductible" := Payments."Reduces Tax";
                        Gratuity := Payments.Gratuity;
                        if Payments."Pay Type" = Payments."Pay Type"::Recurring then "Next Period Entry" := true;
                        "Basic Salary Code" := Payments."Basic Salary Code";
                        "Basic Pay Arrears" := Payments."Basic Pay Arrears";
                        if Payments."Earning Type" = Payments."Earning Type"::"Normal Earning" then "Normal Earnings" := true;
                    end
                    else
                        "Normal Earnings" := false;
                    "House Allowance Code" := Payments."House Allowance Code";
                    //Added LAPUFUND
                    "Commuter Allowance Code" := Payments."Commuter Allowance Code";
                    "Salary Arrears Code" := Payments."Salary Arrears Code";
                    case Payments."Calculation Method" of
                        Payments."Calculation Method"::"Flat amount":
                            Amount := Payments."Flat Amount";
                        // % Of Basic Pay
                        Payments."Calculation Method"::"% of Basic pay":
                            begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay", "Basic Arrears");
                                /*//Leave Allowance
                                        IF Payments."Leave Allwance"=TRUE THEN
                                          BEGIN
                                            Amount:=(Payments.Percentage*(Employee."Basic Pay"*12));
                                          END ELSE*/
                                //Gratuity
                                /*if Payments.Gratuity = true then begin
                                            //Amount:=Payments.Percentage/100*(PayrollMgt.GetMonthWorked(Employee."No."));
                                            //Amount:=Payments.Percentage/100*(Employee."Basic Pay"*12);
                                        end else*/
                                Payments.TestField(Percentage);
                                Amount := Payments.Percentage / 100 * (Employee."Basic Pay" - Employee."Basic Arrears");
                                Amount := PayrollRounding(Amount);
                            end;
                        // % Of Basic after Tax
                        Payments."Calculation Method"::"% of Basic after tax":
                            begin
                                if HRSetup."Company overtime hours" <> 0 then Amount := PayrollRounding(Amount);
                            end;
                        // Based on Hourly Rate
                        Payments."Calculation Method"::"Based on Hourly Rate":
                            begin
                                /*
                                             Amount:="No. of Units"*Employee."Driving Licence"*Payments."Overtime Factor";
                                             IF Payments."Overtime Factor"<>0 THEN
                                             Amount:="No. of Units"*Employee."Driving Licence"*Payments."Overtime Factor";
                                             Amount:=PayrollRounding(Amount);
                                             */
                            end;
                        // Based on Daily Rate
                        Payments."Calculation Method"::"Based on Daily Rate":
                            begin
                                /*
                                            Amount:=Employee."Driving Licence"*Employee."days worked";
                                            Amount:=PayrollRounding(Amount);
                                            */
                            end;
                        // % Of Insurance Amount
                        Payments."Calculation Method"::"% of Insurance Amount":
                            begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Insurance Premium");
                                if "Ext Insurance Amount" <> 0 then
                                    Amount := Abs((Payments.Percentage / 100) * ("Ext Insurance Amount"))
                                else
                                    Amount := Abs((Payments.Percentage / 100) * (Employee."Insurance Premium"));
                                Amount := PayrollRounding(Amount);
                            end;
                        // % F Gross Pay
                        Payments."Calculation Method"::"% of Gross pay":
                            begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay", "Total Allowances");
                                Amount := ((Payments.Percentage / 100) * (Employee."Total Allowances"));
                                Amount := PayrollRounding(Amount);
                            end;
                        // % of Taxable Income
                        Payments."Calculation Method"::"% of Taxable income":
                            begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Taxable Allowance");
                                Amount := ((Payments.Percentage / 100) * (Employee."Taxable Allowance"));
                                Amount := PayrollRounding(Amount);
                            end;
                        //Formula
                        Payments."Calculation Method"::Formula:
                            begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Formula := PayrollMgt.GetPureFormula("Employee No", "Payroll Period", Payments.Formula);
                                Amount := PayrollMgt.GetResult(Formula);
                            end;
                        //% of Other Earnings
                        Payments."Calculation Method"::"% of Other Earnings":
                            begin
                                TotalOtherEarnings := 0;
                                if Employee.Get("Employee No") then;
                                if Employee.Get("Employee No") then begin
                                    Employee.SetRange("Pay Period Filter", "Payroll Period");
                                    OtherEarnings.Reset;
                                    OtherEarnings.SetRange("Main Earning", Payments.Code);
                                    if OtherEarnings.Find('-') then
                                        repeat
                                            AssgnMatrix.Reset;
                                            AssgnMatrix.SetRange(AssgnMatrix.Code, OtherEarnings."Earning Code");
                                            AssgnMatrix.SetRange(AssgnMatrix."Payroll Period", "Payroll Period");
                                            AssgnMatrix.SetRange(AssgnMatrix.Type, AssgnMatrix.Type::Payment);
                                            AssgnMatrix.SetRange(AssgnMatrix."Employee No", "Employee No");
                                            if AssgnMatrix.Find('-') then TotalOtherEarnings += Abs(AssgnMatrix.Amount);
                                        until OtherEarnings.Next = 0;
                                    Payments.TestField(Percentage);
                                    Amount := ((TotalOtherEarnings / 100) * Payments.Percentage);
                                    Amount := PayrollRounding(Amount);
                                end;
                            end;
                        Payments."Calculation Method"::"% of Annual Basic":
                            begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay");
                                Amount := ((Payments.Percentage / 100) * (Employee."Basic Pay" * 12));
                                Amount := PayrollRounding(Amount);
                            end
                        else begin
                            if Payments."Leave Allwance" = true then begin
                                Employee.Reset;
                                Employee.SetRange("No.", "Employee No");
                                if Employee.Find('-') then begin
                                    if Employee."Employment Type" = Employee."Employment Type"::Permanent then Amount := ((Employee."Basic Pay" * 12) * (Payments.Percentage / 100));
                                end
                                else begin
                                    if Employee."Employment Type" = Employee."Employment Type"::Contract then Amount := ((Employee."Basic Pay" * PayrollMgt.GetMonthWorked("Employee No")) * (Payments.Percentage / 100));
                                end;
                            end;
                        end;
                    end;
                    Employee.Reset();
                    Employee.SetRange("No.", "Employee No");
                    if Employee.FindFirst() then begin
                        if Payments."House Allowance Code" = true then begin
                            ScaleBenefits.Reset;
                            ScaleBenefits.SetRange("Salary Scale", Employee."Salary Scale");
                            ScaleBenefits.SetRange("Salary Pointer", Employee.Present);
                            ScaleBenefits.SetRange("Based on branches", true);
                            if ScaleBenefits.Find('-') then begin
                                repeat
                                    HouseAllowances.reset;
                                    HouseAllowances.SetRange("Job group", ScaleBenefits."Salary Scale");
                                    HouseAllowances.SetRange(Pointer, ScaleBenefits."Salary Pointer");
                                    HouseAllowances.SetRange(Branch, Employee."Global Dimension 1 Code");
                                    HouseAllowances.SetRange(Code, ScaleBenefits."ED Code");
                                    if HouseAllowances.FindFirst() then Amount := HouseAllowances.Amount;
                                until ScaleBenefits.Next() = 0;
                            end;
                        end;
                    end;
                    if Payments."Reduces Tax" then begin
                        Amount := PayrollRounding(Amount);
                    end;
                end;
                // //Check for active Leave
                // if "Basic Salary Code" then begin
                //     //check active leaves
                //     //check if leave type affects basic pay(study leave)
                //     Employee.Reset();
                //     Employee.SetRange("No.", "Employee No");
                //     if Employee.FindFirst() then begin
                //         if Employee."Leave Category" <> '' then begin
                //             if PayrollLeaveCategory.Get(Employee."Leave Category") then begin
                //                 Employee.CalcFields("Basic Pay");
                //                 Amount := (PayrollLeaveCategory."% of Basic Pay" / 100) * Employee."Basic Pay";
                //                 Amount := PayrollRounding(Amount);
                //                 Message(Format(Amount));
                //             end;
                //         end;
                //     end;
                // end;
                //------------------Deductions-------------------
                if Type = Type::Deduction then begin
                    Deductions.SetRange(Code, Code);
                    if Deductions.Find('-') then begin
                        if Deductions.Block = true then Error(Error003, Deductions.Code, Deductions.Description);
                        Description := Deductions.Description;
                        "G/L Account" := Deductions."Account No.";
                        "Tax Deductible" := Deductions."Tax deductible";
                        Retirement := Deductions."Pension Scheme";
                        Shares := Deductions.Shares;
                        Paye := Deductions."PAYE Code";
                        "Secondary PAYE" := Deductions."Secondary PAYE";
                        "Insurance Code" := Deductions."Insurance Code";
                        "Main Deduction Code" := Deductions."Main Deduction Code";
                        Voluntary := Deductions.Voluntary;
                        Frequency := Deductions.Type;
                        //Added
                        "Sacco Deduction" := Deductions."Sacco Deduction";
                        if Deductions.Type = Deductions.Type::Recurring then "Next Period Entry" := true;
                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"Flat Amount" then
                            if not Deductions.Imprest then begin
                                Amount := Deductions."Flat Amount";
                                "Employer Amount" := Deductions."Flat Amount Employer";
                            end;
                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay" then begin
                            if Employee.Get("Employee No") then begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay");
                                Amount := Deductions.Percentage / 100 * Employee."Basic Pay";
                                Amount := PayrollRounding(Amount);
                                CheckIfRatesInclusive("Employee No", "Payroll Period", Code, Amount);
                                "Employer Amount" := Deductions."Percentage Employer" / 100 * Employee."Basic Pay";
                                "Employer Amount" := PayrollRounding("Employer Amount");
                                CheckIfRatesInclusive("Employee No", "Payroll Period", Code, "Employer Amount");
                            end;
                        end;
                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Gross Pay" then begin
                            if Employee.Get("Employee No") then begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay", "Total Allowances");
                                Amount := Deductions.Percentage / 100 * Employee."Total Allowances";
                                Amount := PayrollRounding(Amount);
                                CheckIfRatesInclusive("Employee No", "Payroll Period", Code, Amount);
                                "Employer Amount" := Deductions."Percentage Employer" / 100 * Employee."Total Allowances";
                                "Employer Amount" := PayrollRounding("Employer Amount");
                                CheckIfRatesInclusive("Employee No", "Payroll Period", Code, "Employer Amount");
                            end;
                        end;
                        if Deductions.CoinageRounding = true then begin
                            Retirement := Deductions.CoinageRounding;
                            if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay" then
                                "Employer Amount" := Deductions.Percentage / 100 * Employee."Basic Pay"
                            else
                                "Employer Amount" := Deductions."Flat Amount";
                            "Employer Amount" := PayrollRounding("Employer Amount");
                        end;
                        Amount := PayrollRounding(Amount);
                        "Employer Amount" := PayrollRounding("Employer Amount");
                    end;
                    // Deduction Based on Basic Pay and House Allowance
                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance" then begin
                        if Employee.Get("Employee No") then
                            if Employee.Get("Employee No") then begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay", "House Allowance");
                                Amount := Deductions.Percentage / 100 * (Employee."Basic Pay" + Employee."House Allowance");
                                Amount := PayrollRounding(Amount);
                                CheckIfRatesInclusive("Employee No", "Payroll Period", Code, Amount);
                                "Employer Amount" := Deductions."Percentage Employer" / 100 * (Employee."Basic Pay" + Employee."House Allowance");
                                "Employer Amount" := PayrollRounding("Employer Amount");
                                CheckIfRatesInclusive("Employee No", "Payroll Period", Code, "Employer Amount");
                            end;
                    end;
                    //% of Other Earnings
                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Other Earnings" then begin
                        TotalOtherDeductions := 0;
                        if Employee.Get("Employee No") then;
                        if Employee.Get("Employee No") then begin
                            Employee.SetRange("Pay Period Filter", "Payroll Period");
                            OtherDeductions.Reset;
                            OtherDeductions.SetRange("Main Deduction", Deductions.Code);
                            if OtherDeductions.Find('-') then
                                repeat
                                    AssgnMatrix.Reset;
                                    AssgnMatrix.SetRange(AssgnMatrix.Code, OtherDeductions."Earning Code");
                                    AssgnMatrix.SetRange(AssgnMatrix."Payroll Period", "Payroll Period");
                                    AssgnMatrix.SetRange(AssgnMatrix.Type, AssgnMatrix.Type::Payment);
                                    AssgnMatrix.SetRange(AssgnMatrix."Employee No", "Employee No");
                                    if AssgnMatrix.Find('-') then TotalOtherDeductions += Abs(AssgnMatrix.Amount);
                                until OtherDeductions.Next = 0;
                            Deductions.TestField(Percentage);
                            Amount := ((TotalOtherDeductions / 100) * Deductions.Percentage);
                            Amount := PayrollRounding(Amount);
                            "Employer Amount" := Deductions."Percentage Employer" / 100 * TotalOtherDeductions;
                            "Employer Amount" := PayrollRounding("Employer Amount");
                            CheckIfRatesInclusive("Employee No", "Payroll Period", Code, "Employer Amount");
                        end;
                    end;
                    // Deduction Based on Basic Pay + House Allowance + Commuter Allowance + Salary arrears
                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance + Comm Allowance + Sal Arrears" then begin
                        if Employee.Get("Employee No") then
                            if Employee.Get("Employee No") then begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay", "House Allowance", "Commuter Allowance", "Salary Arrears");
                                Amount := Deductions.Percentage / 100 * (Employee."Basic Pay" + Employee."House Allowance" + Employee."Commuter Allowance" + Employee."Salary Arrears");
                                Amount := PayrollRounding(Amount);
                                CheckIfRatesInclusive("Employee No", "Payroll Period", Code, Amount);
                                "Employer Amount" := Deductions."Percentage Employer" / 100 * (Employee."Basic Pay" + Employee."House Allowance" + Employee."Commuter Allowance" + Employee."Salary Arrears");
                                "Employer Amount" := PayrollRounding("Employer Amount");
                                CheckIfRatesInclusive("Employee No", "Payroll Period", Code, "Employer Amount");
                            end;
                    end;
                    if Type = Type::Deduction then Amount := -Amount;
                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Table" then begin
                        GetPayPeriod;
                        Employee.Reset;
                        Employee.SetRange("No.", "Employee No");
                        Employee.SetRange("Pay Period Filter", "Payroll Period");
                        Employee.CalcFields("Total Allowances", "Basic Pay");
                        Amount := -(GetBracket(Deductions, Employee."Total Allowances", "Employee Tier I", "Employee Tier II"));
                        if Deductions."Pension Scheme" then "Employer Amount" := (GetBracket(Deductions, Employee."Total Allowances", "Employee Tier I", "Employee Tier II"));
                    end;
                    /* IF Deductions."Calculation Method"=Deductions."Calculation Method"::Formula THEN BEGIN
                            Employee.SETRANGE("Pay Period Filter","Payroll Period");
                            Formula:=PayrollMgt.GetPureFormula("Employee No","Payroll Period",Deductions.);
                            Amount:=PayrollMgt.GetResult(Formula);
                         END;
                         */
                end;
                if (Type = Type::Loan) then begin
                    LoanApp.Reset;
                    LoanApp.SetRange("Loan No", Code);
                    LoanApp.SetRange("Employee No", "Employee No");
                    if LoanApp.Find('-') then begin
                        if LoanProductType.Get("Loan Product Type") then Description := LoanProductType.Description;
                        Amount := -LoanApp.Repayment;
                        Validate(Amount);
                    end;
                end;
            end;
        }
        field(5; "Effective Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll PeriodX"."Starting Date";
        }
        field(6; "Effective End Date"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll PeriodX"."Starting Date";
        }
        field(7; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = IF ("Employee Type" = FILTER(Permanent | Partime | Locum)) "Payroll PeriodX"."Starting Date"
            ELSE IF ("Employee Type" = CONST(Casual)) "Payroll Period Casuals"."Starting Date"
            ELSE IF ("Employee Type" = CONST(Trustee)) "Payroll Period Trustees"."Starting Date";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;

            trigger OnValidate()
            begin
                if PayPeriod.Get("Payroll Period") then "Pay Period" := PayPeriod.Name;
            end;
        }
        field(8; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            var
                NetPayAmt: Decimal;
                OneThirdError: Label 'The deduction %1 defies the 1/3 rule defined in the operations setup, net pay for Employee %2  should be upto %3';
            begin
                //*********** Earnings********************//
                if (Type = Type::Payment) then begin
                    if Amount < 0 then Error(Error005);
                end;
                //********* Deductions ***************//
                if (Type = Type::Deduction) then begin
                    if xRec.Amount = 0 then begin
                        //if not PayrollMgt.CheckOneThirdRule(Rec, "Employee No", "Payroll Period", NetPayAmt, abs(Amount)) then
                        //Error(OneThirdError, Code, "Employee No", NetPayAmt);
                        //end else begin
                        //  if not PayrollMgt.CheckOneThirdRule(Rec, "Employee No", "Payroll Period", NetPayAmt, abs(Amount)) then
                        //   Error(OneThirdError, Code, "Employee No", NetPayAmt);
                    end;
                    if Amount > 0 then Amount := -Amount;
                    if Voluntary then "Employee Voluntary" := -Amount;
                end;
                //Faith
                // TestField(Closed, false);
                //Added
                /*
                IF "Loan Repay"=TRUE THEN
                BEGIN
                 IF Loan.GET(Rec.Code,Rec."Employee No") THEN BEGIN
                  Loan.CALCFIELDS(Loan."Initial Amount");
                  "Period Repayment":=ABS(Amount)+"Interest Amount";
                  "Initial Amount":=Loan."Effective Start Date";
                  "Outstanding Amount":=Loan."Effective Start Date"-Loan."Initial Amount";
                 END;
                END;
                */
                Amount := PayrollRounding(Amount);
                if "Manual Entry" then begin
                    if Employee.Get("Employee No") then begin
                        Employee.SetRange("Pay Period Filter", "Payroll Period");
                        Employee.CalcFields("Total Allowances", "Total Deductions");
                        /*
                            IF ((Employee."Total Allowances"+Empl."Total Deductions")+Amount)<0 THEN
                            ERROR('Assigning this deduction for Employee %1 will result in a negative pay, Total allowances=%2 Total deductions=%3'
                            ,"Employee No",Employee."Total Allowances",Employee."Total Deductions");
                             */
                    end;
                end;
                if not "Manual Entry" then begin
                    if Employee.Get("Employee No") then begin
                        Employee.SetRange("Pay Period Filter", "Payroll Period");
                        Employee.CalcFields("Total Allowances", "Total Deductions");
                        if ((Employee."Total Allowances" + Employee."Total Deductions")) < 0 then Message(Text001, "Employee No", Employee."Total Allowances", Employee."Total Deductions");
                    end;
                end;
                /*
                    IF "Basic Salary Code"=TRUE THEN
                      BEGIN
                        ValidateBPay(Code);
                      END;
                    */
            end;
        }
        field(9; Description; Text[150])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(10; Taxable; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(11; "Tax Deductible"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(12; Frequency; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Recurring,"Non-recurring";

            trigger OnValidate()
            begin
                if Frequency = Frequency::Recurring then
                    "Next Period Entry" := true
                else
                    "Next Period Entry" := false;
                Modify;
            end;
        }
        field(13; "Pay Period"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(15; "Basic Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Employer Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(17; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(18; "Next Period Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Posting Group Filter"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Posting GroupX";

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(20; "Initial Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Outstanding Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Loan Repay"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(23; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(24; "Salary Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Tax Relief"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Interest Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(27; "Period Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(28; "Non-Cash Benefit"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(29; Quarters; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "No. of Units"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                       HRSetup.GET;
                    IF Type=Type::Payment THEN BEGIN
                    IF Payments.GET(Code) THEN
                    BEGIN
                    IF Payments."Calculation Method"=Payments."Calculation Method"::"% of Basic after tax" THEN BEGIN
                    IF Empl.GET("Employee No") THEN
                    IF HRSetup."Company overtime hours"<>0 THEN
                    Amount:=(Empl."Hourly Rate" *"No. of Units"* Payments."Overtime Factor");///HRSetup."Company overtime hours"
                    END;

                    IF Payments."Calculation Method"=Payments."Calculation Method"::"Based on Hourly Rate" THEN BEGIN
                    IF Empl.GET("Employee No") THEN
                    Amount:="No. of Units"* Empl."Daily Rate";
                    IF Payments."Overtime Factor"<>0 THEN
                    Amount:="No. of Units"* Empl."Daily Rate" *Payments."Overtime Factor"

                    END;

                    IF Payments."Calculation Method"=Payments."Calculation Method"::"Flat amount" THEN BEGIN
                    IF Empl.GET("Employee No") THEN
                    Amount:="No. of Units"*Payments."Total Amount";
                    END;


                  END;
                  END;

                 //*****Deductions
                    IF Type=Type::Deduction THEN BEGIN
                    IF Deductions.GET(Code) THEN
                    BEGIN
                    IF Deductions."Calculation Method"=Deductions."Calculation Method"::"Based on Hourly Rate" THEN BEGIN
                    IF Empl.GET("Employee No") THEN
                    Amount:=-"No. of Units"* Empl."Hourly Rate"
                    END;

                    IF Deductions."Calculation Method"=Deductions."Calculation Method"::"Based on Daily Rate " THEN BEGIN
                    IF Empl.GET("Employee No") THEN
                    Amount:=-"No. of Units"* Empl."Daily Rate"
                    END;

                    IF Deductions."Calculation Method"=Deductions."Calculation Method"::"Flat Amount" THEN BEGIN
                    IF Empl.GET("Employee No") THEN
                    Amount:=-"No. of Units"*Deductions."Flat Amount";
                    END;

                  END;
                  END;
                  TESTFIELD(Closed,FALSE);
                 */
            end;
        }
        field(31; Section; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(33; Retirement; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(34; CFPay; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(35; BFPay; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(36; "Opening Balance"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Type = Type::Deduction) then if "Opening Balance" > 0 then "Opening Balance" := -"Opening Balance";
                TestField(Closed, false);
            end;
        }
        field(37; DebitAcct; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(38; CreditAcct; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39; Shares; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Show on Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Earning/Deduction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Recurring,"Non-recurring";
        }
        field(42; "Time Sheet"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Basic Salary Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Payroll Group"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Company;
        }
        field(45; Paye; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Taxable amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Less Pension Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Monthly Personal Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Normal Earnings"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; "Mortgage Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Monthly Self Cummulative"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Company Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Company Cummulative"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Main Deduction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Opening Balance Company"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Insurance Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Reference No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Manual Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Salary Pointer"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Employee Voluntary"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Amount:=-(ABS(Amount)+"Employee Voluntary");
            end;
        }
        field(61; "Employer Voluntary"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Product Type".Code;
        }
        field(63; "June Paye"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "June Taxable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "June Paye Diff"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Gratuity PAYE"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Paye = true then Modify;
            end;
        }
        field(67; "Basic Pay Arrears"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68; Voluntary; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Loan Interest"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Type = Type::Deduction) then begin
                    if "Loan Interest" > 0 then "Loan Interest" := -"Loan Interest";
                end;
            end;
        }
        field(70; "Top Up Share"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Insurance No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Employee Tier I"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Employee Tier II"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Employer Tier I"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Employer Tier II"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "House Allowance Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(77; "Pay Mode"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Pay Modes";
        }
        field(78; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "No of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(80; Prorated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "House No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Reason For Chage"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Employee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustee';
            OptionMembers = Permanent,Partime,Locum,Casual,Contract,Trustee;
        }
        field(84; Tenure; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Format(Tenure) <> '' then begin
                    "Effective End Date" := CalcDate(Tenure, "Effective Start Date");
                    "Effective End Date" := CalcDate('-1M', "Effective End Date");
                end;
            end;
        }
        field(85; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(86; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(87; "Area"; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(88; "Commuter Allowance Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(89; "Salary Arrears Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Sacco Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(91; "Ext Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Ext Insurance Amount" <> 0 then Validate(Code);
            end;
        }
        field(92; "Secondary PAYE"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(93; Imprest; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(94; Gratuity; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(95; "Mortgage Interest"; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; "Employee No", Type, "Code", "Payroll Period", "Reference No")
        {
            Clustered = true;
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key2; "Employee No", Taxable, "Tax Deductible", Retirement, "Non-Cash Benefit", "Tax Relief")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key3; Type, "Code", "Posting Group Filter")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key4; "Non-Cash Benefit")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key5; Type, "Pay Mode")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key6; "Non-Cash Benefit", Taxable)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key7; Type, Retirement)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key8; "Department Code", "Payroll Period", "Code")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key9; "Employee No", Shares)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key10; Closed, "Code", Type, "Employee No")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key11; "Show on Report")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key12; "Employee No", "Code", "Payroll Period", "Next Period Entry")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key13; "Opening Balance")
        {
        }
        key(Key14; "Department Code", "Payroll Period", Type, "Code")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key15; "Basic Salary Code", "Basic Pay Arrears")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key16; Paye)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount, "Taxable amount";
        }
        key(Key17; "Employee No", "Payroll Period", Type, "Non-Cash Benefit", "Normal Earnings")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "No. of Units", "Opening Balance", Amount, "Taxable amount";
        }
        key(Key18; "Posting Group Filter")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount, "Taxable amount";
        }
        key(Key19; "Payroll Period", Type, "Code")
        {
            SumIndexFields = Amount, "Loan Interest", "Top Up Share";
        }
        key(Key20; Type, "Employee No", "Payroll Period", "Insurance Code")
        {
            SumIndexFields = Amount;
        }
        key(Key21; "Employee No", Type, "Code", "Payroll Period", "Posting Group Filter", "Department Code", "Payroll Group")
        {
            SumIndexFields = Amount, "Loan Interest", "Employer Amount";
        }
        key(Key22; "House Allowance Code")
        {
            SumIndexFields = Amount;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
    end;

    trigger OnDelete()
    begin
        //  TestField(Closed, false);
    end;

    trigger OnModify()
    begin
        //   TestField(Closed, false);
    end;

    trigger OnRename()
    begin
        //  TestField(Closed, false);
    end;

    var
        Paydeduct: Decimal;
        Empl: Record Employee;
        Loan: Record "Employee Earnings History";
        TableAmount: Decimal;
        Basic: Decimal;
        ReducedBal: Decimal;
        InterestAmt: Decimal;
        Maxlimit: Decimal;
        Benefits: Record BracketsX;
        InterestDiff: Decimal;
        SalarySteps: Record "Assignment Matrix-X";
        "reference no": Record "Assignment Matrix-X";
        PPSetup: Record "Purchases & Payables Setup";
        Error000: Label 'Assign  %1  %2 a posting group before assigning any earning or deduction';
        Error001: Label 'You can only assign Earnings and deductions to Active Employees Please confirm if  %1 %2 is an Active Employee';
        Error002: Label 'Earning %1 %2 is Blocked';
        Error003: Label 'Deduction %1 %2 is Blocked';
        Text003: Label 'Deduction %1 %2 is Blocked';
        Error005: Label 'Earning must not be negative';
        "--------------Cheruiyot----------------------------": Integer;
        Employee: Record Employee;
        PayPeriod: Record "Payroll PeriodX";
        PayStartDate: Date;
        PayPeriodText: Text[30];
        Payments: Record EarningsX;
        LoanApp: Record "Loan Application";
        HRSetup: Record "Human Resources Setup";
        Deductions: Record DeductionsX;
        LoanProductType: Record "Loan Product Type";
        Text001: Label 'Assigning this deduction for Employee %1 will result in a negative pay, Total allowances=%2 Total deductions=%3';
        Earnings: Record EarningsX;
        PayrollMgt: Codeunit Payroll;
        EmpContract: Record "Employment Contract";
        DimMgt: Codeunit DimensionManagement;
        AssignmentMatrixX: Record "Assignment Matrix-X";
        ValidateAmountTxt: Label 'You have earnings or deductions that depend on changing this amount.\Do you wish to update them?';
        OtherEarnings: Record "Other Earnings";
        AssgnMatrix: Record "Assignment Matrix-X";
        TotalOtherEarnings: Decimal;
        OtherDeductions: Record "Other Deductions";
        TotalOtherDeductions: Decimal;
        TrusteePayPeriod: Record "Payroll Period Trustees";
        PayrollLeaveCategory: Record "Payroll Leave Category";

    procedure GetPayPeriod()
    begin
        case "Employee Type" of
            "Employee Type"::Trustee:
                begin
                    TrusteePayPeriod.SetRange("Close Pay", false);
                    if TrusteePayPeriod.FindFirst then begin
                        PayStartDate := TrusteePayPeriod."Starting Date";
                        PayPeriodText := TrusteePayPeriod.Name;
                    end;
                end;
            else begin
                PayPeriod.SetRange("Close Pay", false);
                if PayPeriod.Find('-') then PayStartDate := PayPeriod."Starting Date";
                PayPeriodText := PayPeriod.Name;
            end;
        end;
    end;

    procedure GetBracket(DeductionsRec: Record DeductionsX; BasicPay: Decimal; var TierI: Decimal; var TierII: Decimal) TotalAmt: Decimal
    var
        BracketTable: Record BracketsX;
        BracketSource: Record "Bracket TablesX";
        Loop: Boolean;
        PensionableAmt: Decimal;
        TableAmount: Decimal;
        i: Integer;
    begin
        TotalAmt := 0;
        TableAmount := 0;
        i := 0;
        if BracketSource.Get(DeductionsRec."Deduction Table") then;
        BracketTable.SetRange(BracketTable."Table Code", BracketSource."Bracket Code");
        //BracketTable.SETRANGE(Institution,DeductionsRec."Institution Code");
        if BracketTable.Find('-') then begin
            case BracketSource.Type of
                BracketSource.Type::Fixed:
                    begin
                        repeat
                            if ((BasicPay >= BracketTable."Lower Limit") and (BasicPay <= BracketTable."Upper Limit")) then TotalAmt := BracketTable.Amount;
                        until BracketTable.Next = 0;
                    end;
                BracketSource.Type::"Graduating Scale":
                    begin
                        PensionableAmt := BasicPay;
                        repeat
                            i := i + 1;
                            if BasicPay <= 0 then
                                Loop := true
                            else begin
                                if BasicPay >= BracketTable."Upper Limit" then begin
                                    TableAmount := (BracketTable."Taxable Amount" * BracketTable.Percentage / 100);
                                    if Deductions."Pension Scheme" then begin
                                        if i = 1 then
                                            TierI := TableAmount
                                        else
                                            TierII := TableAmount;
                                    end;
                                    TotalAmt := TotalAmt + TableAmount;
                                end
                                else begin
                                    PensionableAmt := PensionableAmt - BracketTable."Lower Limit";
                                    TableAmount := PensionableAmt * (BracketTable.Percentage / 100);
                                    Loop := true;
                                    if Deductions."Pension Scheme" then begin
                                        if i = 1 then
                                            TierI := TableAmount
                                        else
                                            TierII := TableAmount;
                                    end;
                                    TotalAmt := TotalAmt + TableAmount;
                                end;
                            end;
                        until (BracketTable.Next = 0) or Loop = true;
                    end;
            end;
        end;
        exit(TotalAmt);
        //ELSE
        //MESSAGE('The Brackets have not been defined');
    end;

    procedure CreateLIBenefit(var Employee: Code[10]; var BenefitCode: Code[10]; var ReducedBalance: Decimal)
    var
        PaymentDeduction: Record "Assignment Matrix-X";
        Payrollmonths: Record "Payroll PeriodX";
        allowances: Record EarningsX;
    begin
        PaymentDeduction.Init;
        PaymentDeduction."Employee No" := Employee;
        PaymentDeduction.Code := BenefitCode;
        PaymentDeduction.Type := PaymentDeduction.Type::Payment;
        PaymentDeduction."Payroll Period" := PayStartDate;
        PaymentDeduction.Amount := ReducedBalance * InterestDiff;
        PaymentDeduction."Non-Cash Benefit" := true;
        PaymentDeduction.Taxable := true;
        //PaymentDeduction."Next Period Entry":=TRUE;
        if allowances.Get(BenefitCode) then PaymentDeduction.Description := allowances.Description;
        PaymentDeduction.Insert;
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

    procedure GetSetup()
    begin
        HRSetup.Get;
    end;

    procedure GetEmployee()
    begin
        if Employee.Get("Employee No") then;
    end;

    procedure CheckIfRatesInclusive(EmpNo: Code[20]; PayPeriod: Date; DeductionCode: Code[20]; var DeductibleAmt: Decimal)
    var
        DeductionsRec: Record DeductionsX;
        BracketTable: Record BracketsX;
        BracketSource: Record "Bracket TablesX";
        AssMatrix: Record "Assignment Matrix-X";
        i: Integer;
    begin
        if DeductionsRec.Get(DeductionCode) then begin
            if DeductionsRec."Pension Scheme" then begin
                i := 0;
                DeductionsRec.Reset;
                DeductionsRec.SetRange("Calculation Method", DeductionsRec."Calculation Method"::"Based on Table");
                DeductionsRec.SetRange("Pension Scheme", true);
                if DeductionsRec.Find('-') then begin
                    if BracketSource.Get(DeductionsRec."Deduction Table") then;
                    BracketTable.SetRange(BracketTable."Table Code", DeductionsRec."Deduction Table");
                    if BracketTable.Find('-') then
                        repeat
                            i := i + 1;
                            if BracketTable."Contribution Rates Inclusive" then begin
                                AssMatrix.Reset;
                                AssMatrix.SetRange("Employee No", EmpNo);
                                AssMatrix.SetRange("Payroll Period", PayPeriod);
                                AssMatrix.SetRange(Type, AssMatrix.Type::Deduction);
                                AssMatrix.SetRange(Code, DeductionsRec.Code);
                                if AssMatrix.Find('-') then begin
                                    if i = 1 then
                                        DeductibleAmt := DeductibleAmt - AssMatrix."Employee Tier I"
                                    else
                                        DeductibleAmt := DeductibleAmt - AssMatrix."Employee Tier II";
                                end;
                            end;
                        until BracketTable.Next = 0;
                end;
            end;
        end;
    end;

    procedure ValidateBPay(EDCode: Code[20])
    var
        Earns: Record EarningsX;
        Deds: Record DeductionsX;
        Assign: Record "Assignment Matrix-X";
    begin
        begin
            Earns.Reset;
            Earns.SetRange("Calculation Method", Earns."Calculation Method"::"% of Basic pay");
            if Earns.Find('-') then begin
                repeat //Assign.VALIDATE(Code);
                    Validate(Code);
                until Earns.Next = 0;
            end;
            Deds.Reset;
            Deds.SetRange("Calculation Method", Deds."Calculation Method"::"% of Basic Pay");
            if Deds.Find('-') then begin
                repeat //Assign.VALIDATE(Code);
                    Validate(Code);
                until Deds.Next = 0;
            end;
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.SaveDefaultDim(DATABASE::Employee,"No.",FieldNumber,ShortcutDimCode);
        Modify;
    end;

    procedure UpdateEmployeeDetails(var AssignmentMatrix: Record "Assignment Matrix-X")
    var
        myInt: Integer;
    begin
        if Employee.Get(AssignmentMatrix."Employee No") then begin
            AssignmentMatrix."Posting Group Filter" := Employee."Posting Group";
            AssignmentMatrix."Department Code" := Employee."Global Dimension 1 Code";
            AssignmentMatrix."Salary Grade" := Employee."Salary Scale";
            AssignmentMatrix."Salary Pointer" := Employee.Present;
            if Employee."Posting Group" = '' then;
            //ERROR(Error000,Employee."First Name",Employee."Last Name");
            if Employee.Status <> Employee.Status::Active then;
            //ERROR(Error001,Employee."First Name",Employee."Last Name");
            if Employee."Employment Type" <> Employee."Employment Type"::Trustee then begin
                if EmpContract.Get(Employee."Nature of Employment") then AssignmentMatrix."Employee Type" := EmpContract."Employee Type";
            end
            else
                AssignmentMatrix."Employee Type" := Employee."Employment Type";
            AssignmentMatrix."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
            AssignmentMatrix."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
            AssignmentMatrix.Area := Employee.Area;
        end;
    end;
}

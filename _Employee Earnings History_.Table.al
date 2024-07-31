table 50357 "Employee Earnings History"
{
    fields
    {
        field(1; "Employee No"; Code[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Employee;
        }
        field(2; Type; Option)
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            OptionCaption = 'Payment,Deduction,Saving Scheme,Loan';
            OptionMembers = Payment, Deduction, "Saving Scheme", Loan;
        }
        field(3; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = IF(Type=CONST(Payment))EarningsX
            ELSE IF(Type=CONST(Deduction))DeductionsX
            ELSE IF(Type=CONST(Loan))"Loan Application"."Loan No" WHERE("Employee No"=FIELD("Employee No"));
        }
        field(5; "Effective Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Effective End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = "Payroll PeriodX"."Starting Date";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
        }
        field(8; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2: 2;
        }
        field(9; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Taxable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Tax Deductible"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Frequency; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Recurring, "Non-recurring";
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
            DecimalPlaces = 2: 2;
        }
        field(17; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(18; "Next Period Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Posting Group Filter"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Posting GroupX";
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
        }
        field(27; "Period Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Non-Cash Benefit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; Quarters; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "No. of Units"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; Section; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(33; Retirement; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; CFPay; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; BFPay; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Opening Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
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
            OptionMembers = Recurring, "Non-recurring";
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
    }
    keys
    {
        key(Key1; "Employee No", Type, "Code", "Payroll Period", "Reference No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Deductions: Record DeductionsX;
    EmpRec: Record Employee;
    procedure UpdateEntries(AssignMatrix: Record "Assignment Matrix-X")
    var
        EmpEarnRec: Record "Employee Earnings History";
    begin
        EmpEarnRec.Init;
        EmpEarnRec.TransferFields(AssignMatrix);
        if not EmpEarnRec.Get(EmpEarnRec."Employee No", EmpEarnRec.Type, EmpEarnRec.Code, EmpEarnRec."Payroll Period", EmpEarnRec."Reference No")then EmpEarnRec.Insert
        else
        begin
            EmpEarnRec.Reset;
            EmpEarnRec.SetRange("Employee No", AssignMatrix."Employee No");
            EmpEarnRec.SetRange(Type, AssignMatrix.Type);
            EmpEarnRec.SetRange(Code, AssignMatrix.Code);
            EmpEarnRec.SetRange("Payroll Period", AssignMatrix."Payroll Period");
            EmpEarnRec.SetRange("Reference No", AssignMatrix."Reference No");
            if EmpEarnRec.Find('-')then begin
                EmpEarnRec.TransferFields(AssignMatrix);
                EmpEarnRec.Modify;
            end;
        end;
    end;
    procedure FetchFullAmt(AssignMatrix: Record "Assignment Matrix-X"): Decimal var
        EmpEarnRec: Record "Employee Earnings History";
    begin
        EmpEarnRec.Reset;
        EmpEarnRec.SetRange("Employee No", AssignMatrix."Employee No");
        EmpEarnRec.SetRange(Type, AssignMatrix.Type);
        EmpEarnRec.SetRange(Code, AssignMatrix.Code);
        EmpEarnRec.SetRange("Payroll Period", AssignMatrix."Payroll Period");
        EmpEarnRec.SetRange("Reference No", AssignMatrix."Reference No");
        if EmpEarnRec.Find('-')then begin
            exit(EmpEarnRec.Amount);
        end;
    end;
}

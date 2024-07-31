table 50361 DeductionsX
{
    DrillDownPageID = Deduction;
    LookupPageID = Deduction;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Recurring, "Non-recurring";
        }
        field(6; "Tax deductible"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Advance; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Start date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Flat Amount", "% of Basic Pay", "Based on Table", "Based on Hourly Rate", "Based on Daily Rate ", "% of Gross Pay", "% of Basic Pay+Hse Allowance", Formula, "% of Basic Pay+Hse Allowance + Comm Allowance + Sal Arrears", "% of Other Earnings";
        }
        field(12; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account" WHERE("Account Type"=CONST(Posting), Blocked=CONST(false))
            ELSE IF("Account Type"=CONST(Customer))Customer
            ELSE IF("Account Type"=CONST(Vendor))Vendor
            ELSE IF("Account Type"=CONST("Bank Account"))"Bank Account"
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF("Account Type"=CONST("IC Partner"))"IC Partner"
            ELSE IF("Account Type"=CONST(Employee))Employee;
        }
        field(13; "Flat Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Deduction), Code=FIELD(Code), "Posting Group Filter"=FIELD("Posting Group Filter"), "Payroll Period"=FIELD("Pay Period Filter"), "Employee No"=FIELD("Employee Filter"), "Department Code"=FIELD("Department Filter"), "Reference No"=FIELD("Reference Filter"), "Payroll Group"=FIELD("Company Filter"), "Employee Type"=field("Employee Type Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Date Filter"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Posting Group Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Employee Posting GroupX";
        }
        field(17; Loan; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Maximum Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Grace period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Repayment Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll PeriodX";
        }
        field(26; "Pension Scheme"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Deduction Table"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bracket TablesX";
        }
        field(28; "Account No. Employer"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF("Account Type Employer"=CONST("G/L Account"))"G/L Account" WHERE("Account Type"=CONST(Posting), Blocked=CONST(false))
            ELSE IF("Account Type Employer"=CONST(Customer))Customer
            ELSE IF("Account Type Employer"=CONST(Vendor))Vendor
            ELSE IF("Account Type Employer"=CONST("Bank Account"))"Bank Account"
            ELSE IF("Account Type Employer"=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF("Account Type Employer"=CONST("IC Partner"))"IC Partner"
            ELSE IF("Account Type Employer"=CONST(Employee))Employee;
        }
        field(29; "Percentage Employer"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Minimum Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Flat Amount Employer"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Total Amount Employer"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Employer Amount" WHERE(Type=CONST(Deduction), Code=FIELD(Code), "Payroll Period"=FIELD("Pay Period Filter"), "Posting Group Filter"=FIELD("Posting Group Filter"), "Department Code"=FIELD("Department Filter"), "Employee No"=FIELD("Employee Filter"), "Payroll Group"=FIELD("Company Filter"), "Employee Type"=field("Employee Type Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Loan Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,KCB,Coop Loan I,Coop Loan II,HELB,Self HELB,Salary in Advance,Car Loan,Salary Advance 1';
            OptionMembers = " ", KCB, "Coop Loan I", "Coop Loan II", HELB, "Self HELB", "Staff Advance", "Car Loan", "Staff Advance1";
        }
        field(34; "Show Balance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; CoinageRounding; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Employee Filter"; Code[30])
        {
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(37; "Opening Balance"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Opening Balance" WHERE(Type=CONST(Deduction), Code=FIELD(Code), "Employee No"=FIELD("Employee Filter"), "Employee Type"=field("Employee Type Filter")));
            FieldClass = FlowField;
        }
        field(38; "Department Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(39; "Balance Mode"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Increasing, Decreasing';
            OptionMembers = Increasing, " Decreasing";
        }
        field(40; "Main Loan Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(41; Shares; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Show on report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Non-Interest Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Exclude when on Leave"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Co-operative"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Total Shares"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Deduction), Code=FIELD(Code), "Employee No"=FIELD("Employee Filter"), Shares=CONST(true), "Employee Type"=field("Employee Type Filter")));
            FieldClass = FlowField;
        }
        field(47; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "PAYE Code"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckPAYE(Code);
            end;
        }
        field(49; "Total Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Housing Earned Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Pension Limit Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Pension Limit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Applies to All"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Show on Master Roll"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Pension Scheme Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Main Deduction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Insurance Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(58; Block; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Institution Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Institutions;
        }
        field(60; "Reference Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(61; "Show on Payslip Information"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Voluntary Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Owner Occupied Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64; Voluntary; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Voluntary Amount"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Code=FIELD("Voluntary Code"), "Payroll Period"=FIELD("Pay Period Filter"), "Employee No"=FIELD("Employee Filter"), Type=CONST(Deduction), "Employee Type"=field("Employee Type Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Voluntary Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX WHERE(Voluntary=CONST(true));
        }
        field(67; "Loan Interest"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Loan Interest" WHERE(Type=CONST(Deduction), Code=FIELD(Code), "Posting Group Filter"=FIELD("Posting Group Filter"), "Payroll Period"=FIELD("Pay Period Filter"), "Employee No"=FIELD("Employee Filter"), "Department Code"=FIELD("Department Filter"), "Reference No"=FIELD("Reference Filter"), "Payroll Group"=FIELD("Company Filter"), "Employee Type"=field("Employee Type Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68; "Share Top Up"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Top Up Share" WHERE(Type=CONST(Deduction), Code=FIELD(Code), "Posting Group Filter"=FIELD("Posting Group Filter"), "Payroll Period"=FIELD("Pay Period Filter"), "Employee No"=FIELD("Employee Filter"), "Department Code"=FIELD("Department Filter"), "Reference No"=FIELD("Reference Filter"), "Employee Type"=field("Employee Type Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; "Company Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Company;
        }
        field(70; "Customer Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Sacco Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Balance Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Increasing,Decreasing';
            OptionMembers = Increasing, Decreasing;
        }
        field(73; "Exclude Employer Balance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(74; Statutories; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Secondary PAYE"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "Account Type";enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(77; "Account Type Employer";enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
        }
        field(78; Imprest; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Employee Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustee';
            OptionMembers = Permanent, Partime, Locum, Casual, Contract, Trustee;
        }
        field(80; "NSSF"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Exempt from a third rule"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(82; HELB; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(83; NITA; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(84; "Share Contributions Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX;
        }
        field(85; "Benevolent Contributions Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = DeductionsX;
        }
        field(86; "Interest Deduction Code"; Code[20])
        {
            TableRelation = DeductionsX;
        }
        field(87; "Auto Create PV"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(88; "PV created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(89; "POP Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "POP Codes";
        }
        field(90; "PV Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll PeriodX";
        }
        field(91; "NHIF"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Show on report")
        {
        }
        key(Key3; "Exclude when on Leave")
        {
        }
        key(Key4; "Co-operative")
        {
        }
        key(Key5; Rate)
        {
        }
        key(Key6; Shares)
        {
        }
        key(Key7; Loan)
        {
        }
        key(Key8; "Pension Scheme Code")
        {
        }
        key(Key9; "Institution Code")
        {
        }
        key(Key10; Description)
        {
        }
    }
    fieldgroups
    {
    }
    var Text000: Label 'You cannot have more than one PAYE Code, %1  %2 is already defined as PAYE';
    procedure CheckPAYE(PAYECode: Code[20])
    var
        DeductionsRec: Record DeductionsX;
    begin
        DeductionsRec.Reset;
        DeductionsRec.SetFilter(Code, '<>%1', PAYECode);
        DeductionsRec.SetRange("PAYE Code", true);
        if DeductionsRec.Find('-')then Error(Text000, DeductionsRec.Code, DeductionsRec.Description);
    end;
}

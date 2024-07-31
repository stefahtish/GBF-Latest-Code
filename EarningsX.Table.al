table 50360 EarningsX
{
    DrillDownPageID = Earning;
    LookupPageID = Earning;

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
        field(3; "Pay Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Recurring,Non-recurring';
            OptionMembers = Recurring, "Non-recurring";
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Taxable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Flat amount,% of Basic pay,% of Gross pay,% of Insurance Amount,% of Taxable income,% of Basic after tax,Based on Hourly Rate,Based on Daily Rate,Formula,% of Annual Basic,% of Other Earnings,% of Mortgage Amount';
            OptionMembers = "Flat amount", "% of Basic pay", "% of Gross pay", "% of Insurance Amount", "% of Taxable income", "% of Basic after tax", "Based on Hourly Rate", "Based on Daily Rate", Formula, "% of Annual Basic", "% of Other Earnings", "% of Mortgage Amount";
        }
        field(8; "Flat Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Account No."; Code[20])
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
        field(11; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), Code=FIELD(Code), "Posting Group Filter"=FIELD("Posting Group Filter"), "Payroll Period"=FIELD("Pay Period Filter"), "Employee No"=FIELD("Employee Filter"), "Department Code"=FIELD("Department Filter"), "Employee Type"=field("Employee Type Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Date Filter"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Posting Group Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Employee Posting GroupX";
        }
        field(14; "Pay Period Filter"; Date)
        {
            ClosingDates = false;
            FieldClass = FlowFilter;
            TableRelation = "Payroll PeriodX";
        }
        field(15; Quarters; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Non-Cash Benefit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Minimum Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Maximum Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Reduces Tax"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Overtime Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Employee Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Employee";
        }
        field(22; Counter; Integer)
        {
            CalcFormula = Count("Assignment Matrix-X" WHERE("Payroll Period"=FIELD("Pay Period Filter"), "Employee No"=FIELD("Employee Filter"), Code=FIELD(Code), "Employee Type"=field("Employee Type Filter")));
            FieldClass = FlowField;
        }
        field(23; NoOfUnits; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."No. of Units" WHERE(Code=FIELD(Code), "Payroll Period"=FIELD("Pay Period Filter"), "Employee No"=FIELD("Employee Filter"), "Employee Type"=field("Employee Type Filter")));
            FieldClass = FlowField;
        }
        field(24; "Low Interest Benefit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Show Balance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; CoinageRounding; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; OverDrawn; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Opening Balance"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Opening Balance" WHERE(Type=CONST(Payment), Code=FIELD(Code), "Employee No"=FIELD("Employee Filter"), "Employee Type"=field("Employee Type Filter")));
            FieldClass = FlowField;
        }
        field(29; OverTime; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Department Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(31; Months; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Used to cater for taxation based on annual bracket eg 1,12 months (the default is 1month) FOR NEPAL';
        }
        field(32; "Show on Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Time Sheet"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Total Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Total Hrs"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; Weekend; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; Weekday; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Basic Salary Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Default Enterprise"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Default Activity"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(41; Prorate; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Earning Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Normal Earning,Owner Occupier,Home Savings,Low Interest,Tax Relief,Insurance Relief';
            OptionMembers = "Normal Earning", "Owner Occupier", "Home Savings", "Low Interest", "Tax Relief", "Insurance Relief";
        }
        field(43; "Applies to All"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Show on Master Roll"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "House Allowance Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Responsibility Allowance Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Commuter Allowance Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(48; Block; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Basic Pay Arrears"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Pensionable Pay"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Used to define the monthly Pension Earned';
        }
        field(51; "Per Diem"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Part Time"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Leave Allwance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54; Formula; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Supension Earnings Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Requires Employee Request"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Casual Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(58; Gratuity; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Yearly Bonus"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Acting Allowance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Special Duty"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Salary Arrears Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "% of Other Earnings"; Integer)
        {
            CalcFormula = Count("Other Earnings" WHERE("Main Earning"=FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Sacco Earning"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Account Type";enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(66; "Employee Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustee';
            OptionMembers = Permanent, Partime, Locum, Casual, Contract, Trustee;
        }
        field(67; BoardSittingAllowance; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Transfer Allowance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Transport Allowance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Acting Not Qualify(%)"; Decimal)
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
        key(Key2; "Show on Report")
        {
        }
        key(Key3; OverTime)
        {
        }
        key(Key4; "Time Sheet")
        {
        }
        key(Key5; "Earning Type")
        {
        }
        key(Key6; "House Allowance Code")
        {
        }
        key(Key7; "Responsibility Allowance Code")
        {
        }
        key(Key8; "Commuter Allowance Code")
        {
        }
        key(Key9; Description)
        {
        }
    }
    fieldgroups
    {
    }
}

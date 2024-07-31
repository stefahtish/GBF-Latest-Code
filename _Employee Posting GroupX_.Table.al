table 50362 "Employee Posting GroupX"
{
    DrillDownPageID = "Employee HR Posting Group";
    LookupPageID = "Employee HR Posting Group";

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
        field(3; "Salary Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(4; "Income Tax Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(5; "SSF Employer Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(6; "SSF Employee Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(7; "Net Salary Payable"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF("Net Salary Account Type"=FILTER("G/L Account"))"G/L Account"
            ELSE IF("Net Salary Account Type"=FILTER(Vendor))Vendor
            ELSE IF("Net Salary Account Type"=FILTER("Bank Account"))"Bank Account"
            ELSE IF("Net Salary Account Type"=FILTER("Fixed Asset"))"Fixed Asset"
            ELSE IF("Net Salary Account Type"=FILTER(Customer))Customer;
        }
        field(8; "Operating Overtime"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(9; "Tax Relief"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(10; "Employee Provident Fund Acc."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(11; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll PeriodX";
        }
        field(12; "Pension Employer Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Pension Employee Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Earnings and deductions"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Daily Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Normal Overtime"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Weekend Overtime"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Enterprise Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(19; "Activity Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(20; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(21; Seasonals; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Pension; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Net Salary Account Type";enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(24; "Employee Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustee';
            OptionMembers = Permanent, Partime, Locum, Casual, Contract, Trustee;
        }
        field(25; "PAYE Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(26; "Employee Type"; Option)
        {
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustee';
            OptionMembers = Permanent, Partime, Locum, Casual, Contract, Trustee;
        }
        field(27; "Gratuity Account"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Earnings and deductions")
        {
        }
    }
    fieldgroups
    {
    }
}

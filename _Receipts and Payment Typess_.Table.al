table 50741 "Receipts and Payment Typess"
{
    fields
    {
        field(1; "Code"; Code[30])
        {
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account", Customer, Vendor, "Bank Account", "Fixed Asset", "IC Partner";
        }
        field(4; Type; Option)
        {
            OptionCaption = ' ,Receipt,Payment,Surrender,Imprest';
            OptionMembers = " ", Receipt, Payment, Surrender, Imprest;
        }
        field(5; "VAT Chargeable"; Option)
        {
            OptionMembers = No, Yes;
        }
        field(6; "Withholding Tax Chargeable"; Option)
        {
            OptionMembers = No, Yes;
        }
        field(7; "VAT Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(8; "Withholding Tax Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(9; "Default Grouping"; Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(10; "G/L Account"; Code[20])
        {
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account" WHERE("Account Type"=CONST(Posting), Blocked=CONST(false))
            ELSE IF("Account Type"=CONST(Customer))Customer
            ELSE IF("Account Type"=CONST(Vendor))Vendor
            ELSE IF("Account Type"=CONST("Bank Account"))"Bank Account"
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF("Account Type"=CONST("IC Partner"))"IC Partner";
        }
        field(50000; "Policy No. Mandatory"; Boolean)
        {
        }
        field(50001; "Claim No. Mandatory"; Boolean)
        {
        }
        field(50002; "Loan No. Mandatory"; Boolean)
        {
        }
        field(50003; "Split Principal and Interest"; Boolean)
        {
        }
        field(50004; "Insurance Trans Type"; Option)
        {
            OptionCaption = ' ,Premium,Commission,Tax,Wht,Excess,Claim Reserve,Claim Payment,Reinsurance Premium,Reinsurance Commission,Reinsurance Premium Taxes,Reinsurance Commission Taxes,Net Premium,Claim Recovery,Salvage,Reinsurance Claim Reserve,Reinsurance Recovery Payment ,Accrued Reinsurance Premium,Deposit Premium,XOL Adjustment Premium,UPR,IBNR,DAC,Re-UPR,Loan Deposit';
            OptionMembers = " ", Premium, Commission, Tax, Wht, Excess, "Claim Reserve", "Claim Payment", "Reinsurance Premium", "Reinsurance Commission", "Reinsurance Premium Taxes", "Reinsurance Commission Taxes", "Net Premium", "Claim Recovery", Salvage, "Reinsurance Claim Reserve", "Reinsurance Recovery Payment ", "Accrued Reinsurance Premium", "Deposit Premium", "XOL Adjustment Premium", UPR, IBNR, DAC, "Re-UPR", "Loan Deposit";
        }
        field(50005; "Investment Transaction Type"; Option)
        {
            OptionCaption = ' ,Acquisition,Disposal,Interest,Dividend,Bonus,Revaluation,Share-split,Premium,Discounts,Other Income,Expenses,Principal';
            OptionMembers = " ", Acquisition, Disposal, Interest, Dividend, Bonus, Revaluation, "Share-split", Premium, Discounts, "Other Income", Expenses, Principal;
        }
        field(50006; "Investment Type"; Code[10])
        {
            // TableRelation = "Investment Type";
            trigger OnValidate()
            begin
            //  IF AssetTypesRec.GET("Investment Type") THEN
            //     "Investment Type Name" := AssetTypesRec.Description;
            end;
        }
        field(50007; "Investment Type Name"; Text[30])
        {
        }
        field(50008; "No. Of Units Mandatory"; Boolean)
        {
        }
        field(50009; "Payment Schedule Link"; Boolean)
        {
        }
        field(50010; "Claimant ID. Mandatory"; Boolean)
        {
        }
        field(50011; "Debit Note Mandatory"; Boolean)
        {
        }
        field(50012; "Default Customer Posting Group"; Code[20])
        {
            TableRelation = "Customer Posting Group";
        }
        field(50013; "Default Vendor Posting Group"; Code[20])
        {
            TableRelation = "Vendor Posting Group";
        }
        field(50014; "Treaty Code Mandatory"; Boolean)
        {
        }
        field(50015; "Treaty Addendum Code Mandatory"; Boolean)
        {
        }
        field(50016; "Treaty Layer Mandatory"; Boolean)
        {
        }
        field(50017; "Investment Code Mandatory"; Boolean)
        {
        }
        field(50018; "FA Posting Type"; Option)
        {
            AccessByPermission = TableData "Fixed Asset"=R;
            Caption = 'FA Posting Type';
            OptionCaption = ' ,Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance';
            OptionMembers = " ", "Acquisition Cost", Depreciation, "Write-Down", Appreciation, "Custom 1", "Custom 2", Disposal, Maintenance;
        }
    }
    keys
    {
        key(Key1; "Code", Type)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var
// AssetTypesRec: Record Investment Type;
}

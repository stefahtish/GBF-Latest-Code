table 50118 "Receipts and Payment Types"
{
    DrillDownPageID = "Receipts & Payment Types";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Account Type";enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';

            trigger OnValidate()
            begin
                if Type = Type::Invoice then begin
                    if "Account Type" in["Account Type"::"Bank Account", "Account Type"::Customer, "Account Type"::Employee, "Account Type"::"IC Partner", "Account Type"::Vendor]then Error('Account type can only be G/L Account , Fixed Asset, Item or Charge (Item) for Invoices ');
                end;
                if "Account Type" = "Account Type"::"G/L Account" then "Direct Expense":=true
                else
                    "Direct Expense":=false;
            end;
        }
        field(4; Type; Option)
        {
            NotBlank = true;
            OptionCaption = ' ,Receipt,Payment,Imprest,Claim,Advance,Expense,Petty Cash,Receipt-Property,Input Tax,Service Charge,Invoice';
            OptionMembers = " ", Receipt, Payment, Imprest, Claim, Advance, Expense, "Petty Cash", "Receipt-Property", "Input Tax", "Service Charge", Invoice;
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
            TableRelation = IF("Account Type"=CONST(Customer))"Customer Posting Group"
            ELSE IF("Account Type"=CONST(Vendor))"Vendor Posting Group"
            ELSE IF("Account Type"=CONST("Bank Account"))"Bank Account Posting Group"
            ELSE IF("Account Type"=CONST("Fixed Asset"))"FA Posting Group"
            ELSE IF("Account Type"=CONST("IC Partner"))"IC Partner";
        }
        field(10; "Account No."; Code[20])
        {
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account" WHERE("Account Type"=CONST(Posting), Blocked=CONST(false))
            ELSE IF("Account Type"=CONST(Customer))Customer
            ELSE IF("Account Type"=CONST(Vendor))Vendor
            ELSE IF("Account Type"=CONST("Bank Account"))"Bank Account"
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF("Account Type"=CONST("IC Partner"))"IC Partner"
            ELSE IF("Account Type"=CONST(Employee))Employee
            ELSE IF("Account Type"=CONST(Item))Item;

            trigger OnValidate()
            begin
                GLAcc.Reset;
                if GLAcc.Get("Account No.")then begin
                    // "Old Account No":=GLAcc."Old Account No";
                    // IF Type=Type::Payment THEN
                    // //Ensure all Income statement accounts are set for budget control
                    // IF GLAcc."Income/Balance"= GLAcc."Income/Balance"::"Income Statement" THEN
                    //     GLAcc.TESTFIELD(GLAcc."Budget Controlled",TRUE);
                    //
                    //   GLAcc.TESTFIELD(GLAcc."Budget Controlled",TRUE);
                    if GLAcc."Direct Posting" = false then begin
                        Error('Direct Posting must be True');
                    end;
                end;
                if("Account Type" = "Account Type"::"G/L Account") and (GLAcc."Income/Balance" = GLAcc."Income/Balance"::"Income Statement")then "Direct Expense":=true
                else
                    "Direct Expense":=false;
            end;
        }
        field(11; "Pending Voucher"; Boolean)
        {
        }
        field(12; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if "Account Type" <> "Account Type"::"Bank Account" then begin
                    Error('You can only enter Bank No where Account Type is Bank Account');
                end;
            end;
        }
        field(13; "Transation Remarks"; Text[250])
        {
            NotBlank = true;
        }
        field(14; "Payment Reference"; Option)
        {
            OptionMembers = Normal, "Farmer Purchase";
        }
        field(15; "Customer Payment On Account"; Boolean)
        {
        }
        field(16; "Direct Expense"; Boolean)
        {
            Editable = false;
        }
        field(17; "Calculate Retention"; Option)
        {
            OptionMembers = No, Yes;
        }
        field(18; "Retention Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(19; Blocked; Boolean)
        {
        }
        field(20; "Based On Travel Rates Table"; Boolean)
        {
        }
        field(21; "Receipt Reference"; Option)
        {
            OptionMembers = Normal, "Travel Advance Refunds", "Other Advance Refunds";

            trigger OnValidate()
            begin
                if "Receipt Reference" <> "Receipt Reference"::Normal then TestField("Account Type", "Account Type"::Customer);
            end;
        }
        field(22; "Based On a Table"; Boolean)
        {
        }
        field(23; "Old Account No"; Code[20])
        {
        }
        field(24; "Do NOT Allow Apply Twice"; Boolean)
        {
        }
        field(25; "Payment Option"; Option)
        {
            OptionMembers = " ", "Medical Claims", Training;
        }
        field(26; "Imprest Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Claim Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Cost of Sale"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Check Medical Ceiling"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Property Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Property Receipt Type"; Option)
        {
            Caption = 'Property Transaction Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Rent Receipt,Service Charge,TPS Repayment,TPS Deposit';
            OptionMembers = "Rent Receipt", "Service Charge", "TPS Repayment", "TPS Deposit";
        }
        field(33; "Manual Allocation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(36; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(37; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(38; Training; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "VAT Bus. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group".Code;
        }
        field(40; "Payroll Liabilities"; Boolean)
        {
            DataClassification = ToBeClassified;
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
        fieldgroup(DropDown; "Code", Description, "Account Type", "Account No.")
        {
        }
    }
    var GLAcc: Record "G/L Account";
    PayLine: Record "Payment Lines";
}

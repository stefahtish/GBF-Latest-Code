table 50240 "Travel Expense"
{
    fields
    {
        field(1; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                RequestHeader.RESET;
                IF RequestHeader.GET("Document No") THEN
                  "Customer A/C":=RequestHeader."Customer A/C";
                */
            end;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate("Unit Price");
            end;
        }
        field(5; "Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(6; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount:=Quantity * "Unit Price";
                "Requested Amount":=Quantity * "Unit Price";
            end;
        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                //Check Whether amount exceeds the budget
                //Budget Amount
                GLSetup.GET;
                BudgetEntry.SETRANGE(BudgetEntry."Budget Name",GLSetup."Current Budget");
                BudgetEntry.SETRANGE(BudgetEntry."G/L Account No.","Account No");
                BudgetEntry.CALCFIELDS(BudgetEntry.Amount);
                BudgetAmount:=BudgetEntry.Amount;
                
                //Get The Net Change
                GLEntry.SETRANGE(GLEntry."G/L Account No.","Account No");
                */
            end;
        }
        field(8; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account", Customer, Vendor, "Bank Account", "Fixed Asset", "IC Partner";
        }
        field(9; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account"
            ELSE IF("Account Type"=CONST(Customer))Customer
            ELSE IF("Account Type"=CONST(Vendor))Vendor
            ELSE IF("Account Type"=CONST("Bank Account"))"Bank Account"
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF("Account Type"=CONST("IC Partner"))"IC Partner";

            trigger OnValidate()
            begin
            /*
                
                IF "Account No" <> '' THEN BEGIN
                GLEntry.RESET;
                GLEntry.SETRANGE(GLEntry."G/L Account No.","Account No");
                GLEntry.SETRANGE(GLEntry."Global Dimension 1 Code","Global Dimension 1 Code");
                GLEntry.SETRANGE(GLEntry."Global Dimension 2 Code","Global Dimension 2 Code");
                GLEntry.SETRANGE("Global Dimension 3 Code","Cost Centre" );
                GLEntry.CALCSUMS(Amount);
                IF GLEntry.FIND('-') THEN BEGIN
                "Actual Spent":=GLEntry.Amount;
                END;
                GLSetup.GET;
                BudgetEntry.RESET;
                BudgetEntry.SETRANGE(BudgetEntry."Budget Name",GLSetup."Current Budget");
                BudgetEntry.SETRANGE(BudgetEntry."G/L Account No.","Account No");
                BudgetEntry.SETRANGE(BudgetEntry."Global Dimension 1 Code","Global Dimension 1 Code");
                BudgetEntry.SETRANGE(BudgetEntry."Global Dimension 2 Code","Global Dimension 2 Code");
                BudgetEntry.SETRANGE(BudgetEntry."Budget Dimension 1 Code","Cost Centre");
                BudgetEntry.CALCSUMS(Amount);
                IF BudgetEntry.FIND('-') THEN
                "Available Budget":=BudgetEntry.Amount-"Actual Spent";
                //BudgetEntry.SETRANGE(BudgetEntry."Budget Dimension 4 Code");
                
                END;
                
                */
            end;
        }
        field(10; "Transaction Type"; Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                
                IF
                  TransactionTypeRec.GET("Transaction Type") THEN BEGIN
                  "Account Type":=TransactionTypeRec."Account Type";
                  "Account No":=TransactionTypeRec."Account No.";
                  Description:=TransactionTypeRec."Transaction Name";
                END;
                
                */
            end;
        }
        field(11; "Reference No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Requested Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Type; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                
                IF RequestHeader.GET("Document No") THEN
                BEGIN
                IF TravelRates.GET(RequestHeader."Job Group",RequestHeader.Country,RequestHeader.City,Type) THEN
                BEGIN
                "Unit Price":=TravelRates.Amount;
                END
                
                END;
                
                */
            end;
        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(16; "Asset No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset";
        }
        field(23; "Actual Spent"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Remaining Amount":=Amount - "Actual Spent";
            end;
        }
        field(24; "Remaining Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cust. Ledger Entry" WHERE("Customer No."=FIELD("Customer A/C"), Open=CONST(true));

            trigger OnValidate()
            begin
            /*

                CustLedger.RESET;
                CustLedger.SETRANGE(CustLedger."Entry No.","Entry No");
                CustLedger.SETRANGE(CustLedger.Open,TRUE);
                IF CustLedger.FIND('-') THEN
                BEGIN
                 Description:=CustLedger.Description;
                 Quantity:=1;
                 CustLedger.CALCFIELDS(CustLedger."Remaining Amount",CustLedger.Amount);
                 "Unit Price":=CustLedger."Remaining Amount";
                 Amount:=CustLedger."Remaining Amount";
                 //MESSAGE('RemainingAmt=%1\RequestedAmt=%2',CustLedger.Amount,"Requested Amount");
                 "Reference No":=CustLedger."Document No.";
                // MESSAGE('Reference=%1',CustLedger."Document No.");
                END;

               */
            end;
        }
        field(26; "Customer A/C"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Expense Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Accountable Expenses,Non-Accountable Expenses';
            OptionMembers = "Accountable Expenses", "Non-Accountable Expenses";
        }
        field(28; Surrender; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                
                IF "Expense Type"="Expense Type"::"Non-Accountable Expenses" THEN
                    ERROR(Text000);
                IF Amount=0 THEN
                  ERROR(Text001);
                
                
                */
            end;
        }
        field(29; "Available Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Cost Centre"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                
                Dimen:="Cost Centre";
                Dimen:=COPYSTR(Dimen, 1, 3);
                "Global Dimension 2 Code":=Dimen;
                Dimens:="Cost Centre";
                Dimens:=COPYSTR(Dimens, 1 , 1);
                "Global Dimension 1 Code":=Dimens;
                
                
                */
            end;
        }
        field(31; "FSC Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Fn Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

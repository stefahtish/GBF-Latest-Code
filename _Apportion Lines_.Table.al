table 50159 "Apportion Lines"
{
    fields
    {
        field(2; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
            DataClassification = ToBeClassified;
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ", Payment, Invoice, "Credit Memo", "Finance Charge Memo", Reminder, Refund;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                IncomingDocument: Record "Incoming Document";
            begin
            end;
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(8; "G/L Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(9; "G/L Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Entry"."Entry No." WHERE("G/L Account No."=FIELD("G/L Account No."), Amount=FILTER(>0), Apportioned=FILTER(false));

            trigger OnValidate()
            begin
                GetHeader;
                if GLEntry.Get("G/L Entry No.")then TransferFields(GLEntry);
            end;
        }
        field(10; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF("Bal. Account Type"=CONST("G/L Account"))"G/L Account"
            ELSE IF("Bal. Account Type"=CONST(Customer))Customer
            ELSE IF("Bal. Account Type"=CONST(Vendor))Vendor
            ELSE IF("Bal. Account Type"=CONST("Bank Account"))"Bank Account"
            ELSE IF("Bal. Account Type"=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF("Bal. Account Type"=CONST("IC Partner"))"IC Partner"
            ELSE IF("Bal. Account Type"=CONST(Employee))Employee;
        }
        field(17; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(27; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
            //UserMgt.LookupUserID("User ID");
            end;
        }
        field(51; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account", Customer, Vendor, "Bank Account", "Fixed Asset", "IC Partner", Employee;
        }
        field(53; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
            DataClassification = ToBeClassified;
        }
        field(54; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
            DataClassification = ToBeClassified;
        }
        field(55; "Document Date"; Date)
        {
            Caption = 'Document Date';
            ClosingDates = true;
            DataClassification = ToBeClassified;
        }
        field(56; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = ToBeClassified;
        }
        field(57; "Source Type"; Option)
        {
            Caption = 'Source Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Customer,Vendor,Bank Account,Fixed Asset,Employee';
            OptionMembers = " ", Customer, Vendor, "Bank Account", "Fixed Asset", Employee;
        }
        field(58; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            TableRelation = IF("Source Type"=CONST(Customer))Customer
            ELSE IF("Source Type"=CONST(Vendor))Vendor
            ELSE IF("Source Type"=CONST("Bank Account"))"Bank Account"
            ELSE IF("Source Type"=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF("Source Type"=CONST(Employee))Employee;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
            //ShowDimensions;
            end;
        }
        field(50031; "Investment Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset";
        }
        field(50032; "No. Of Units"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /* IF "Receipt Payment Type"="Receipt Payment Type"::"Unit Trust" THEN BEGIN
                 IF Brokers.GET("Unit Trust Member No") THEN BEGIN
                
                 Brokers.CALCFIELDS("No.Of Units","Acquisition Cost","Current Value",Revaluations);
                 IF "No. Of Units">Brokers."No.Of Units" THEN
                  ERROR('You cannot redeem more units than you have!!');
                
                
                   IF  Brokers."No.Of Units" >0 THEN
                // "Current unit price":=Brokers."Current Value"/Brokers."No.Of Units" ;
                 //"Price Per Share":="Current unit price";
                VALIDATE("Price Per Share");
                VALIDATE(Amount);
                  END;
                
                 END ELSE BEGIN
                  IF "No. Of Units"<0 THEN
                  ERROR('You Cannot Sale Negative No. of Shares!!');
                
                   VALIDATE(Amount);
                 END;*/
            end;
        }
        field(50033; "Investment Transcation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Acquisition,Disposal,Interest,Dividend,Bonus,Revaluation,Share-split,Premium,Discounts,Gain(Loss) on Disposal,Interest Receivable,Dividend Receivable,Right Issue';
            OptionMembers = , Acquisition, Disposal, Interest, Dividend, Bonus, Revaluation, "Share-split", Premium, Discounts, "Gain(Loss) on Disposal", "Interest Receivable", "Dividend Receivable", "Right Issue";
        }
        field(60030; "Nominal Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60031; "Payment Ref"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60050; "Document Filter"; Text[250])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                LookupDocuments;
            end;
        }
        field(60051; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9585; "Property Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9586; "Transaction Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9590; "Entry Type[Income/expense]"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Income,Expense';
            OptionMembers = " ", Income, Expense;
        }
        field(9591; "Lease No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9613; Rent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9614; "Service Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9615; "Property Floor"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9616; "Property Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9617; "Charge code"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(9702; "Property Transaction Type"; Option)
        {
            Caption = 'FA Posting Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Acquisition Cost,Revaluation,Revenue,Maintenance,Tenant Purchase,Interest,Repayments,Accrued Income,Interest Paid';
            OptionMembers = "Acquisition Cost", Revaluation, Revenue, Maintenance, "Tenant Purchase", Interest, Repayment, "Accrued Income", "Interest Paid";
        }
        field(9703; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9704; "Property Receipt Type"; Option)
        {
            Caption = 'Property Transaction Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Rent Receipt,Service Charge,TPS Repayment,TPS Deposit';
            OptionMembers = " ", "Rent Receipt", "Service Charge", "TPS Repayment", "TPS Deposit";
        }
        field(9705; "Period Reference"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accounting Period"."Starting Date";

            trigger OnValidate()
            var
                PeriodRec: Record "Accounting Period";
            begin
            end;
        }
    }
    keys
    {
        key(Key1; "No.", "G/L Account No.", "G/L Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var GLEntry: Record "G/L Entry";
    ApportionHeader: Record "Apportion Header";
    procedure LookupDocuments()
    var
        GLFilters: Text;
        ViewString: Text;
        GLEntries: Page "Apportion G/L Entries";
        GLEntry: Record "G/L Entry";
        GLEntryCopy: Record "G/L Entry";
    begin
        TestField("G/L Account No.");
        GLEntry.SetRange(GLEntry."G/L Account No.", "G/L Account No.");
        GLEntry.SetRange(GLEntry.Apportioned, false);
        GLEntry.SetFilter(GLEntry.Amount, '>%1', 0);
        GLEntries.SetTableView(GLEntry);
        GLEntries.LookupMode(true);
        if GLEntries.RunModal = ACTION::LookupOK then begin
            GLEntryCopy.Copy(GLEntry);
        //GLFilters:=GLEntries.GetSelectionFilter;
        end;
    end;
    local procedure GetHeader()
    begin
        if ApportionHeader.Get("No.")then;
    end;
}

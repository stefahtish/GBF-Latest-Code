table 50123 "Commitment Entries"
{
    DrillDownPageID = "Commitment Entries";
    LookupPageID = "Commitment Entries";

    fields
    {
        field(1; "Commitment No"; Code[20])
        {
            trigger OnValidate()
            begin
            /*
                IF "Commitment No" <> xRec."Commitment No" THEN BEGIN
                    GenLedgerSetup.GET();
                    NoSeriesMgt.TestManual( GenLedgerSetup."Commitment No");
                     "Commitment No" := '';
                END;
                 */
            end;
        }
        field(2; "Commitment Date"; Date)
        {
        }
        field(3; "Commitment Type"; Option)
        {
            OptionCaption = 'Commitment,Commitment Reversal,Encumberance,Encumberance Reversal';
            OptionMembers = Commitment, "Commitment Reversal", Encumberance, "Encumberance Reversal";
        }
        field(4; Account; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(5; "Committed Amount"; Decimal)
        {
        }
        field(6; User; Code[50])
        {
        }
        field(7; "Document No"; Code[20])
        {
        }
        field(8; InvoiceNo; Code[20])
        {
        }
        field(9; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10; No; Code[20])
        {
        }
        field(11; "Entry No"; Integer)
        {
            AutoIncrement = false;
        }
        field(12; "Global Dimension 1"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(13; "Global Dimension 2"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(14; "Line No."; Integer)
        {
        }
        field(15; "Account No."; Code[20])
        {
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account"
            ELSE IF("Account Type"=CONST(Customer))Customer
            ELSE IF("Account Type"=CONST(Vendor))Vendor
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset";
        }
        field(16; "Account Name"; Text[100])
        {
        }
        field(17; Description; Text[250])
        {
        }
        field(18; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account", Customer, Vendor, "Bank Account", "Fixed Asset";
        }
        field(19; "Uncommittment Date"; Date)
        {
        }
        field(20; "Dimension Set ID"; Integer)
        {
            Editable = true;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(21; "Last Modified By"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(22; "Global Dimension 3"; Code[15])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(23; "Global Dimension 4"; Code[15])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(24; "Global Dimension 5"; Code[15])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(25; "Global Dimension 6"; Code[15])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(26; "Global Dimension 7"; Code[15])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(27; "Global Dimension 8"; Code[15])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(28; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Imprest,Petty Cash,Payment Voucher,LPO,Store Requisition,Staff Claim,Imprest Surrender,Purchase Requisition,Purchase Invoice,Training Request';
            OptionMembers = " ", Imprest, "Petty Cash", "Payment Voucher", LPO, "Store Requisition", "Staff Claim", "Imprest Surrender", "Purchase Requisition", "Purchase Invoice", "Training Request";
        }
        field(29; "Payment Posted"; Boolean)
        {
            CalcFormula = Lookup(Payments.Posted WHERE("No."=FIELD("Commitment No")));
            FieldClass = FlowField;
        }
        field(30; "SRN Posted"; Boolean)
        {
            CalcFormula = Lookup("Internal Request Header".Posted WHERE("No."=FIELD("Commitment No")));
            FieldClass = FlowField;
        }
        field(31; "Imprest Surrendered"; Boolean)
        {
            CalcFormula = Lookup(Payments.Surrendered WHERE("No."=FIELD("Commitment No")));
            FieldClass = FlowField;
        }
        field(32; "Invoice No"; Code[50])
        {
            CalcFormula = Lookup("Purch. Inv. Header"."Vendor Invoice No." WHERE("Order No."=FIELD("Commitment No")));
            FieldClass = FlowField;
        }
        field(33; "Quantity Invoiced"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Direct Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Amount Incl VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Budget Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name".Name;
        }
    }
    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
            SumIndexFields = "Committed Amount";
        }
        key(Key2; "Commitment No", "Commitment Type", No)
        {
            SumIndexFields = "Committed Amount";
        }
        key(Key3; "Document No", "Commitment Type")
        {
            SumIndexFields = "Committed Amount";
        }
        key(Key4; Account, "Commitment Date", "Global Dimension 1", "Global Dimension 2")
        {
            SumIndexFields = "Committed Amount";
        }
        key(Key5; No, "Commitment Date")
        {
            SumIndexFields = "Committed Amount";
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
    /*
       IF "Commitment No" = '' THEN BEGIN
         GenLedgerSetup.GET(GenLedgerSetup."Commitment No");
         GenLedgerSetup.TESTFIELD(GenLedgerSetup."Commitment No");
         NoSeriesMgt.InitSeries(GenLedgerSetup."Commitment No",xRec."No. Series",0D,"Commitment No","No. Series");
       END;
        */
    end;
    var GenLedgerSetup: Record "General Ledger Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    DimMgt: Codeunit DimensionManagement;
    procedure ShowDimensions()
    begin
        "Dimension Set ID":=DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1', "Entry No"));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1", "Global Dimension 2");
    end;
}

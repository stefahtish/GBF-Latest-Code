table 50551 "Investment Setup"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Investment Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Money Market Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(4; "Property Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5; "Equity Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(6; "Mortgages/Loans"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(7; "Year Days"; Integer)
        {
        }
        field(8; "6months Days"; Integer)
        {
        }
        field(9; "Warning Period"; DateFormula)
        {
        }
        field(10; "Retirement Age"; Integer)
        {
        }
        field(11; "Market Mortgage Interest Rate"; Decimal)
        {
        }
        field(12; "Government Mortgage Rate"; Decimal)
        {
        }
        field(13; "Calendar Days"; Integer)
        {
        }
        field(14; "Withholding Tax Percentage"; Decimal)
        {
        }
        field(15; "Management Fee Receivables AC"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(16; "Management Fee Income AC"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(17; "Witholding Tax%-Fixed Deposits"; Decimal)
        {
        }
        field(18; "Other Commission Percentage"; Decimal)
        {
        }
        field(19; "Unit Trust Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(20; "Unit Trust Member Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(21; "Forex Exchange Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(22; "NSE Website"; Text[80])
        {
        }
        field(23; "General Journal"; Code[10])
        {
        }
        field(24; "Batch Name"; Code[20])
        {
        }
        field(25; "Offshore Investment Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(26; "Receipt Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(27; "Posted Receipts No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(28; "PV Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(29; "Requisition No.s"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(30; "Equity Settlement Period"; DateFormula)
        {
        }
        field(31; "Money Market Settlement Period"; DateFormula)
        {
        }
        field(32; "Bond Settlement Period"; DateFormula)
        {
        }
        field(33; "Bond Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(34; "Broker Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(35; "Investment Folder"; Text[100])
        {
        }
        field(36; "Institutions No."; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(37; "Registrer Nos."; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(38; "Disposal Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(39; "Dividend Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(40; "Expected Interest No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(41; Director; Code[30])
        {
        }
        field(42; "Report Ref No."; Code[20])
        {
        }
        field(43; "Fund/Pool Nos"; Code[20])
        {
            Caption = 'Funds';
            TableRelation = "No. Series";
        }
        field(44; "Current Company"; Text[30])
        {
            TableRelation = Company;
        }
        field(45; "Post to Inter Company"; Boolean)
        {
        }
        field(46; "Portfolio Trans Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(47; "Property Lease Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(48; "Lease Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(49; "Finance Email"; Text[100])
        {
        }
        field(50; "Investment Email"; Text[100])
        {
        }
        field(51; "Send to External"; Boolean)
        {
        }
        field(52; "Equity Action Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(53; "Rights Declaration Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(54; "Sale Rights Order Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(55; "Sale Rights Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(56; "Purchase Rights Order Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(57; "Purchase Rights Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(58; "Execise Rights Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(59; "Right Refund Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(60; "Billing Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(61; "Maintainace No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(62; "Room Booking"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(63; "Complains No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(64; "Fund Req Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(65; "Bid App Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(1000; "Investment Book Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(1001; "Allow FA Posting From"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(1002; "Allow FA Posting To"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(1003; "Tenant Purchase Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(1004; "TPS Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(1005; "Gen. Interest Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(1006; "Posted Tenant Purchase Inv No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(1007; "Property Interest Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(1008; "Property Interest Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(1009; "Share Price Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(1010; "Min Lease Renewal Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(1011; "Max Lease Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(1012; "Bulk Insert Journal"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate("Bulk Direct Posting");
            end;
        }
        field(1013; "Bulk Direct Posting"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Bulk Direct Posting" then if "Bulk Insert Journal" then Error(Text001, FieldCaption("Bulk Insert Journal"), FieldCaption("Bulk Direct Posting"));
            end;
        }
        field(1014; "Bulk Journal Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(1015; "Bulk Journal Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name"=FIELD("Bulk Journal Template"));
        }
        field(1016; "Bulk Posting Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(1017; "Tenant Gen. Bus. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Business Posting Group";
        }
        field(1018; "Tenant Gen. Prod. Posting Grp"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(1019; "TPS Principle Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(1020; "TPS Interest Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(1021; "TPS Gen. Bus. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";
        }
        field(1022; "TPS Gen. Prod. Posting Grp"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group";
        }
        field(1023; "TPS Application Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(1024; "TPS Penalty Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(1025; "TPS Penalty %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(1026; "TPS Invoice Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(1027; "Rounding Precision"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(1028; "Rounding Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Up,Down,Nearest';
            OptionMembers = " ", Up, Down, Nearest;
        }
        field(1029; "Charges Inclusive VAT"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(1030; "No. of Days in Year"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(1031; "TPS Invoice Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(1032; "TPS Penalty Grace Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(1033; "TPS Interest Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Schedule Interest,Daily Interest';
            OptionMembers = "Schedule Interest", "Daily Interest";
        }
        field(1034; "TPS FA Disposal Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name WHERE(Type=CONST(Assets));
        }
        field(1035; "Property Amalgamation Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(1036; "Penalty Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'No Penalty,Principal in Arrears,Principal in Arrears+Interest in Arrears';
            OptionMembers = "No Penalty", "Principal in Arrears", "Principal in Arrears+Interest in Arrears";
        }
        field(1037; "Service Charge Invoice Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Text001: Label '%1 and %2 cannot be both setup as true in the investment.';
}

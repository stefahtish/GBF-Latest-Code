table 50117 "Cash Management Setups"
{
    Caption = 'Cash Management Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Payment Voucher Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(3; "Imprest Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(4; "Imprest Surrender Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(5; "Petty Cash Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(6; "Receipt Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(7; "Post VAT"; Boolean)
        {
        }
        field(8; "Rounding Type"; Option)
        {
            OptionCaption = 'Up,Nearest,Down';
            OptionMembers = Up, Nearest, Down;
        }
        field(9; "Rounding Precision"; Decimal)
        {
        }
        field(10; "Imprest Limit"; Decimal)
        {
        }
        field(11; "Imprest Due Date"; DateFormula)
        {
        }
        field(12; "PV Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13; "Petty Cash Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(14; "Imprest Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(15; "Current Budget"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(16; "Current Budget Start Date"; Date)
        {
        }
        field(17; "Current Budget End Date"; Date)
        {
        }
        field(18; "Imprest Posting Group"; Code[20])
        {
            TableRelation = "Customer Posting Group";
        }
        field(19; "General Bus. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Business Posting Group";
        }
        field(20; "VAT Bus. Posting Group"; Code[20])
        {
            TableRelation = "VAT Business Posting Group";
        }
        field(21; "Check for Committment"; Boolean)
        {
        }
        field(23; "Imprest Surrender Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(24; "Bank Transfer Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(25; "Receipt Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(26; "Petty Cash Surrender Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(27; "Petty Cash Surrender Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(28; "Donor Workflows Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(29; "Attachment Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(30; "Approvals Delegation Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(31; "Petty Cash Max"; Decimal)
        {
        }
        field(32; "Staff Claim Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(33; "Staff Claim Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(34; "Bank Transfer Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(35; "Max Imprests Unsurrendered"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Max Open Documents"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "EFT Path"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Loan Journal Template"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(39; "Loan Batch Template"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch";
        }
        field(40; "Append Sign To Documents"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Laundry Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(42; "Laundry Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(43; "Laundry Payable Account"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(44; "Laundry Bank Account"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(45; "Laundry Inspection Notes"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(46; "Laundry Payment Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(47; "Laundry Invoice Path"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Profile Delegation Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(49; "Library Charge Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(50; "Library Charge Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name"=FIELD("Library Charge Template"));
        }
        field(51; "Library Charge Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(52; "Proposed Budget Approval Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(53; "Budget Approval Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54; "Bank Reconciliation Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(55; "Approtionment Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(56; "Apportion Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(57; "Apportion Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(58; "Apportionment Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(59; "Input Tax Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60; "Service Charge Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(61; "Service Charge Surrender Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(62; "Service Charge Claim Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(63; "FA Disposal Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(64; "Finance Email"; Text[100])
        {
        }
        field(66; "Departmemtal Budget Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(67; "Item Journal Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(68; "Tag Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(69; "PV Request Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(70; "Projects G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(71; "Vendor Email Subject"; Text[150])
        {
            Caption = 'Vendor Email Subject';
            DataClassification = ToBeClassified;
        }
        field(72; "Vendor Email Body"; Text[250])
        {
            Caption = 'Vendor Email Body';
            DataClassification = ToBeClassified;
        }
        field(73; "Customer Email subject"; Text[150])
        {
            Caption = 'Customer Email Subject';
            DataClassification = ToBeClassified;
        }
        field(74; "Customer Email Body"; Text[250])
        {
            Caption = 'Customer Email Body';
            DataClassification = ToBeClassified;
        }
        field(75; "EFT Payee Reference Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(76; "User Department Budget Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(77; "Tax Payment Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(78; "Medical Cover Receipt Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(79; "Payment Files Archive Path"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Tax Expense Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(81; "Tax Files Path"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(82; "EFT Path User"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(83; "EFT Path User Password"; Text[50])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
            Caption = 'EFT File Encryption Key';
        }
        field(84; "Forex Path"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(85; "EFT File Gen Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(86; "Default Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(87; "Travel Limit Date"; DateFormula)
        {
        }
        field(88; "Bill Number Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(89; "Welfare Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(90; "Travel Request Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50136; "POP Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "POP Codes";
        }
        field(50137; "Default Bank"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" WHERE("Bank Type"=CONST(Bank));
        }
        field(50141; "Pay Mode"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(50144; "Payment Description1"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50145; "Payment Description2"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50146; "Payment Description3"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50147; "Payment Description4"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50148; "Debit Narrative"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50149; "Credit Narrative"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50150; "Purpose Pay"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50151; "Serial No"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50152; "EFT Serial No"; Code[15])
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
}

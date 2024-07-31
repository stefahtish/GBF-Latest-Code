table 50405 "Loan Ledger Entry-Payroll"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Loan No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Employee No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF("Loan Customer Type"=CONST(Staff))Employee
            ELSE IF("Loan Customer Type"=CONST("External Customer"))Customer;
        }
        field(4; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Principal,Interest,Principal Repayment,Interest Repayment,Settlement';
            OptionMembers = " ", Principal, Interest, "Principal Repayment", "Interest Repayment", Settlement;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Payment Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Bank Account,Cash,Cheque,EFT,RTGS,MPESA,PDQ';
            OptionMembers = "G/L Account", "Bank Account", Cash, Cheque, EFT, RTGS, MPESA, PDQ;
        }
        field(8; "Payment Reference No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Debtor's Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(13; "Shortcut Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(14; "Shortcut Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(15; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Transaction Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Loan Customer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Staff,External Customer';
            OptionMembers = Staff, "External Customer";
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var DimMgt: Codeunit DimensionManagement;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        NewDimSetID: Integer;
        PaymentRec: Record Payments;
    begin
        OldDimSetID:="Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

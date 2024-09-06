tableextension 50108 BankAccTableExt extends "Bank Account"
{
    fields
    {
        modify("Balance (LCY)")
        {
            Caption = 'Balance (KSH)';
        }
        modify("Net Change (LCY)")
        {
            Caption = 'Net Change (KSH)';
        }
        modify("Debit Amount (LCY)")
        {
            Caption = 'Debit Amount (KSH)';
        }
        modify("Credit Amount (LCY)")
        {
            Caption = 'Credit Amount (KSH)';
        }
        modify("Balance at Date (LCY)")
        {
            Caption = 'Balance at Date (KSH)';
        }
        field(50000; "Bank Type"; Option)
        {
            OptionCaption = 'Bank,Petty Cash,Normal,Cash,Fixed Deposit,SMPA,Chq Collection';
            OptionMembers = Bank,"Petty Cash",Normal,Cash,"Fixed Deposit",SMPA,"Chq Collection";
        }
        field(50001; "CashierID"; Code[50])
        {
            TableRelation = "User Setup";
            DataClassification = ToBeClassified;
        }
        field(50002; "Address 4"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Address 5"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Narration"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Shortcut Dimension 3 Code"; Code[20])
        {
            TableRelation = "Dimension Value" where("Global Dimension No." = const(3));
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
        }
        field(50006; "Sort Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Check Bank Limit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Bank Limit (LCY)"; Decimal)
        {
            Caption = 'ank Limit (KSH)';
            AutoFormatType = 1;
            DataClassification = ToBeClassified;
        }
        field(50009; "Bank code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks;

            trigger OnValidate()
            var
                Banks: Record Banks;
            begin
                if Banks.get("Bank Code") then "Bank Name" := banks.Name;
            end;
        }
        //  "Bank Name"
        field(50010; "Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        // "Bank Branch Name"
        field(50011; "Bank Branch Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Bank Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
}

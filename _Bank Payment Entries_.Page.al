page 50210 "Bank Payment Entries"
{
    Caption = 'Bank Payment Entries';
    PageType = Card;
    SourceTable = "Bank Payment Entries";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Bill Number"; Rec."Bill Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill Number field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created Date field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Mode field.';
                }
                field("Bank Reference"; Rec."Bank Reference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Reference field.';
                }
                field("Debit Account"; Rec."Debit Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Debit Account field.';
                }
                field(CustomerRefNumber; Rec.CustomerRefNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CustomerRefNumber field.';
                }
                field("Debit CustName"; Rec."Debit CustName")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Debit CustName field.';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone Number field.';
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Date field.';
                }
                field("Bill Amount"; Rec."Bill Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill Amount field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
            }
        }
    }
}

pageextension 50104 VendorCardExt extends "Vendor Card"
{
    layout
    {
        modify("Our Account No.")
        {
            Visible = false;
        }
        addlast(General)
        {
            field("Staff No."; Rec."Staff No.")
            {
                ApplicationArea = All;
            }
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = All;
            }
            field(Investment; Rec.Investment)
            {
                ApplicationArea = All;
            }
            field("Bond Counter Party"; Rec."Bond Counter Party")
            {
                ApplicationArea = All;
            }
            field("Bond Issuer"; Rec."Bond Issuer")
            {
                ApplicationArea = All;
            }
            field("PIN Certificate Expiry"; Rec."PIN Certificate Expiry")
            {
                Caption = 'Tax compliance expiry date';
                ApplicationArea = All;
            }
            field("KBA Bank Code"; Rec."KBA Bank Code")
            {
                ApplicationArea = all;
                Caption = 'Bank Code';
            }
            field("Bank Name"; Rec."Bank Name")
            {
                ApplicationArea = all;
            }
            field("KBA Branch Code"; Rec."KBA Branch Code")
            {
                ApplicationArea = all;
                Caption = 'Bank Branch Code';
            }
            field("Bank Branch Name"; Rec."Bank Branch Name")
            {
                ApplicationArea = all;
            }
            field("Bank account No"; Rec."Bank account No")
            {
                ApplicationArea = all;
            }
            field("KRA PIN"; Rec."KRA PIN")
            {
                ApplicationArea = all;
            }
        }
        addlast(Payments)
        {
            field("Vendor Swift Code"; Rec."Vendor Swift Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Swift Code field.';
            }
            field("Vendor Bank Code Name"; Rec."Vendor Bank Code Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Bank Code Name field.';
            }
            field("Vendor Bank Branch Name"; Rec."Vendor Bank Branch Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Bank Branch Name field.';
            }
            field("Vendor Bank Account No"; Rec."Vendor Bank Account No")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Bank Account No field.';
            }
            field("Vendor Bank Branch Code"; Rec."Vendor Bank Branch Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Bank Branch Code field.';
            }
            field("Vendor Bank Code"; Rec."Vendor Bank Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Bank Code field.';
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(Evaluate)
            {
                Caption = 'Send for Evaluation';
                Image = SendConfirmation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // if Confirm('Are you sure?', false) = true then
                    ProcMgt.SendVendorForEvaluation(Rec);
                    CurrPage.Close();
                end;
            }
            action("Send Receipt to Vendor")
            {
                Caption = 'Send Receipt';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ReceiptLines;
                // RunObject = report "Payslip Email Report";
            }
        }
    }
    var
        ProcMgt: Codeunit "Procurement Management";
}

page 51500 "Payments Portal"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Payments;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Enabled = Rec.Status = Rec.Status::Open;

                field("No."; Rec."No.")
                {
                    Enabled = false;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    Enabled = false;
                }
                field(Date; Rec.Date)
                {
                    Enabled = false;
                }
                field("Apply on behalf"; Rec."Apply on behalf")
                {
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Enabled = Rec."Apply on behalf";
                }
                field("Account No."; Rec."Account No.")
                {
                    Enabled = Rec."Apply on behalf";
                    Visible = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Enabled = false;
                }
                field("Claim Type"; Rec."Claim Type")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Enabled = false;
                }
                group(Control49)
                {
                    ShowCaption = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Enabled = false;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        Enabled = false;
                    }
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                        Visible = false;
                    }
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Enabled = false;

                    trigger OnValidate()
                    begin
                    end;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Enabled = false;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Enabled = false;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Enabled = false;
                }
                field(Payee; Rec.Payee)
                {
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Caption = 'Purpose';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.TestField("Payment Narration");
                    end;
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                    Caption = 'Staff Claim Amount';
                    TableRelation = Payments."Petty Cash Net Amount";
                }
                field("Imprest Surrender Doc. No"; Rec."Imprest Surrender Doc. No")
                {
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                group("Apportion?")
                {
                    Caption = 'Apportion?';
                    Visible = false;

                    field("No Apportion"; Rec."No Apportion")
                    {
                        Caption = 'No';
                    }
                    field(Apportion; Rec.Apportion)
                    {
                        Caption = 'Yes';
                    }
                }
                field("Confirm Receipt"; Rec."Confirm Receipt")
                {
                    Visible = false;
                }
                field("User Id"; Rec."User Id")
                {
                    Visible = false;
                }
                field(Destination; Rec.Destination)
                {
                }
                field("Travel Date"; Rec."Travel Date")
                {
                }
                field("Date of Project"; Rec."Date of Project")
                {
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Posted By"; Rec."Posted By")
                {
                }
                field("Posted Date"; Rec."Posted Date")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Imprest Issue Doc. No"; Rec."Imprest Issue Doc. No")
                {
                }
                field("Impress Amount 1"; Rec."Impress Amount 1")
                {
                }
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                }
                field("Actual Amount Spent"; Rec."Actual Amount Spent")
                {
                }
                field("Surrender Date"; Rec."Surrender Date")
                {
                }
                field("Surrender Status"; Rec."Surrender Status")
                {
                }
            }
        }
    }
}

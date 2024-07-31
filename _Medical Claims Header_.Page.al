page 50484 "Medical Claims Header"
{
    PageType = Card;
    SourceTable = "Medical Claims";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Claim No"; Rec."Claim No")
                {
                    Editable = false;
                }
                field("Claim Date"; Rec."Claim Date")
                {
                }
                field(Claimant; Rec.Claimant)
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field(OutEntitlement; Rec.OutEntitlement)
                {
                    Editable = false;
                }
                field(InEntitlement; Rec.InEntitlement)
                {
                    Editable = false;
                }
                field("Service Provider"; Rec."Service Provider")
                {
                }
                field("Service Provider Name"; Rec."Service Provider Name")
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Total Claims"; Rec."Total Claims")
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field("Cheque No"; Rec."Cheque No")
                {
                }
                field(Settled; Rec.Settled)
                {
                }
                field("No. of Approvals"; Rec."No. of Approvals")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Message('Coming Soon');
                end;
            }
            action("Cancel Approval Request")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Message('Coming Soon');
                end;
            }
            action("View Approvals")
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Message('Coming Soon');
                end;
            }
        }
    }
}

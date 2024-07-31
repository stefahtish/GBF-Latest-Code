page 50419 "Employee Leaves"
{
    PageType = Card;
    SourceTable = Employee;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;

                field("No."; Rec."No.")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("Total Savings"; Rec."Total Savings")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Employment Date"; Rec."Employment Date")
                {
                }
            }
            part(Control11; "Leave Entitlement ListPart")
            {
                SubPageLink = "Employee No" = FIELD("No.");
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
            }
            action("Cancel Approval")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
            action("View Approvals")
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
        }
    }
}

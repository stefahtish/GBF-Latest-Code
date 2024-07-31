page 51489 "Contract Change List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Contract Change Header";
    Editable = false;
    CardPageId = "Contract Change Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                }
                field("Previous End Date"; Rec."Previous End Date")
                {
                    ApplicationArea = All;
                }
                field("New Contract End Date"; Rec."New Contract End Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Change Type"; Rec."Change Type")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Open;

                trigger OnAction();
                begin
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Open;

                trigger OnAction();
                begin
                end;
            }
        }
    }
}

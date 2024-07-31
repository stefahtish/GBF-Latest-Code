page 51490 "Contract Change Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Contract Change Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Previous End Date"; Rec."Previous End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Extension Duration"; Rec."Extension Duration")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("New Contract End Date"; Rec."New Contract End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Change Type"; Rec."Change Type")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Extension Reason"; Rec."Extension Reason")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Card)
            {
                Visible = false;
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;
                RunObject = page "Contract Creation Card";
                RunPageLink = "No."=field("No.");
            }
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                var
                    ApprovalsMgmt2: Codeunit ApprovalMgtCuExtension;
                begin
                    if Confirm('Do you want to send the approval request?', false) = true then begin
                        Rec.TestField("Contract No.");
                        Rec.TestField("Change Type");
                        if Rec."Change Type" = Rec."Change Type"::Extension then begin
                            Rec.TestField("Extension Duration");
                            Rec.TestField("Extension Reason");
                        end;
                        if ApprovalsMgmt2.CheckContChangeRequestWorkflowEnabled(Rec)THEN ApprovalsMgmt2.OnSendContChangeRequestApproval(Rec);
                    end;
                    CurrPage.Close();
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::"Pending Approval";

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit ApprovalMgtCuExtension;
                    Text001: Label 'Are you sure you want to Cancel document %1';
                begin
                    if Confirm(Text001, false, Rec."No.")then begin
                        ApprovalMgt.OnCancelContChangeApproval(Rec);
                    end;
                    CurrPage.Close();
                end;
            }
        }
    }
    var myInt: Integer;
}

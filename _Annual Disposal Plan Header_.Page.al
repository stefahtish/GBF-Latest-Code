page 50366 "Annual Disposal Plan Header"
{
    Caption = 'Annual Disposal Plan Header';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    SourceTable = "AnnualDisposal Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    enabled = false;
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field("Accounting Period"; Rec."Accounting Period")
                {
                    ToolTip = 'Specifies the value of the Accounting Period field';
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ToolTip = 'Specifies the value of the Year field';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;
                }
                field("Created by"; Rec."Created by")
                {
                    ToolTip = 'Specifies the value of the Created by field';
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field';
                    ApplicationArea = All;
                }
            }
            part("Annual Asset  Disposal"; "Annual Asset  Disposal")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send for approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckAssetDisposalWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendAssetDisposalForApproval(Rec);
                end;
            }
            action("Cancel approval request")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelAssetDisposalApprovalRequest(Rec);
                end;
            }
            action("Plan")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelAssetDisposalApprovalRequest(Rec);
                end;
            }
        }
    }
    var
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        AssetReport: Report "Annual Disposal Plan";
}

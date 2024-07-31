page 51326 "ICT Workplan Header"
{
    PromotedActionCategories = 'New,Process,Report,Approvals';
    Caption = 'ICT Workplan Header';
    PageType = Card;
    SourceTable = "ICT Workplan";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field("Key Perfomance Criteria"; Rec."Key Perfomance Criteria")
                {
                    ApplicationArea = All;
                }
                field("KP Criteria Description"; Rec."KP Criteria Description")
                {
                    ApplicationArea = All;
                }
                field("Key Result Area"; Rec."Key Result Area")
                {
                    ApplicationArea = All;
                }
                field("KRA Description"; Rec."KRA Description")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Criteria Code"; Rec."Criteria Code")
                {
                    ApplicationArea = All;
                }
                field("Criteria Description"; Rec."Criteria Description")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Time Frame"; Rec."Time Frame")
                {
                    ToolTip = 'Specifies the value of the Time Frame field';
                    ApplicationArea = All;
                }
                // field("Activity Code"; Rec."Activity Code")
                // {
                //     ToolTip = 'Specifies the value of the Activity Code field';
                //     ApplicationArea = All;
                // }
                // field("Activity Description"; Rec."Activity Description")
                // {
                //     ToolTip = 'Specifies the value of the Activity Description field';
                //     ApplicationArea = All;
                // }
                field(Target; Rec.Target)
                {
                    ToolTip = 'Specifies the value of the Target field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
            part("ICT Workplan Indicators"; "ICT Workplan Indicators")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                promoted = true;
                PromotedCategory = Category4;
                //PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                begin
                    if ApprovalsMgmt.CheckICTWorkplanWorkflowEnabled(Rec) then ApprovalsMgmt.OnSendICTWorkplanForApproval(Rec);
                    CurrPage.Close();
                end;
            }
            action("Cancel Approval Request")
            {
                promoted = true;
                PromotedCategory = Category4;
                //PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
                begin
                    ApprovalsMgmt.OnCancelICTWorkplanApprovalRequest(Rec);
                    CurrPage.Close();
                end;
            }
        }
    }
}

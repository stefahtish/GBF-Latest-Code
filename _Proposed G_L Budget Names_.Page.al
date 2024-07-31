page 50278 "Proposed G/L Budget Names"
{
    Caption = 'G/L Budget Names';
    PageType = List;
    SourceTable = "G/L Budget Name";
    SourceTableView = WHERE("Budget Status" = FILTER(<> Approved));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field(Name; Rec.Name)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the general ledger budget.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a description of the general ledger budget name.';
                }
                field("Global Dimension 1 Code"; GLSetup."Global Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Global Dimension 1 Code';
                    Editable = false;
                    ToolTip = 'Specifies the global dimension that is set up in the Global Dimension 1 Code field in the General Ledger Setup window.';
                }
                field("Global Dimension 2 Code"; GLSetup."Global Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Global Dimension 2 Code';
                    Editable = false;
                    ToolTip = 'Specifies the global dimension that is set up in the Global Dimension 2 Code field in the General Ledger Setup window.';
                }
                field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field("Budget Dimension 4 Code"; Rec."Budget Dimension 4 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies that entries cannot be created for the budget. ';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(EditBudget)
            {
                ApplicationArea = Suite;
                Caption = 'Edit Budget';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Return';
                ToolTip = 'Specify budgets that you can create in the general ledger application area. If you need several different budgets, you can create several budget names.';

                trigger OnAction()
                var
                    Budget: Page Budget;
                begin
                    Budget.SetBudgetName(Rec.Name);
                    Budget.Run;
                end;
            }
            group(ReportGroup)
            {
                Caption = 'Report';
                Image = "Report";

                action(ReportTrialBalance)
                {
                    ApplicationArea = Suite;
                    Caption = 'Trial Balance/Budget';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'View budget details for the specified period.';

                    trigger OnAction()
                    begin
                        REPORT.Run(Report::"Trial Balance/Budget", TRUE, FALSE);
                    end;
                }
            }
            group(Approvals)
            {
                action("SendApproval")
                {
                    Caption = 'Send Proposed Budget For Approval';

                    trigger OnAction()
                    begin
                        if Confirm(SendApprovalTxt, false) then begin
                            if GLBudgetNames.Get(Rec.Name) then begin
                                if ApprovalsMgt.CheckProposedBudgetWorkflowEnabled(GLBudgetNames) then ApprovalsMgt.OnSendProposedBudgetApproval(GLBudgetNames);
                            end;
                        end;
                    end;
                }
                action(CancelApproval)
                {
                    Caption = 'Cancel Approval Request';

                    trigger OnAction()
                    begin
                        if GLBudgetNames.Get(Rec.Name) then ApprovalsMgt.OnCancelProposedBudgetApproval(GLBudgetNames);
                    end;
                }
                action(ViewApprovals)
                {
                    Caption = 'View Approvals';

                    trigger OnAction()
                    begin
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        GLSetup.Get;
    end;

    var
        GLSetup: Record "General Ledger Setup";

    procedure GetSelectionFilter(): Text
    var
        GLBudgetName: Record "G/L Budget Name";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(GLBudgetName);
        exit(SelectionFilterManagement.GetSelectionFilterForGLBudgetName(GLBudgetName));
    end;

    var
        GLBudgetNames: Record "G/L Budget Name";
        ApprovalsMgt: Codeunit ApprovalMgtCuExtension;
        SendApprovalTxt: Label 'Are you sure you want to send for approval?';
}

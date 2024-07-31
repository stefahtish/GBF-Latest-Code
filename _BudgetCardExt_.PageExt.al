pageextension 50100 "BudgetCardExt" extends Budget
{
    actions
    {
        addafter(ReportBudget)
        {
            action("Budget Tracker")
            {
                ApplicationArea = Suite;
                Caption = 'Budget Tracker';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'View budget tracker details for the specified period.';

                trigger OnAction()
                var
                    GLAccount: Record "G/L Account";
                    Budget: Report "Budget Tracker";
                begin
                    GLAccount.SetRange("Budget Filter", BudgetName);
                    Budget.SetTableView(GLAccount);
                    Budget.Run();
                end;
            }
            action("Budget and Comparison")
            {
                ApplicationArea = Suite;
                Caption = 'Budget and Comparison';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'View Budget and Comparison details for the specified period.';

                trigger OnAction()
                var
                    GLAccount: Record "G/L Account";
                    Budget: Report "Budget and Comparison";
                begin
                    GLAccount.SetRange("Budget Filter", BudgetName);
                    Budget.SetTableView(GLAccount);
                    Budget.Run();
                end;
            }
        }
        addafter(ReportGroup)
        {
            group("Approvals")
            {
                action(SendApproval)
                {
                    Caption = 'Send Proposed Budget For Approval';
                    ApplicationArea = All;
                    /* trigger OnAction()
                        begin
                            if Confirm(SendApprovalTxt, false) then begin
                                //if GLBudgetName.get(budget)

                            end;
                        end; */
                }
            }
        }
    }
    var
        ApprovalsMgt: Codeunit ApprovalMgtCuExtension;
        GLBudgetName: Record "G/L Budget Name";
        SendApprovalTxt: Label 'Are you sure you want to Send for Approval?';
}

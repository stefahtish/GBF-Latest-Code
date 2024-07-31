page 50276 "Proposed Budget Card"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Proposed Budget Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Name; Rec.Name)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Posted By"; Rec."Posted By")
                {
                }
                field("Date-Time Posted"; Rec."Date-Time Posted")
                {
                }
            }
            part("Proposed Budget Lines"; "Proposed Budget Lines")
            {
                Caption = 'Proposed Budget Lines';
                Editable = false;
                SubPageLink = "Budget Name" = FIELD(Name);
                SubPageView = WHERE(Proposed = FILTER(true));
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post To Final Budget';
                Image = PostedDeposit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Budget: Record "Budget Approval Header";
                    BudgetApprovalLines: Record "Budget Approval Lines";
                    GLBudgetEntry: Record "G/L Budget Entry";
                    ProposedBudgetHeader: Record "Proposed Budget Header";
                begin
                    //FinanceManagement.PostFinalBudget(Rec);
                end;
            }
        }
    }
    var
        PostTxt: Label 'Are you sure you want to post these proposed budget entries to %1 Main Final Budget';
        FinanceManagement: Codeunit "Payments Management";
}

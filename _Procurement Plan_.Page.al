page 50756 "Procurement Plan"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "G/L Budget Name";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Total Budget Allocation"; Rec."Total Budget Allocation")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control8; "Procurement Plan Items")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Plan Year" = FIELD(Name);
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action(Print)
            {
                Caption = 'Procurement Plan Report';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Commit();
                    ProcPlan.Reset;
                    ProcPlan.SetRange("Plan Year", Rec.Name);
                    PlanReport.SetTableView(ProcPlan);
                    PlanReport.Run();
                end;
            }
        }
    }
    var
        PlanReport: Report "Procurement Plan";
        ProcPlan: Record "Procurement Plan";
}

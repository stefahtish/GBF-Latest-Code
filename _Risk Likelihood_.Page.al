page 50907 "Risk Likelihood"
{
    PageType = List;
    SourceTable = "Risk Likelihood";
    SourceTableView = SORTING("Likelihood Score") ORDER(Ascending);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Likelihood Score"; Rec."Likelihood Score")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Probability Start Range"; Rec."Probability Start Range")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Probability Start >= (%)';
                }
                field(Probability; Rec.Probability)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Probability End <= (%)';
                }
                field("Frequency (General)"; Rec."Frequency (General)")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Frequency (Timeframe)"; Rec."Frequency (Timeframe)")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
        }
    }
}

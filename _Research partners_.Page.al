page 51060 "Research partners"
{
    PageType = ListPart;
    SourceTable = "ResearchSurvey Workplan Line";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    caption = 'Name';
                    ApplicationArea = Basic, Suite;
                }
                field(Role; Rec.Role)
                {
                }
                field("Budgetary Plan"; Rec."Budgetary Plan")
                {
                    Caption = 'Budgetary Input';
                }
            }
        }
    }
    actions
    {
    }
}

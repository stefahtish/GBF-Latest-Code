page 51401 "ProjBudget"
{
    PageType = ListPart;
    Caption = 'Budget';
    SourceTable = ProjBudget;
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Current Status"; Rec."Current Status")
                {
                    ToolTip = 'Specifies the value of the Current Status field.';
                    ApplicationArea = All;
                }
                field("Previous Status"; Rec."Previous Status")
                {
                    ToolTip = 'Specifies the value of the Previous Status field.';
                    ApplicationArea = All;
                }
                field("Budget Perfomance"; Rec."Budget Perfomance")
                {
                    ToolTip = 'Specifies the value of the Budget Perfomance field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

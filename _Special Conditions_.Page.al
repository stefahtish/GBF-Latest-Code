page 51367 "Special Conditions"
{
    UsageCategory = lists;
    PageType = ListPart;
    SourceTable = SpecialConditions;
    applicationarea = all;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    visible = false;
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Special Conditions"; Rec."Special Conditions")
                {
                    ToolTip = 'Specifies the value of the Special Conditions field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}

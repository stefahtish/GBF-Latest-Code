page 51368 "General Conditions"
{
    UsageCategory = lists;
    PageType = ListPart;
    SourceTable = GeneralConditions;
    applicationarea = all;
    autosplitkey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                    visible = false;
                }
                field("General Condition Code"; Rec."General Condition Code")
                {
                    ToolTip = 'Specifies the value of the General Condition Code field.';
                    ApplicationArea = All;
                }
                field("General Conditions"; Rec."General Conditions")
                {
                    editable = false;
                    ToolTip = 'Specifies the value of the General Conditions field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}

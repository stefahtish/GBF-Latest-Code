page 51419 "Contract Terms And Cond Lines"
{
    Caption = 'Contract Terms And Cond Lines';
    UsageCategory = lists;
    PageType = ListPart;
    applicationarea = all;
    autosplitkey = true;
    SourceTable = "Contract Terms And Cond Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Terms Code"; Rec."Terms Code")
                {
                    ToolTip = 'Specifies the value of the Terms Code field.';
                    ApplicationArea = All;
                }
                field("Terms Text"; Rec."Terms Text")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Terms Text field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

page 50737 "Rating Scale List"
{
    ApplicationArea = All;
    Caption = 'Rating Scale List';
    PageType = List;
    SourceTable = "Rating Scale";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Achievement Performance Target"; Rec."Achievement Performance Target")
                {
                    ToolTip = 'Specifies the value of the Achievement of Performance Targets field.';
                    ApplicationArea = All;
                }
                field("Rating Scale Description"; Rec."Rating Scale Description")
                {
                    ToolTip = 'Specifies the value of the Rating Scale Description field.';
                    ApplicationArea = All;
                }
                field("Rating Scale Range"; Rec."Rating Scale Range")
                {
                    ToolTip = 'Specifies the value of the Rating Scale Range field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

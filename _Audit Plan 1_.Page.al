page 50890 "Audit Plan 1"
{
    AutoSplitKey = true;
    PageType = ListPlus;
    SourceTable = "Audit Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                }
                field("Risk Rating"; Rec."Risk Rating")
                {
                }
            }
        }
    }
    actions
    {
    }
}

page 50850 "Resolution Steps List"
{
    AutoSplitKey = true;
    PageType = CardPart;
    SourceTable = "Resolution Steps";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Interaction Resol. Code"; Rec."Interaction Resol. Code")
                {
                }
                field("Step Number"; Rec."Step Number")
                {
                }
                field("Resolution Description"; Rec."Resolution Description")
                {
                }
            }
        }
    }
    actions
    {
    }
}

page 50621 "Training Evaluation Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Training Evaluation Lines";
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}

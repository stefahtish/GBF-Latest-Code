page 50619 "Training Areas"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Training Area";
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

page 50447 "Appraisal Formats Setup"
{
    PageType = List;
    SourceTable = "Appraisal Formats";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                }
                field(Indicator; Rec.Indicator)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
    actions
    {
    }
}

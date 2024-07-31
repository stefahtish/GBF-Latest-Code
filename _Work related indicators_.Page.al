page 50629 "Work related indicators"
{
    PageType = List;
    SourceTable = "Work related indicators";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(AttributeCode; Rec.AttributeCode)
                {
                }
            }
        }
    }
    actions
    {
    }
}

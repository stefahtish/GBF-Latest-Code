page 50630 "Perfomance rating matrix"
{
    PageType = List;
    SourceTable = "Perfomance rating matrix";
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
                field(Start; Rec.Start)
                {
                }
                field("End"; Rec."End")
                {
                }
                field(Grade; Rec.Grade)
                {
                }
            }
        }
    }
    actions
    {
    }
}

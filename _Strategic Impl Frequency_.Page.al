page 50612 "Strategic Impl Frequency"
{
    Caption = 'Time frames';
    PageType = List;
    SourceTable = "Strategic Imp Frequency";
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
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
    }
}

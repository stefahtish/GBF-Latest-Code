page 50441 "Rules & Regulations"
{
    PageType = List;
    SourceTable = "Rules & Regulations";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Rules & Regulations"; Rec."Rules & Regulations")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
            group(Control10)
            {
                ShowCaption = false;
                Visible = false;

                field("Document Link"; Rec."Document Link")
                {
                }
                field("Language Code (Default)"; Rec."Language Code (Default)")
                {
                }
                field(Attachement; Rec.Attachement)
                {
                }
            }
        }
    }
    actions
    {
    }
}

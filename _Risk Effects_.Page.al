page 51192 "Risk Effects"
{
    PageType = ListPart;
    SourceTable = "Risk Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
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

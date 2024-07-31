page 51228 "ICT Issue Setup"
{
    Caption = 'ICT Issue Setup';
    PageType = List;
    SourceTable = "ICT Issue Setup2";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Category; Rec.Category)
                {
                }
                field("Category Description"; Rec."Category Description")
                {
                    Enabled = false;
                }
                field(Issue; Rec.Issue)
                {
                }
            }
        }
    }
}

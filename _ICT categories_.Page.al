page 51230 "ICT categories"
{
    Caption = 'ICT categories';
    PageType = List;
    SourceTable = "ICT Issue Categories";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field';
                    ApplicationArea = All;
                }
                field("Category Description"; Rec."Category Description")
                {
                    ToolTip = 'Specifies the value of the Category Description field';
                    ApplicationArea = All;
                }
            }
        }
    }
}

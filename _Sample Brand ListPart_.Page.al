page 50382 "Sample Brand ListPart"
{
    Caption = 'Sample Brand ListPart';
    PageType = ListPart;
    SourceTable = "Sample Customer Branches";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Branch; Rec.Branch)
                {
                    Caption = 'Brand code';
                    ToolTip = 'Specifies the value of the Branch field';
                    ApplicationArea = All;
                }
                field("Branch name"; Rec."Branch name")
                {
                    Caption = 'Brand name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Branch name field';
                    ApplicationArea = All;
                }
            }
        }
    }
}

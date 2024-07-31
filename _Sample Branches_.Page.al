page 51039 "Sample Branches"
{
    Caption = 'Branches';
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
                    ToolTip = 'Specifies the value of the Branch name field';
                    ApplicationArea = All;
                }
            }
        }
    }
}

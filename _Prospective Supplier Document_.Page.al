page 50840 "Prospective Supplier Document"
{
    Caption = 'Prospective Supplier Document Card';
    PageType = Card;
    SourceTable = "Prospective Supplier Documents";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Prospect No."; Rec."Prospect No.")
                {
                    ToolTip = 'Specifies the value of the Prospect No. field';
                    ApplicationArea = All;
                }
                field("Document Code"; Rec."Document Code")
                {
                    ToolTip = 'Specifies the value of the Document Code field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
            }
        }
    }
}

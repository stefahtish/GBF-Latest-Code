page 50839 "Prospective Supplier Documents"
{
    Caption = 'Prospective Supplier Documents';
    PageType = ListPart;
    CardPageId = "Prospective Supplier Document";
    SourceTable = "Prospective Supplier Documents";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                field("Prospect No."; Rec."Prospect No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Prospect No. field';
                    ApplicationArea = All;
                }
            }
        }
    }
}

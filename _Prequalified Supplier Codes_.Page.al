page 50195 "Prequalified Supplier Codes"
{
    Caption = 'Prequalified Supplier Codes';
    PageType = ListPart;
    SourceTable = "Prequalified Supplier Categ";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Category Code"; Rec."Category Code")
                {
                    Caption = 'Code';
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field(Vendor; Rec.Vendor)
                {
                    Visible = false;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }
}

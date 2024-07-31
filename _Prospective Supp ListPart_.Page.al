page 51336 "Prospective Supp ListPart"
{
    Caption = 'Prospective Supplier Document Links';
    PageType = ListPart;
    SourceTable = "Supplier Document Links";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Link; Rec.Link)
                {
                    ToolTip = 'Specifies the value of the URL field.';
                    ApplicationArea = All;

                    //  Editable = false;
                    trigger OnDrillDown()
                    begin
                        System.Hyperlink(Rec.Link);
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the description field.';
                    Editable = false;
                    Visible = false;
                }
                field("Record ID"; Rec."Record ID")
                {
                    ToolTip = 'Specifies the value of the Record ID field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
}

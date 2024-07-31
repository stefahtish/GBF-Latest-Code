page 51077 "Salmonella Spp"
{
    AutoSplitKey = true;
    Caption = 'Salmonella Spp. detection form';
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("RVS color change"; Rec."RVS color change")
                {
                    ApplicationArea = All;
                }
                field("XLD plates"; Rec."XLD plates")
                {
                    ApplicationArea = All;
                }
                field(Butt; Rec.Butt)
                {
                    ApplicationArea = All;
                }
                field(Slant; Rec.Slant)
                {
                    ApplicationArea = All;
                }
                field("Gas production"; Rec."Gas production")
                {
                    ApplicationArea = All;
                }
                field("Remarks(Present"; Rec."Remarks(Present")
                {
                    ApplicationArea = All;
                }
                field("Cannot be done"; Rec."Cannot be done")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

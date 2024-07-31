page 51071 "Organoleptic Test"
{
    AutoSplitKey = true;
    Caption = 'Organoleptic Test';
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Colour; Rec.Colour)
                {
                    ApplicationArea = All;
                }
                field("Odour and Taints "; Rec."Odour and Taints ")
                {
                    ApplicationArea = All;
                }
                field(Specifications; Rec.Specifications)
                {
                    ApplicationArea = All;
                }
                field("Remarks(PassFail)"; Rec."Remarks(PassFail)")
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

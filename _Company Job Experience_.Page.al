page 50603 "Company Job Experience"
{
    Caption = 'Company Job Experience';
    PageType = ListPart;
    SourceTable = "Company Job Experience";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Industry; Rec.Industry)
                {
                    ApplicationArea = All;
                }
                field("Industry Name"; Rec."Industry Name")
                {
                    ApplicationArea = All;
                }
                field("Hierarchy Level"; Rec."Hierarchy Level")
                {
                    ApplicationArea = All;
                }
                field("No. of Years"; Rec."No. of Years")
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

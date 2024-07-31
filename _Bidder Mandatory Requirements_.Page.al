page 50306 "Bidder Mandatory Requirements"
{
    Caption = 'Bidder Mandatory Requirements';
    PageType = ListPart;
    SourceTable = "Bidder Mandatory Requirements";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field("Mandatory Requirement"; Rec."Mandatory Requirement")
                {
                    ApplicationArea = All;
                }
                field(Complied; Rec.Complied)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

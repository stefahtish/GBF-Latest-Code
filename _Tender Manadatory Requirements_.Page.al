page 50305 "Tender Manadatory Requirements"
{
    Caption = 'Tender Manadatory Requirements';
    PageType = ListPart;
    SourceTable = "Tender Mandatory Requirements";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Mandatory Requirement"; Rec."Mandatory Requirement")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

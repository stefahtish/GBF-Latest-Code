page 50115 "Destination Code"
{
    PageType = List;
    SourceTable = Destination;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;

                field("Destination Code"; Rec."Destination Code")
                {
                }
                field("Destination Name"; Rec."Destination Name")
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
                field("Destination Type"; Rec."Destination Type")
                {
                }
                field("Other Area"; Rec."Other Area")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("&Rates Setup")
            {
                Caption = '&Rates Setup';
                Image = ReceiptLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Destination Rate";
                RunPageLink = "Destination Code" = FIELD("Destination Code");
            }
        }
    }
}

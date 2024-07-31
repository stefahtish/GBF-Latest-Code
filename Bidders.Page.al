page 50307 Bidders
{
    Caption = 'Bidders';
    PageType = List;
    SourceTable = Bidders;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Tender Amount"; Rec."Tender Amount")
                {
                    ApplicationArea = All;
                }
                field("Bid Security Amount"; Rec."Bid Security Amount")
                {
                    ApplicationArea = All;
                }
                field("Bid Expiry Date"; Rec."Bid Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Copies Submitted"; Rec."No. of Copies Submitted")
                {
                    ApplicationArea = All;
                }
                field("Physical Address"; Rec."Physical Address")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = All;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Pre Qualified"; Rec."Pre Qualified")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

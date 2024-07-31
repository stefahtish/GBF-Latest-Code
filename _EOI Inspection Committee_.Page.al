page 50354 "EOI Inspection Committee"
{
    Caption = 'Inspection Committee';
    PageType = List;
    SourceTable = "Tender Committees";
    SourceTableView = where("Procurement Method" = const(EOI), "Committee Type" = const(Inspection));
    CardPageId = "EOI Inspection Commitee Card";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Appointment No"; Rec."Appointment No")
                {
                    ApplicationArea = All;
                }
                field("Tender/Quotation No"; Rec."Tender/Quotation No")
                {
                    ApplicationArea = All;
                }
                field("Committee Name"; Rec."Committee Name")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

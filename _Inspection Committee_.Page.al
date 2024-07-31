page 50313 "Inspection Committee"
{
    Caption = 'Inspection Committee';
    PageType = List;
    SourceTable = "Tender Committees";
    SourceTableView = where("Committee Type" = const(Inspection));
    CardPageId = "Inspection Commitee Card";
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
                    Caption = 'Tender Reference No.';
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
            part("Committee Members"; "Committee Members")
            {
                SubPageLink = "Appointment No" = field("Appointment No");
                Visible = false;
            }
        }
    }
}

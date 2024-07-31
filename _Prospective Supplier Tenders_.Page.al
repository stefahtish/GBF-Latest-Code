page 50232 "Prospective Supplier Tenders"
{
    Caption = 'Prospective Supplier Tenders';
    PageType = ListPart;
    CardPageId = "Prospective Tender Card";
    SourceTable = "Prospective Supplier Tender";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    Caption = 'Tender/RFQ/RFP/EOI No';
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                    ApplicationArea = All;
                }
                field(TenderOpeningDate; Rec.TenderOpeningDate)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(TenderClosingDate; Rec.TenderClosingDate)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Tender Status"; Rec."Tender Status")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Sent for Evaluation"; Rec."Sent for Evaluation")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expected Closing Time"; Rec."Expected Closing Time")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Prospect No."; Rec."Prospect No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Passed Preliminary"; Rec."Passed Preliminary")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Passed Technical"; Rec."Passed Technical")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Passed Financial"; Rec."Passed Financial")
                {
                    ApplicationArea = ALL;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Show Tender Items")
            {
                Image = Item;
                RunObject = page "Prospective Tender Lines";
                RunPageLink = "Tender No." = field("Tender No."), "Response No" = field("Prospect No.");
            }
            action("Attachments")
            {
                ApplicationArea = All;
                Image = Attachments;
                Visible = false;

                trigger OnAction()
                begin
                end;
            }
        }
    }
}

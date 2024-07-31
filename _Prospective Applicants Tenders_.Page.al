page 51428 "Prospective Applicants Tenders"
{
    Caption = 'Applicants';
    PageType = List;
    SourceTable = "Prospective Supplier Tender";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Tender No."; Rec."Tender No.")
                {
                    Caption = 'No.';
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
                }
                field(TenderClosingDate; Rec.TenderClosingDate)
                {
                    ApplicationArea = All;
                }
                field("Tender Status"; Rec."Tender Status")
                {
                    ApplicationArea = All;
                }
                field("Sent for Evaluation"; Rec."Sent for Evaluation")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expected Closing Time"; Rec."Expected Closing Time")
                {
                    ApplicationArea = All;
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                }
                field("Prospect No."; Rec."Prospect No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

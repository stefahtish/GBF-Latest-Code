page 50800 "Tender List"
{
    CardPageID = "Tender Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Procurement Request";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = all;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = all;
                }
                field("Procurement Plan No"; Rec."Procurement Plan No")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = all;
                }
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Tender Type" := Rec."Tender Type"::Open;
        Rec."Process Type" := Rec."Process Type"::Tender;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Tender Type" := Rec."Tender Type"::Open;
        Rec."Process Type" := Rec."Process Type"::Tender;
    end;
}

page 50823 "Restricted Tender List"
{
    CardPageID = "Restricted Tender Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Procurement Request";
    SourceTableView = WHERE("Process Type" = CONST(Tender), "Tender Type" = const(Restricted));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field("Requisition No"; Rec."Requisition No")
                {
                }
                field("Procurement Plan No"; Rec."Procurement Plan No")
                {
                    Visible = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Category; Rec.Category)
                {
                }
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Tender Type" := Rec."Tender Type"::Restricted;
        Rec."Process Type" := Rec."Process Type"::Tender;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Tender Type" := Rec."Tender Type"::Restricted;
        Rec."Process Type" := Rec."Process Type"::Tender;
    end;
}

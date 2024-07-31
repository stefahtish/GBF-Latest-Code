page 50805 "RFP List"
{
    CardPageID = "RFP Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Procurement Request";
    SourceTableView = WHERE("Process Type" = CONST(RFP));
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
            }
        }
    }
    actions
    {
    }
}

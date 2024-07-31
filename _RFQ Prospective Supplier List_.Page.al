page 51313 "RFQ Prospective Supplier List"
{
    CardPageID = "RFQ Prospective Supplier card";
    // DeleteAllowed = false;
    PageType = List;
    SourceTable = "Prospective Suppliers";
    SourceTableView = WHERE(Type = filter(RFQ));
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
                field(Date; Rec.Date)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("E-mail"; Rec."E-mail")
                {
                }
            }
        }
    }
    actions
    {
    }
}

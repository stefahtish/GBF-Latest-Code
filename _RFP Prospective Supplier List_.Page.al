page 51315 "RFP Prospective Supplier List"
{
    CardPageID = "RFP Prospective Supplier card";
    // DeleteAllowed = false;
    PageType = List;
    SourceTable = "Prospective Suppliers";
    SourceTableView = WHERE(Type = filter(RFP));
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

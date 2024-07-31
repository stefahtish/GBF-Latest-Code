page 50818 "Prospective Supplier List"
{
    CardPageID = "Prospective Supplier card";
    // DeleteAllowed = false;
    PageType = List;
    SourceTable = "Prospective Suppliers";
    ApplicationArea = All;

    //SourceTableView = WHERE(Type = filter(Tender));
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
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
    }
}

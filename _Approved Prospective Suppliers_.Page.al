page 51156 "Approved Prospective Suppliers"
{
    CardPageID = "Prospective Supplier card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Prospective Suppliers";
    SourceTableView = WHERE(Status = filter(Released));
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}

page 50173 "Suppliers"
{
    CardPageID = "Prequalified Supplier";
    PageType = List;
    SourceTable = "Prequalified Suppliers";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                /* field("No."; "No.")
                {
                    Editable = false;
                } */
                field("Vendor No"; Rec."Vendor No")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Category; Rec.Category)
                {
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                }
                field("Contract Period"; Rec."Contract Period")
                {
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                }
            }
        }
    }
    actions
    {
    }
}

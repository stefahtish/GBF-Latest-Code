page 50827 "Committee Suppliers"
{
    PageType = ListPart;
    SourceTable = "Prospective Suppliers";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = false;
    SourceTableView = where("Pre Qualified" = const(true), "Supplier Status" = const(Evaluation));
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

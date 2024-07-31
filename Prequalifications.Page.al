page 50754 Prequalifications
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Procurement Category Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Fiscal Year"; Rec."Fiscal Year")
                {
                }
                field(Category; Rec.Category)
                {
                }
                field("Category Name"; Rec."Category Name")
                {
                }
            }
        }
    }
    actions
    {
    }
}

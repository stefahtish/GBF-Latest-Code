page 50821 "Supplier Evaluation Approved"
{
    PageType = List;
    CardPageID = "Supplier Evaluation Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "Supplier Evaluation Header";
    SourceTableView = WHERE(Status = filter("Pending Approval" | Approved));
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
                field("Document Date"; Rec."Document Date")
                {
                }
                field(User; Rec.User)
                {
                }
                field(Title; Rec.Title)
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
    actions
    {
    }
}

page 50844 "Tender Supplier Evaluation"
{
    Caption = 'Supplier Evaluation List';
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Supplier Evaluation Header";
    CardPageID = "Supplier Evaluation Card3";
    SourceTableView = where(Type = const(Tender), Submitted = const(true));
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
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Quote No"; Rec."Quote No")
                {
                    Caption = 'RFQ No.';
                    ApplicationArea = all;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = all;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}

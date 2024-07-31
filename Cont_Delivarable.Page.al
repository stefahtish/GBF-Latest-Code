page 50994 Cont_Delivarable
{
    PageType = ListPart;
    SourceTable = Cert_Delivarable;
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
                field(Delivarable; Rec.Delivarable)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Paid; Rec.Paid)
                {
                }
                field("Total Amount Paid"; Rec."Total Amount Paid")
                {
                }
            }
        }
    }
    actions
    {
    }
}

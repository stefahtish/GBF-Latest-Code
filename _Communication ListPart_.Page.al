page 50568 "Communication ListPart"
{
    PageType = ListPart;
    SourceTable = "Communication Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Visible = false;
                }
                field(Category; Rec.Category)
                {
                }
                field("Recipient No."; Rec."Recipient No.")
                {
                }
                field("Recipient Name"; Rec."Recipient Name")
                {
                }
                field("Recipient E-Mail"; Rec."Recipient E-Mail")
                {
                }
                field("Recipient Phone No."; Rec."Recipient Phone No.")
                {
                }
                field("E-Mail Sent"; Rec."E-Mail Sent")
                {
                }
                field("SMS Sent"; Rec."SMS Sent")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
}

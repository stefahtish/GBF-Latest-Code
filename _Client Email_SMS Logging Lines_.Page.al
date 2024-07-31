page 50886 "Client Email/SMS Logging Lines"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Email/SMS Logging Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'General';

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
                field("Error Message"; Rec."Error Message")
                {
                }
            }
        }
    }
    actions
    {
    }
}

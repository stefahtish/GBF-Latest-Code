page 50887 "SMS Logging Lines Listpart"
{
    PageType = Listpart;
    SourceTable = "SMS Logging Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'General';

                field("Line No."; Rec."Line No.")
                {
                }
                field("Client Type"; Rec."Client Type")
                {
                }
                field("Client No."; Rec."Client No.")
                {
                }
                field("Client Phone Number"; Rec."Client Phone Number")
                {
                }
                field("SMS Error Message"; Rec."SMS Error Message")
                {
                }
                field("SMS Sent"; Rec."SMS Sent")
                {
                }
            }
        }
    }
    actions
    {
    }
}

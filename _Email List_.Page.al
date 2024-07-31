page 50663 "Email List"
{
    CardPageID = "Email Header Card";
    PageType = List;
    SourceTable = "Email Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                }
                field("Total Items"; Rec."Total Items")
                {
                }
                field("Total Sent"; Rec."Total Sent")
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

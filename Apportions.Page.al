page 50282 Apportions
{
    CardPageID = "Apportion Card";
    PageType = List;
    SourceTable = "Apportion Header";
    SourceTableView = WHERE(Posted = CONST(false));
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
                field("Created Date"; Rec."Created Date")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
            }
        }
    }
    actions
    {
    }
}

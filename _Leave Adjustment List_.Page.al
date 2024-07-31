page 50435 "Leave Adjustment List"
{
    CardPageID = "Leave Adjustment Header";
    PageType = List;
    SourceTable = "Leave Bal Adjustment Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Posted By"; Rec."Posted By")
                {
                }
                field("Posted Date"; Rec."Posted Date")
                {
                }
            }
        }
    }
    actions
    {
    }
}

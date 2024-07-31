page 50275 "Proposed Budget List"
{
    CardPageID = "Proposed Budget Card";
    PageType = List;
    SourceTable = "Proposed Budget Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
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
                field("Date-Time Posted"; Rec."Date-Time Posted")
                {
                }
            }
        }
    }
    actions
    {
    }
}

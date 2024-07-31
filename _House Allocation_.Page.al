page 50488 "House Allocation"
{
    CardPageID = "Employee House";
    PageType = List;
    SourceTable = "R.Shortlisting Header";
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
                field("Recruitment Need"; Rec."Recruitment Need")
                {
                }
                field("Job ID"; Rec."Job ID")
                {
                }
                field(Positions; Rec.Positions)
                {
                }
            }
        }
    }
    actions
    {
    }
}

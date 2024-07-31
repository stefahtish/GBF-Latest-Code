page 50542 "Closed Recruitment Shortlist"
{
    CardPageID = "Short List";
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Recruitment Needs";
    SourceTableView = WHERE("Shortlisting Closed" = FILTER(true));
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
                field("Job ID"; Rec."Job ID")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Priority; Rec.Priority)
                {
                }
                field(Positions; Rec.Positions)
                {
                }
                field(Approved; Rec.Approved)
                {
                }
                field("Date Approved"; Rec."Date Approved")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
        }
    }
}

page 50461 "Recruitment Request List"
{
    CardPageID = "Recruitment Request";
    PageType = List;
    SourceTable = "Recruitment Needs";
    SourceTableView = WHERE(Status = FILTER(<> Released), Approved = CONST(false));
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
                field(Description; Rec.Description)
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
                field("Documentation Link"; Rec."Documentation Link")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Turn Around Time"; Rec."Turn Around Time")
                {
                }
                field("Expected Reporting Date"; Rec."Expected Reporting Date")
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

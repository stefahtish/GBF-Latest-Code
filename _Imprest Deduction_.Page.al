page 50689 "Imprest Deduction"
{
    CardPageID = "Imprest Deduction Card";
    Editable = false;
    PageType = List;
    SourceTable = "Imprest Deduction";
    SourceTableView = WHERE(Status = FILTER(Open | "Pending Approval"));
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
                field(Description; Rec.Description)
                {
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Date Posted"; Rec."Date Posted")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Posted By"; Rec."Posted By")
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

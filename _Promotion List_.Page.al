page 50496 "Promotion List"
{
    CardPageID = "Employee Promotion Card";
    PageType = List;
    SourceTable = "Employee Acting Position";
    SourceTableView = WHERE("Promotion Type" = CONST(Promotion), Status = FILTER(<> Approved | Rejected));
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
                field("Promotion Type"; Rec."Promotion Type")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field(Name; Rec.Name)
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

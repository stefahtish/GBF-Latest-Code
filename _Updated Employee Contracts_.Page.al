page 50538 "Updated Employee Contracts"
{
    CardPageID = "Employee Contract";
    PageType = List;
    SourceTable = "Employee Contracts";
    SourceTableView = WHERE(Status = FILTER(Released));
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
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Contract Type"; Rec."Contract Type")
                {
                }
                field(Tenure; Rec.Tenure)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
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

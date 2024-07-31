page 50442 "Employee Transfer List"
{
    CardPageID = "Employee Transfer Card";
    PageType = List;
    SourceTable = "Employee Transfers";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transfer No"; Rec."Transfer No")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Department To Transfer"; Rec."Department Name")
                {
                }
                field("Job Group"; Rec."Job Group")
                {
                }
                field("Length of Stay"; Rec."Length of Stay")
                {
                }
                field("HOD Employee No"; Rec."HOD Employee No")
                {
                }
            }
        }
    }
    actions
    {
    }
}

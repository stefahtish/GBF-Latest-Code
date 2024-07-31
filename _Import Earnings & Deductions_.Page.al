page 50676 "Import Earnings & Deductions"
{
    CardPageID = "Earning & Deductions Header";
    PageType = List;
    SourceTable = "Import Earn & Ded Header";
    SourceTableView = WHERE(Status = FILTER(<> Released));
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
                field(Type; Rec.Type)
                {
                }
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Pay Period"; Rec."Pay Period")
                {
                }
                field(Total; Rec.Total)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }
    actions
    {
    }
}

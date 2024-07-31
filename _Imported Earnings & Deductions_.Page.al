page 50677 "Imported Earnings & Deductions"
{
    CardPageID = "Earning & Deductions Header";
    PageType = List;
    SourceTable = "Import Earn & Ded Header";
    SourceTableView = WHERE(Status = FILTER(Released));
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
                field("Pay Period Text"; Rec."Pay Period Text")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Total; Rec.Total)
                {
                }
            }
        }
    }
    actions
    {
    }
}

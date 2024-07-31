page 50384 "Project Team"
{
    PageType = Listpart;
    //pagetype = list;
    SourceTable = "Project Team";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = all;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = all;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
    }
}

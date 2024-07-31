page 50438 "Base Calender List"
{
    CardPageID = "Base Calender Card New";
    PageType = List;
    SourceTable = "Base Calender Custom";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Customized Changes Exist"; Rec."Customized Changes Exist")
                {
                }
            }
        }
    }
    actions
    {
    }
}

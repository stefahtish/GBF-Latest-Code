page 50570 "Profiles Custom"
{
    PageType = List;
    SourceTable = "all Profile";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Profile ID"; Rec."Profile ID")
                {
                }
            }
        }
    }
    actions
    {
    }
}

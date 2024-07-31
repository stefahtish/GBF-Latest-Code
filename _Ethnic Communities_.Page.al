page 50515 "Ethnic Communities"
{
    PageType = List;
    SourceTable = "Ethnic Communities";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ethnic Code"; Rec."Ethnic Code")
                {
                }
                field("Ethnic Name"; Rec."Ethnic Name")
                {
                }
            }
        }
    }
    actions
    {
    }
}

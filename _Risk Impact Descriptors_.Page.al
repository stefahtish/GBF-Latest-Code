page 51189 "Risk Impact Descriptors"
{
    PageType = List;
    SourceTable = "Risk Impact Descriptors";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Impact Code"; Rec."Impact Code")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Domain Code"; Rec."Domain Code")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Impact Descriptior"; Rec."Impact Descriptior")
                {
                }
            }
        }
    }
    actions
    {
    }
}

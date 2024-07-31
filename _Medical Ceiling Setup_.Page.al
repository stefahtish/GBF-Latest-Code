page 50258 "Medical Ceiling Setup"
{
    PageType = List;
    SourceTable = "Medical Ceiling Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Salary Scale"; Rec."Salary Scale")
                {
                }
                field("Annual Amount"; Rec."Annual Amount")
                {
                }
            }
        }
    }
    actions
    {
    }
}

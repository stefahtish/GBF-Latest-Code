page 50386 "Project Task Components"
{
    Caption = 'Contract Milestone Components';
    PageType = List;
    SourceTable = "Project Task Components";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Component; Rec.Component)
                {
                }
                field("Component Budget"; Rec."Component Budget")
                {
                }
                field("Progress Level"; Rec."Progress Level")
                {
                }
            }
        }
    }
    actions
    {
    }
}

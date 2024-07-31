page 50193 "Approval Stages ListPart"
{
    Caption = 'Approval Stages';
    PageType = List;
    SourceTable = "Approval Stages1";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Approval Stage"; Rec."Approval Stage")
                {
                }
                field("Approval Stage Name"; Rec."Approval Stage Name")
                {
                }
                field("Minimum Approvers"; Rec."Minimum Approvers")
                {
                }
            }
        }
    }
    actions
    {
    }
}

page 50190 "Approval Stages"
{
    PageType = List;
    SourceTable = "Approval Stages1";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Workflow User Group Code"; Rec."Workflow User Group Code")
                {
                }
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

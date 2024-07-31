pageextension 50114 WrkflowUserGroupPageExt extends "Workflow User Group"
{
    actions
    {
        addfirst(Processing)
        {
            action("Approval Stages")
            {
                Image = Stages;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Approval Stages ListPart";
                RunPageLink = "Workflow User Group Code" = field(Code);
                ApplicationArea = All;
            }
        }
    }
}

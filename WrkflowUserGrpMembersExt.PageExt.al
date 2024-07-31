pageextension 50115 WrkflowUserGrpMembersExt extends "Workflow User Group Members"
{
    layout
    {
        addlast(Group)
        {
            field("Approval Stages"; Rec."Approval Stages")
            {
                ApplicationArea = All;
            }
            field(Subtitute; Rec.Subtitute)
            {
                ToolTip = 'Specifies the value of the Subtitute field.';
                ApplicationArea = All;
            }
        }
    }
}

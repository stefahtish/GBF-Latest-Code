tableextension 50113 WorkflowUserGrpMemberTableExt extends "Workflow User Group Member"
{
    fields
    {
        field(50000; "Approval Stages"; Code[20])
        {
            TableRelation = "Approval Stages1"."Approval Stage";
        }
        field(60000; "Delegated From"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(60001; "Subtitute"; Code[50])
        {
            TableRelation = "User Setup";
        }
    }
}

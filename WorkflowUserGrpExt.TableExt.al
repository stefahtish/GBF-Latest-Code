tableextension 50112 WorkflowUserGrpExt extends "Workflow User Group"
{
    fields
    {
        field(50000; "Approval Stages"; Code[20])
        {
            TableRelation = "Approval Stages1"."Approval Stage";
        }
        field(50001; "Subtitute"; Code[50])
        {
            TableRelation = "User Setup";

            ;
        }
    }
}

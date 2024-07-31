pageextension 50146 "Workflow TableRel pageExt" extends "Workflow - Table Relations"
{
    layout
    {
        addafter("Related Field Caption")
        {
            field(Finance; Rec.Finance)
            {
                ApplicationArea = All;
            }
            field(HR; Rec.HR)
            {
                ApplicationArea = All;
            }
            field(Procurement; Rec.Procurement)
            {
                ApplicationArea = All;
            }
            field(Audit; Rec.Audit)
            {
                ApplicationArea = All;
            }
        }
    }
}

page 51394 "PMWorkPlan"
{
    PageType = ListPart;
    Caption = 'Work Plan';
    SourceTable = PmworkPlan;
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("WPNO."; Rec."WPNO.")
                {
                    ToolTip = 'Specifies the value of the WPNO. field.';
                    ApplicationArea = All;
                    Caption = 'WorkPlan Number';
                    visible = false;
                }
                field(Phase; Rec.Phase)
                {
                    ToolTip = 'Specifies the value of the Phase field.';
                    ApplicationArea = All;
                }
                field(Deliverable; Rec.Deliverable)
                {
                    ToolTip = 'Specifies the value of the Deliverable field.';
                    ApplicationArea = All;
                }
                field("Responsible Person Code"; Rec."Responsible Person Code")
                {
                    ToolTip = 'Specifies the value of the Responsible Person Code field.';
                    ApplicationArea = All;
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ToolTip = 'Specifies the value of the Responsible Person field.';
                    ApplicationArea = All;
                    editable = false;
                }
                field("Timeline in Days"; Rec."Timeline in Days")
                {
                    ToolTip = 'Specifies the value of the Timeline in Days field.';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Collection Date"; Rec."Collection Date")
                {
                    ApplicationArea = all;
                }
                field("Notification Sent"; Rec."Notification Sent")
                {
                    ApplicationArea = all;
                }
                field("Invoice Created"; Rec."Invoice Created")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}

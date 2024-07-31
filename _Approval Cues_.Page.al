page 51423 "Approval Cues"
{
    Caption = 'Approval Cues';
    PageType = CardPart;
    SourceTable = "Approval Cues";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                cuegroup(Approvals)
                {
                    Caption = 'Approvals';

                    field("Requests to Approve"; Rec."Requests to Approve")
                    {
                        ApplicationArea = All;
                        DrillDownPageID = "Requests to Approve";
                        Style = Favorable;
                    }
                    field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
                    {
                        ApplicationArea = All;
                        DrillDownPageID = "Approval Request Entries";
                        Style = Favorable;
                    }
                    field("Orders to Approve"; Rec."Orders to Approve")
                    {
                        ApplicationArea = All;
                        DrillDownPageID = "Requests to Approve";
                        Style = Favorable;
                        ToolTip = 'Specifies the value of the Orders to Approve field.';
                    }
                    field("Imprest Requests to Approve"; Rec."Imprest Requests to Approve")
                    {
                        ToolTip = 'Specifies the value of the Requests to Approve field.';
                        ApplicationArea = All;
                        DrillDownPageID = "Requests to Approve";
                        Style = Favorable;
                    }
                    field("Imprest Surr to Approve"; Rec."Imprest Surr to Approve")
                    {
                        ToolTip = 'Specifies the value of the Requests to Approve field.';
                        ApplicationArea = All;
                        DrillDownPageID = "Requests to Approve";
                        Style = Favorable;
                    }
                    field("Purchase Requests to Approve"; Rec."Purchase Requests to Approve")
                    {
                        ToolTip = 'Specifies the value of the Purchase Requests to Approve field.';
                        ApplicationArea = All;
                        DrillDownPageID = "Requests to Approve";
                        Style = Favorable;
                    }
                    field("Store Requisitions to Approve"; Rec."Store Requisitions to Approve")
                    {
                        ToolTip = 'Specifies the value of the Leave Adjustment Requests to Approv field.';
                        ApplicationArea = All;
                        DrillDownPageID = "Requests to Approve";
                        Style = Favorable;
                    }
                    field("Leave Requests to Approve"; Rec."Leave Requests to Approve")
                    {
                        ToolTip = 'Specifies the value of the Requests to Approve field.';
                        ApplicationArea = All;
                        DrillDownPageID = "Requests to Approve";
                        Style = Favorable;
                    }
                    field("Leave Adj to Approve"; Rec."Leave Adj to Approve")
                    {
                        ToolTip = 'Specifies the value of the Leave Adjustment Requests to Approve field.';
                        ApplicationArea = All;
                        DrillDownPageID = "Requests to Approve";
                        Style = Favorable;
                        Visible = false;
                    }
                    field("Leave Recall to Approve"; Rec."Leave Recall to Approve")
                    {
                        ToolTip = 'Specifies the value of the Leave Recall Requests to Approve field.';
                        ApplicationArea = All;
                        DrillDownPageID = "Requests to Approve";
                        Style = Favorable;
                        Visible = false;
                    }
                    field("Employee Appraisal to Approve"; Rec."Employee Appraisal to Approve")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Employee Appraisal to Approve field.';
                        DrillDownPageID = "Requests to Approve";
                        Style = Favorable;
                    }
                    field("General Requests to Approve"; Rec."General Requests to Approve")
                    {
                        ToolTip = 'Specifies the value of the Requests to Approve field.';
                        ApplicationArea = All;
                        DrillDownPageID = "Requests to Approve";
                        Style = Favorable;
                        Visible = false;
                    }
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then Rec.SetRange("User ID Filter", UserId);
        end;
        if not Rec.Get then begin
            Rec.Init();
            Rec.Insert();
        end;
        Rec.SetRange("User ID Filter", UserId);
    end;

    var
        UserSetup: Record "User Setup";
}

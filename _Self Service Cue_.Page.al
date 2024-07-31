page 51415 "Self Service Cue"
{
    Caption = 'Self Service Cues';
    PageType = CardPart;
    SourceTable = "General Management Cue";
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Imprest)
            {
                field(Imprests; Rec.Imprests)
                {
                    Caption = 'Open';
                    DrillDownPageId = "Imprests-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Pending Imprests"; Rec."Pending Imprests")
                {
                    Caption = 'Pending';
                    DrillDownPageId = "Imprests-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Approved Imprest"; Rec."Approved Imprest")
                {
                    Caption = 'Approved';
                    DrillDownPageId = "Imprests-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
            }
            cuegroup("Imprests Surrenders")
            {
                Caption = 'Imprest Surrenders';

                field("Imprest Surrenders"; Rec."Imprest Surrenders")
                {
                    Caption = 'Open';
                    DrillDownPageId = "Imprest Surrenders-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Pending Imprest Surrenders"; Rec."Pending Imprest Surrenders")
                {
                    Caption = 'Pending';
                    DrillDownPageId = "Imprest Surrenders-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Approved Imprest Surrenders"; Rec."Approved Imprest Surrenders")
                {
                    Caption = 'Approved';
                    DrillDownPageId = "Imprest Surrenders-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
            }
            cuegroup("Staff claims")
            {
                field("Staff Claims List"; Rec."Staff Claims List")
                {
                    Caption = 'Open';
                    DrillDownPageId = "Staff Claim List-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Pending Staff Claim List"; Rec."Pending Staff Claim List")
                {
                    Caption = 'Pending';
                    DrillDownPageId = "Staff Claim List-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Approved Staff Claim"; Rec."Approved Staff Claim")
                {
                    Caption = 'Approved';
                    DrillDownPageId = "Staff Claim List-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
            }
            cuegroup("Purchase request")
            {
                field("Purchase request list"; Rec."Purchase request list")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Request List";
                }
                field("Purchase request list Approved"; Rec."Purchase request list Approved")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Request Approved";
                }
                field("Pending Approval Purchase request list"; Rec."Pending Approval Request list")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Request Approved";
                }
            }
            cuegroup("Store request")
            {
                field("Store Request List"; Rec."Store Request List")
                {
                    Caption = 'Open';
                    DrillDownPageId = "Store Request List-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Pending Store Request"; Rec."Pending Store Request")
                {
                    Caption = 'Pending';
                    DrillDownPageId = "Store Request List-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Approved Store Request"; Rec."Approved Store Request")
                {
                    Caption = 'Approved';
                    DrillDownPageId = "Store Request List-General";
                    StyleExpr = true;
                    Style = Favorable;
                }
            }
            // cuegroup(Approvals)
            // {
            //     Caption = 'Approvals';
            //     Visible = true;
            //     field("Requests to Approve"; "Requests to Approve")
            //     {
            //         ApplicationArea = All;
            //         DrillDownPageID = "Requests to Approve";
            //     }
            //     field("Requests Sent for Approval"; "Requests Sent for Approval")
            //     {
            //         ApplicationArea = All;
            //         DrillDownPageID = "Approval Request Entries";
            //     }
            // }
            cuegroup(Leave)
            {
                Caption = 'Leave Application';

                field("Open Leave"; Rec."Open Leave")
                {
                    Caption = 'Open';
                    ApplicationArea = All;
                    DrillDownPageId = "Self-Service Leave Application";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Leave Rerliever Open"; Rec."Leave Reliever Open")
                {
                    Caption = 'Reliever Open';
                    ApplicationArea = All;
                    DrillDownPageId = "Self-Service Leave Application";
                    StyleExpr = true;
                    Style = Favorable;
                }
                field("Leave Reliever Approved"; Rec."Leave Reliever Approved")
                {
                    Caption = 'Reliever Approved';
                    ApplicationArea = All;
                    DrillDownPageId = "Self-Service Leave Application";
                    StyleExpr = true;
                    Style = Favorable;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("User ID Filter", UserId);
            end;
        end;
        if not Rec.Get('') then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    var
        UserSetup: Record "User Setup";
}

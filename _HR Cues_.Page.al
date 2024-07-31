page 50508 "HR Cues"
{
    PageType = CardPart;
    SourceTable = "Approval Cues";
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Control2)
            {
                ShowCaption = false;

                field("All Employees"; Rec."All Employees")
                {
                }
                field("Active Employees"; Rec."Active Employees")
                {
                }
                field("Retired Employees"; Rec."Retired Employees")
                {
                }
                field("Resigned Employees"; Rec."Resigned Employees")
                {
                }
                field("Probation Employees"; Rec."Probation Employees")
                {
                }
            }
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                Visible = true;

                field("Requests to Approve"; Rec."Requests to Approve")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Requests to Approve";
                }
                field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Approval Request Entries";
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then Rec.SetRange("User ID Filter", UserId);
        end;
        if not Rec.Get('') then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    var
        UserSetup: Record "User Setup";
}

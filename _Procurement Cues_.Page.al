page 50767 "Procurement Cues"
{
    PageType = CardPart;
    SourceTable = "Approval Cues";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("Approval request entries"; Rec."Approval request entries")
            {
            }
            field("Pending Approvals"; Rec."Pending Approvals")
            {
            }
            field("Approved LPO"; Rec."Approved LPO")
            {
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

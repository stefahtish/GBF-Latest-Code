page 50172 "Fund Management Cues"
{
    PageType = CardPart;
    SourceTable = "Approval Cues";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("Approved Imprest"; Rec."Approved Imprest")
            {
            }
            field("Imprest Surrenders"; Rec."Imprest Surrenders")
            {
            }
            field("Staff Claims List"; Rec."Staff Claims List")
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

page 50510 "General Activities Cues"
{
    PageType = CardPart;
    SourceTable = "Approval Cues";
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup("General Activities")
            {
                field("Approved Imprest"; Rec."Approved Imprest")
                {
                }
                field("Imprest Surrenders"; Rec."Imprest Surrenders")
                {
                }
                field("Approved Imprest Surrenders"; Rec."Approved Imprest Surrenders")
                {
                }
                field("Staff Claims List"; Rec."Staff Claims List")
                {
                }
                field("Approved Staff Claim"; Rec."Approved Staff Claim")
                {
                }
                field("Purchase Request List"; Rec."Purchase Request List")
                {
                }
                field("Purchase Request Approved"; Rec."Purchase Request Approved")
                {
                }
                field("Store Request List"; Rec."Store Request List")
                {
                }
                field("Approved Store Request"; Rec."Approved Store Request")
                {
                }
                field("Leave Application List"; Rec."Leave Application List")
                {
                }
                field("Transport Requests"; Rec."Transport Requests")
                {
                }
                field("Approved Travel Requests"; Rec."Approved Travel Requests")
                {
                }
                field("Training Request List"; Rec."Training Request List")
                {
                }
                field("Approved Training Request List"; Rec."Approved Training Request List")
                {
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

pageextension 50158 ApprovalUserSetupPageExt extends "Approval User Setup"
{
    actions
    {
        addlast(Navigation)
        {
            action("User Signature")
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = Signature;
                RunObject = page "User Signatures";
                RunPageLink = "User ID" = field("User ID");
                ApplicationArea = All;
            }
        }
    }
}

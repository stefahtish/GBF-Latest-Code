page 50483 "Medical Claims List"
{
    CardPageID = "Medical Claims Header";
    PageType = List;
    SourceTable = "Medical Claims";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Claim No"; Rec."Claim No")
                {
                }
                field("Claim Date"; Rec."Claim Date")
                {
                }
                field("Service Provider"; Rec."Service Provider")
                {
                }
                field("Service Provider Name"; Rec."Service Provider Name")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field(Claimant; Rec.Claimant)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Settled; Rec.Settled)
                {
                }
                field("Cheque No"; Rec."Cheque No")
                {
                }
            }
        }
    }
    actions
    {
    }
}

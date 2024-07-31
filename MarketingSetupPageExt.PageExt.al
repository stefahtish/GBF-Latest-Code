pageextension 50107 MarketingSetupPageExt extends "Marketing Setup"
{
    layout
    {
        addlast(Numbering)
        {
            field(Interact; Rec.Interact)
            {
                Caption = 'Interaction Nos';
                ApplicationArea = All;
            }
            field("Enquiries Nos."; Rec."Enquiries Nos.")
            {
                ApplicationArea = All;
            }
        }
    }
}

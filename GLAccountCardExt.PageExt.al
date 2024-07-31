pageextension 50105 GLAccountCardExt extends "G/L Account Card"
{
    layout
    {
        addlast(General)
        {
            field("Votebook Entry"; Rec."Votebook Entry")
            {
                ApplicationArea = all;
                Caption = 'Check Budget';
            }
        }
    }
}

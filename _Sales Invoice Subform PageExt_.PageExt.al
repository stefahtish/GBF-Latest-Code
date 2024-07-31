pageextension 50120 "Sales Invoice Subform PageExt" extends "Sales Invoice Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("VAT Bus. Posting Groups"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Gen. Bus. Posting Groups"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            // field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            // {
            // }
        }
        addafter("No.")
        {
            field("Project Code"; Rec."Project Code")
            {
                ApplicationArea = all;
            }
            field(Phase; Rec.Phase)
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}

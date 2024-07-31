pageextension 50147 "Sales&Receivables PageExt" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("VAT Bus. Posting Gr. (Price)")
        {
            field("Default Customer Posting Group"; Rec."Default Customer Posting Group")
            {
                ApplicationArea = All;
            }
            field("Default Gen Business Group"; Rec."Default Gen Business Group")
            {
                ApplicationArea = All;
            }
            field("Default VAT Posting Group"; Rec."Default VAT Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
}

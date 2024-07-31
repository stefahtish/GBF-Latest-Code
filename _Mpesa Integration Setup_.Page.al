page 50363 "Mpesa Integration Setup"
{
    Caption = 'Mpesa Integration Setup';
    PageType = Card;
    SourceTable = "MPESA Integration Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Default Dim1"; Rec."Default Dim1")
                {
                    ApplicationArea = All;
                }
                field("Default Dim2"; Rec."Default Dim2")
                {
                    ApplicationArea = All;
                }
                field("Default Responsibility Center"; Rec."Default Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Default Type"; Rec."Default Type")
                {
                    ApplicationArea = All;
                }
                field("Integration Journal Template"; Rec."Integration Journal Template")
                {
                    ApplicationArea = All;
                }
                field("Operations & Manitenance A/C"; Rec."Operations & Manitenance A/C")
                {
                    ApplicationArea = All;
                }
                field("Default Bank Account"; Rec."Default Bank Account")
                {
                    ApplicationArea = All;
                }
                field("Default Description"; Rec."Default Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

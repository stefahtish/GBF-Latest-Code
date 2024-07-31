page 51135 "Issued Licenses"
{
    Caption = 'Issued Permits';
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = true;
    SourceTable = "Issued Applicant License";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                }
                field("License/Permit"; Rec."License/Permit")
                {
                    caption = 'Permit';
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("License No."; Rec."License No.")
                {
                    Caption = 'Regulatory Permit No.';
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry date"; Rec."Expiry date")
                {
                    ApplicationArea = All;
                }
                field(Outlet; Rec.Outlet)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

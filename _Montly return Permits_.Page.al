page 51033 "Montly return Permits"
{
    Caption = 'Permits';
    PageType = ListPart;
    SourceTable = "Monthly return permits";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Applicant No"; Rec."Applicant No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Permit No."; Rec."Permit No.")
                {
                    ApplicationArea = All;
                }
                field(Outlet; Rec.Outlet)
                {
                    Enabled = false;
                }
            }
        }
    }
}

page 51146 "Applicant Product Area of Sale"
{
    Caption = 'Areas of Sale';
    PageType = ListPart;
    SourceTable = "Applicant product area of sale";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Applicant No"; Rec."Applicant No")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field(Outlet; Rec.Outlet)
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field("Area of sale"; Rec."Area of sale")
                {
                    ApplicationArea = All;
                }
                field("Area of sale name"; Rec."Area of sale name")
                {
                    ApplicationArea = All;
                    enabled = false;
                }
            }
        }
    }
}

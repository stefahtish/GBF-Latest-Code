page 51150 "Applicant Sell to Whom"
{
    Caption = 'Sell To Whom';
    PageType = ListPart;
    SourceTable = "Applicant sell to whom2";
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
                field(Product; Rec.Product)
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field("Sell to Whom"; Rec."Sell to Whom")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

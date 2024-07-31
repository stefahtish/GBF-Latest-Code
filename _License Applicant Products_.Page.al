page 51132 "License Applicant Products"
{
    Caption = 'Nature of Produce list';
    PageType = ListPart;
    SourceTable = "Applicants Products per outlet";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Product; Rec.Product)
                {
                    caption = 'Nature of Produce';
                    ApplicationArea = All;
                }
                field("Unit of measure"; Rec."Unit of measure2")
                {
                    ApplicationArea = All;
                }
                field("Quantity handled"; Rec."Quantity handled")
                {
                    Caption = 'Quantity per day';
                    ApplicationArea = All;
                }
                field("Sell to whom"; Rec."Sell to whom")
                {
                    ApplicationArea = All;
                }
                field("Area of Sale"; Rec."Area of Sale")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Area of Sale Name"; Rec."Area of Sale Name")
                {
                    enabled = false;
                    Visible = false;
                }
                field("Application no"; Rec."Application no")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Outlet; Rec.Outlet)
                {
                    Visible = false;
                }
            }
        }
    }
}

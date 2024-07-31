page 51031 "Monthly Return Product List"
{
    Caption = 'Monthly Return Product';
    PageType = List;
    SourceTable = "Monthly Returns  Product";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ApplicationNo; Rec.ApplicationNo)
                {
                    Visible = false;
                }
                field(Product; Rec.Product)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
            }
        }
    }
}

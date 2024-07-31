page 50746 "Order Due days Threshold"
{
    Caption = 'Order Due days Threshold';
    PageType = List;
    SourceTable = "Order Due Days Threshold";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Band name"; Rec."Band name")
                {
                    ApplicationArea = All;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = All;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = All;
                }
                field("Due days"; Rec."Due days")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

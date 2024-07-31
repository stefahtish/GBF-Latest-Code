page 51274 "Fuel Allocations"
{
    Caption = 'Fuel Allocations';
    CardPageId = "Fuel Allocation";
    PageType = List;
    Editable = false;
    SourceTable = "Fuel Allocations";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field("Start date"; Rec."Start date")
                {
                    ApplicationArea = All;
                }
                field("End date"; Rec."End date")
                {
                    ApplicationArea = All;
                }
                field("Allocated by"; Rec."Allocated by")
                {
                    ApplicationArea = All;
                }
                field("Total Allocated Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field(Allocated; Rec.Allocated)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }
}

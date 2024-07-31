page 50611 "Fuel Allocation Periods"
{
    Caption = 'Fuel Allocation Periods';
    PageType = List;
    SourceTable = "Fuel Allocation Periods";
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
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.closed)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Close Period")
            {
                Visible = not Rec.closed;

                trigger OnAction()
                begin
                    Rec.closed := true;
                    Rec.Modify();
                    //HrManagement.TransferFuelBalances(Rec);
                end;
            }
        }
    }
    // trigger OnAfterGetRecord()
    // begin
    //     GetNextPeriod();
    // end;  
    var
        HrManagement: Codeunit "HR Management";
}

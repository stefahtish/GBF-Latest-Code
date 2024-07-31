page 51273 "Fuel Allocation"
{
    Caption = 'Fuel Allocation';
    PageType = Card;
    SourceTable = "Fuel Allocations";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not Rec.Allocated;

                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field("Allocated by"; Rec."Allocated by")
                {
                    ApplicationArea = All;
                }
                field("Employee name"; Rec."Employee name")
                {
                    ApplicationArea = All;
                }
                field("Start date"; Rec."Start date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("End date"; Rec."End date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Allocated Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Usage"; Rec."Total Usage")
                {
                    ApplicationArea = All;
                }
                field("Total Balance"; Rec."Total Balance")
                {
                    ApplicationArea = All;
                }
            }
            part("Fuel Allocation Lines"; "Fuel Allocation Lines")
            {
                Editable = not Rec.Allocated;
                SubPageLink = Period = field(Period);
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Allocate)
            {
                Visible = not Rec.Allocated;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ProcMgmt: Codeunit "Procurement Management";
                begin
                    Rec.TestField(Period);
                    ProcMgmt.FuelAllocation(Rec);
                    CurrPage.close;
                end;
            }
            action("Top up schedule")
            {
                trigger OnAction()
                var
                    FuelAlloc: Record "Fuel Allocations";
                begin
                    FuelAlloc.RESET;
                    FuelAlloc.SETRANGE(Period, Rec.Period);
                    Commit;
                    REPORT.RUN(Report::"Fuel Top up Schedule", TRUE, FALSE, FuelAlloc);
                end;
            }
        }
    }
    var
        HRManagement: Codeunit "HR Management";
}

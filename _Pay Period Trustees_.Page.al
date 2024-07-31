page 50684 "Pay Period Trustees"
{
    PageType = List;
    SourceTable = "Payroll Period Trustees";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                }
                field("Pay Date"; Rec."Pay Date")
                {
                }
                field(Closed; Rec.Closed)
                {
                    Editable = false;
                }
                field("Close Pay"; Rec."Close Pay")
                {
                    Editable = false;
                }
                field("Total Allowances"; Rec."Total Allowances")
                {
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                }
                field("P.A.Y.E"; Rec."P.A.Y.E")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(Action12)
            {
                action("Close Pay Period")
                {
                    Caption = 'Close Pay Period';
                    Image = ClosePeriod;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if not Confirm('You are about to close the current Pay period are you sure you want to do this?' + //
 ' Make sure all reports are correct before closing the current pay period, Go ahead?', false) then
                            exit;
                        ClosingFunction.GetCurrentPeriod(Rec);
                        ClosingFunction.Run;
                    end;
                }
                action("Create Period")
                {
                    Caption = 'Create Period';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = false;
                    RunObject = Report "Create Payroll Period";
                    Visible = false;
                }
            }
        }
    }
    var
        ClosingFunction: Report "Close Pay Period - Trustees";
}

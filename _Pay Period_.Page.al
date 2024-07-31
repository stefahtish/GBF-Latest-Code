page 50634 "Pay Period"
{
    PageType = List;
    SourceTable = "Payroll PeriodX";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pay Date"; Rec."Pay Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Close Pay"; Rec."Close Pay")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("P.A.Y.E"; Rec."P.A.Y.E")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = Basic, Suite;
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
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if not Confirm('You are about to close the current Pay period are you sure you want to do this?' + //
 ' Make sure all reports are correct before closing the current pay period, Go ahead?', false)then exit;
                        ClosingFunction.GetCurrentPeriod(Rec);
                        ClosingFunction.Run;
                    end;
                }
                action("Create Period")
                {
                    Caption = 'Create Period';
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = false;
                    RunObject = Report "Create Payroll Period";
                    Visible = true;
                }
            }
        }
    }
    var ClosingFunction: Report "Close Pay Period";
}

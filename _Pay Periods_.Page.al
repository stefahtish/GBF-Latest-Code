page 50643 "Pay Periods"
{
    PageType = List;
    SourceTable = "Payroll PeriodX";
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
                }
                field("Close Pay"; Rec."Close Pay")
                {
                }
                field("P.A.Y.E"; Rec."P.A.Y.E")
                {
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                }
                field("Leave Payment Period"; Rec."Leave Payment Period")
                {
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Close Period")
            {
                action("Close Pay Period")
                {
                    Caption = 'Close Pay Period';

                    trigger OnAction()
                    begin
                        if (Rec.Closed = true) then Error('This Pay Period is already Closed');
                        if not Confirm(Text000, false) then exit;
                        ClosingFunction.GetCurrentPeriod(Rec);
                        ClosingFunction.Run;
                    end;
                }
                action("Create Pay Period")
                {
                    RunObject = Report "Create Payroll Period";
                }
            }
        }
    }
    var
        Text000: Label 'You are about to close the current Pay period are you sure you want to do this?                                                                                               Make sure all reports are correct before closing the current pay period, Go ahead?';
        ClosingFunction: Report "Close Pay Period";
}

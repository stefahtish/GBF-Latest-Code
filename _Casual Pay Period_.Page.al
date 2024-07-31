page 50657 "Casual Pay Period"
{
    PageType = List;
    SourceTable = "Payroll Period Casuals";
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

                    trigger OnAction()
                    begin
                        if not Confirm('You are about to close the current Pay period are you sure you want to do this?' + //
 ' Make sure all reports are correct before closing the current pay period, Go ahead?', false) then
                            exit;
                        //ClosingFunction.GetCurrentPeriod(Rec);
                        //ClosingFunction.RUN;
                    end;
                }
                group(Action14)
                {
                    action("Create Period")
                    {
                        Caption = 'Create Period';
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = New;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = false;
                        //The property 'PromotedOnly' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedOnly = false;
                        RunObject = Report "Create Payroll Period- Casual";
                    }
                }
            }
        }
    }
    var
        ClosingFunction: Report "Close Pay Period";
}

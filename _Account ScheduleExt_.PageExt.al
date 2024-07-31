pageextension 50121 "Account ScheduleExt" extends 104
{
    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        addafter(Outdent)
        {
            action("Print.")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    AccScheduleName: Record "Acc. Schedule Name";
                    AccountSchedule: Report "Account ScheduleExt";
                begin
                    AccScheduleName.Get(Rec."Schedule Name");
                    AccountSchedule.SetAccSchedName(AccScheduleName.Name);
                    AccountSchedule.SetColumnLayoutName(AccScheduleName."Default Column Layout");
                    AccountSchedule.Run;
                end;
            }
        }
    }
    var myInt: Integer;
}

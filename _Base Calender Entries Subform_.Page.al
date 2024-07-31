page 50437 "Base Calender Entries Subform"
{
    PageType = ListPart;
    SourceTable = Date;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CurrentCalendarCode; CurrentCalendarCode)
                {
                    Caption = 'Base Calendar Code';
                    Editable = false;
                    ToolTip = 'Specifies which base calender was used as the basis';
                    Visible = false;
                }
                field("Period Start"; Rec."Period Start")
                {
                }
                field("Period Name"; Rec."Period Name")
                {
                }
                field(WeekNo; WeekNo)
                {
                    Caption = 'Week No.';
                }
                field(Nonworking; Nonworking)
                {
                }
                field(Description; Description)
                {
                }
            }
        }
    }
    actions
    {
    }
    var
        BaseCalendarChange: Record "Base Calendar Change";
        PeriodFormMgt: Codeunit PeriodPageManagement;
        //CalendarMgmt: Codeunit "Calendar Management";
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        Nonworking: Boolean;
        WeekNo: Integer;
        Description: Text[30];
        CurrentCalendarCode: Code[10];
}

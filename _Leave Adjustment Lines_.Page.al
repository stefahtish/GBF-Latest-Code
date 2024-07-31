page 50434 "Leave Adjustment Lines"
{
    PageType = ListPart;
    SourceTable = "Leave Bal Adjustment Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff No."; Rec."Staff No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    Caption = 'Leave Type';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Leave Adj Entry Type"; Rec."Leave Adj Entry Type")
                {
                }
                field(CurrentEntitlement; Rec.CurrentEntitlement)
                {
                    Caption = 'Current Entitlement';
                    Editable = false;
                }
                field(CurrentBalFoward; Rec.CurrentBalFoward)
                {
                    Caption = 'Current Balance Brought';
                    Editable = false;
                }
                field("New Entitlement"; Rec."New Entitlement")
                {
                    Caption = 'Entitlement Adjustment';
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                }
                field("Employment Type"; Rec."Employment Type")
                {
                }
            }
        }
    }
    actions
    {
    }
}

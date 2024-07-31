page 50486 "Travelling Employees List"
{
    PageType = ListPart;
    SourceTable = "Employees Travelling";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Air Ticket"; Rec."Air Ticket")
                {
                    Caption = 'Transport';
                }
                field("Per Diem"; Rec."Per Diem")
                {
                }
                field("Tuition Fee"; Rec."Tuition Fee")
                {
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
        }
    }
    actions
    {
    }
}

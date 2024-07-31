page 50651 "Payroll Requests"
{
    CardPageID = "Payroll Request Card";
    PageType = List;
    SourceTable = "Payroll Requests";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Applies; Rec.Applies)
                {
                }
                field(Groups; Rec.Group)
                {
                    Caption = 'Group';
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Code"; Rec.Code)
                {
                }
                field("Calculation Method"; Rec."Calculation Method")
                {
                }
                field("Flat Amount"; Rec."Flat Amount")
                {
                }
                field(Percentage; Rec.Percentage)
                {
                }
                field(Formula; Rec.Formula)
                {
                }
            }
        }
    }
    actions
    {
    }
}

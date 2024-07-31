page 50973 "Testing Employee Allocation"
{
    Caption = 'Testing Employee Allocation';
    PageType = ListPart;
    SourceTable = "Testing Employee Allocation";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee name"; Rec."Employee name")
                {
                }
            }
        }
    }
}

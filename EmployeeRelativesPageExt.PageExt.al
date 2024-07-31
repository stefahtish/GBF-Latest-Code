pageextension 50131 EmployeeRelativesPageExt extends "Employee Relatives"
{
    layout
    {
        addlast(Control1)
        {
            field("Employee No."; Rec."Employee No.")
            {
                Enabled = false;
                ApplicationArea = All;
            }
        }
    }
}

report 50245 "Assign Matrix Update"
{
    DefaultLayout = RDLC;
    RDLCLayout = './AssignMatrixUpdate.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
        {
            trigger OnAfterGetRecord()
            begin
                if Emp.Get("Assignment Matrix-X"."Employee No") then "Assignment Matrix-X".Area := Emp.Area;
                "Assignment Matrix-X".Modify;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var
        AssignMatrix: Record "Assignment Matrix-X";
        Emp: Record Employee;
}

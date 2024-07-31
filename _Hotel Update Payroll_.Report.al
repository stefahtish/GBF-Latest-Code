report 50257 "Hotel Update Payroll"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HotelUpdatePayroll.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
        {
            trigger OnAfterGetRecord()
            begin
                "Assignment Matrix-X".Amount := -("Assignment Matrix-X".Amount);
                "Assignment Matrix-X".Modify;
            end;

            trigger OnPreDataItem()
            begin
                "Assignment Matrix-X".SetRange(Type, Type::Deduction);
                "Assignment Matrix-X".SetFilter(Amount, '>%1', 0);
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
}

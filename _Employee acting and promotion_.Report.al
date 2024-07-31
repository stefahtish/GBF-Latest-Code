report 50200 "Employee acting and promotion"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Employeeactingandpromotion.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Employee Acting Position"; "Employee Acting Position")
        {
            column(Start_Date; "Employee Acting Position"."Start Date")
            {
            }
            column(End_Date; "Employee Acting Position"."End Date")
            {
            }
            column(Reason; "Employee Acting Position".Reason)
            {
            }
            column(Employee_No; "Employee Acting Position"."Employee No.")
            {
            }
            column(New_Scale; "Employee Acting Position"."New Scale")
            {
            }
            column(New_Pointer; "Employee Acting Position"."New Pointer")
            {
            }
            column(New_Benefits; "Employee Acting Position"."New Benefits")
            {
            }
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
        "Company Information": Code[10];
}

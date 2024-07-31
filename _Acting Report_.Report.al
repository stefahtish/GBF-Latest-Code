report 50249 "Acting Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ActingReport.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Employee Acting Position"; "Employee Acting Position")
        {
            column(Employee_No; "Employee Acting Position"."Employee No.")
            {
            }
            column(NewScale; "Employee Acting Position"."New Scale")
            {
            }
            column(New_Pointer; "Employee Acting Position"."New Pointer")
            {
            }
            column(New_Benefits; "Employee Acting Position"."New Benefits")
            {
            }
            column(Acting_Amount; "Employee Acting Position"."Acting Amount")
            {
            }
            column(Acting_Position; "Employee Acting Position".Position)
            {
            }
            column(Start_Date; "Employee Acting Position"."Start Date")
            {
            }
            column(End_; "Employee Acting Position"."End Date")
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
}

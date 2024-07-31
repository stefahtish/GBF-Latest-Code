report 50516 " Training Cost Comparision"
{
    Caption = ' Training Cost Comparision';
    DefaultLayout = RDLC;
    RDLCLayout = './Report/TrainingCost.rdl';
    ApplicationArea = All;
    dataset
    {
        dataitem(TrainingRequest; "Training Request")
        {
            column(RequestNo; "Request No.")
            {
            }
            column(EmployeeNo; "Employee No")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }

            column(Description; Description)
            {
            }
            column(Planned_Start_Date; Format("Planned Start Date"))
            { }
            column(Planned_End_Date; FORMAT("Planned End Date"))
            { }

            column(CostofTraining; "Cost of Training")
            {
            }

            column(EmployeeCost; "Employee Cost")
            {
            }
            column(CompNme; CompInfo.Name)
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(CompAdress; CompInfo.Address)
            {
            }
            column(CompPhone; CompInfo."Phone No.")
            {
            }
            column(Postal; CompInfo."Post Code")
            {
            }
            column(Email; CompInfo."E-Mail")
            {
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        CompInfo: Record "Company Information";

    trigger OnPreReport()
    var

    begin
        CompInfo.CalcFields(Picture)
    end;
}

report 50189 Training
{
    DefaultLayout = RDLC;
    RDLCLayout = './Training.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Training Request"; "Training Request")
        {
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Comp_Logo; CompanyInfo.Picture)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Request_No; "Training Request"."Request No.")
            {
            }
            column(Request_Date; "Training Request"."Request Date")
            {
            }
            column(Department_Code; "Training Request"."Department Code")
            {
            }
            column(No_Of_Days; "Training Request"."No. Of Days")
            {
            }
            column(Training_Insitution; "Training Request"."Training Insitution")
            {
            }
            column(Venue; "Training Request".Venue)
            {
            }
            column(Tuition_Fee_Total; "Training Request"."Tuition Fee")
            {
            }
            column(Per_Diem_Total; "Training Request"."Per Diem")
            {
            }
            column(Transport_Total; "Training Request"."Air Ticket")
            {
            }
            column(Total_Cost_Totals; "Training Request"."Total Cost")
            {
            }
            column(Planned_Start_Date; "Training Request"."Planned Start Date")
            {
            }
            column(Planned_End_Date; "Training Request"."Planned End Date")
            {
            }
            dataitem("Employees Travelling"; "Employees Travelling")
            {
                DataItemLink = "Request No." = FIELD("Request No.");

                column(Employee_No; "Employees Travelling"."Employee No")
                {
                }
                column(Employee_Name; "Employees Travelling"."Employee Name")
                {
                }
                column(TuitionFee; "Employees Travelling"."Tuition Fee")
                {
                }
                column(Per_Diem; "Employees Travelling"."Per Diem")
                {
                }
                column(Air_Ticket; "Employees Travelling"."Air Ticket")
                {
                }
                column(Total_Cost; "Employees Travelling"."Total Cost")
                {
                }
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}

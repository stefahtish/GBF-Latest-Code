report 50434 Projects
{
    DefaultLayout = RDLC;
    RDLCLayout = './Projects.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Project; "Project Header")
        {
            RequestFilterFields = "User ID", Status, "Actual Start Date", "Actual End Date";

            column(No_Project; Project."No.")
            {
            }
            column(ProjectName_Project; Project."Project Name")
            {
            }
            column(ProjectDate_Project; Project."Project Date")
            {
            }
            column(EstimatedStartDate_Project; Project."Estimated Start Date")
            {
            }
            column(EstimatedEndDate_Project; Project."Estimated End Date")
            {
            }
            column(EstimatedDuration_Project; Project."Estimated Duration")
            {
            }
            column(ActualStartDate_Project; Project."Actual Start Date")
            {
            }
            column(ActualEndDate_Project; Project."Actual End Date")
            {
            }
            column(ActualDuration_Project; Project."Actual Duration")
            {
            }
            column(ProjectBudget_Project; Project."Project Budget")
            {
            }
            column(ContractNo_Project; Project."Contract No")
            {
            }
            column(ContractName_Project; Project."Project Name")
            {
            }
            column(Status_Project; Project.Status)
            {
            }
            column(UserID_Project; Project."User ID")
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompCity; CompanyInformation.City)
            {
            }
            column(CompPhone; CompanyInformation."Phone No.")
            {
            }
            column(CompPic; CompanyInformation.Picture)
            {
            }
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    var
        ProjectTeam: Record "Project Team";
        FullName: Text[70];
        CompanyInformation: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
}

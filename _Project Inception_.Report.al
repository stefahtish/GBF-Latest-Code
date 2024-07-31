report 50447 "Project Inception"
{
    ApplicationArea = All;
    Caption = 'Project Inception';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Project Inception.rdl';

    dataset
    {
        dataitem(ProjectIdentification; ProjectIdentification)
        {
            column(ProjectName_ProjectIdentification; "Project Name")
            {
            }
            column(BackgroundContext_ProjectIdentification; "Background/Context")
            {
            }
            column(Sampling_ProjectIdentification; Sampling)
            {
            }
            column(PreliminaryFindings_ProjectIdentification; "Preliminary Findings")
            {
            }
            column(LogisticsSupport_ProjectIdentification; "Logistics/Support")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompLogo; CompanyInfo.Picture)
            {
            }
            column(USERID; UserId)
            {
            }
            column(TIME; Time)
            {
            }
            dataitem(PMWorkPlan; PMWorkPlan)
            {
                DataItemLink = "Project No."=field("Project No.");

                column(Phase_PMWorkPlan; Phase)
                {
                }
                column(Deliverable_PMWorkPlan; Deliverable)
                {
                }
                column(ResponsiblePerson_PMWorkPlan; "Responsible Person")
                {
                }
                column(TimelineinDays_PMWorkPlan; "Timeline in Days")
                {
                }
                column(Amount_PMWorkPlan; Amount)
                {
                }
                column(CollectionDate_PMWorkPlan; "Collection Date")
                {
                }
                column(InvoiceCreated_PMWorkPlan; "Invoice Created")
                {
                }
                column(ProjectNo_PMWorkPlan; "Project No.")
                {
                }
                column(ResponsiblePersonCode_PMWorkPlan; "Responsible Person Code")
                {
                }
            }
            dataitem(ProjectLines; "Project Lines")
            {
                DataItemLink = "Project No."=field("Project No.");

                column(Limitations_ProjectIdentification; Limitation)
                {
                }
                column(DataCollection_ProjectIdentification; "Data Collection Method")
                {
                }
                column(Objective_ProjectIdentification; Objective)
                {
                }
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
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;
    var CompanyInfo: Record "Company Information";
}

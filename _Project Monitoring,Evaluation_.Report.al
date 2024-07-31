report 50459 "Project Monitoring,Evaluation"
{
    ApplicationArea = All;
    Caption = 'Project Monitoring,Evaluation';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Project Monitoring,Evaluation.rdl';

    dataset
    {
        dataitem(ProjectIdentification; ProjectIdentification)
        {
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
            column(ProjectNo_ProjectIdentification; "Project No.")
            {
            }
            column(ProjectName_ProjectIdentification; "Project Name")
            {
            }
            column(ProjectStatus_ProjectIdentification; "Project Status")
            {
            }
            column(ProjectManagerName_ProjectIdentification; "Project Manager Name")
            {
            }
            column(ProjectStartDate_ProjectIdentification; "Project Start Date")
            {
            }
            column(ProjectEndDate_ProjectIdentification; "Project End Date")
            {
            }
            column(ProjectDuration_ProjectIdentification; "Project Duration")
            {
            }
            column(ProjectEstimatedCost_ProjectIdentification; "Project Estimated Cost")
            {
            }
            column(ProjectRelevance_ProjectIdentification; "Project Relevance")
            {
            }
            column(ProjectPerformance_ProjectIdentification; "Project Performance")
            {
            }
            column(AuditComments_ProjectIdentification; "Audit Comments")
            {
            }
            column(SubstantiveContribution_ProjectIdentification; "Substantive Contribution")
            {
            }
            dataitem(ProjectManagementImplCommittee; ProjectManagementImplCommittee)
            {
                DataItemLink = "Project No."=field("Project No.");

                column(FullName_ProjectManagementImplCommittee; "Full Name")
                {
                }
                column(IDNumber_ProjectManagementImplCommittee; "ID Number")
                {
                }
                column(Contact_ProjectManagementImplCommittee; Contact)
                {
                }
                column(EmailAddress_ProjectManagementImplCommittee; "Email Address")
                {
                }
                column(InstitutionOrganizationName_ProjectManagementImplCommittee; "Institution/Organization Name")
                {
                }
                column(ProjectNo_ProjectManagementImplCommittee; "Project No.")
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
    var CompanyInfo: Record "Company Information";
}

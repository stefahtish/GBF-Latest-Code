report 50446 "Project Identification"
{
    ApplicationArea = All;
    Caption = 'Project Identification';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Project Identification.rdl';

    dataset
    {
        dataitem(ProjectIdentification; ProjectIdentification)
        {
            RequestFilterFields = "Project No.";

            column(TitleOfAssignment_ProjectIdentification; "Project Name")
            {
            }
            column(ContactPerson_ProjectIdentification; "Contact Person")
            {
            }
            column(Email_ProjectIdentification; Email)
            {
            }
            column(PhoneNumber_ProjectIdentification; "Phone Number")
            {
            }
            column(Abstractcode_ProjectIdentification; Abstractcode)
            {
            }
            column(AbstractContent_ProjectIdentification; AbstractContent)
            {
            }
            column(NeedContent_ProjectIdentification; NeedContent)
            {
            }
            column(PurposeContent_ProjectIdentification; PurposeContent)
            {
            }
            column(DesignActivity_ProjectIdentification; DesignActivity)
            {
            }
            column(ModeofDissemination_ProjectIdentification; "Mode of Dissemination")
            {
            }
            column(EvaluationContent_ProjectIdentification; EvaluationContent)
            {
            }
            column(SustainabilityContent_ProjectIdentification; SustainabilityContent)
            {
            }
            column(ProjectBudget_ProjectIdentification; "Project Budget")
            {
            }
            column(TitlePage; TitlePage)
            {
            }
            column(AbstractLable; AbstractLable)
            {
            }
            column(StatementLabel; StatementLabel)
            {
            }
            column(PurposeLabel; PurposeLabel)
            {
            }
            column(ProjectDesign; ProjectDesign)
            {
            }
            column(ManagementPlanLabel; ManagementPlanLabel)
            {
            }
            column(EvaluationPlanLabel; EvaluationPlanLabel)
            {
            }
            column(DisseminationPlanLabel; DisseminationPlanLabel)
            {
            }
            column(ProjectTeamLabel; ProjectTeamLabel)
            {
            }
            column(BudgetLabel; BudgetLabel)
            {
            }
            column(SustainabilityLabel; SustainabilityLabel)
            {
            }
            column(AttachmentsLabel; AttachmentsLabel)
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
            dataitem(ProjectManagementPlan; ProjectManagementPlan)
            {
                DataItemLink = "Project No."=field("Project No.");

                column(PersonelNumber_ProjectManagementPlan; PersonelNumber)
                {
                }
                column(ProjectPersonel_ProjectManagementPlan; "Project Personel")
                {
                }
                column(ProjectResposibilities_ProjectManagementPlan; "Project Resposibilities")
                {
                }
            }
            dataitem(ProjectTeamQualification; ProjectTeamQualification)
            {
                DataItemLink = "Project No."=field("Project No.");

                column(TeamMemberName_ProjectTeamQualification; "Team Member Name")
                {
                }
                column(EmpNo_ProjectTeamQualification; "Emp No.")
                {
                }
                column(Qualification_ProjectTeamQualification; Qualification)
                {
                }
            }
            dataitem("Document Attachment"; "Document Attachment")
            {
                DataItemLink = "No."=field("Project No.");

                column(FileName_RecordLinks; "File Name")
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
    var TitlePage: Label 'Title page';
    CompanyInfo: Record "Company Information";
    AbstractLable: Label 'Abstract';
    StatementLabel: Label 'Statement of need';
    ProjectDesign: Label 'Project design';
    ManagementPlanLabel: Label 'Management plan';
    PurposeLabel: Label 'Statement of purpose';
    EvaluationPlanLabel: Label 'Evaluation plan';
    DisseminationPlanLabel: Label 'Dissemination plan';
    ProjectTeamLabel: Label 'Project team - Qualifications';
    BudgetLabel: Label 'Budget';
    SustainabilityLabel: Label 'Sustainability plan';
    AttachmentsLabel: Label 'Attachments';
}

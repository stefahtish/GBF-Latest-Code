report 50386 "ERM Process Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ERMProcessReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Risk Header"; "Risk Header")
        {
            RequestFilterFields = "No.";

            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyAddr; CompanyInfo.Address)
            {
            }
            column(CompanyCIty; CompanyInfo.City)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(No_RiskHeader; "Risk Header"."No.")
            {
            }
            column(DateCreated_RiskHeader; "Risk Header"."Date Created")
            {
            }
            column(CreatedBy_RiskHeader; "Risk Header"."Created By")
            {
            }
            column(EmployeeNo_RiskHeader; "Risk Header"."Employee No.")
            {
            }
            column(EmployeeName_RiskHeader; "Risk Header"."Employee Name")
            {
            }
            column(RiskDescription_RiskHeader; RiskNotesText)
            {
            }
            column(DocumentStatus_RiskHeader; "Risk Header"."Document Status")
            {
            }
            column(NoSeries_RiskHeader; "Risk Header"."No. Series")
            {
            }
            column(DateIdentified_RiskHeader; "Risk Header"."Date Identified")
            {
            }
            column(RiskCategory_RiskHeader; "Risk Header"."Risk Category")
            {
            }
            column(RiskCategoryDescription_RiskHeader; "Risk Header"."Risk Category Description")
            {
            }
            column(ValueatRisk_RiskHeader; "Risk Header"."Value at Risk")
            {
            }
            column(RiskLikelihood_RiskHeader; "Risk Header"."Risk Likelihood")
            {
            }
            column(RiskImpact_RiskHeader; "Risk Header"."Risk Impact")
            {
            }
            column(RiskLikelihoodValue_RiskHeader; "Risk Header"."Risk Likelihood Value")
            {
            }
            column(RiskImpactValue_RiskHeader; "Risk Header"."Risk Impact Value")
            {
            }
            column(RiskLI_RiskHeader; "Risk Header"."Risk (L * I)")
            {
            }
            column(ControlEvaluationLikelihood_RiskHeader; "Risk Header"."Control Evaluation Likelihood")
            {
            }
            column(ControlEvaluationImpact_RiskHeader; "Risk Header"."Control Evaluation Impact")
            {
            }
            column(ResidualRiskLikelihood_RiskHeader; "Risk Header"."Residual Risk Likelihood")
            {
            }
            column(ResidualLikelihoodImpact_RiskHeader; "Risk Header"."Residual Likelihood Impact")
            {
            }
            column(ResidualRiskLI_RiskHeader; "Risk Header"."Residual Risk (L * I)")
            {
            }
            column(RiskResponse_RiskHeader; "Risk Header"."Risk Response")
            {
            }
            column(ShortcutDimension1Code_RiskHeader; "Risk Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_RiskHeader; "Risk Header"."Shortcut Dimension 2 Code")
            {
            }
            column(Status_RiskHeader; "Risk Header".Status)
            {
            }
            column(Type_RiskHeader; "Risk Header".Type)
            {
            }
            column(RiskOpportunityAssessment_RiskHeader; "Risk Header"."Risk Opportunity Assessment")
            {
            }
            column(RiskDepartment_RiskHeader; "Risk Header"."Risk Department")
            {
            }
            column(RiskDepartmentDescription_RiskHeader; "Risk Header"."Risk Department Description")
            {
            }
            column(HODUserID_RiskHeader; "Risk Header"."HOD User ID")
            {
            }
            column(RiskRegion_RiskHeader; "Risk Header"."Risk Region")
            {
            }
            column(RiskRegionName_RiskHeader; "Risk Header"."Risk Region Name")
            {
            }
            column(ProjectCode_RiskHeader; "Risk Header"."Project Code")
            {
            }
            column(ReviewDate_RiskHeader; "Risk Header"."Review Date")
            {
            }
            column(AssessmentDate_RiskHeader; "Risk Header"."Assessment Date")
            {
            }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Risk Description");
                "Risk Description".CreateInStream(Instr);
                RiskNote.Read(Instr);
                RiskNotesText := Format(RiskNote);
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        RiskNote: BigText;
        RiskNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
}

report 50380 "Risk Assessment List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RiskAssessmentList.rdl';
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
            column(Control_Risk__RiskHeader; "Risk Header"."Control Risk (L * I)")
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
            dataitem("Risk Line"; "Risk Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", Type, "Line No.") ORDER(Ascending);

                column(DocumentNo_RiskLine; "Risk Line"."Document No.")
                {
                }
                column(Type_RiskLine; "Risk Line".Type)
                {
                }
                column(LineNo_RiskLine; "Risk Line"."Line No.")
                {
                }
                column(Description_RiskLine; "Risk Line".Description)
                {
                }
                column(Target_RiskLine; "Risk Line".Target)
                {
                }
                column(Tolerance_RiskLine; "Risk Line".Tolerance)
                {
                }
                column(Appetite_RiskLine; "Risk Line".Appetite)
                {
                }
                column(DateofCompletion_RiskLine; "Risk Line"."Date of Completion")
                {
                }
                column(MitigationActions_RiskLine; "Risk Line"."Mitigation Actions")
                {
                }
                column(MitigationOwner_RiskLine; "Risk Line"."Mitigation Owner")
                {
                }
                column(Timelines_RiskLine; "Risk Line".Timelines)
                {
                }
                column(MitigationStatus_RiskLine; "Risk Line"."Mitigation Status")
                {
                }
                column(Comments_RiskLine; "Risk Line".Comments)
                {
                }
                column(KRIsStatus_RiskLine; "Risk Line"."KRI(s) Status")
                {
                }
                column(UpdateFrequency_RiskLine; "Risk Line"."Update Frequency")
                {
                }
                column(RiskCategory_RiskLine; "Risk Line"."Risk Category")
                {
                }
                column(RiskCategoryDescription_RiskLine; "Risk Line"."Risk Category Description")
                {
                }
                column(RiskOpportunityAssessment_RiskLine; "Risk Line"."Risk Opportunity Assessment")
                {
                }
                column(METype_RiskLine; "Risk Line"."M & E Type")
                {
                }
                column(MELineNo_RiskLine; "Risk Line"."ME Line No.")
                {
                }
                column(UpdateDate_RiskLine; "Risk Line"."Update Date")
                {
                }
                column(UpdateStopped_RiskLine; "Risk Line"."Update Stopped")
                {
                }
                column(Select_RiskLine; "Risk Line".Select)
                {
                }
                column(SendtoRegister_RiskLine; "Risk Line"."Send to Register")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    case "Risk Line".Type of
                        "Risk Line".Type::"Risk Category":
                            if "Risk Line".Description = '' then
                                "Risk Line".Description := "Risk Line"."Risk Category Description";
                    end;
                end;
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
        RiskCategory: Text;
}

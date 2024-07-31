report 50379 "Risk Identification"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RiskIdentification.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Risk Header"; "Risk Header")
        {
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
            column(No_; "Risk Header"."No.")
            {
            }
            column(EmployeeName; "Risk Header"."Employee Name")
            {
            }
            column(Risk_Description; RiskNotesText)
            {
            }
            column(DateIdentified; "Risk Header"."Date Identified")
            {
            }
            column(CreatedBy; "Risk Header"."Created By")
            {
            }
            column(DateCreated; "Risk Header"."Date Created")
            {
            }
            column(Risk_Impact; "Risk Impact")
            {
            }
            column(Residual_Risk_Impact; "Residual Risk Impact")
            {
            }
            column(Residual_Risk_Likelihood_Cat; "Residual Risk Likelihood Cat")
            {
            }
            column(Risk_Acceptance_Decision; "Risk Acceptance Decision")
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

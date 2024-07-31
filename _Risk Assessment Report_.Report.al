report 50378 "Risk Assessment Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RiskAssessmentReport.rdl';
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
            column(No; "Risk Header"."No.")
            {
            }
            column(DateCreated; "Risk Header"."Date Created")
            {
            }
            column(CreatedBy; "Risk Header"."Created By")
            {
            }
            column(EmployeeNo; "Risk Header"."Employee No.")
            {
            }
            column(EmployeeName; "Risk Header"."Employee Name")
            {
            }
            column(RiskDescription; RiskNotesText)
            {
            }
            column(Risk_Department; "Risk Department")
            {
            }
            column(Risk_Region_Name; "Risk Region Name")
            {
            }
            column(Status; Status)
            {
            }
            column(DateIdentified; "Risk Header"."Date Identified")
            {
            }
            column(RiskType; "Risk Header".Type)
            {
            }
            column(ValueatRisk; "Risk Header"."Value at Risk")
            {
            }
            column(Risk_Probability; "Risk Probability")
            {
            }
            column(RiskLikelihood; "Risk Header"."Risk Likelihood")
            {
            }
            column(Risk_Likelihood_Value; "Risk Likelihood Value")
            {
            }
            column(Risk_Impact; "Risk Impact")
            {
            }
            column(RiskLikelihoodValue; "Risk Header"."Risk Likelihood Value")
            {
            }
            column(RiskImpactValue; "Risk Header"."Risk Impact Value")
            {
            }
            column(RiskL_I; "Risk Header"."Risk (L * I)")
            {
            }
            column(RAG_Status; "RAG Status")
            {
            }
            column(Linked_Incident_Description; "Linked Incident Description")
            {
            }
            column(Control_Risk_Impact; "Control Risk Impact")
            {
            }
            column(Control_Risk_Probability; "Control Risk Probability")
            {
            }
            column(ControlEvaluationImpact; "Risk Header"."Control Evaluation Impact")
            {
            }
            column(Control_Risk_Likelihood; "Control Risk Likelihood")
            {
            }
            column(ControlEvaluationLikelihood; "Risk Header"."Control Evaluation Likelihood")
            {
            }
            column(Value_after_Control; "Value after Control")
            {
            }
            column(Control_Risk__L___I_; "Control Risk (L * I)")
            {
            }
            column(Control_RAG_Status; "Control RAG Status")
            {
            }
            column(Residual_Value; "Residual Value")
            {
            }
            column(ResidualRiskLikelihood; "Risk Header"."Residual Risk Likelihood")
            {
            }
            column(ResidualLikelihoodImpact; "Risk Header"."Residual Likelihood Impact")
            {
            }
            column(ResidualRiskL_I; "Risk Header"."Residual Risk (L * I)")
            {
            }
            column(Residual_RAG_Status; "Residual RAG Status")
            {
            }
            column(Risk_Category; "Risk Category")
            {
            }
            column(Risk_Category_Description; "Risk Category Description")
            {
            }
            column(RiskCategory; RiskCategory)
            {
            }
            column(RiskCause; GetRiskCause("Risk Header"."No."))
            {
            }
            column(RiskMitigation; GetRiskMitigation("Risk Header"."No."))
            {
            }
            dataitem("Risk Line"; "Risk Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where(Type = CONST("KRI(s)"));

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
        i: Integer;
        j: Integer;

    local procedure GetRiskCause(DocNo: Code[50]): Text
    var
        RiskLine: Record "Risk Line";
        RiskHeader: Record "Risk Header";
        Cause: array[50] of Text;
        Causes: Text;
    begin
        if RiskHeader.Get(DocNo) then begin
            i := 0;
            RiskLine.Reset;
            RiskLine.SetRange("Document No.", RiskHeader."No.");
            RiskLine.SetRange(Type, RiskLine.Type::Drivers);
            if RiskLine.Find('-') then begin
                repeat
                    i := i + 1;
                    Cause[i] := RiskLine.Description;
                until RiskLine.Next = 0;
                for j := 1 to i do begin
                    if j = 1 then
                        Causes := Cause[j]
                    else
                        Causes := Causes + '/' + Cause[j];
                end;
            end;
        end;
        exit(Causes);
    end;

    local procedure GetRiskMitigation(DocNo: Code[50]): Text
    var
        RiskLine: Record "Risk Line";
        RiskHeader: Record "Risk Header";
        Mitigation: array[50] of Text;
        Mitigations: Text;
    begin
        if RiskHeader.Get(DocNo) then begin
            i := 0;
            RiskLine.Reset;
            RiskLine.SetRange("Document No.", RiskHeader."No.");
            RiskLine.SetRange(Type, RiskLine.Type::"Mitigation Proposal");
            if RiskLine.Find('-') then begin
                repeat
                    i := i + 1;
                    Mitigation[i] := RiskLine.Description;
                until RiskLine.Next = 0;
                for j := 1 to i do begin
                    if j = 1 then
                        Mitigations := Mitigation[j]
                    else
                        Mitigations := Mitigations + '/' + Mitigation[j];
                end;
            end;
        end;
        exit(Mitigations);
    end;
}

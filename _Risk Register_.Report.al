report 50366 "Risk Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RiskRegister.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Risk Register"; "Risk Register")
        {
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompLogo; CompanyInfo.Picture)
            {
            }
            column(EntryNo_RiskRegister; "Risk Register"."Entry No.")
            {
            }
            column(DocumentNo_RiskRegister; "Risk Register".Type)
            {
            }
            column(Objective_RiskRegister; "Risk Register".Category)
            {
            }
            column(Risk_RiskRegister; "Risk Register"."Value at Risk")
            {
            }
            column(Drivers_RiskRegister; "Risk Register"."Value at Risk Amount")
            {
            }
            column(KRIs_RiskRegister; "Risk Register"."Gross (L*I)")
            {
            }
            column(Effect_RiskRegister; "Risk Register"."Existing Control / Mitigation")
            {
            }
            column(ValueatRiskAmount_RiskRegister; "Risk Register"."Residual (L*I)")
            {
            }
            column(Category_RiskRegister; "Risk Register"."KRI(s) Description")
            {
            }
            column(Likelihood_RiskRegister; "Risk Register"."Mitigation Action")
            {
            }
            column(Impact_RiskRegister; "Risk Register"."Mitigation Owner")
            {
            }
            column(LI_RiskRegister; "Risk Register"."KRI(s) Status")
            {
            }
            column(MitigationAction_RiskRegister; "Risk Register".Comment)
            {
            }
            column(ResidualLikelihood_RiskRegister; "Risk Register".Archive)
            {
            }
            column(ResidualImpact_RiskRegister; "Risk Register"."Document No.")
            {
            }
            column(ResidualLI_RiskRegister; "Risk Register"."Global Dimension 1 Code")
            {
            }
            column(ProposedMitigation_RiskRegister; "Risk Register"."Global Dimension 2 Code")
            {
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

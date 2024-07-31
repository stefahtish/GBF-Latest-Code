report 50377 "Risk Assessment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RiskAssessment.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Risk Header"; "Risk Header")
        {
            RequestFilterFields = "No.";

            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompAddr2; CompanyInfo."Address 2")
            {
            }
            column(CompCity; CompanyInfo.City)
            {
            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompLogo; CompanyInfo.Picture)
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(No_RiskHeader; "Risk Header"."No.")
            {
            }
            column(RiskDescription_RiskHeader; RiskNotesText)
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
            column(RiskCategory; GetRiskCategory("Risk Header"."No."))
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
            }
            trigger OnAfterGetRecord()
            begin
                //Calc Risk Description
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
        i: Integer;
        j: Integer;

    local procedure GetRiskCategory(DocNo: Code[50]): Text
    var
        RiskLine: Record "Risk Line";
        RiskHeader: Record "Risk Header";
        Category: array[50] of Text;
        Categories: Text;
    begin
        if RiskHeader.Get(DocNo) then begin
            i := 0;
            RiskLine.Reset;
            RiskLine.SetRange("Document No.", RiskHeader."No.");
            RiskLine.SetRange(Type, RiskLine.Type::"Risk Category");
            if RiskLine.Find('-') then begin
                repeat
                    i := i + 1;
                    Category[i] := RiskLine."Risk Category Description";
                until RiskLine.Next = 0;
                for j := 1 to i do begin
                    if j = 1 then
                        Categories := Category[j]
                    else
                        Categories := Categories + '/' + Category[j];
                end;
            end;
        end;
        exit(Categories);
    end;

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

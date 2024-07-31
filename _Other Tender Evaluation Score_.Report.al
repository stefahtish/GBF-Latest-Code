report 50467 "Other Tender Evaluation Score"
{
    DefaultLayout = RDLC;
    Caption = 'Pass/Fail';
    RDLCLayout = './OtherTenderEvaluationScores.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(TenderCommittees; "Tender Committees")
        {
            column(AppointmentNo; "Appointment No")
            {
            }
            column(CommitteeID; "Committee ID")
            {
            }
            column(CommitteeName; "Committee Name")
            {
            }
            column(CreationDate; "Creation Date")
            {
            }
            column(TenderQuotationNo; "Tender/Quotation No")
            {
            }
            column(Title; Title)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompPic; CompanyInfo.Picture)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(Companycity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompCountry; CompanyInfo."Country/Region Code")
            {
            }
            dataitem("Supplier Evaluation Header"; "Supplier Evaluation Header")
            {
                DataItemLink = "Committee No." = field("Appointment No");

                column(No_; "No.")
                {
                }
                column(Quote_No; "Quote No")
                {
                }
                column(Total_Score; "Total Score")
                {
                }
                column(User; User)
                {
                }
                dataitem("Supplier Evaluation Score"; "Supplier Evaluation Score")
                {
                    DataItemLink = "Document No." = field("No.");

                    column(Score_Parameter; "Score Parameter")
                    {
                    }
                    column(Score_DescriptionHeader; "Score Description")
                    {
                    }
                    column(Supplier_Code; "Supplier Code")
                    {
                    }
                    column(Supplier_Name; GetSupplierName("Supplier Code"))
                    {
                    }
                    column(Total_ScoreHeader; "Total Score")
                    {
                    }
                    column(BlobDescription; DescTxt)
                    {
                    }
                    dataitem("Supplier Evaluation Score Line"; "Supplier Evaluation Score Line")
                    {
                        DataItemLink = "Document No." = field("Document No."), "Supplier Code" = field("Supplier Code"), "Score Parameter" = field("Score Parameter");

                        column(Score_DescriptionLine; ScoreDescTxt)
                        {
                        }
                        column(Score; Score)
                        {
                        }
                        column(Y_N; "Y/N")
                        {
                        }
                        column(Maximum_Score; "Maximum Score")
                        {
                        }
                        column(PassFail_SupplierEvaluationScoreLine; "Pass/Fail")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            PurchSetup.Get();
                            ScoreSetupLines.reset;
                            ScoreSetupLines.SetRange(Code, "Supplier Evaluation Score Line"."Score Parameter");
                            ScoreSetupLines.SetRange("Line No.", "Supplier Evaluation Score Line"."Line No.");
                            if ScoreSetupLines.FindFirst then begin
                                ScoreSetupLines.CalcFields(Description);
                                ScoreSetupLines.Description.CreateInStream(ScoreInstrm);
                                ScoreDescBigTxt.Read(ScoreInstrm);
                                ScoreDescTxt := Format(ScoreDescBigTxt);
                            end;
                            QuoteLines.Reset;
                            QuoteLines.SetRange("Quote No", "Supplier Evaluation Header"."Quote No");
                            QuoteLines.SetRange("Vendor No", "Supplier Evaluation Score Line"."Supplier Code");
                            QuoteLines.SetFilter(Amount, '>%1', 0);
                            if QuoteLines.Find('-') then begin
                                QuoteLines.CalcFields("Min Value");
                                LeastAmount := QuoteLines."Min Value";
                                //total financial score = leastamount divided by the amount by the financial percentage
                                TotalFinancialScore := Round(LeastAmount / QuoteLines.Amount * PurchSetup."Financial Percentage", 1);
                                TotalScore := TotalFinancialScore + TotalTechnicalScore;
                            end;
                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        SupScoreSetup.Reset();
                        SupScoreSetup.SetRange(Code, "Supplier Evaluation Score"."Score Parameter");
                        if SupScoreSetup.FindFirst() then begin
                            SupScoreSetup.CalcFields(Description);
                            SupScoreSetup.Description.CreateInStream(Instrm);
                            DescBigTxt.Read(Instrm);
                            DescTxt := Format(DescBigTxt);
                        end;
                        /*"Supplier Evaluation Score".CalcFields(Description);
                            "Supplier Evaluation Score".Description.CreateInStream(Instrm);
                            DescBigTxt.Read(Instrm);
                            DescTxt := Format(DescBigTxt);*/
                    end;
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
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        ProspectRec: Record "Prospective Suppliers";
        Instrm: InStream;
        Outstrm: OutStream;
        DescBigTxt: BigText;
        LeastAmount: Decimal;
        DescTxt: Text;
        SupScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLines: Record "Supplier Evaluation Setup Line";
        ScoreInstrm: InStream;
        ScoreOutstrm: OutStream;
        ScoreDescBigTxt: BigText;
        ScoreDescTxt: Text;
        TotalScore: Decimal;
        TotalFinancialScore: Decimal;
        TotalTechnicalScore: Decimal;
        PurchSetup: Record "Purchases & Payables Setup";
        QuoteLines: Record "RFP Evaluation Line";
        CompanyInfo: Record "Company Information";

    local procedure GetSupplierName(SupplierCode: Code[50]): Text
    begin
        if ProspectRec.get(SupplierCode) then exit(ProspectRec.Name);
    end;
}

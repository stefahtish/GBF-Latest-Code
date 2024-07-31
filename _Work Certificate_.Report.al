report 50353 "Work Certificate"
{
    DefaultLayout = RDLC;
    RDLCLayout = './WorkCertificate.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Contract_Work; Contract_Work)
        {
            RequestFilterFields = "Contract No.", "IPC No.";

            column(ContractNo_; Contract_Work."Contract No.")
            {
            }
            column(PreviousGrossworkdoneDate_; Contract_Work."Previous Gross work done Date")
            {
            }
            column(PreviousGrossworkdone_; Contract_Work."Previous Gross work done")
            {
            }
            column(PresentGrossworkdoneDate_; Contract_Work."Present Gross work done Date")
            {
            }
            column(PresentGrossworkdone_; Contract_Work."Present Gross work done")
            {
            }
            column(CummulativeGrossworkdone_; Contract_Work."Cummulative Gross work done")
            {
            }
            column(Materialonsite_; Contract_Work."Material on site")
            {
            }
            column(V75Materialonsite_; Contract_Work."75% Material on site")
            {
            }
            column(Daywork_; Contract_Work.Daywork)
            {
            }
            column(VariationOrders_; Contract_Work."Variation Orders")
            {
            }
            column(Claims_; Contract_Work.Claims)
            {
            }
            column(PriceAdjustment_; Contract_Work."Price Adjustment")
            {
            }
            column(PriceAdjForeign_; Contract_Work."Price Adj Foreign")
            {
            }
            column(PriceAdjLocal_; Contract_Work."Price Adj Local")
            {
            }
            column(InterestonLatePayment_; Contract_Work."Interest on Late Payment")
            {
            }
            column(DescriptionTotal_; Contract_Work."Description Total")
            {
            }
            column(PrevRetationAt10_; Contract_Work."Prev Retation At 10%")
            {
            }
            column(presentRetationAt10_; Contract_Work."present Retation At 10%")
            {
            }
            column(CummulativeRetationAt10_; Contract_Work."Cummulative Retation At 10%")
            {
            }
            column(RetationTotal_; Contract_Work."Retation Total")
            {
            }
            column(RecoveryAdvancePayment_; Contract_Work."Recovery Advance Payment")
            {
            }
            column(PrevRecoveryAdvancePayment_; Contract_Work."Prev Recovery Advance Payment")
            {
            }
            column(PrecRecoveryAdvancePayment_; Contract_Work."Prec Recovery Advance Payment")
            {
            }
            column(TotalRecoveryAdvancePayment_; Contract_Work."Total Recovery Advance Payment")
            {
            }
            column(BalanceofRecAdvancePayment_; Contract_Work."Balance of Rec Advance Payment")
            {
            }
            column(CummulativeNetDue_; Contract_Work."Cummulative Net Due")
            {
            }
            column(LastCertificateNo_; Contract_Work."Last Certificate No.")
            {
            }
            column(PrevPaymentonLastCert_; Contract_Work."Prev Payment on Last Cert")
            {
            }
            column(NetDuetoContractor_; Contract_Work."Net Due to Contractor")
            {
            }
            column(Relaeseof50Retation_; Contract_Work."Relaese of 50% Retation")
            {
            }
            column(TotalDueincVAT_; Contract_Work."Total Due inc(VAT)")
            {
            }
            column(Cpic; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(IPCNo_; Contract_Work."IPC No.")
            {
            }
            dataitem(Contract; Contract1)
            {
                DataItemLink = "Contract No." = FIELD("Contract No.");
                RequestFilterFields = "Contract No.", "IPC No.";

                column(ContractName; Contract."Contract Name")
                {
                }
                column(ContractCategory; Contract."Contract Category")
                {
                }
                column(ProjectManager; Contract."Project Manager")
                {
                }
                column(Status; Contract.Status)
                {
                }
                column(Dateofcommencement; Contract."Date of commencement")
                {
                }
                column(DateofCompletion; Contract."Date of Completion")
                {
                }
                column(Tenderno; Contract."Tender no.")
                {
                }
                column(ContractorName; Contract."Contractor Name")
                {
                }
                column(Client; Contract.Client)
                {
                }
                column(IPCNo1; Contract."IPC No.")
                {
                }
                column(OriginalContractPrice; Contract."Original Contract Price")
                {
                }
                column(RevisedPrice; Contract."Revised Price")
                {
                }
                column(ContractorAddress; Contract."Contractor Address")
                {
                }
                column(ContractValue_; Contract."Contract Value")
                {
                }
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
        workContr: Record Contract_Work;
}

report 50352 "Consultant Certificate"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ConsultantCertificate.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Contract; Contract1)
        {
            RequestFilterFields = "Contract No.", "IPC No.";

            column(DateofCertificate; Contract."Date of Certificate")
            {
            }
            column(ContractNo; Contract."Contract No.")
            {
            }
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
            column(OriginalContractPrice; Contract."Original Contract Price")
            {
            }
            column(ContractorName; Contract."Contractor Name")
            {
            }
            column(AmountPaid; Contract."Amount Paid")
            {
            }
            column(CreatedBy; Contract."Created By")
            {
            }
            column(ProgressofWork; Contract."Progress of Work")
            {
            }
            column(Client; Contract.Client)
            {
            }
            column(ContractValue; Contract."Contract Value")
            {
            }
            column(TitleOfAssignment; Contract."Title Of Assignment")
            {
            }
            column(TotalContractAmount_; Contract."Total Contract Amount")
            {
            }
            column(TotalDelivarableAmount_; Contract."Total Delivarable Amount")
            {
            }
            column(PaidAmount; PaidAmount)
            {
            }
            column(TotalApproxofprovSum_; Contract."Total Approx of prov Sum")
            {
            }
            column(TotalPaidAmount_; Contract.TotalPaidAmount)
            {
            }
            column(Amount_To_Text; NumberText[1])
            {
            }
            column(Status_Con; Contract.Status)
            {
            }
            column(CreatedBy_; Contract."Created By")
            {
            }
            column(IPCNo_; Contract."IPC No.")
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(CPicture; CompanyInfo.Picture)
            {
            }
            column(ProvisionalSum; Contract."Provisional Sum")
            {
            }
            dataitem("Cert_Contract Amount"; "Cert_Contract Amount")
            {
                DataItemLink = "Conract No." = FIELD("Contract No.");
                RequestFilterFields = "Conract No.";

                column(No_1; "Cert_Contract Amount"."No.")
                {
                }
                column(Delivarable_1; "Cert_Contract Amount".Delivarable)
                {
                }
                column(Status_1; "Cert_Contract Amount".Status)
                {
                }
                column(Amount_1; "Cert_Contract Amount".Amount)
                {
                }
            }
            dataitem(Cert_Delivarable; Cert_Delivarable)
            {
                DataItemLink = "Conract No." = FIELD("Contract No.");

                column(No_2; Cert_Delivarable."No.")
                {
                }
                column(Delivarable_2; Cert_Delivarable.Delivarable)
                {
                }
                column(Status_2; Cert_Delivarable.Status)
                {
                }
                column(Amount_2; Cert_Delivarable.Amount)
                {
                }
                column(TotalAmountPaid_2; Cert_Delivarable."Total Amount Paid")
                {
                }
            }
            dataitem("Cert_Provi Sum"; "Cert_Provi Sum")
            {
                DataItemLink = "Conract No." = FIELD("Contract No.");

                column(No_3; "Cert_Provi Sum"."No.")
                {
                }
                column(Delivarable_3; "Cert_Provi Sum".Delivarable)
                {
                }
                column(Status_3; "Cert_Provi Sum".Status)
                {
                }
                column(Amount_3; "Cert_Provi Sum".Amount)
                {
                }
            }
            dataitem("Payment Schedule"; "Payment Schedule")
            {
                DataItemLink = "Contract No." = FIELD("Contract No.");

                column(Activity_4; "Payment Schedule".Activity)
                {
                }
                column(Delivarable_4; "Payment Schedule".Delivarable)
                {
                }
                column(Status_4; "Payment Schedule".Status)
                {
                }
                column(Amount_4; "Payment Schedule".Amount)
                {
                }
                column(PaidAmount_4; "Payment Schedule"."Paid Amount")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                Contract.CalcFields("Total Delivarable Amount", TotalPaidAmount);
                AmountToText := Round(Contract."Total Delivarable Amount" - Contract.TotalPaidAmount, 0.01);
                PaymentMgt.InitTextVariable;
                PaymentMgt.FormatNoText(NumberText, AmountToText, CurrencyCodeText);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
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
    var
        CertDelivarable: Record Cert_Delivarable;
        PaidAmount: Decimal;
        AmountToText: Decimal;
        PaymentMgt: Codeunit "Payments Management";
        NumberText: array[2] of Text[80];
        CurrencyCodeText: Code[10];
        CompanyInfo: Record "Company Information";
}

report 50479 "Contract Expiry Notifications"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //ProcessingOnly = true;
    DefaultLayout = RDLC;
    RDLCLayout = './ContractExpiryNotifications.rdl';

    dataset
    {
        dataitem("Project Header"; "Project Header")
        {
            column(No_; "No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                ContractCounter+=1;
            end;
            trigger OnPreDataItem()
            begin
                Clear(EstimatedDate);
                PurchSetup.Get();
                EstimatedDate:=CalcDate(PurchSetup."Contract Notification Period", Today);
                "Project Header".SetFilter("Estimated End Date", '%1..%2', Today, EstimatedDate);
            end;
            trigger OnPostDataItem()
            var
                ContractExpiry: Report "Contract Expiry";
                PurchSet: Record "Purchases & Payables Setup";
                CompanyInfo: Record "Company Information";
                FileManagement: Codeunit "File Management";
                Employee: Record Employee;
                SenderName: Text;
                SenderAddress: Text;
                Receipient: list of[text];
                Subject: Text;
                FileName: Text;
                TimeNow: Text;
                RecipientCC: list of[text];
                Attachment: Text;
                ErrorMsg: Text;
                Body: Label 'Dear All, <br><br> This is to notify you that the following contracts are about to expire.<br><br>Please find attached a detailed report to see the details.<br><br> Kind Regards, <br><br> <Strong>%1</Strong> ';
                Instr: InStream;
                EmailSignText: Text;
                EmailSignBigText: BigText;
                TempBlobNew: Codeunit "Temp Blob";
                EmailMessage: Codeunit "Email Message";
                Email: Codeunit Email;
                EmailScenario: Enum "Email Scenario";
                FilePath: Text;
            begin
                if ContractCounter >= 1 then begin
                    PurchSet.Get();
                    if FORMAT(PurchSet."Contract Notification Period") <> '' then begin
                        Clear(ContractExpiry);
                        CompanyInfo.get;
                        CompanyInfo.CalcFields(Picture);
                        Clear(Receipient);
                        PurchSet.TestField("Procurement Email");
                        CompanyInfo.Get;
                        CompanyInfo.TestField(Name);
                        CompanyInfo.TestField("E-Mail");
                        SenderName:=CompanyInfo.Name;
                        SenderAddress:=CompanyInfo."E-Mail";
                        Receipient.Add(PurchSet."Procurement Email");
                        Subject:='Contract Expiry';
                        EmailMessage.Create(Receipient, Subject, StrSubstNo((Body), SenderName), true);
                        Clear(Instr);
                        FileName:='ContractExpiry-' + Format(System.Random(10000)) + '.pdf';
                        FilePath:=PurchSet."Re-order Path" + '\' + FileName;
                        ContractExpiry.SetTableView("Project Header");
                        /* eddie if not Exists(FilePath) then
                            ContractExpiry.SaveAsPdf(FilePath);

                        FileManagement.BLOBImportFromServerFile(TempBlobNew, FilePath);*/
                        TempBlobNew.CreateInStream(Instr);
                        EmailMessage.AddAttachment(FileName, 'PDF', Instr);
                        Email.Send(EmailMessage, EmailScenario::Default);
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
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
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var PurchSetup: Record "Purchases & Payables Setup";
    EstimatedDate: Date;
    ContractCounter: Integer;
}

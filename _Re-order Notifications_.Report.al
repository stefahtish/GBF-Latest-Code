report 50476 "Re-order Notifications"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //ProcessingOnly = true;
    DefaultLayout = RDLC;
    RDLCLayout = './ReorderNotify.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            column(No_; "No.")
            {
            }
            trigger OnAfterGetRecord()
            var
            begin
                Item.CalcFields(Inventory);
                if Inventory > "Reorder Point" then CurrReport.Skip();
                ItemCount+=1;
            end;
            trigger OnPreDataItem()
            begin
                Item.SetFilter("Reorder Point", '<>%1', 0);
                Item.SetFilter(Type, '%1', Item.Type::Inventory);
            end;
            trigger OnPostDataItem()
            var
                StoresRept: Report "Stock Report";
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
                Body: Label 'Dear All, <br><br> This is to notify you that the following items need replenishment.<br><br>Please find attached a detailed report to see the details.<br><br> Kind Regards, <br><br> <Strong>%1</Strong> ';
                Instr: InStream;
                EmailSignText: Text;
                EmailSignBigText: BigText;
                TempBlobNew: Codeunit "Temp Blob";
                EmailMessage: Codeunit "Email Message";
                Email: Codeunit Email;
                EmailScenario: Enum "Email Scenario";
                FilePath: Text;
            begin
                PurchSet.Get();
                if PurchSet."Send Re-Order Notifications" then begin
                    Clear(StoresRept);
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
                    Subject:='Item Replenishment';
                    EmailMessage.Create(Receipient, Subject, StrSubstNo((Body), SenderName), true);
                    Clear(Instr);
                    FileName:='StockReport-' + Format(System.Random(10000)) + '.pdf';
                    FilePath:=PurchSet."Re-order Path" + '\' + FileName;
                    StoresRept.SetTableView(Item);
                    /* eddie if not Exists(FilePath) then
                        StoresRept.SaveAsPdf(FilePath);

                    FileManagement.BLOBImportFromServerFile(TempBlobNew, FilePath);*/
                    TempBlobNew.CreateInStream(Instr);
                    EmailMessage.AddAttachment(FileName, 'PDF', Instr);
                    Email.Send(EmailMessage, EmailScenario::Default);
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
    var ItemCount: Integer;
}

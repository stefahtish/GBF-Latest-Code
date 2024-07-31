report 50481 "Send Project Notifications"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(PMWorkPlan; PMWorkPlan)
        {
            column(Phase; Phase)
            {
            }
            column(Deliverable; Deliverable)
            {
            }
            column(Collection_Date; "Collection Date")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Responsible_Person; "Responsible Person")
            {
            }
            column(Project_No_; "Project No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                ItemCount+=1;
                ProjectIdentRec.Reset();
                ProjectIdentRec.SetRange("Project No.", "Project No.");
                if ProjectIdentRec.FindFirst()then begin
                    StartDate:=ProjectIdentRec."Project Start Date";
                    EndDate:=ProjectIdentRec."Project End Date";
                    ProjectBudget:=ProjectIdentRec."Project Estimated Cost";
                    ProjectName:=ProjectIdentRec."Project Name";
                end;
                if not ProjectIdentRec."Under Implementation" then CurrReport.Skip();
            end;
            trigger OnPreDataItem()
            begin
                NotifyDate:=CalcDate('1W', Today);
                PMWorkPlan.SetFilter("Notification Sent", '%1', false);
                PMWorkPlan.SetFilter("Collection Date", '%1..%2', Today, NotifyDate);
            end;
            trigger OnPostDataItem()
            var
                PRJTRept: Report "Project Mgt. Notifications";
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
                Body: Label 'Dear All, <br><br> This is to notify you that the following projects have billable deliverables which require invoicing.<br><br>Please find attached a detailed report to see the details.<br><br> Kind Regards, <br><br> <Strong>%1</Strong> ';
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
                    Clear(PRJTRept);
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
                    Subject:='Billable Projects';
                    EmailMessage.Create(Receipient, Subject, StrSubstNo((Body), SenderName), true);
                    Clear(Instr);
                    FileName:='ProjectBillableRept-' + Format(System.Random(10000)) + '.pdf';
                    FilePath:=PurchSet."Re-order Path" + '\' + FileName;
                    PRJTRept.SetTableView(PMWorkPlan);
                    /*eddie  if not Exists(FilePath) then
                        PRJTRept.SaveAsPdf(FilePath);

                    FileManagement.BLOBImportFromServerFile(TempBlobNew, FilePath);*/
                    TempBlobNew.CreateInStream(Instr);
                    EmailMessage.AddAttachment(FileName, 'PDF', Instr);
                    if ItemCount > 0 then Email.Send(EmailMessage, EmailScenario::Default);
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
    var NotifyDate: Date;
    ItemCount: Integer;
    ProjectIdentRec: Record ProjectIdentification;
    ProjectName: Text;
    ProjectBudget: Decimal;
    StartDate: Date;
    EndDate: Date;
    Qualifies: Boolean;
}

report 50293 ContractJobQueue
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(EmployeeContracts; "Employee Contracts")
        {
            trigger OnAfterGetRecord()
            var
                HRSetup: Record "Human Resources Setup";
                DateDue: Date;
                LineNo: Integer;
                Generated: Boolean;
                PayrollPeriod: Date;
                CompanyInfo: Record "Company Information";
                SMTP: Codeunit "email message";
                email: Codeunit email;
                //SMTPSetup: Record "SMTP Mail Setup";
                SenderName: Text;
                SenderAddress: Text;
                Receipient: List of [Text];
                Subject: Text;
                FileName: Text;
                TimeNow: Text;
                ReceipientCC: List of [Text];
                Attachment: Text;
                ErrorMsg: Text;
                NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt"></b></p><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that the contract of:   <Strong> %1 </Strong>-<Strong> will be coming to an end on %2.';
                MailSuccess: Label 'Employees have been notified successfully.';
                NoOfRecipients: Integer;
                EMpRec: Record Employee;
                EmpEmail: Text;
            begin
                HRSetup.Get;
                HRSetup.TestField("Human Resource Emails");
                HRSetup.TestField("Contract Notification Days");
                DateDue := CalcDate(HRSetup."Contract Notification Days", Today);
                EmployeeContracts.Reset;
                EmployeeContracts.SetFilter("End Date", '=%1', DateDue);
                EmployeeContracts.SetRange(Notified, true);
                if EmployeeContracts.Find('-') then
                    repeat
                        CompanyInfo.Get;
                        CompanyInfo.TestField(Name);
                        CompanyInfo.TestField("E-Mail");
                        SenderName := CompanyInfo.Name;
                        SenderAddress := CompanyInfo."E-Mail";
                        EMpRec.Reset();
                        If EMpRec.Get(EmployeeContracts."Employee No") then begin
                            EmpEmail := EMpRec."Company E-Mail";
                        end;
                        Receipient.Add(EmpEmail);
                        ReceipientCC.Add(HRSetup."Human Resource Emails");
                        Subject := 'Contract End Notification';
                        TimeNow := Format(Time);
                        SMTP.Create(Receipient, Subject, '', true);
                        SMTP.AppendtoBody(StrSubstNo(NewBody, EmployeeContracts."Employee Name", EmployeeContracts."End Date"));
                        NoOfRecipients := ReceipientCC.Count;
                        if NoOfRecipients > 0 then //SMTP.AddCC(ReceipientCC);
                            email.Send(SMTP);
                        EmployeeContracts.Notified := true;
                        EmployeeContracts.Modify();
                    until EmployeeContracts.Next() = 0;
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
}

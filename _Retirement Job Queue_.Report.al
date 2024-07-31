report 50458 "Retirement Job Queue"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(EmpRec; "Employee")
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
                SenderName: Text;
                SenderAddress: Text;
                Receipient: List of [Text];
                Subject: Text;
                FileName: Text;
                TimeNow: Text;
                RecipientCC: List of [Text];
                Attachment: Text;
                ErrorMsg: Text;
                NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt"></b></p><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that the date of retirement is due in a year.';
                MailSuccess: Label 'Employees have been notified successfully.';
                NoOfRecipients: Integer;
            begin
                HRSetup.Get;
                HRSetup.TestField("Human Resource Emails");
                DateDue := CalcDate('-1Y', Today);
                EmpRec.Reset;
                EmpRec.SetRange("Employment Status", EmpRec."Employment Status"::Active);
                EmpRec.SetFilter("Retirement Date", '..%1', DateDue);
                if EmpRec.Find('-') then
                    repeat
                        CompanyInfo.Get;
                        CompanyInfo.TestField(Name);
                        CompanyInfo.TestField("E-Mail");
                        SenderName := CompanyInfo.Name;
                        SenderAddress := CompanyInfo."E-Mail";
                        Receipient.Add(EmpRec."Company E-Mail");
                        Subject := 'Retirement Date Notification';
                        TimeNow := Format(Time);
                        SMTP.Create(Receipient, Subject, '', true);
                        SMTP.AppendtoBody(StrSubstNo(NewBody, EmpRec."First Name", EmpRec."End Date"));
                        NoOfRecipients := RecipientCC.Count;
                        if NoOfRecipients > 0 then //eddieSMTP.AddCC(RecipientCC);
                            email.Send(SMTP);
                    until EmpRec.Next() = 0;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetRange("Employment Status", EmpRec."Employment Status"::Active);
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

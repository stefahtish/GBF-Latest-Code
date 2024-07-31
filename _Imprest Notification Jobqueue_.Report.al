report 50469 "Imprest Notification Jobqueue"
{
    Caption = 'Imprest Notification Job Queue';
    ApplicationArea = All;

    dataset
    {
        dataitem(Payments; Payments)
        {
            DataItemTableView = where(Posted = const(true), Status = const(Released), "Payment Type" = const(Imprest));

            trigger OnAfterGetRecord()
            var
                CashSetup: Record "Cash Management Setups";
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
                HRSetup: Record "Human Resources Setup";
                ErrorMsg: Text;
                NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt"></b></p><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that your imprest of %1 is due on %2. Reference No. %3';
                MailSuccess: Label 'Employees have been notified successfully.';
                NoOfRecipients: Integer;
            begin
                CashSetup.Get;
                CashSetup.TestField("Finance Email");
                HRSetup.Get;
                HRSetup.TestField("Imprest Notification Days");
                DateDue := CalcDate(format(HRSetup."Imprest Notification Days"), Today);
                EmpRec.Reset();
                EmpRec.SetRange("No.", Payments."Staff No.");
                If EmpRec.FindFirst() then begin
                    StaffEmail := EmpRec."Company E-Mail";
                end;
                PaymentRec.Reset;
                PaymentRec.SetFilter("Due Date", '=%1', DateDue);
                if PaymentRec.Find('-') then
                    repeat
                        PaymentRec.CalcFields("Total Amount");
                        CompanyInfo.Get;
                        CompanyInfo.TestField(Name);
                        CompanyInfo.TestField("E-Mail");
                        SenderName := CompanyInfo.Name;
                        SenderAddress := CashSetup."Finance EMail";
                        Receipient.Add(StaffEmail);
                        Subject := 'Imprest Due Date Notification';
                        TimeNow := Format(Time);
                        SMTP.Create(Receipient, Subject, '', TRUE);
                        SMTP.AppendTOBody(StrSubstNo(NewBody, PaymentRec."Total Amount", PaymentRec."Due Date", PaymentRec."No."));
                        NoOfRecipients := RecipientCC.Count;
                        if NoOfRecipients > 0 then //EDDIESMTP.AddCC(RecipientCC);
                            email.Send(SMTP);
                    until PaymentRec.Next() = 0;
            end;
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
    var
        PaymentRec: Record Payments;
        EmpRec: Record Employee;
        StaffEmail: Text;
}

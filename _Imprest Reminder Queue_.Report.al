report 50474 "Imprest Reminder Queue"
{
    ProcessingOnly = true;
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem(Payments; Payments)
        {
            trigger OnAfterGetRecord()
            var
                HRSetup: Record "Human Resources Setup";
                DateDue: Date;
                ImprestHeader: Record Payments;
                SMTP: Codeunit "email message";
                email: Codeunit email;
                SenderName: Text;
                SenderAddress: Text;
                Receipient: List of [Text];
                Subject: Text;
                FileName: Text;
                TimeNow: Text;
                CompanyInfo: Record "Company Information";
                RecipientCC: List of [Text];
                RecipientBCC: List of [Text];
                Employees: Record Employee;
                RecipientMail: Text[80];
                NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that your imprest<Strong> %2 </Strong>is due for surrender on <Strong> %3</Strong>. <br><br> Thank you. <br><br> Kind Regards, <br><br><Strong> %4</Strong>';
            begin
                HRSetup.Get;
                HRSetup.TestField("Imprest Notification Days");
                DateDue := CalcDate(format(HRSetup."Imprest Notification Days"), Today);
                Payments.Reset;
                Payments.SetRange("No.", Payments."No.");
                Payments.SetRange("Payment Type", Payments."Payment Type"::Imprest);
                Payments.SetFilter("Due Date", '=%1', DateDue);
                Payments.SetRange(Surrendered, false);
                Payments.SetRange(Status, Payments.Status::Released);
                if Payments.Find('-') then
                    repeat
                        Employees.Reset();
                        Employees.SetRange("No.", Payments."Staff No.");
                        if Employees.Find('-') then RecipientMail := Employees."Company E-Mail";
                        CompanyInfo.Get;
                        CompanyInfo.TestField(Name);
                        SenderAddress := CompanyInfo."E-Mail";
                        SenderName := CompanyInfo.Name;
                        Receipient.Add(RecipientMail);
                        Subject := ('Imprest No - ' + ' ' + Payments."No." + ' ' + 'Due to Surrender');
                        TimeNow := Format(Time);
                        SMTP.Create(Receipient, Subject, '', TRUE);
                        SMTP.AppendTOBody(StrSubstNo(NewBody, Payments."Account Name", Payments."No.", Payments."Due Date", SenderName));
                        email.Send(SMTP);
                    UNTIL Payments.NEXT = 0;
            end;
        }
    }
}

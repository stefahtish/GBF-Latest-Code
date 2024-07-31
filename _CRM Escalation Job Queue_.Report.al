report 50402 "CRM Escalation Job Queue"
{
    Caption = 'CRM Notifications';
    ApplicationArea = All;

    dataset
    {
        dataitem(ClientInteractionHeader; "Client Interaction Header")
        {
            DataItemTableView = where(Resolve = const(false));

            trigger OnAfterGetRecord()
            var
                NextNotification: Date;
            begin
                Timelines.Reset();
                Timelines.SetRange("Interaction Type", "Interaction Type");
                if Timelines.FindFirst() then begin
                    Escalations.Reset();
                    Escalations.SetRange("Interaction Code", "Interact Code");
                    if Escalations.FindLast() then begin
                        if Escalations."First Notification" = false then NextNotification := CalcDate(Timelines."First Notification", DT2DATE(Escalations.DateTime));
                        if Escalations."First Notification" = false then
                            NextNotification := CalcDate(Timelines."First Notification", DT2DATE(Escalations.DateTime))
                        else if Escalations."Second Notification" = false then
                            NextNotification := CalcDate(Timelines."Second Notification", DT2DATE(Escalations.DateTime))
                        else
                            NextNotification := CalcDate(Timelines."Subsequent Notifications", Escalations."Last Notification Date");
                        if Today >= NextNotification then begin
                            clear(Receipient);
                            CompanyInfo.GET;
                            CompanyInfo.TESTFIELD(Name);
                            CompanyInfo.TESTFIELD("E-Mail");
                            SenderName := CompanyInfo.Name;
                            SenderAddress := CompanyInfo."E-Mail";
                            Receipient.Add(Escalations."Escalation Email");
                            Subject := 'CRM Escalation Reminder';
                            TimeNow := FORMAT(TIME);
                            Employee.get(Escalations."Escalation Employee No.");
                            SMTP.Create(Receipient, Subject, '', TRUE);
                            SMTP.AppendtoBody(STRSUBSTNO(BodyTxt, Employee."First Name", "Interact Code", Escalations.DateTime, CompanyInfo.Name));
                            IF ReceipientCC.Count <> 0 THEN //eddie SMTP.AddCC(ReceipientCC);
                                Email.Send(SMTP);
                            if Escalations."First Notification" = false then begin
                                Escalations."First Notification" := true;
                                Escalations."Last Notification Date" := Today;
                            end
                            else if Escalations."Second Notification" = false then begin
                                Escalations."Second Notification" := true;
                                Escalations."Last Notification Date" := Today;
                            end
                            else
                                Escalations."Last Notification Date" := Today;
                            Escalations."No of Escalations" += 1;
                            Escalations.Modify();
                        end;
                    end;
                end;
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
        CompanyInfo: Record "Company Information";
        SenderName: Text;
        SenderAddress: Text;
        Name: Text[50];
        Receipient: List of [Text];
        ReceipientCC: List of [Text];
        TimeNow: Text;
        Subject: Text;
        SMTP: Codeunit "Email Message";
        Email: Codeunit Email;
        AuditSetup: Record "Audit Setup";
        Escalations: Record "Interaction Escalations";
        Timelines: Record "Interaction Timelines";
        Employee: Record Employee;
        BodyTxt: Label 'Dear %1, <br><br>This is to remind you of interaction %2 escalated to you on %3. Please look into it.<br><br>Thank you.<br><br>Regards,<br><br>%4';
}

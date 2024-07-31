codeunit 50134 "Incident Escalation"
{
    trigger OnRun()
    begin
        EscalateUnResolvedIncidences;
    end;
    procedure EscalateUnResolvedIncidences()
    var
        DueDate: Date;
        Incident: Record "User Support Incident";
    begin
        RiskSetUp.Get;
        RiskSetUp.TestField("Escalation Due Date");
        Incident.Reset();
        Incident.SetRange(Status, Incident.Status::Pending);
        If Incident.Find('-')then begin
            repeat if CalcDate(RiskSetUp."Escalation Due Date", Incident."Incident Date") >= Today then begin
                    SentEscalationMail(Incident);
                end;
            until Incident.next = 0;
        end;
    end;
    local procedure SentEscalationMail(Incident: Record "User Support Incident")
    var
        MailBody: Label 'Dear <strong>Sir/Madam</strong>, <br> This is to notify that pending incident no <strong>%1</strong>  is due and has been escalated.  <br> Kind Regards, Thank you.';
        SenderAddress: Text[100];
        CC: List of[Text];
        Emailmessage: Codeunit "Email Message";
        Subject: Label 'Pending Incident Escalation';
        CompInfo: Record "Company Information";
        SenderName: Text[50];
        Receipient: List of[Text];
    begin
        CompInfo.GET;
        RiskSetUp.Get();
        CompInfo.TestField("E-Mail");
        SenderAddress:=CompInfo."E-Mail";
        SenderName:=CompInfo.Name;
        Receipient.Add(RiskSetUp."Escalation Email");
        CC.Add(RiskSetUp."Escalation CC");
        Emailmessage.create(Receipient, Subject, '', true);
        Emailmessage.AppendtoBody(StrSubstNo(MailBody, Incident."Incident Reference"));
        if CC.Count > 0 then //eddie Emailmessage.AddCC(CC);
            if email.Send(Emailmessage)then begin
                Incident.Status:=Incident.Status::Escalated;
                Incident.Modify()end;
    end;
    var RiskSetUp: Record "Audit Setup";
    email: Codeunit Email;
}

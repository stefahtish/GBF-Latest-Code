report 50392 "Compliance Job Queue"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Audit Lines"; "Audit Lines")
        {
            trigger OnAfterGetRecord()
            begin
                //Update compliance
                IF (("Audit Lines"."Audit Line Type" = "Audit Lines"."Audit Line Type"::Compliance) AND ("Audit Lines"."Update Frequency" <> "Audit Lines"."Update Frequency"::" ") AND (NOT "Audit Lines"."Update Stopped")) THEN BEGIN
                    if "Audit Lines"."Update Date" = Today then begin
                        CompanyInfo.GET;
                        CompanyInfo.TESTFIELD(Name);
                        CompanyInfo.TESTFIELD("E-Mail");
                        SenderName := CompanyInfo.Name;
                        SenderAddress := CompanyInfo."E-Mail";
                        Receipient.Add(GetRiskOfficersEmails);
                        Subject := 'Compliance Update';
                        TimeNow := FORMAT(TIME);
                        SMTP.Create(Receipient, Subject, '', TRUE);
                        SMTP.AppendtoBody(STRSUBSTNO(BodyTxt, 'Risk manager', "Document No.", GetNextUpdateDate("Update Date", "Update Frequency"), CompanyInfo.Name));
                        IF ReceipientCC.Count <> 0 THEN //eddieSMTP.AddCC(ReceipientCC);
                            email.Send(SMTP);
                        //Update Date
                        CASE "Audit Lines"."Update Frequency" OF
                            "Audit Lines"."Update Frequency"::Annually:
                                BEGIN
                                    "Audit Lines"."Update Date" := CALCDATE('1Y', "Audit Lines"."Update Date");
                                    "Audit Lines".MODIFY;
                                END;
                            "Audit Lines"."Update Frequency"::"Semi Annually":
                                BEGIN
                                    "Audit Lines"."Update Date" := CALCDATE('6M', "Audit Lines"."Update Date");
                                    "Audit Lines".MODIFY;
                                END;
                            "Audit Lines"."Update Frequency"::Quaterly:
                                BEGIN
                                    "Audit Lines"."Update Date" := CALCDATE('1Q', "Audit Lines"."Update Date");
                                    "Audit Lines".MODIFY;
                                END;
                            "Audit Lines"."Update Frequency"::Monthly:
                                BEGIN
                                    "Audit Lines"."Update Date" := CALCDATE('1M', "Audit Lines"."Update Date");
                                    "Audit Lines".MODIFY;
                                END;
                            "Audit Lines"."Update Frequency"::Weekly:
                                BEGIN
                                    "Audit Lines"."Update Date" := CALCDATE('1W', "Audit Lines"."Update Date");
                                    "Audit Lines".MODIFY;
                                END;
                            "Audit Lines"."Update Frequency"::Daily:
                                BEGIN
                                    "Audit Lines"."Update Date" := CALCDATE('1D', "Audit Lines"."Update Date");
                                    "Audit Lines".MODIFY;
                                END;
                        END;
                    end;
                END;
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
        CompanyInfo: Record "Company Information";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: List of [Text];
        ReceipientCC: List of [Text];
        TimeNow: Text;
        Subject: Text;
        SMTP: Codeunit "Email Message";
        Email: Codeunit email;
        AuditSetup: Record "Audit Setup";
        Employee: Record Employee;
        BodyTxt: Label 'Dear %1, <br><br>The compliance with Compliance No. %2 needs an update on the compliance status. The Next Update Date is <Strong>%3</Strong>.<br><br>Thank you.<br><br>Regards,<br><br>%4';

    local procedure NotifyMEUpdate()
    var
        AuditLine: Record "Audit Lines";
        RiskSetup: Record "Audit Setup";
        BodyTxt: Label 'Dear %1, <br><br>The compliance with Compliance No. %2 that is assigned to you needs an update. The Next Update Date is %3.<br><br>Thank you.<br><br>Regards,<br><br>%4';
    begin
        AuditLine.RESET;
        AuditLine.SETRANGE("Document No.", "Audit Lines"."Document No.");
        AuditLine.SETRANGE("Audit Line Type", AuditLine."Audit Line Type"::Compliance);
        AuditLine.SETRANGE("Update Stopped", FALSE);
        // AuditLine.SETFILTER("Update Frequency",'<>%1',AuditLine."Update Frequency"::" ");
        IF AuditLine.FIND('-') THEN BEGIN
            IF NOT RiskSetup.GET THEN EXIT;
            IF AuditLine."Update Date" = TODAY THEN BEGIN
                CompanyInfo.GET;
                CompanyInfo.TESTFIELD(Name);
                CompanyInfo.TESTFIELD("E-Mail");
                SenderName := CompanyInfo.Name;
                SenderAddress := CompanyInfo."E-Mail";
                Receipient.Add(GetRiskOfficersEmails());
                TimeNow := FORMAT(TIME);
                SMTP.Create(Receipient, Subject, '', TRUE);
                SMTP.AppendtoBody(STRSUBSTNO(BodyTxt, 'Risk manager', AuditLine."Document No.", AuditLine."Update Date", CompanyInfo.Name));
                IF ReceipientCC.Count <> 0 THEN //eddie SMTP.AddCC(ReceipientCC);
                    Email.Send(SMTP);
                //Update Next Date
                CASE AuditLine."Update Frequency" OF
                    AuditLine."Update Frequency"::Annually:
                        BEGIN
                            AuditLine."Update Date" := CALCDATE('1Y', AuditLine."Update Date");
                            AuditLine.MODIFY;
                        END;
                    AuditLine."Update Frequency"::"Semi Annually":
                        BEGIN
                            AuditLine."Update Date" := CALCDATE('6M', AuditLine."Update Date");
                            AuditLine.MODIFY;
                        END;
                    AuditLine."Update Frequency"::Quaterly:
                        BEGIN
                            AuditLine."Update Date" := CALCDATE('1Q', AuditLine."Update Date");
                            AuditLine.MODIFY;
                        END;
                    AuditLine."Update Frequency"::Monthly:
                        BEGIN
                            AuditLine."Update Date" := CALCDATE('1M', AuditLine."Update Date");
                            AuditLine.MODIFY;
                        END;
                    AuditLine."Update Frequency"::Weekly:
                        BEGIN
                            AuditLine."Update Date" := CALCDATE('1W', AuditLine."Update Date");
                            AuditLine.MODIFY;
                        END;
                    AuditLine."Update Frequency"::Daily:
                        BEGIN
                            AuditLine."Update Date" := CALCDATE('1D', AuditLine."Update Date");
                            AuditLine.MODIFY;
                        END;
                END;
            END;
        END;
    end;

    local procedure GetRiskOfficersEmails(): Text
    var
        i: Integer;
        RiskOfficerMails: Text;
        j: Integer;
        EmployeeEmail: array[1000] of Text;
        EmployeeMail: array[100] of Text;
    begin
        AuditSetup.GET;
        AuditSetup.TESTFIELD("Risk Officer Job ID");
        i := 0;
        IF AuditSetup."Risk Officer Job ID" <> '' THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE("Job Position", AuditSetup."Risk Officer Job ID");
            IF Employee.FIND('-') THEN BEGIN
                REPEAT
                    i := i + 1;
                    EmployeeMail[i] := Employee."E-Mail";
                UNTIL Employee.NEXT = 0;
            END;
            RiskOfficerMails := '';
            FOR j := 1 TO i DO BEGIN
                IF j = 1 THEN
                    RiskOfficerMails := EmployeeMail[j]
                ELSE
                    RiskOfficerMails := RiskOfficerMails + ';' + EmployeeMail[j];
            END;
        END;
        EXIT(RiskOfficerMails);
    end;

    local procedure GetNextUpdateDate(TodayDate: Date; UpdateFrequency: Option " ",Daily,Weekly,Monthly,Quaterly,"Semi Annually",Annually): Date
    begin
        CASE UpdateFrequency OF
            UpdateFrequency::" ":
                EXIT(0D);
            UpdateFrequency::Annually:
                EXIT(CALCDATE('1Y', TodayDate));
            UpdateFrequency::Daily:
                EXIT(CALCDATE('1D', TodayDate));
            UpdateFrequency::Monthly:
                EXIT(CALCDATE('1M', TodayDate));
            UpdateFrequency::Quaterly:
                EXIT(CALCDATE('1Q', TodayDate));
            UpdateFrequency::"Semi Annually":
                EXIT(CALCDATE('6M', TodayDate));
            UpdateFrequency::Weekly:
                EXIT(CALCDATE('1W', TodayDate));
        END;
    end;
}

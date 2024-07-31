report 50369 "Risk Job Queue"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Risk Line"; "Risk Line")
        {
            trigger OnAfterGetRecord()
            begin
                //Update M & E
                IF (("Risk Line".Type = "Risk Line".Type::"M&E") AND ("Risk Line"."Update Date" = TODAY) AND ("Risk Line"."Update Frequency" <> "Risk Line"."Update Frequency"::" ") AND (NOT "Risk Line"."Update Stopped")) THEN BEGIN
                    CompanyInfo.GET;
                    CompanyInfo.TESTFIELD(Name);
                    CompanyInfo.TESTFIELD("E-Mail");
                    SenderName := CompanyInfo.Name;
                    SenderAddress := CompanyInfo."E-Mail";
                    Receipient.Add(GetChampionEmail("Document No."));
                    Subject := 'Risk M&E Update';
                    TimeNow := FORMAT(TIME);
                    SMTP.Create(Receipient, Subject, '', TRUE);
                    SMTP.AppendtoBody(STRSUBSTNO(BodyTxt, 'Risk User', "Document No.", GetNextUpdateDate("Update Date", "Update Frequency"), CompanyInfo.Name));
                    IF ReceipientCC.Count <> 0 THEN //eddieSMTP.AddCC(ReceipientCC);
                        email.Send(SMTP);
                    //Update Date
                    CASE "Risk Line"."Update Frequency" OF
                        "Risk Line"."Update Frequency"::Annually:
                            BEGIN
                                "Risk Line"."Update Date" := CALCDATE('1Y', "Risk Line"."Update Date");
                                "Risk Line".MODIFY;
                            END;
                        "Risk Line"."Update Frequency"::"Semi Annually":
                            BEGIN
                                "Risk Line"."Update Date" := CALCDATE('6M', "Risk Line"."Update Date");
                                "Risk Line".MODIFY;
                            END;
                        "Risk Line"."Update Frequency"::Quaterly:
                            BEGIN
                                "Risk Line"."Update Date" := CALCDATE('1Q', "Risk Line"."Update Date");
                                "Risk Line".MODIFY;
                            END;
                        "Risk Line"."Update Frequency"::Monthly:
                            BEGIN
                                "Risk Line"."Update Date" := CALCDATE('1M', "Risk Line"."Update Date");
                                "Risk Line".MODIFY;
                            END;
                        "Risk Line"."Update Frequency"::Weekly:
                            BEGIN
                                "Risk Line"."Update Date" := CALCDATE('1W', "Risk Line"."Update Date");
                                "Risk Line".MODIFY;
                            END;
                        "Risk Line"."Update Frequency"::Daily:
                            BEGIN
                                "Risk Line"."Update Date" := CALCDATE('1D', "Risk Line"."Update Date");
                                "Risk Line".MODIFY;
                            END;
                    END;
                END;
                //Update KRIs
                IF (("Risk Line".Type = "Risk Line".Type::"KRI(s)") AND ("Risk Line"."Date of Completion" = TODAY)) THEN BEGIN
                    CompanyInfo.GET;
                    CompanyInfo.TESTFIELD(Name);
                    CompanyInfo.TESTFIELD("E-Mail");
                    SenderName := CompanyInfo.Name;
                    SenderAddress := CompanyInfo."E-Mail";
                    Receipient.Add(GetChampionEmail("Document No."));
                    Subject := 'Risk KRI(s) Update.';
                    TimeNow := FORMAT(TIME);
                    SMTP.Create(Receipient, Subject, '', TRUE);
                    SMTP.AppendtoBody(STRSUBSTNO(KRIBodyTxt, 'Risk User', "Document No.", CompanyInfo.Name));
                    IF ReceipientCC.Count <> 0 THEN //eddieSMTP.AddCC(ReceipientCC);
                        email.Send(SMTP);
                    //Update Dates
                    CASE "Risk Line"."Update Frequency" OF
                        "Risk Line"."Update Frequency"::Annually:
                            BEGIN
                                "Risk Line"."Date of Completion" := CALCDATE('1Y', "Risk Line"."Date of Completion");
                                "Risk Line".MODIFY;
                            END;
                        "Risk Line"."Update Frequency"::"Semi Annually":
                            BEGIN
                                "Risk Line"."Date of Completion" := CALCDATE('6M', "Risk Line"."Date of Completion");
                                "Risk Line".MODIFY;
                            END;
                        "Risk Line"."Update Frequency"::Quaterly:
                            BEGIN
                                "Risk Line"."Date of Completion" := CALCDATE('1Q', "Risk Line"."Date of Completion");
                                "Risk Line".MODIFY;
                            END;
                        "Risk Line"."Update Frequency"::Monthly:
                            BEGIN
                                "Risk Line"."Date of Completion" := CALCDATE('1M', "Risk Line"."Date of Completion");
                                "Risk Line".MODIFY;
                            END;
                        "Risk Line"."Update Frequency"::Weekly:
                            BEGIN
                                "Risk Line"."Date of Completion" := CALCDATE('1W', "Risk Line"."Date of Completion");
                                "Risk Line".MODIFY;
                            END;
                        "Risk Line"."Update Frequency"::Daily:
                            BEGIN
                                "Risk Line"."Date of Completion" := CALCDATE('1D', "Risk Line"."Date of Completion");
                                "Risk Line".MODIFY;
                            END;
                    END;
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
        SMTP: Codeunit "email message";
        email: Codeunit email;
        BodyTxt: Label 'Dear %1, <br><br>The Risk with Risk No. %2 that is assigned to you needs an update on the M&E. The Next Update Date is <Strong>%3</Strong>.<br><br>Thank you.<br><br>Regards,<br><br>%4';
        KRIBodyTxt: Label 'Dear %1, <br><br>The Risk with Risk No. %2 that is assigned to you needs an update on the KRI(s).<br><br>Thank you.<br><br>Regards,<br><br>%3';

    local procedure NotifyMEUpdate()
    var
        RiskLine: Record "Risk Line";
        RiskSetup: Record "Audit Setup";
        BodyTxt: Label 'Dear %1, <br><br>The Risk with Risk No. %2 that is assigned to you needs an update on the M&E. The Next Update Date is %3.<br><br>Thank you.<br><br>Regards,<br><br>%4';
    begin
        RiskLine.RESET;
        RiskLine.SETRANGE("Document No.", "Risk Line"."Document No.");
        RiskLine.SETRANGE(Type, RiskLine.Type::"M&E");
        // RiskLine.SETRANGE("Update Stopped",FALSE);
        // RiskLine.SETFILTER("Update Frequency",'<>%1',RiskLine."Update Frequency"::" ");
        IF RiskLine.FIND('-') THEN BEGIN
            IF NOT RiskSetup.GET THEN EXIT;
            IF RiskLine."Update Date" = TODAY THEN BEGIN
                CompanyInfo.GET;
                CompanyInfo.TESTFIELD(Name);
                CompanyInfo.TESTFIELD("E-Mail");
                SenderName := CompanyInfo.Name;
                SenderAddress := CompanyInfo."E-Mail";
                Receipient.Add(GetChampionEmail(RiskLine."Document No."));
                TimeNow := FORMAT(TIME);
                SMTP.Create(Receipient, Subject, '', TRUE);
                SMTP.AppendtoBody(STRSUBSTNO(BodyTxt, 'Risk User', RiskLine."Document No.", RiskLine."Update Date", CompanyInfo.Name));
                IF ReceipientCC.Count <> 0 THEN //eddieSMTP.AddCC(ReceipientCC);
                    email.Send(SMTP);
                //Update Next Date
                CASE RiskLine."Update Frequency" OF
                    RiskLine."Update Frequency"::Annually:
                        BEGIN
                            RiskLine."Update Date" := CALCDATE('1Y', RiskLine."Update Date");
                            RiskLine.MODIFY;
                        END;
                    RiskLine."Update Frequency"::"Semi Annually":
                        BEGIN
                            RiskLine."Update Date" := CALCDATE('6M', RiskLine."Update Date");
                            RiskLine.MODIFY;
                        END;
                    RiskLine."Update Frequency"::Quaterly:
                        BEGIN
                            RiskLine."Update Date" := CALCDATE('1Q', RiskLine."Update Date");
                            RiskLine.MODIFY;
                        END;
                    RiskLine."Update Frequency"::Monthly:
                        BEGIN
                            RiskLine."Update Date" := CALCDATE('1M', RiskLine."Update Date");
                            RiskLine.MODIFY;
                        END;
                    RiskLine."Update Frequency"::Weekly:
                        BEGIN
                            RiskLine."Update Date" := CALCDATE('1W', RiskLine."Update Date");
                            RiskLine.MODIFY;
                        END;
                    RiskLine."Update Frequency"::Daily:
                        BEGIN
                            RiskLine."Update Date" := CALCDATE('1D', RiskLine."Update Date");
                            RiskLine.MODIFY;
                        END;
                END;
            END;
        END;
    end;

    local procedure GetChampionEmail(DocNo: Code[100]): Text
    var
        RiskHeader: Record "Risk Header";
        RiskChampions: Record "Internal Audit Champions";
        DimChampNotFoundErr: Label 'There is no Risk Champion for %1 Region %2 Department';
    begin
        IF RiskHeader.GET(DocNo) THEN BEGIN
            RiskChampions.RESET;
            RiskChampions.SETRANGE(Type, RiskChampions.Type::Risk);
            RiskChampions.SETRANGE("Shortcut Dimension 1 Code", RiskHeader."Risk Region");
            RiskChampions.SETRANGE("Shortcut Dimension 2 Code", RiskHeader."Risk Department");
            IF RiskChampions.FINDFIRST THEN
                EXIT(RiskChampions."E-Mail")
            ELSE
                ERROR(DimChampNotFoundErr, RiskHeader."Shortcut Dimension 1 Code", RiskHeader."Shortcut Dimension 2 Code");
        END;
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

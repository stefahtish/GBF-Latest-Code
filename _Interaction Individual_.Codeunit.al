codeunit 50137 "Interaction Individual"
{
    trigger OnRun()
    begin
        EscalateComplaintToNextLevel(ClientHeaderNo);
    end;
    var ComplaintCode: Code[20];
    EscLevel: Integer;
    txtEscalationName: array[6]of Text[20];
    txtOldLevelName: Text[20];
    txtNewLevelName: Text[20];
    intOldLevelNo: Integer;
    intNewLevelNo: Integer;
    ClientHeaderNo: Code[20];
    EscalationLevel: Record "Interaction Escalations";
    UserSetup: Record "User Setup";
    SMTP: Codeunit "Email Message";
    email: Codeunit Email;
    procedure EscalateComplaintToNextLevel(ClientHeaderNo: Code[20])
    var
        TotEscHrs: Duration;
        EscDateTime: DateTime;
        CurrentDayRemDuration: Duration;
        NextWorkingDate: Date;
        TotWorkingHrs: Duration;
        CompInceHdr: Record "Client Interaction Header";
        EscSetup: Record "Interaction Channel";
        EscalationHrs: Integer;
        CompInceDate: Date;
        CompInceTime: Time;
        SerMgtSetup: Record "Service Mgt. Setup";
        Description: Text[100];
        WorkingDay: Boolean;
        CalendarMgmt: Codeunit "Calendar Management";
        ComplaintInceCode: Code[20];
        CompChangeLevel: Record "Client Interaction Header";
        CurrComInceLevel: Integer;
        txtEscalationName: array[6]of Text[20];
        ltxtLineType: Text[20];
        ltxtActionType: Text[30];
        ltxtDescription: Text[250];
        lTC1000: Label 'Interaction successfully escalated.';
        ldttmCurrentDateAndEndTime: DateTime;
        EscalationLevel: Record "Interaction Escalations";
        SenderName: Text[100];
        SenderAddress: Text[100];
        Receipients: Text[100];
        Body: Text[250];
        Subject: Text[30];
        CustomizedCalender: Record "Customized Calendar Change";
        Recipient: List of[Text];
    begin
        //Loop to next level escalation for all open complaints
        EscalationLevel.Reset;
        EscalationLevel.SetRange("Interaction Code", ClientHeaderNo);
        if EscalationLevel.Find('+')then begin
            if UserSetup.Get(EscalationLevel.User)then Recipient.Add(UserSetup."E-Mail");
            if UserSetup.Get(UserId)then begin
                SenderAddress:=UserSetup."E-Mail";
                SenderName:=UserId;
            end;
            if CompInceHdr.Get(ClientHeaderNo)then begin
                Body:=EscalationLevel.Remarks + ' Interaction No. ' + ClientHeaderNo + ' Client' + CompInceHdr."Client No.";
                Subject:=Format(CompInceHdr."Interaction Type");
            end;
            SMTP.Create(Recipient, Subject, Body, true);
            Email.Send(SMTP);
            // CompInceHdr.Status := CompInceHdr.Status::Escalated;
            CompInceHdr.Modify;
        end;
        // CompInceHdr.Reset;
        // CompInceHdr.SetCurrentKey(CompInceHdr."Interact Code");
        // CompInceHdr.SetFilter(CompInceHdr.Status, '<>%1', CompInceHdr.Status::Closed);
        // CompInceHdr.SetFilter(CompInceHdr."Escalation Clock", '<>%1', 0DT);
        // CompInceHdr.SetFilter(CompInceHdr."Interaction Channel", '<>%1', '');
        // CompInceHdr.SetFilter(CompInceHdr.Status, '<>%1', CompInceHdr.Status::"Awaiting 3rd Party");
        // CompInceHdr.SetFilter(CompInceHdr."Interact Code", ClientHeaderNo);
        if CompInceHdr.FindFirst then repeat if CompInceHdr."Escalation Level No." < 5 then begin
                    funEscalationNames;
                    intOldLevelNo:=CompInceHdr."Escalation Level No.";
                    intNewLevelNo:=CompInceHdr."Escalation Level No." + 1;
                    //Captured complaint registered date time, working hours
                    ComplaintCode:=CompInceHdr."Interact Code";
                    CompInceDate:=DT2Date(CompInceHdr."Escalation Clock");
                    CompInceTime:=DT2Time(CompInceHdr."Escalation Clock");
                    EscalationHrs:=0;
                    if EscSetup.Get(CompInceHdr."Interaction Channel")then begin
                        //Get escalation hours as per the escalation setup for each channel
                        EscalationHrs:=funGetEscalationHoursFromSetup(CompInceHdr, 0);
                        TotWorkingHrs:=EscSetup."Day End Time" - EscSetup."Day Start Time";
                        //Need to define base calendar code in Service management setup to find working/non working day
                        SerMgtSetup.Get();
                        //WorkingDay := not CalendarMgmt.CheckDateStatus(CustomizedCalender);
                        if WorkingDay then begin
                            //Capture values in required variables
                            TotEscHrs:=(EscalationHrs * 60 * 60 * 1000);
                            CompInceDate:=DT2Date(CompInceHdr."Escalation Clock");
                            CompInceTime:=DT2Time(CompInceHdr."Escalation Clock");
                            CurrentDayRemDuration:=EscSetup."Day End Time" - CompInceTime;
                            //RW-041010
                            if CurrentDayRemDuration >= TotEscHrs then begin
                                ldttmCurrentDateAndEndTime:=CreateDateTime(CompInceDate, EscSetup."Day End Time");
                                EscDateTime:=ldttmCurrentDateAndEndTime - (CurrentDayRemDuration - TotEscHrs);
                            end
                            else
                            begin
                                EscDateTime:=CompInceHdr."Escalation Clock" + CurrentDayRemDuration end;
                            //RW-041010
                            TotEscHrs:=TotEscHrs - CurrentDayRemDuration;
                            NextWorkingDate:=CompInceDate;
                            //Calculation to find escalation date and time
                            if TotEscHrs > 0 then repeat NextWorkingDate:=CalcDate('+1D', NextWorkingDate);
                                    EscDateTime:=CreateDateTime(NextWorkingDate, EscSetup."Day Start Time");
                                    //WorkingDay := not CalendarMgmt.CheckDateStatus(CustomizedCalender);
                                    if WorkingDay then begin
                                        if TotEscHrs >= TotWorkingHrs then CurrentDayRemDuration:=EscSetup."Day End Time" - EscSetup."Day Start Time"
                                        else
                                            CurrentDayRemDuration:=TotEscHrs;
                                        EscDateTime:=EscDateTime + CurrentDayRemDuration;
                                        TotEscHrs:=TotEscHrs - CurrentDayRemDuration;
                                    end;
                                until TotEscHrs <= 0;
                            //Update Escalation date and time(Last Updated Date and Time) in Complaint Incedent Header table
                            if(EscDateTime <= CreateDateTime(WorkDate, Time)) and (CompInceHdr."Escalation Level No." <> 6)then begin
                                CompChangeLevel.Reset;
                                CompChangeLevel.SetCurrentKey(CompChangeLevel."Interact Code");
                                CompChangeLevel.SetRange(CompChangeLevel."Interact Code", CompInceHdr."Interact Code");
                                if CompChangeLevel.FindFirst then begin
                                    CompChangeLevel."Escalation Level No.":=CompInceHdr."Escalation Level No." + 1;
                                    //CompChangeLevel."Escalation Clock" := EscDateTime;
                                    CompChangeLevel."Escalation Clock":=CreateDateTime(WorkDate, Time);
                                    CompChangeLevel."Last Updated Date and Time":=CreateDateTime(WorkDate, Time);
                                    CompChangeLevel."Escalation Level Name":=funGetEscalationName(CompInceHdr."Escalation Level No." + 1);
                                    //AES
                                    CompChangeLevel."Major Category":=CompChangeLevel."Major Category"::"Complaints Bureau";
                                    //AES
                                    CompChangeLevel.Modify;
                                    ltxtLineType:='System';
                                    ltxtActionType:='Escalated';
                                    ltxtDescription:='SLA Escalated to level ' + CompChangeLevel."Escalation Level Name";
                                    InsertDetailLine(CompInceHdr, ltxtLineType, ltxtActionType, ltxtDescription);
                                    txtNewLevelName:=CompChangeLevel."Escalation Level Name";
                                    funSendEscalationMail(CompInceHdr);
                                    Message(lTC1000);
                                end;
                            end;
                        end;
                    end;
                end;
            until CompInceHdr.Next = 0;
    end;
    procedure InsertDetailLine(precInteractHeader: Record "Client Interaction Header"; ptxtLineType: Text[20]; ptxtActionType: Text[30]; ptxtDescription: Text[250])
    var
        lrecClientInteractLine: Record "Client Interaction Line";
        lintLineNo: Integer;
    begin
        //C004
        lrecClientInteractLine.Reset;
        lrecClientInteractLine.SetRange("Client Interaction No.", precInteractHeader."Interact Code");
        if lrecClientInteractLine.FindLast then lintLineNo:=lrecClientInteractLine."Line No." + 10000
        else
            lintLineNo:=10000;
        lrecClientInteractLine.Init;
        lrecClientInteractLine."Client Interaction No.":=precInteractHeader."Interact Code";
        lrecClientInteractLine."Line No.":=lintLineNo;
        Evaluate(lrecClientInteractLine."Line Type", ptxtLineType);
        Evaluate(lrecClientInteractLine."Action Type", ptxtActionType);
        lrecClientInteractLine."User ID":=UserId;
        lrecClientInteractLine."Date and Time":=CreateDateTime(WorkDate, Time);
        lrecClientInteractLine.Description:=ptxtDescription;
        lrecClientInteractLine.Insert;
    //C004
    end;
    procedure GetNextLineNo(CompLine: Record "Client Interaction Line"; BelowxRec: Boolean): Integer var
        CompLine2: Record "Client Interaction Line";
        LoLineNo: Integer;
        HiLineNo: Integer;
        NextLineNo: Integer;
        LineStep: Integer;
    begin
        NextLineNo:=0;
        LineStep:=10000;
        CompLine2.Reset;
        CompLine2.SetRange("Client Interaction No.", ComplaintCode);
        if CompLine2.FindLast then NextLineNo:=CompLine2."Line No." + LineStep
        else
            NextLineNo:=LineStep;
        exit(NextLineNo);
    end;
    procedure funEscalateIgnoreSLA(var precInteractionHeader: Record "Client Interaction Header"): Boolean var
        lrecInteractionLine: Record "Client Interaction Line";
        intNextLineNo: Integer;
        ltxtLineType: Text[20];
        ltxtActionType: Text[30];
        ltxtDescription: Text[250];
        lintOldLevelNo: Integer;
    begin
        funEscalationNames;
        if precInteractionHeader."Escalation Level No." = 5 then exit(false);
        intOldLevelNo:=precInteractionHeader."Escalation Level No.";
        intNewLevelNo:=precInteractionHeader."Escalation Level No." + 1;
        precInteractionHeader."Escalation Level No."+=1;
        lrecInteractionLine.Reset;
        precInteractionHeader."Escalation Level Name":=txtEscalationName[precInteractionHeader."Escalation Level No." + 1];
        precInteractionHeader."Escalation Clock":=CreateDateTime(WorkDate, Time);
        precInteractionHeader."Last Updated Date and Time":=CreateDateTime(WorkDate, Time);
        ltxtLineType:='System';
        ltxtActionType:='Escalated';
        ltxtDescription:='Manually escalated to level ' + precInteractionHeader."Escalation Level Name";
        InsertDetailLine(precInteractionHeader, ltxtLineType, ltxtActionType, ltxtDescription);
        txtNewLevelName:=precInteractionHeader."Escalation Level Name";
        funSendEscalationMail(precInteractionHeader);
        //message('escalated');
        exit(true);
    end;
    procedure funEscalationNames()
    begin
        txtEscalationName[1]:='ZERO';
        txtEscalationName[2]:='ONE';
        txtEscalationName[3]:='TWO';
        txtEscalationName[4]:='THREE';
        txtEscalationName[5]:='FOUR';
        txtEscalationName[6]:='FIVE';
    end;
    procedure funGetEscalationName(pintEscalationLevel: Integer): Text[30]begin
        funEscalationNames;
        exit(txtEscalationName[pintEscalationLevel + 1]);
    end;
    procedure funGetEscalationHoursFromSetup(irecClientInterHdr: Record "Client Interaction Header"; EscalationSteps: Integer): Integer var
        lrecEscalationSetup: Record "Interaction Channel";
        lintEscalationHr: Integer;
        recEscalationSteps: Record "Interactions Escalation Setup";
    begin
        if lrecEscalationSetup.Get(irecClientInterHdr."Interaction Channel")then begin
            //AES CODE
            EscalationSteps:=irecClientInterHdr."Escalation Level No.";
            recEscalationSteps.Reset;
            recEscalationSteps.SetRange(recEscalationSteps."Channel No.", irecClientInterHdr."Interaction Channel");
            recEscalationSteps.SetRange(recEscalationSteps."Level Code", 'Level ' + Format(EscalationSteps));
            if recEscalationSteps.Find('-')then begin
                lintEscalationHr:=recEscalationSteps."Level Duration - Hours";
            end;
        end;
        exit(lintEscalationHr);
    //AES CODE
    //  IF irecClientInterHdr."Escalation Level No." = 0 THEN BEGIN
    //    lintEscalationHr := lrecEscalationSetup."Level 0";
    //  END ELSE IF irecClientInterHdr."Escalation Level No." = 1 THEN BEGIN
    //    lintEscalationHr := lrecEscalationSetup."Level 1";
    //  END ELSE IF irecClientInterHdr."Escalation Level No." = 2 THEN BEGIN
    //    lintEscalationHr := lrecEscalationSetup."Level 2";
    //  END ELSE IF irecClientInterHdr."Escalation Level No." = 3 THEN BEGIN
    //    lintEscalationHr := lrecEscalationSetup."Level 3";
    //  END ELSE IF irecClientInterHdr."Escalation Level No." = 4 THEN BEGIN
    //    lintEscalationHr := lrecEscalationSetup."Level 4";
    //  END ELSE IF irecClientInterHdr."Escalation Level No." = 5 THEN BEGIN
    //    lintEscalationHr  := lrecEscalationSetup."Level 5";
    //  END;
    //END;
    //EXIT(lintEscalationHr);
    end;
    procedure funSendEscalationMail(precInteractionHeader: Record "Client Interaction Header")
    var
        lcduSMTPEmail: Codeunit "Email Message";
        Email: Codeunit Email;
        ltxtSenderName: Text[100];
        ltxtSenderAddress: Text[100];
        ltxtRecipients: Text[100];
        ltxtSubject: Text[200];
        ltxtBody: Text[1024];
        lrecUserSetup: Record "User Setup";
        lTC1000: Label '''%1 is escalated to new level %2''';
        ltxtCCRecipients: Text[100];
        lTC1001: Label ' is now for your attention. Please check this and carry out the appropriate actions. The Details of this Interaction are as follows :';
        lTC1002: Label 'Interaction Creation Date and Time : ';
        lTC1003: Label 'Interaction Type Description : ';
        lTC1004: Label 'Interaction Cause Description : ';
        lTC1005: Label 'Last Interaction Action : ';
        lTC1006: Label 'Last Interaction Date and Time : ';
        lTC1007: Label 'Last Interaction Created By : ';
        lTC1008: Label 'Last Interaction Description : ';
        lTC1009: Label 'Kind regards,.';
        lrecInteractionLine: Record "Client Interaction Line";
        lchar13: Char;
        lchar10: Char;
        Recipient: List of[Text];
    begin
        //C002
        if lrecUserSetup.Get(UserId)then begin
            lrecUserSetup.TestField(lrecUserSetup."E-Mail");
            ltxtSenderName:=UserId;
            ltxtSenderAddress:=lrecUserSetup."E-Mail";
        end;
        //ltxtCCRecipients := funGetEscalationEmailID(precInteractionHeader, intOldLevelNo);
        //ltxtRecipients := funGetEscalationEmailID(precInteractionHeader, intNewLevelNo);
        Recipient.Add(funGetEscalationEmailID(precInteractionHeader, intNewLevelNo));
        Recipient.Add(funGetEscalationEmailID(precInteractionHeader, intOldLevelNo));
        if(Recipient.Count > 0)then begin
            ltxtSubject:=precInteractionHeader."Client No." + ',' + precInteractionHeader."Client Name" + ' ' + 'escalated to new level' + ' ' + txtNewLevelName;
            ltxtBody:='Dear User,';
            lcduSMTPEmail.Create(Recipient, ltxtSubject, ltxtBody, false);
            lchar13:=13;
            lchar10:=10;
            lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
            lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
            lcduSMTPEmail.AppendtoBody('Interaction ');
            lcduSMTPEmail.AppendtoBody(precInteractionHeader."Interact Code");
            lcduSMTPEmail.AppendtoBody(lTC1001);
            lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
            lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
            lcduSMTPEmail.AppendtoBody(lTC1002);
            lcduSMTPEmail.AppendtoBody(Format(precInteractionHeader."Date and Time"));
            lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
            lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
            lcduSMTPEmail.AppendtoBody(lTC1003);
            lcduSMTPEmail.AppendtoBody(precInteractionHeader."Interaction Type Desc.");
            lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
            lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
            lcduSMTPEmail.AppendtoBody(lTC1004);
            lcduSMTPEmail.AppendtoBody(precInteractionHeader."Interaction Cause Desc.");
            lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
            lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
            lrecInteractionLine.Reset;
            lrecInteractionLine.SetRange(lrecInteractionLine."Client Interaction No.", precInteractionHeader."Interact Code");
            if lrecInteractionLine.FindLast then begin
                lcduSMTPEmail.AppendtoBody(lTC1005);
                lcduSMTPEmail.AppendtoBody(Format(lrecInteractionLine."Action Type"));
                lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
                lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
                lcduSMTPEmail.AppendtoBody(lTC1006);
                lcduSMTPEmail.AppendtoBody(Format(lrecInteractionLine."Date and Time"));
                lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
                lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
                lcduSMTPEmail.AppendtoBody(lTC1007);
                lcduSMTPEmail.AppendtoBody(lrecInteractionLine."User ID");
                lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
                lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
                lcduSMTPEmail.AppendtoBody(lTC1008);
                lcduSMTPEmail.AppendtoBody(lrecInteractionLine.Description);
            end;
            lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
            lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
            lcduSMTPEmail.AppendtoBody(lTC1009);
            lcduSMTPEmail.AppendtoBody(Format(lchar13) + Format(lchar10));
            lcduSMTPEmail.AppendtoBody(UserId);
            //lcduSMTPEmail.AddCC(ltxtCCRecipients);
            Email.Send(lcduSMTPEmail);
        end;
    //C002
    end;
    procedure funGetEscalationEmailID(precClientInterHdr: Record "Client Interaction Header"; pintLevelNo: Integer): Text[100]var
        lrecEscalationSetup: Record "Interaction Channel";
        ltxtEscalationEmailId: Text[100];
        recEscalActualSetup: Record "Interactions Escalation Setup";
    begin
        //AES CODE
        recEscalActualSetup.SetRange(recEscalActualSetup."Channel No.", precClientInterHdr."Interaction Channel");
        recEscalActualSetup.SetRange(recEscalActualSetup."Level Code", 'Level ' + Format(pintLevelNo));
        if recEscalActualSetup.FindFirst then ltxtEscalationEmailId:=recEscalActualSetup."Distribution E-mail for Level";
        exit(ltxtEscalationEmailId);
    //AES CODE
    //IF lrecEscalationSetup.GET(precClientInterHdr."Interaction Channel") THEN BEGIN
    //  IF pintLevelNo = 0 THEN BEGIN
    //    //lrecEscalationSetup.TESTFIELD(lrecEscalationSetup."Distribution E-mail Level 0");
    //
    //    ltxtEscalationEmailId := lrecEscalationSetup."Distribution E-mail Level 0";
    //  END ELSE IF pintLevelNo = 1 THEN BEGIN
    //    //lrecEscalationSetup.TESTFIELD(lrecEscalationSetup."Distribution E-mail Level 1");
    //    ltxtEscalationEmailId := lrecEscalationSetup."Distribution E-mail Level 1";
    //  END ELSE IF pintLevelNo = 2 THEN BEGIN
    //    //lrecEscalationSetup.TESTFIELD(lrecEscalationSetup."Distribution E-mail Level 2");
    //    ltxtEscalationEmailId := lrecEscalationSetup."Distribution E-mail Level 2";
    //  END ELSE IF pintLevelNo = 3 THEN BEGIN
    //    //lrecEscalationSetup.TESTFIELD(lrecEscalationSetup."Distribution E-mail Level 3");
    //    ltxtEscalationEmailId := lrecEscalationSetup."Distribution E-mail Level 3";
    //  END ELSE IF pintLevelNo = 4 THEN BEGIN
    //    //lrecEscalationSetup.TESTFIELD(lrecEscalationSetup."Distribution E-mail Level 4");
    //    ltxtEscalationEmailId  := lrecEscalationSetup."Distribution E-mail Level 4";
    //  END ELSE IF pintLevelNo = 5 THEN BEGIN
    //    //lrecEscalationSetup.TESTFIELD(lrecEscalationSetup."Distribution E-mail Level 5");
    //    ltxtEscalationEmailId := lrecEscalationSetup."Distribution E-mail Level 5";
    //  END;
    //END;
    //EXIT(ltxtEscalationEmailId);
    end;
}

codeunit 50132 "Internal Audit Management"
{
    trigger OnRun()
    begin
        MESSAGE(GetRiskOfficersEmails);
    //MailReportDeadlineReminder;
    end;
    var ICTSetup: Record "ICT Setup";
    CompanyInfo: Record "Company Information";
    AuditSetup: Record "Audit Setup";
    Text0001: Label 'Do you want to Send the Incident %1?';
    Text0002: Label 'Risk sent successfully.';
    Text0003: Label 'Do you want to send the Notification?';
    Text0004: Label 'Notification Sent Successfully.';
    Text0005: Label 'Do you want to send the Audit Notification to %1 Department?';
    AuditNotice: Label 'Dear <Strong>%1</Strong>,<br> <br> You have been subscribed to receive this email from Department %2.<br> <br> Thank you. Regards,<br><br><Strong>%3</Strong>';
    DimVal: Record "Dimension Value";
    Employee: Record Employee;
    UserSetup: Record "User Setup";
    FileRec: File;
    Receipients: List of[Text];
    AuditHeader: Record "Audit Header";
    ConfirmSendtoChampion: Label 'Do you want to Send the Risk %1 to the Risk Champions?';
    ConfirmSendtoOfficer: Label 'Do you want to Send the Risk %1 to the Risk Officer?';
    ConfirmSendtoHOD: Label 'Do you want to Send the Risk %1 to the HOD?';
    ConfirmSendtoChampion2: Label 'Do you want to Send the Risk %1 to the Risk Champion?';
    RiskLedger: Record "Risk Ledger Entry";
    RiskValueSetup: Record "Risk Value Setup";
    RiskHeader: Record "Risk Header";
    Emailmessage: Codeunit "Email Message";
    Receipient: List of[Text];
    ReceipientCC: List of[Text];
    SenderName: Text;
    SenderAddress: Text;
    TimeNow: Text;
    Subject: Text;
    DefaultOption: Integer;
    RiskRegister: Record "Risk Register";
    GlobalAuditLine: Record "Audit Lines";
    GlobalAuditHeader: Record "Audit Header";
    ConfirmSendtoPM: Label 'Do you want to Send the Risk %1 to the Project Manager?';
    NextEntryNo: Integer;
    RecomEntryNo: Integer;
    Window: Dialog;
    ScopeLineNo: Integer;
    ProjectList: Page "Projects List";
    Project: Record Projects;
    WorkpaperProgramNo: Code[50];
    WorkpaperDoneBy: Code[50];
    WorkpaperDate: Date;
    WorkpaperNo: Code[50];
    ConfirmSendEmailtoRiskChampion: Label 'Do you want to send an Email Notification to the Risk Champion?';
    ConfirmSendEmailtoHOD: Label 'Do you want to send an Email Notification to the HOD?';
    ConfirmSendEmailtoProjectManager: Label 'Do you want to send an Email Notification to the Project Manager?';
    procedure SendRiskCommunication(Communication: Record "Communication Header")
    var
        Instr: InStream;
        EmailBodyText: Text;
        EmailBodyBigText: BigText;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        Email: Codeunit Email;
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: Text;
        Attachment: Text;
        ErrorMsg: Text;
    begin
        ICTSetup.GET;
        CompanyInfo.GET;
        CompanyInfo.TESTFIELD("E-Mail");
        // AuditSetup.GET;
        // AuditSetup.TESTFIELD("Risk Email");
        IF Communication.Sent THEN ERROR('Communication has been done already!!');
        IF NOT CONFIRM(Text0001, FALSE, Communication."No.")THEN EXIT
        ELSE
        BEGIN
            CASE Communication."Communication Type" OF Communication."Communication Type"::"E-Mail": BEGIN
                //Calc EmailBody
                Communication.CALCFIELDS("E-Mail Body");
                Communication."E-Mail Body".CREATEINSTREAM(Instr);
                EmailBodyBigText.READ(Instr);
                EmailBodyText:=FORMAT(EmailBodyBigText);
                //Get User Email
                IF UserSetup.GET(USERID)THEN IF Employee.GET(UserSetup."Employee No.")THEN;
                //Create & Send Email
                SenderName:=Employee."First Name" + ' ' + Employee."Last Name";
                SenderAddress:=Communication."Sender Email";
                Receipient.Add(Communication."Receipient E-Mail");
                Subject:=Communication."E-Mail Subject";
                TimeNow:=FORMAT(TIME);
                FileName:=Communication.Attachment;
                Emailmessage.Create(Receipient, Subject, '', true);
                Emailmessage.AppendToBody(STRSUBSTNO(EmailBodyText));
                IF Communication.Attachment <> '' THEN Emailmessage.AppendtoBody(STRSUBSTNO(EmailBodyText));
                Emailmessage.AddAttachment(FileName, Attachment, '');
                email.Send(Emailmessage);
                MESSAGE(Text0002);
                Communication.Sent:=TRUE;
                Communication.Status:=Communication.Status::Sent;
                Communication.MODIFY(TRUE);
            END;
            // Communication."Communication Type"::SMS:
            //     BEGIN
            //     END;
            END;
        END;
    end;
    procedure SendAuditNotification(Communication: Record "Communication Header")
    var
        Instr: InStream;
        EmailBodyText: Text;
        EmailBodyBigText: BigText;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: Text;
        Email: Codeunit Email;
        Attachment: Text;
        ErrorMsg: Text;
        CommLines: Record "Communication Lines";
    begin
        ICTSetup.GET;
        CompanyInfo.GET;
        CompanyInfo.TESTFIELD("E-Mail");
        AuditSetup.GET;
        //AuditSetup.TESTFIELD("Risk Email");
        IF Communication.Status = Communication.Status::Sent THEN ERROR('Communication has already been sent!!');
        IF NOT Communication."Notify Department" THEN BEGIN
            Receipients.Add(Communication."Receipient E-Mail")END
        ELSE
            Receipients.Add(Communication."Shortcut Dimension 2 Code");
        IF NOT CONFIRM(Text0003)THEN EXIT
        ELSE
        BEGIN
            CASE Communication."Communication Type" OF Communication."Communication Type"::"E-Mail": BEGIN
                IF NOT Communication."Notify Department" THEN BEGIN
                    //Calc EmailBody
                    Communication.CALCFIELDS("E-Mail Body");
                    Communication."E-Mail Body".CREATEINSTREAM(Instr);
                    EmailBodyBigText.READ(Instr);
                    EmailBodyText:=FORMAT(EmailBodyBigText);
                    //MESSAGE(EmailBodyText);
                    //Create & Send Email
                    SenderName:=Communication."Sender Name";
                    SenderAddress:=CompanyInfo."E-Mail";
                    Receipient.Add(Communication."Receipient E-Mail");
                    Subject:=Communication."E-Mail Subject";
                    TimeNow:=FORMAT(TIME);
                    FileName:=Communication.Attachment;
                    Emailmessage.Create(Receipient, Subject, '', true);
                    Emailmessage.AppendToBody(STRSUBSTNO(EmailBodyText));
                    Emailmessage.AddAttachment(FileName, Attachment, '');
                    email.Send(emailmessage);
                /*IF ErrorMsg <> '' THEN
                              Communication.Sent := False
                            ELSE
                              Communication.Sent := True;
                            Communication.MODIFY;*/
                END
                ELSE
                BEGIN
                    CommLines.RESET;
                    CommLines.SETRANGE("No.", Communication."No.");
                    IF CommLines.FIND('-')THEN BEGIN
                        REPEAT //Calc EmailBody
                            Communication.CALCFIELDS("E-Mail Body");
                            Communication."E-Mail Body".CREATEINSTREAM(Instr);
                            EmailBodyBigText.READ(Instr);
                            EmailBodyText:=FORMAT(EmailBodyBigText);
                            //MESSAGE(EmailBodyText);
                            //Create & Send Email
                            SenderName:=Communication."Sender Name";
                            SenderAddress:=CompanyInfo."E-Mail";
                            Receipient.Add(CommLines."Recipient E-Mail");
                            Subject:=Communication."E-Mail Subject";
                            TimeNow:=FORMAT(TIME);
                            FileName:=Communication.Attachment;
                            Emailmessage.Create(Receipient, Subject, '', true);
                            Emailmessage.AppendtoBody(STRSUBSTNO(EmailBodyText));
                            Emailmessage.AddAttachment(FileName, Attachment, '');
                            email.Send(Emailmessage);
                        UNTIL CommLines.NEXT = 0;
                    END;
                END;
                MESSAGE(Text0004);
            END;
            // Communication."Communication Type"::SMS:
            //     BEGIN
            //     END;
            END;
            Communication.Status:=Communication.Status::Sent;
            Communication.Sent:=TRUE;
            Communication.MODIFY(TRUE);
        END;
    end;
    procedure SendAuditPlanNotice(AuditHeader: Record "Audit Header")
    var
        Instr: InStream;
        EmailBodyText: Text;
        EmailBodyBigText: BigText;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        Email: Codeunit Email;
        SenderAddress: Text;
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: Text;
        Attachment: Text;
        ErrorMsg: Text;
        Audit2: Record "Audit Header";
        Percentage: Integer;
        TotalCount: Integer;
        Counter: Integer;
        Window: Dialog;
    begin
        AuditSetup.GET;
        CompanyInfo.GET;
        IF NOT CONFIRM(Text0005, TRUE, GetDimensionValue(AuditHeader."Shortcut Dimension 2 Code"))THEN EXIT
        ELSE
        BEGIN
            IF AuditHeader."Send Attachment" AND NOT AuditHeader."Notification Sent" THEN BEGIN
                FileName:=AuditSetup."Attachment Path" + 'Audit ' + GetDimensionValue(AuditHeader."Shortcut Dimension 2 Code") + '.pdf';
                Audit2.RESET;
                Audit2.SETRANGE("No.", AuditHeader."No.");
            //REPORT.SAVEASPDF(Report::"Audit Program", FileName, Audit2);
            END;
            //Get Dept Employees
            Employee.RESET;
            Employee.SETRANGE("Global Dimension 1 Code", AuditHeader."Shortcut Dimension 1 Code");
            Employee.SETRANGE("Global Dimension 2 Code", AuditHeader."Shortcut Dimension 2 Code");
            Employee.SETFILTER("E-Mail", '<>%1', '');
            IF Employee.FIND('-')THEN Window.OPEN('Sending E-Mail : @1@@@@@@@@@@@@@@@' + 'Employee:#2###############');
            TotalCount:=Employee.COUNT;
            REPEAT Percentage:=(ROUND(Counter / TotalCount * 10000, 1));
                Counter:=Counter + 1;
                Window.UPDATE(1, Percentage);
                Window.UPDATE(2, (FORMAT(Employee."No.") + ' ' + Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name"));
                SenderName:=CompanyInfo.Name;
                SenderAddress:=CompanyInfo."E-Mail";
                Receipient.Add(Employee."E-Mail");
                Subject:=AuditHeader.Description;
                TimeNow:=FORMAT(TIME);
                Emailmessage.Create(Receipient, Subject, '', true);
                Emailmessage.AppendtoBody(STRSUBSTNO(AuditNotice, Employee."First Name", AuditHeader."Shortcut Dimension 1 Code", CompanyInfo.Name));
                IF AuditHeader."Send Attachment" THEN BEGIN
                    Emailmessage.AddAttachment(FileName, Attachment, '');
                END;
                Email.send(Emailmessage);
            UNTIL Employee.NEXT = 0;
            Window.CLOSE;
            MESSAGE('Sent Successfully');
            AuditHeader."Notification Sent":=TRUE;
            AuditHeader.MODIFY;
        END;
    end;
    procedure GetDimensionValue(DimCode: Code[50]): Text[250]begin
        DimVal.RESET;
        DimVal.SETRANGE(Code, DimCode);
        IF DimVal.FIND('-')THEN EXIT(DimVal.Name);
    end;
    procedure GetEmployeeName(UserName: Code[50]): Text[250]begin
        IF UserSetup.GET(UserName)THEN IF Employee.GET(UserSetup."Employee No.")THEN EXIT(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
    end;
    procedure SendRiskIncident(var Incident: Record "User Support Incident")
    var
        Instr: InStream;
        EmailBodyText: Text;
        EmailBodyBigText: BigText;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: Text;
        Attachment: Text;
        ErrorMsg: Text;
        EmailText: Label 'Dear <Strong>%1</Strong>,<br> <br> This is a incident reporting E-Mail. Kindly alert the relevant authorities of the Possible Risk.<br> <br> Thank you. Regards, <br> <br>%2';
        EmailAttached: Label 'Dear <Strong>%1</Strong>,<br> <br> This is a incident reporting E-Mail <br><br>Attached is an Image of the Incident.<br> <br> Kindly alert the relevant authorities of the Possible Risk.<br> <br> Thank you. Regards, <br> <br>%2';
        OutStr: OutStream;
        IncidentReportedMssg: Label 'The Incident has been reported successfully!';
    begin
        ICTSetup.GET;
        CompanyInfo.GET;
        CompanyInfo.TESTFIELD("E-Mail");
        AuditSetup.GET;
        AuditSetup.TESTFIELD("Risk Email");
        if Incident."Screen Shot".HasValue then AuditSetup.TestField("Attachment Path");
        FileName:=AuditSetup."Attachment Path" + Incident."Incident Reference" + '.jpg';
        //Calc EmailBody
        Incident.CALCFIELDS("Screen Shot");
        Incident."Screen Shot".CREATEINSTREAM(Instr);
        EmailBodyBigText.READ(Instr);
        EmailBodyText:=FORMAT(EmailBodyBigText);
        //Create & Send Email
        SenderName:=Employee."First Name" + ' ' + Employee."Last Name";
        SenderAddress:=Incident."User email Address";
        Receipient.Add(AuditSetup."Risk Email");
        Subject:=Incident."Incident Reference" + ' - ' + Incident."Incident Cause";
        TimeNow:=FORMAT(TIME);
        IF Incident."Screen Shot".HASVALUE THEN BEGIN
            Incident."Screen Shot".CREATEINSTREAM(Instr);
        // EDDIEFileRec.CREATE(FileName);
        // FileRec.CREATEOUTSTREAM(OutStr);
        // COPYSTREAM(OutStr, Instr);
        // FileRec.CLOSE;
        END;
        Emailmessage.Create(Receipient, Subject, '', true);
        IF Incident."Screen Shot".HASVALUE THEN Emailmessage.AppendtoBody(STRSUBSTNO(EmailAttached, 'Sir/Madam', (Employee."First Name" + ' ' + Employee."Last Name")))
        ELSE
            Emailmessage.AppendtoBody(STRSUBSTNO(EmailText, 'Sir/Madam', (Employee."First Name" + ' ' + Employee."Last Name")));
        IF Incident."Screen Shot".HASVALUE THEN Emailmessage.AddAttachment(FileName, Attachment, '');
        Email.send(Emailmessage);
        Incident.Status:=Incident.Status::Pending;
        Incident.Sent:=true;
        If GUIALLOWED then MESSAGE(IncidentReportedMssg);
    end;
    procedure MailAuditReport(AuditHeader: Record "Audit Header")
    var
        Instr: InStream;
        EmailBodyText: Text;
        EmailBodyBigText: BigText;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        Email: Codeunit Email;
        SenderAddress: Text;
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: Text;
        Attachment: Text;
        ErrorMsg: Text;
        AuditHead2: Record "Audit Header";
        ConfirmSendAuditReport: Label 'Do you want to send the Audit Report %1?';
        EmailBody: Label 'Dear <Stong>%1</Strong>, <br><br> Kindly find attached the Audit Report that was conducted on your Department. <br><br>Thank you. <br><br>Regards, <br><br>%2';
        AuditLines: Record "Audit Lines";
    begin
        AuditSetup.GET;
        CompanyInfo.GET;
        IF NOT CONFIRM(ConfirmSendAuditReport, TRUE, AuditHeader."No.")THEN EXIT
        ELSE
        BEGIN
            IF NOT AuditHeader."Notification Sent" THEN BEGIN
                FileName:=(AuditSetup."Attachment Path" + 'Audit Report ' + AuditHeader."Shortcut Dimension 2 Code" + '.pdf');
                AuditHead2.RESET;
                AuditHead2.SETRANGE("No.", AuditHeader."No.");
            //EDDIE REPORT.SAVEASPDF(Report::"Internal Audit Report", FileName, AuditHead2);
            END;
            //Get Dept Employees
            DimVal.RESET;
            DimVal.SETRANGE(Code, AuditHeader."Shortcut Dimension 2 Code");
            IF DimVal.FIND('-')THEN BEGIN
                SenderName:=CompanyInfo.Name;
                SenderAddress:=CompanyInfo."E-Mail";
                Receipient.Add(Employee."E-Mail");
                Subject:=('Audit Report' + GetDimensionValue(AuditHeader."Shortcut Dimension 2 Code"));
                TimeNow:=FORMAT(TIME);
                Emailmessage.Create(Receipient, Subject, '', true);
                Emailmessage.AppendtoBody(STRSUBSTNO(EmailBody, 'User', AuditHeader."Audit Period Start Date", CompanyInfo.Name));
                Emailmessage.AddAttachment(FileName, Attachment, '');
                email.Send(emailmessage);
            END;
            //
            //Mail Auditee
            AuditLines.RESET;
            AuditLines.SETRANGE("Document No.", AuditHeader."No.");
            AuditLines.SETRANGE("Audit Line Type", AuditLines."Audit Line Type"::"Report Recommendation");
            IF AuditLines.FIND('-')THEN BEGIN
                SenderName:=CompanyInfo.Name;
                SenderAddress:=CompanyInfo."E-Mail";
                Receipient.Add(AuditLines."Responsible Personnel Code");
                Subject:=('Audit Report' + GetDimensionValue(AuditHeader."Shortcut Dimension 2 Code"));
                TimeNow:=FORMAT(TIME);
                Emailmessage.Create(Receipient, Subject, '', TRUE);
                Emailmessage.AppendtoBody(STRSUBSTNO(EmailBody, 'User', AuditHeader."Audit Period Start Date", CompanyInfo.Name));
                Emailmessage.AddAttachment(FileName, Attachment, '');
                Email.send(Emailmessage);
            END;
            NotifyAuditorReportChanges(AuditHeader);
            MESSAGE('Audit Report Sent Successfully');
            AuditHeader."Notification Sent":=TRUE;
            AuditHeader.MODIFY;
        //
        END;
    end;
    procedure CreateDepartmentRegister(Audit: Record "Audit Header")
    var
        DepartmentReg: Record "Audit Header";
        AuditLines: Record "Audit Lines";
        DepartmentLines: Record "Audit Lines";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        AuditSetup.Get();
        AuditSetup.TESTFIELD("Risk Register Nos");
        DepartmentReg.Init();
        DepartmentReg.TransferFields(Audit);
        DepartmentReg.Type:=DepartmentReg.Type::"Department Register";
        DepartmentReg."No.":=NoSeriesManagement.GetNextNo(AuditSetup."Risk Register Nos", 0D, TRUE);
        DepartmentReg.Insert;
        AuditLines.SetRange("Document No.", Audit."No.");
        if AuditLines.Find('-')then begin
            repeat DepartmentLines.Init();
                DepartmentLines.TransferFields(AuditLines);
                DepartmentLines."Document No.":=DepartmentReg."No.";
                DepartmentLines.Insert(true);
            until AuditLines.Next() = 0;
        end;
    end;
    procedure MailRiskSurvey(Audit: Record "Audit Header")
    var
        Instr: InStream;
        EmailBodyText: Text;
        EmailBodyBigText: BigText;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        // SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Subject: Text;
        FileName: Text;
        Email: Codeunit Email;
        TimeNow: Text;
        RecipientCC: Text;
        Attachment: Text;
        ErrorMsg: Text;
        Audit2: Record "Audit Header";
        ConfirmSurveySendMssg: Label 'Do you wish to send the Risk Survey Report %1?';
        RiskSurveyEmailBody: Label 'Dear <Strong>%1</Strong> <br><br>Kindly find attached a Risk Survey Report.<br><br>Thank you.<br><br>Regards,<br><br>%2';
        Champions: Record "Internal Audit Champions";
    begin
        AuditSetup.GET;
        CompanyInfo.GET;
        IF NOT CONFIRM(ConfirmSurveySendMssg, TRUE, Audit."No.")THEN EXIT
        ELSE
        BEGIN
            IF NOT Audit."Notification Sent" THEN BEGIN
                FileName:=(AuditSetup."Attachment Path" + 'Audit Survey ' + Audit."Employee No." + '.pdf');
                Audit2.RESET;
                Audit2.SETRANGE("No.", Audit."No.");
            //EDDIE REPORT.SAVEASPDF(Report::"Risk Survey", FileName, Audit2);
            END;
            //Get Risk Champions
            Champions.RESET;
            Champions.SETRANGE(Type, Champions.Type::Risk);
            IF Champions.FIND('-')THEN REPEAT SenderName:=Audit."Employee Name";
                    //SenderAddress := CompanyInfo."E-Mail";
                    SenderAddress:=Audit."Sender E-Mail";
                    Receipients.Add(Champions."E-Mail");
                    Subject:=('Risk Survey ' + Audit."No.");
                    TimeNow:=FORMAT(TIME);
                    Emailmessage.Create(Receipient, Subject, '', true);
                    Emailmessage.AppendtoBody(STRSUBSTNO(RiskSurveyEmailBody, Champions."Employee Name", Audit."Employee Name"));
                    Emailmessage.AddAttachment(FileName, Attachment, '');
                    Email.send(Emailmessage);
                UNTIL Champions.NEXT = 0;
            MESSAGE('Risk Survey sent Successfully');
            Audit."Notification Sent":=TRUE;
            Audit.MODIFY;
        END;
    end;
    procedure MailReportDeadlineReminder()
    var
        AuditLines: Record "Audit Lines";
        Instr: InStream;
        EmailBodyText: Text;
        EmailBodyBigText: BigText;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        // SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: Text;
        Attachment: Text;
        ErrorMsg: Text;
        ReminderMssg: Label 'Dear <Strong>%1</Strong>, <br><br>This is reminder Email on the Recommended Action on the Audit Report %2 for %3 Department that you were assigned as the Responsible Personnel. <br><br>Kindly work on the recommedation.<br><br>The Due Date is on <Strong>%4</Strong>.<br><br>Thank you.<br><br>Regards,<br><br>%5.';
    begin
        CompanyInfo.GET;
        CompanyInfo.TESTFIELD("E-Mail");
        AuditLines.RESET;
        AuditLines.SETRANGE("Reminder Sent", FALSE);
        IF AuditLines.FIND('-')THEN BEGIN
            CASE AuditLines."Audit Line Type" OF AuditLines."Audit Line Type"::"Report Recommendation": BEGIN
                REPEAT AuditSetup.GET;
                    IF CALCDATE(AuditSetup."Report Deadline Reminder", AuditLines.Date) = TODAY THEN //Get Employee
                        IF Employee.GET(AuditLines."Responsible Personnel Code")THEN BEGIN
                            IF Employee."E-Mail" <> '' THEN Receipient.Add(Employee."E-Mail")
                            ELSE
                                EXIT;
                        END;
                    //Get Header
                    SenderName:=CompanyInfo.Name;
                    SenderAddress:=CompanyInfo."E-Mail";
                    Subject:='Audit Reminder';
                    TimeNow:=FORMAT(TIME);
                    FileName:='';
                    Emailmessage.Create(Receipient, Subject, '', true);
                    Emailmessage.AppendtoBody(STRSUBSTNO(ReminderMssg, Employee."First Name", AuditHeader."No.", GetDimensionValue(AuditHeader."Shortcut Dimension 2 Code"), FORMAT(AuditLines.Date, 0, '<Day,2> <Month Text> <Year4>'), CompanyInfo.Name));
                    Emailmessage.AddAttachment(FileName, Attachment, '');
                    Email.send(Emailmessage);
                    //Modify as Sent
                    AuditLines."Reminder Sent":=TRUE;
                    AuditLines.MODIFY;
                UNTIL AuditLines.NEXT = 0;
            END;
            END;
        END;
    end;
    local procedure InsertApprover(DocNo: Code[50]; var UserName: Code[50])
    var
        AuditHeader: Record "Audit Header";
    begin
        IF AuditHeader.GET(DocNo)THEN AuditHeader."Reviewed By":=UserName;
    end;
    procedure GetAuditCommunicationDept(DocNo: Code[50])
    var
        FilterDept: FilterPageBuilder;
        DimVal: Record "Dimension Value";
        CommLines: Record "Communication Lines";
    begin
        CLEAR(FilterDept);
        FilterDept.ADDTABLE(DimVal.TABLENAME, DATABASE::"Dimension Value");
        FilterDept.ADDFIELD(DimVal.TABLENAME, DimVal."Global Dimension No.");
        FilterDept.ADDFIELD(DimVal.TABLENAME, DimVal.Code);
        FilterDept.ADDFIELD(DimVal.TABLENAME, DimVal.Name);
        IF NOT FilterDept.RUNMODAL THEN EXIT;
        DimVal.SETVIEW(FilterDept.GETVIEW(DimVal.TABLENAME));
        IF DimVal.FINDSET THEN REPEAT CommLines.INIT;
                CommLines."No.":=DocNo;
                CommLines.Category:=CommLines.Category::Department;
                CommLines."Recipient No.":=DimVal.Code;
                CommLines."Recipient Name":=DimVal.Name;
                CommLines.INSERT;
            UNTIL DimVal.NEXT = 0;
    end;
    procedure GetWorkPaperProgramNo(AuditHead: Record "Audit Header")
    var
        Audit2: Record "Audit Header";
        AuditLine: Record "Audit Lines";
        TempAudit: Record "Audit Header";
    begin
    /*
        IF AuditHeader.GET(AuditHead."Audit Program No.") THEN BEGIN
            CASE AuditHead.Type OF
                AuditHead.Type::"Work Paper":
                    BEGIN
                        AuditHead."Done By" := AuditHeader."Created By";
                        AuditHead."Done By Name" := AuditHeader."Employee Name";
                        AuditHead.MODIFY(TRUE);
                        COMMIT;
                    END;
            END;
        END;
        */
    end;
    procedure UpdateWorkPaperReviewer(AuditHead: Record "Audit Header")
    var
        Audit2: Record "Audit Header";
    begin
        IF Audit2.GET(AuditHeader."No.")THEN BEGIN
            CASE Audit2.Type OF Audit2.Type::"Work Paper": BEGIN
                Audit2."Reviewed By":=USERID;
            //Audit2."Reviewed By Name" := GetEmployeeName(USERID);
            //Audit2."Date Reviewed" := TODAY;
            END;
            END;
        END;
    end;
    procedure GetReviewAuditee(AuditHeader: Record "Audit Header")
    var
        AuditLines: Record "Audit Lines";
        UserSetup: Record "User Setup";
    begin
        CASE AuditHeader.Type OF AuditHeader.Type::"Audit Report": BEGIN
            AuditLines.RESET;
            AuditLines.SETRANGE("Document No.", AuditHeader."No.");
            IF AuditLines.FIND('-')THEN BEGIN
                CASE AuditLines."Audit Line Type" OF AuditLines."Audit Line Type"::"Report Recommendation": BEGIN
                    REPEAT UserSetup.RESET;
                        UserSetup.SETRANGE("Employee No.", AuditLines."Responsible Personnel Code");
                        IF UserSetup.FIND('-')THEN BEGIN
                            //AuditHeader.Auditee := UserSetup."User ID";
                            AuditHeader.MODIFY;
                        END;
                    UNTIL AuditLines.NEXT = 0;
                END;
                END;
            END;
        END;
        END;
    end;
    procedure GetEmployeeEmail(EmployeeNo: Code[50]): Text[250]var
        Employee: Record Employee;
    begin
        IF Employee.GET(EmployeeNo)THEN EXIT(Employee."Company E-Mail");
    end;
    procedure NotifyAuditorReportChanges(AuditHeader: Record "Audit Header")
    var
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: Text;
        Attachment: Text;
        ErrorMsg: Text;
        SentReportMssg: Label 'Do you want to Send back the Audit Report %1?';
        SentReportEmail: Label 'Dear %1, <br><br> This is to notify you that the Audit Report %2 has been reviewed by the Auditee %3. <br><br>Thank you.<br><br>Regards,<br><br>%4';
        AuditeeName: Text;
    begin
        AuditSetup.GET;
        IF NOT CONFIRM(SentReportMssg, FALSE, AuditHeader."No.")THEN EXIT
        ELSE
        BEGIN
        /*
            IF NOT AuditHeader."User Reviewed" THEN BEGIN
                IF UserSetup.GET(AuditHeader.Auditee) THEN BEGIN
                    SenderName := GetEmployeeName(UserSetup."Employee No.");
                    SenderAddress := GetEmployeeEmail(UserSetup."Employee No.");
                    Receipient.Add(GetUserIDEmail(AuditHeader."Created By"));
                    Subject := ('Audit Report Review');
                    TimeNow := FORMAT(TIME);
                    Emailmessage.Create(SenderName, SenderAddress, Receipient, Subject, '');
                    Emailmessage.AppendtoBody(STRSUBSTNO(SentReportEmail, 'Sir/Madam', AuditHeader."No.", SenderName, SenderName));
                    Emailmessage.AddAttachment(FileName, Attachment,'');
                    Email.send(Emailmessage);
                END;
                AuditHeader."User Reviewed" := TRUE;
                AuditHeader.MODIFY;
            END;
            */
        END;
    end;
    procedure GetUserIDEmail(UserName: Code[100]): Text[250]var
        Employee: Record Employee;
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.GET(UserName)THEN BEGIN
            IF Employee.GET(UserSetup."Employee No.")THEN EXIT(Employee."E-Mail");
        END;
    end;
    procedure NotifySenderOnChanges(var RiskHeader: Record "Risk Header")
    var
        ConfirmSendRisk: Label 'Do you want to send the Risk Document %1 to %2?';
        SenderEmailBody: Label 'Dear Sir/Madam,<br><br> A risk with ID : <Strong>%1</Strong> that you created was rejected. Thank you<br><br>Kind Regards';
        Text001: Label 'Sending Risk : #1###############';
        SendingMssg: Label 'Sending Risk :  #1##########';
    begin
        if not Confirm(ConfirmSendRisk, true, RiskHeader."No.", RiskHeader."Employee No.")then exit
        else
        begin
            CompanyInfo.GET;
            CompanyInfo.TESTFIELD(Name);
            CompanyInfo.TESTFIELD("E-Mail");
            Window.Open(SendingMssg);
            Window.Update(1, RiskHeader."No.");
            SenderName:=CompanyInfo.Name;
            SenderAddress:=CompanyInfo."E-Mail";
            Receipient.Add(GetEmployeeEmailFromUserID(RiskHeader."Created By"));
            TimeNow:=FORMAT(TIME);
            Subject:='Risk ' + RiskHeader."No.";
            Emailmessage.Create(Receipient, Subject, '', TRUE);
            Emailmessage.AppendtoBody(STRSUBSTNO(SenderEmailBody, RiskHeader."No."));
            IF ReceipientCC.Count <> 0 then //SMTP.AddCC(ReceipientCC);
                if Receipient.Count <> 0 then Email.send(Emailmessage);
            Window.CLOSE;
            RiskHeader."Document Status":=RiskHeader."Document Status"::New;
            RiskHeader.MODIFY(TRUE);
        end;
    end;
    procedure NotifyIncidSenderOnChanges(var Incident: Record "User Support Incident")
    var
        ConfirmSendRisk: Label 'Do you want to send the Incident document %1 to %2?';
        SenderEmailBody: Label 'Dear Sir/Madam,<br><br> An incident with reference : <Strong>%1</Strong> that you created was rejected. Thank you<br><br>Kind Regards';
        Text001: Label 'Sending Risk : #1###############';
        SendingMssg: Label 'Sending Risk :  #1##########';
    begin
        if not Confirm(ConfirmSendRisk, false, Incident."Incident Reference", Incident."Employee No")then exit
        else
        begin
            CompanyInfo.GET;
            CompanyInfo.TESTFIELD(Name);
            CompanyInfo.TESTFIELD("E-Mail");
            Window.Open(SendingMssg);
            Window.Update(1, RiskHeader."No.");
            SenderName:=CompanyInfo.Name;
            SenderAddress:=CompanyInfo."E-Mail";
            Receipient.Add(GetEmployeeEmailFromUserID(Incident.User));
            TimeNow:=FORMAT(TIME);
            Subject:='Risk ' + Incident."Incident Reference";
            Emailmessage.Create(Receipient, Subject, '', TRUE);
            Emailmessage.AppendtoBody(STRSUBSTNO(SenderEmailBody, Incident."Incident Reference"));
            IF ReceipientCC.Count <> 0 then //eddie SMTP.AddCC(ReceipientCC);
                if Receipient.Count <> 0 then Email.send(Emailmessage);
            Window.CLOSE;
        end;
    end;
    procedure InsertRiskRegister(AuditHeader: Record "Audit Header")
    var
        AuditLine: Record "Audit Lines";
        RiskRegister: Record "Risk Register";
    begin
        AuditSetup.GET;
        AuditLine.RESET;
        AuditLine.SETRANGE("Document No.", AuditHeader."No.");
        AuditLine.SETFILTER("Audit Line Type", '%1|%2', AuditLine."Audit Line Type"::"Internal Risk", AuditLine."Audit Line Type"::"External Risk");
        IF AuditLine.FIND('-')THEN BEGIN
            REPEAT BEGIN
            END;
            UNTIL AuditLine.NEXT = 0;
        END;
    end;
    procedure SendtoRiskChampion(var RiskHeader: Record "Risk Header")
    var
        ConfirmSendRisk: Label 'Do you want to send the Risk Document %1 to %2 Department?';
        RiskChampionsEmailBody: Label 'Dear Sir/Madam,<br><br> A risk with ID : <Strong>%1</Strong> has been associated with your Department <Strong>%2</Strong>. <br><br> The Risk was identified on %3 by %4.<br><br>Thank you<br><br>Kind Regards,<br><br>%5';
        Text001: Label 'Sending Risk : #1###############';
        Text002: Label 'Department Code : #2###############';
        Text003: Label 'Department Name : #3###############';
        SendingMssg: Label 'Sending Risk :  #1##########\\Department Code:@2@@@@@@@@@@@@@\Department Name :@3@@@@@@@@@@@@@';
    begin
        if not Confirm(ConfirmSendRisk, true, RiskHeader."No.", RiskHeader."Risk Region Name")then exit
        else
        begin
            CompanyInfo.GET;
            CompanyInfo.TESTFIELD(Name);
            CompanyInfo.TESTFIELD("E-Mail");
            Window.Open(SendingMssg);
            Window.Update(1, RiskHeader."No.");
            Window.Update(2, RiskHeader."Risk Region");
            Window.Update(3, RiskHeader."Risk Region Name");
            SenderName:=CompanyInfo.Name;
            SenderAddress:=CompanyInfo."E-Mail";
            Receipient.Add(GetRiskChampionsDeptEmails(RiskHeader."Risk Region"));
            //ReceipientCC.Add(GetRiskOfficersEmails);
            TimeNow:=FORMAT(TIME);
            Subject:='Risk ' + RiskHeader."No." + ' ' + RiskHeader."Risk Region Name";
            Emailmessage.Create(Receipient, Subject, '', TRUE);
            Emailmessage.AppendtoBody(STRSUBSTNO(RiskChampionsEmailBody, RiskHeader."No.", RiskHeader."Risk Region Name", Format(RiskHeader."Date Identified", 0, '<Month Text> <Closing><Day>, <Year4>'), RiskHeader."Employee Name", CompanyInfo.Name));
            IF ReceipientCC.Count <> 0 then //eddieSMTP.AddCC(ReceipientCC);
                if Receipient.Count <> 0 then Email.send(Emailmessage);
            Window.CLOSE;
        end;
        RiskHeader."Document Status":=RiskHeader."Document Status"::HOD;
        RiskHeader.MODIFY(TRUE);
    end;
    procedure SendMailtoRiskChampion2(var RiskHeader: Record "Risk Header")
    var
        ConfirmSendRisk: Label 'Do you want to send the Risk Document %1 to %2 Department?';
        RiskChampionsEmailBody: Label 'Dear Sir/Madam,<br><br> A risk with ID : <Strong>%1</Strong> has been associated with your Department <Strong>%2</Strong> and escalated to you. <br><br> The Risk was identified on %3 by %4.<br><br>Thank you<br><br>Kind Regards,<br><br>%5';
        Text001: Label 'Sending Risk : #1###############';
        Text002: Label 'Department Code : #2###############';
        Text003: Label 'Department Name : #3###############';
        SendingMssg: Label 'Sending Risk :  #1##########\\Department Code:@2@@@@@@@@@@@@@\Department Name :@3@@@@@@@@@@@@@';
    begin
        if not Confirm(ConfirmSendRisk, true, RiskHeader."No.", RiskHeader."Risk Region Name")then exit
        else
        begin
            CompanyInfo.GET;
            CompanyInfo.TESTFIELD(Name);
            CompanyInfo.TESTFIELD("E-Mail");
            Window.Open(SendingMssg);
            Window.Update(1, RiskHeader."No.");
            Window.Update(2, RiskHeader."Risk Region");
            Window.Update(3, RiskHeader."Risk Region Name");
            SenderName:=CompanyInfo.Name;
            SenderAddress:=CompanyInfo."E-Mail";
            Receipient.Add(GetRiskChampions2DeptEmails(RiskHeader."Risk Region"));
            //ReceipientCC.Add(GetRiskOfficersEmails);
            TimeNow:=FORMAT(TIME);
            Subject:='Risk ' + RiskHeader."No." + ' ' + RiskHeader."Risk Region Name";
            Emailmessage.Create(Receipient, Subject, '', TRUE);
            Emailmessage.AppendtoBody(STRSUBSTNO(RiskChampionsEmailBody, RiskHeader."No.", RiskHeader."Risk Region Name", Format(RiskHeader."Date Identified", 0, '<Month Text> <Closing><Day>, <Year4>'), RiskHeader."Employee Name", CompanyInfo.Name));
            IF ReceipientCC.Count <> 0 then //eddieSMTP.AddCC(ReceipientCC);
                if Receipient.Count <> 0 then Email.send(Emailmessage);
            Window.CLOSE;
        end;
        RiskHeader."Document Status":=RiskHeader."Document Status"::MD;
        RiskHeader.MODIFY(TRUE);
    end;
    procedure SendtoRiskOfficer(var RiskHeader: Record "Risk Header")
    begin
        IF NOT CONFIRM(ConfirmSendtoOfficer, FALSE, RiskHeader."No.")THEN EXIT
        ELSE
        BEGIN
            RiskHeader."Document Status":=RiskHeader."Document Status"::HOD;
            RiskHeader.MODIFY(TRUE);
        END;
    end;
    procedure SendtoHOD(var RiskHeader: Record "Risk Header")
    var
        SentToHODSuccessfully: Label 'The Risk Document %1 has been sent Successfully to the HOD.';
        HODMailBody: Label 'Dear %1,<br><br>There is an Identified Risk %2 that is related to your Department.<br><br>Thank you.<br><br>Regards,<br><br>%3';
    begin
        IF NOT CONFIRM(ConfirmSendtoHOD, FALSE, RiskHeader."No.")THEN EXIT
        ELSE
        BEGIN
            IF CONFIRM(ConfirmSendEmailtoHOD, FALSE)THEN BEGIN
                CompanyInfo.GET;
                CompanyInfo.TESTFIELD(Name);
                CompanyInfo.TESTFIELD("E-Mail");
                SenderName:=CompanyInfo.Name;
                SenderAddress:=CompanyInfo."E-Mail";
                Receipient.Add(GetDeptHOD(RiskHeader."Risk Region", RiskHeader."Risk Department"));
                ReceipientCC.Add(GetRiskOfficersEmails);
                Subject:='Risk Identified';
                TimeNow:=FORMAT(TIME);
                Emailmessage.Create(Receipient, Subject, '', TRUE);
                Emailmessage.AppendtoBody(STRSUBSTNO(HODMailBody, 'Sir/Madam', RiskHeader."No.", CompanyInfo.Name));
                IF ReceipientCC.Count <> 0 THEN //SMTP.AddCC(ReceipientCC);
                    Email.send(Emailmessage);
            END;
            RiskHeader."Document Status":=RiskHeader."Document Status"::HOD;
            RiskHeader.MODIFY(TRUE);
            MESSAGE(SentToHODSuccessfully, RiskHeader."No.");
        END;
    end;
    procedure SendtoRiskChampion2(var RiskHeader: Record "Risk Header")
    begin
        IF NOT CONFIRM(ConfirmSendtoChampion2, FALSE, RiskHeader."No.")THEN EXIT
        ELSE
        BEGIN
            RiskHeader."Document Status":=RiskHeader."Document Status"::"Board Review";
            RiskHeader.MODIFY(TRUE);
        END;
    end;
    procedure SendToRiskRegister(var RiskHeader: Record "Risk Header"; Type: Option " ", Corporate, Department, Project)
    var
        RiskLine: Record "Risk Line";
    begin
        RiskHeader.TestField("Mark Okay", true);
        RiskLine.RESET;
        RiskLine.SETRANGE("Document No.", RiskHeader."No.");
        RiskLine.SETFILTER(Type, '%1|%2|%3', RiskLine.Type::"KRI(s)", RiskLine.Type::Response, RiskLine.Type::"Risk Category");
        IF RiskLine.FIND('-')THEN BEGIN
            REPEAT RiskRegister.INIT;
                GetNextEntryNo;
                RiskRegister."Entry No.":=NextEntryNo;
                RiskRegister."Document No.":=RiskHeader."No.";
                RiskRegister."Global Dimension 1 Code":=RiskHeader."Risk Region";
                RiskRegister."Global Dimension 2 Code":=RiskHeader."Risk Department";
                RiskRegister."Risk Type":=RiskHeader.Type;
                RiskHeader.CALCFIELDS("Risk Description");
                RiskRegister."Risk Description":=RiskHeader."Risk Description";
                RiskRegister."Document Line No.":=RiskLine."Line No.";
                CASE Type OF Type::Corporate: RiskRegister.Type:=RiskRegister.Type::Corporate;
                Type::Department: RiskRegister.Type:=RiskRegister.Type::Department;
                Type::Project: RiskRegister.Type:=RiskRegister.Type::Project;
                END;
                RiskRegister."Project Code":=RiskHeader."Project Code";
                RiskRegister."Value at Risk Amount":=RiskHeader."Value at Risk";
                RiskRegister."Gross (L*I)":=RiskHeader."Risk (L * I)";
                RiskRegister."Residual (L*I)":=RiskHeader."Residual Risk (L * I)";
                CASE RiskLine.Type OF RiskLine.Type::"KRI(s)": BEGIN
                    RiskRegister."KRI(s) Status":=RiskLine."KRI(s) Status";
                    RiskRegister."KRI(s) Description":=RiskLine.Description;
                END;
                RiskLine.Type::Response: BEGIN
                    RiskRegister."Mitigation Status":=RiskLine."Mitigation Status";
                    RiskRegister."Mitigation Owner":=RiskLine."Mitigation Owner";
                    RiskRegister."Mitigation Action":=RiskLine."Mitigation Actions";
                END;
                RiskLine.Type::"Risk Category": BEGIN
                    RiskRegister.Category:=RiskLine."Risk Category";
                END;
                END;
                RiskRegister.Archive:=FALSE;
                RiskRegister.INSERT;
            UNTIL RiskLine.NEXT = 0;
        END;
        RiskHeader."Document Status":=RiskHeader."Document Status"::Closed;
        RiskHeader.MODIFY(TRUE);
    end;
    procedure UpdateRiskMitigation(var RiskLine: Record "Risk Line")
    var
        RiskLine2: Record "Risk Line";
        ConfirmChange: Label 'Do you want to update the Risk Status?';
    begin
        IF NOT CONFIRM(ConfirmChange, FALSE)THEN EXIT
        ELSE
        BEGIN
            RiskLine2.RESET;
            RiskLine2.SETRANGE("Document No.", RiskLine."Document No.");
            RiskLine2.SETRANGE(Type, RiskLine2.Type::"KRI(s)");
            IF RiskLine2.FIND('-')THEN BEGIN
                RiskLedger.INIT;
                RiskLedger."Entry No.":=RiskLedger."Entry No." + 1;
                RiskLedger."Document No.":=RiskLine2."Document No.";
                RiskLedger."Mitigation Status":=RiskLine2."Mitigation Status";
                RiskLedger."Mitigation KRI(s)":=RiskLine2."KRI(s) Status";
                RiskLedger.INSERT;
            END;
            RiskLine2.RESET;
            RiskLine2.SETRANGE("Document No.", RiskLine."Document No.");
            RiskLine2.SETRANGE(Type, RiskLine2.Type::"KRI(s)");
            RiskLine2.DELETEALL;
            RiskLine2.INIT;
            RiskLine2."Document No.":=RiskLine."Document No.";
            RiskLine2.Type:=RiskLine2.Type::"KRI(s)";
            RiskLine2."KRI(s) Status":=RiskLine."KRI(s) Status";
            RiskLine2."Mitigation Status":=RiskLine."Mitigation Status";
            RiskLine2.Target:=RiskLine."Mitigation Status";
            RiskLine2.Tolerance:=RiskLine."KRI(s) Status";
            RiskLine2.INSERT;
        END;
    end;
    procedure UpdateRiskMitigation2(var RiskLine: Record "Risk Line")
    var
        RiskLine2: Record "Risk Line";
        ConfirmChange: Label 'Do you want to update the Risk Status?';
    begin
        IF NOT CONFIRM(ConfirmChange, FALSE)THEN EXIT
        ELSE
        BEGIN
            RiskRegisterMEUpdate(RiskLine);
            RiskLine2.RESET;
            RiskLine2.SETRANGE("Document No.", RiskLine."Document No.");
            RiskLine2.SETRANGE(Type, RiskLine2.Type::"KRI(s)");
            IF RiskLine2.FIND('-')THEN BEGIN
                RiskValueSetup.RESET;
                RiskValueSetup.SETRANGE(Type, RiskValueSetup.Type::"Risk Appetite");
                IF RiskValueSetup.FIND('-')THEN BEGIN
                    CASE TRUE OF(RiskLine2.Tolerance >= RiskValueSetup."Start Value") AND (RiskLine2.Tolerance <= RiskValueSetup."End Value"): BEGIN
                        /*RiskLine2.RESET;
                                RiskLine2.SETRANGE("Document No.",RiskLine."Document No.");
                                RiskLine2.SETRANGE(Type,RiskLine2.Type::"KRI(s)");
                                IF RiskLine2.FINDSET THEN
                                  RiskLine2.DELETEALL;*/
                        RiskLine2.RESET;
                        RiskLine2.SETRANGE("Document No.", RiskLine."Document No.");
                        IF RiskLine2.FIND('-')THEN REPEAT RiskLine2.Appetite:=RiskValueSetup.Value;
                                RiskLine2.MODIFY;
                            UNTIL RiskLine2.NEXT = 0;
                    END;
                    END;
                END;
            END;
            RiskLine2.RESET;
            RiskLine2.SETRANGE("Document No.", RiskLine."Document No.");
            IF RiskLine.FINDFIRST THEN BEGIN
                IF RiskHeader.GET(RiskLine2."Document No.")THEN BEGIN
                END;
            END;
        END;
    end;
    procedure MailAuditeeReport(var AuditHeader: Record "Audit Header")
    var
        ConfrimSendtoAuditee: Label 'Do you want to Send the Audit Report %1 to the Auditee %2 - %3?';
        AuditeeReportEmail: Label 'Dear %1, <br><br>An Audit Report %2 has been sent to you. Kindly look at it then send it back to the Auditor. <br><br> Thank you.<br><br>Regards,<br><br>%3';
    begin
    /*
        IF NOT CONFIRM(ConfrimSendtoAuditee, FALSE, AuditHeader."No.", AuditHeader.Auditee, GetEmployeeName(AuditHeader."Auditee User ID")) THEN
            EXIT
        ELSE BEGIN
            AuditHeader.TESTFIELD(Auditee);
            AuditHeader.TESTFIELD("Auditee User ID");

            CompanyInfo.GET;
            CompanyInfo.TESTFIELD(Name);
            CompanyInfo.TESTFIELD("E-Mail");

            SenderName := CompanyInfo.Name;
            SenderAddress := CompanyInfo."E-Mail";
            Receipient := GetEmployeeEmail(AuditHeader.Auditee);
            Subject := 'Audit Report';
            TimeNow := FORMAT(TIME);

            Emailmessage.Create(SenderName, SenderAddress, Receipient, Subject, '', TRUE);
            Emailmessage.AppendtoBody(STRSUBSTNO(AuditeeReportEmail, GetEmployeeName(AuditHeader."Auditee User ID"), AuditHeader."No.", CompanyInfo.Name));
            Email.send(Emailmessage);

            AuditHeader."Report Status" := AuditHeader."Report Status"::Auditee;
            AuditHeader.MODIFY(TRUE);
        END;
        */
    end;
    procedure MailAuditorReport(var AuditHeader: Record "Audit Header")
    var
        ConfrimSendtoAuditor: Label 'Do you want to Send the Audit Report %1 to the Auditor?';
        AuditorReportEmail: Label 'Dear %1, <br><br>An Audit Report %2 has been send to you from the Auditee %3 - %4 <br><br> Thank you.<br><br>Regards,<br><br>%5';
    begin
        IF NOT CONFIRM(ConfrimSendtoAuditor, FALSE, AuditHeader."No.")THEN EXIT
        ELSE
        BEGIN
            CompanyInfo.GET;
            CompanyInfo.TESTFIELD(Name);
            CompanyInfo.TESTFIELD("E-Mail");
            SenderName:=CompanyInfo.Name;
            SenderAddress:=CompanyInfo."E-Mail";
            Receipient.Add(GetEmployeeEmailFromUserID(AuditHeader."Created By"));
            Subject:='Audit Report';
            TimeNow:=FORMAT(TIME);
            Emailmessage.Create(Receipient, Subject, '', TRUE);
            Emailmessage.AppendtoBody(STRSUBSTNO(AuditorReportEmail, GetEmployeeName(AuditHeader."Created By"), AuditHeader."No.", AuditHeader.Auditee, GetEmployeeName(AuditHeader."Auditee User ID"), CompanyInfo.Name));
            Email.send(Emailmessage);
            AuditHeader."Report Status":=AuditHeader."Report Status"::Audit;
            AuditHeader.MODIFY(TRUE);
        END;
    end;
    procedure GetEmployeeEmailFromUserID(UserName: Code[50]): Text[100]begin
        IF UserSetup.GET(UserName)THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE("No.", UserSetup."Employee No.");
            IF Employee.FINDFIRST THEN EXIT(Employee."Company E-Mail");
        END;
    end;
    local procedure GetRiskOfficersEmails(): Text var
        i: Integer;
        RiskOfficerMails: Text;
        j: Integer;
        EmployeeEmail: array[1000]of Text;
        EmployeeMail: array[100]of Text;
    begin
        AuditSetup.GET;
        AuditSetup.TESTFIELD("Risk Officer Job ID");
        i:=0;
        IF AuditSetup."Risk Officer Job ID" <> '' THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE("Job Position", AuditSetup."Risk Officer Job ID");
            IF Employee.FIND('-')THEN BEGIN
                REPEAT i:=i + 1;
                    EmployeeMail[i]:=Employee."E-Mail";
                UNTIL Employee.NEXT = 0;
            END;
            RiskOfficerMails:='';
            FOR j:=1 TO i DO BEGIN
                IF j = 1 THEN RiskOfficerMails:=EmployeeMail[j]
                ELSE
                    RiskOfficerMails:=RiskOfficerMails + ';' + EmployeeMail[j];
            END;
        END;
        EXIT(RiskOfficerMails);
    end;
    local procedure GetRiskChampionsDeptEmails(RiskRegion: Code[100]): Text var
        RiskChampions: Record "Internal Audit Champions";
        RiskChampionsEmails: Text;
        i: Integer;
        j: Integer;
        ChampionEmail: array[1000]of Text;
    begin
        //RiskChampions.Reset();
        RiskChampions.SetRange("Shortcut Dimension 1 Code", RiskRegion);
        if RiskChampions.FindFirst()then exit(RiskChampions."E-Mail");
    end;
    local procedure GetRiskChampions2DeptEmails(RiskRegion: Code[100]): Text var
        RiskChampions: Record "Internal Audit Champions";
        Employee: Record Employee;
        RiskChampionsEmails: Text;
        i: Integer;
        j: Integer;
        ChampionEmail: array[1000]of Text;
    begin
        //RiskChampions.Reset();
        RiskChampions.SetRange("Shortcut Dimension 1 Code", RiskRegion);
        if RiskChampions.FindFirst()then begin
            IF Employee.GET(RiskChampions."Escalator ID")THEN EXIT(Employee."Company E-Mail");
        end;
    end;
    procedure SendDocBackToRiskChampion(var RiskHeader: Record "Risk Header")
    var
        ConfirmSendBackMssg: Label 'Do you want to send the Document %1 back to the Risk Officer?';
        SentBackSuccessfully: Label 'The Document %1 has been sent back Successfully.';
    begin
        IF NOT CONFIRM(ConfirmSendBackMssg, FALSE, RiskHeader."No.")THEN EXIT
        ELSE
        BEGIN
            RiskHeader."Document Status":=RiskHeader."Document Status"::HOD;
            RiskHeader.MODIFY(TRUE);
            MESSAGE(SentBackSuccessfully, RiskHeader."No.");
        END;
    end;
    procedure SendtoRiskCreator(var RiskHeader: Record "Risk Header")
    var
        ConfirmSendRisk: Label 'Do you want to send the Risk Document %1 to %2 Department?';
        RiskChampionsEmailBody: Label 'Dear Sir/Madam,<br><br> A risk with ID : <Strong>%1</Strong> associated to your Department <Strong>%2</Strong>. <br><br> The Risk was identified on %3 by %4.<br><br>Thank you<br><br>Kind Regards,<br><br>%5';
        Text001: Label 'Sending Risk : #1###############';
        Text002: Label 'Department Code : #2###############';
        Text003: Label 'Department Name : #3###############';
        SendingMssg: Label 'Sending Risk :  #1##########\\Department Code:@2@@@@@@@@@@@@@\Department Name :@3@@@@@@@@@@@@@';
    begin
        CompanyInfo.GET;
        CompanyInfo.TESTFIELD(Name);
        CompanyInfo.TESTFIELD("E-Mail");
        Window.Open(SendingMssg);
        Window.Update(1, RiskHeader."No.");
        SenderName:=CompanyInfo.Name;
        SenderAddress:=CompanyInfo."E-Mail";
        Receipient.Add(GetRiskChampionsDeptEmails(RiskHeader."Risk Region"));
        //ReceipientCC.Add(GetRiskOfficersEmails);
        TimeNow:=FORMAT(TIME);
        Subject:='Risk ' + RiskHeader."No." + ' ' + RiskHeader."Risk Region Name";
        Emailmessage.Create(Receipient, Subject, '', TRUE);
        Emailmessage.AppendtoBody(STRSUBSTNO(RiskChampionsEmailBody, RiskHeader."No.", RiskHeader."Risk Region Name", Format(RiskHeader."Date Identified", 0, '<Month Text> <Closing><Day>, <Year4>'), RiskHeader."Employee Name", CompanyInfo.Name));
        IF ReceipientCC.Count <> 0 then //edddieSMTP.AddCC(ReceipientCC);
            if Receipient.Count <> 0 then Email.send(Emailmessage);
        Window.CLOSE;
    end;
    procedure RiskRegistersSTRNMenu(var RiskHeader: Record "Risk Header")
    var
        MenuSet: Label 'Department,Project';
        Selection: Integer;
        ConfirmSendToRegisterMssg: Label 'Do you wnat to send the Risk %1 to the Registers?';
    begin
        IF NOT CONFIRM(ConfirmSendToRegisterMssg, FALSE, RiskHeader."No.")THEN EXIT
        ELSE
        BEGIN
            CASE RiskHeader."Document Status" OF RiskHeader."Document Status"::HOD: DefaultOption:=1;
            RiskHeader."Document Status"::"Project Manager": DefaultOption:=2;
            END;
            Selection:=STRMENU(MenuSet, DefaultOption);
            CASE TRUE OF Selection = 1: SendToRiskRegister(RiskHeader, 2);
            Selection = 2: SendToRiskRegister(RiskHeader, 3);
            END;
            RiskHeader."Document Status":=RiskHeader."Document Status"::HOD;
            RiskHeader.MODIFY(TRUE);
        END;
    end;
    procedure SendToCorporateRegister(var RiskReg: Record "Risk Register")
    var
        RiskReg2: Record "Risk Register";
        SendToCorpRegConfirm: Label 'Do you want to Send the Risk %1 to the Corporate Register?';
        SentSuccessFully: Label 'The Risk No. %1 has been sent Successfully to the Corporate Register.';
    begin
        IF NOT CONFIRM(SendToCorpRegConfirm, FALSE, RiskReg."Document No.")THEN EXIT
        ELSE
        BEGIN
            RiskReg2.RESET;
            RiskReg2.SETRANGE("Document No.", RiskReg."Document No.");
            IF RiskReg2.FIND('-')THEN BEGIN
                REPEAT RiskReg2.Type:=RiskReg2.Type::Corporate;
                    RiskReg2.MODIFY;
                UNTIL RiskReg2.NEXT = 0;
            END;
            MESSAGE(SentSuccessFully, RiskReg."Document No.");
        END;
    end;
    procedure ArchiveRiskInRegister(RiskRegister: Record "Risk Register")
    var
        RiskRegister2: Record "Risk Register";
        ConfirmArchiveRisk: Label 'Do you want to Archive the Risk %1?';
        ArchivedMessage: Label 'The Risk %1 has been Archived Successfully.';
    begin
        IF NOT CONFIRM(ConfirmArchiveRisk, FALSE, RiskRegister."Document No.")THEN EXIT
        ELSE
        BEGIN
            RiskRegister2.RESET;
            RiskRegister2.SETRANGE("Document No.", RiskRegister."Document No.");
            IF RiskRegister2.FIND('-')THEN BEGIN
                REPEAT RiskRegister2.Archive:=TRUE;
                    RiskRegister2.MODIFY(TRUE);
                UNTIL RiskRegister2.NEXT = 0;
            END;
            MESSAGE(ArchivedMessage, RiskRegister."Document No.");
        END;
    end;
    procedure InsertReportObjectivesFromProgram(var AuditHeader: Record "Audit Header"; ProgramNo: Code[50])
    var
        AuditHeader2: Record "Audit Header";
        AuditLine2: Record "Audit Lines";
        LineNo: Integer;
    begin
        CASE AuditHeader.Type OF AuditHeader.Type::"Audit Report": BEGIN
            //Delete All Lines Available
            AuditLine2.RESET;
            AuditLine2.SETRANGE("Document No.", AuditHeader."No.");
            AuditLine2.SETRANGE("Audit Line Type", AuditLine2."Audit Line Type"::"Report Objectives");
            IF AuditLine2.FINDSET THEN AuditLine2.DELETEALL;
            GlobalAuditLine.RESET;
            GlobalAuditLine.SETRANGE("Document No.", ProgramNo);
            GlobalAuditLine.SETRANGE("Audit Line Type", GlobalAuditLine."Audit Line Type"::Objectives);
            IF GlobalAuditLine.FIND('-')THEN BEGIN
                REPEAT LineNo:=LineNo + 10000;
                    AuditLine2.INIT;
                    AuditLine2."Document No.":=AuditHeader."No.";
                    AuditLine2."Audit Line Type":=AuditLine2."Audit Line Type"::"Report Objectives";
                    AuditLine2."Line No.":=LineNo;
                    GlobalAuditLine.CALCFIELDS(Description);
                    AuditLine2.Description:=GlobalAuditLine.Description;
                    AuditLine2.INSERT;
                UNTIL GlobalAuditLine.NEXT = 0;
            END;
            IF AuditHeader2.GET(ProgramNo)THEN BEGIN
                AuditHeader2.Archived:=TRUE;
                AuditHeader2.MODIFY;
            END;
        END;
        END;
    end;
    procedure InsertScopeFromProgram(var AuditHeader: Record "Audit Header"; ProgramNo: Code[50])
    var
        AuditHeader2: Record "Audit Header";
        AuditLine2: Record "Audit Lines";
        LineNo: Integer;
    begin
        CASE AuditHeader.Type OF AuditHeader.Type::"Work Paper": BEGIN
            LineNo:=0;
            //Delete All Lines Available
            AuditLine2.RESET;
            AuditLine2.SETRANGE("Document No.", AuditHeader."No.");
            AuditLine2.SETRANGE("Audit Line Type", AuditLine2."Audit Line Type"::"WorkPaper Scope");
            IF AuditLine2.FINDSET THEN AuditLine2.DELETEALL;
            GlobalAuditLine.RESET;
            GlobalAuditLine.SETRANGE("Document No.", ProgramNo);
            GlobalAuditLine.SETRANGE("Audit Line Type", GlobalAuditLine."Audit Line Type"::Scope);
            GlobalAuditLine.SetRange("Scope Selected", true);
            IF GlobalAuditLine.FIND('-')THEN BEGIN
                REPEAT LineNo:=LineNo + 1;
                    AuditLine2.INIT;
                    AuditLine2."Document No.":=AuditHeader."No.";
                    AuditLine2."Audit Line Type":=AuditLine2."Audit Line Type"::"WorkPaper Scope";
                    AuditLine2."Line No.":=LineNo;
                    AuditLine2."Scope Line No.":=GlobalAuditLine."Line No.";
                    AuditLine2."Description 2":=GlobalAuditLine."Description 2";
                    AuditLine2.INSERT;
                UNTIL GlobalAuditLine.NEXT = 0;
            END;
        END;
        END;
    end;
    procedure GetAuditPlanStatus(var AuditHeader: Record "Audit Header")
    var
        LocalAuditHeader: Record "Audit Header";
    begin
        CASE AuditHeader.Type OF AuditHeader.Type::"Audit Program": BEGIN
            IF GlobalAuditHeader.GET(AuditHeader."Audit Plan No.")THEN BEGIN
                GlobalAuditHeader."Document Status":=GlobalAuditHeader."Document Status"::"Audit Program";
                GlobalAuditHeader.MODIFY;
            END;
        END;
        AuditHeader.Type::"Work Paper": BEGIN
            IF GlobalAuditHeader.GET(AuditHeader."Audit Program No.")THEN BEGIN
                IF LocalAuditHeader.GET(GlobalAuditHeader."Audit Plan No.")THEN BEGIN
                    LocalAuditHeader."Document Status":=LocalAuditHeader."Document Status"::"Working Paper";
                    LocalAuditHeader.MODIFY;
                END;
            END;
        END;
        AuditHeader.Type::"Audit Report": BEGIN
            IF GlobalAuditHeader.GET(AuditHeader."Audit Program No.")THEN BEGIN
                IF LocalAuditHeader.GET(GlobalAuditHeader."Audit Plan No.")THEN BEGIN
                    LocalAuditHeader."Document Status":=LocalAuditHeader."Document Status"::"Audit Report";
                    LocalAuditHeader.MODIFY;
                END;
            END;
        END;
        END;
    end;
    procedure InsertWorkpaperObservationToAuditReport(var AuditHeader: Record "Audit Header"; DocNo: Code[50])
    var
        LocalAuditLine: Record "Audit Lines";
        LocalAuditHeader: Record "Audit Header";
        LineNo: Integer;
    begin
        IF GlobalAuditHeader.GET(AuditHeader."No.")THEN BEGIN
            GlobalAuditLine.RESET;
            GlobalAuditLine.SETRANGE("Document No.", GlobalAuditHeader."No.");
            GlobalAuditLine.SETRANGE("Audit Line Type", GlobalAuditLine."Audit Line Type"::"WorkPaper Conclusion");
            IF GlobalAuditLine.FIND('-')THEN BEGIN
                REPEAT LocalAuditLine.INIT;
                    LocalAuditLine."Document No.":=DocNo;
                    IF GlobalAuditLine.Favourable THEN BEGIN
                        LocalAuditLine."Audit Line Type":=LocalAuditLine."Audit Line Type"::"Report Observation";
                        LocalAuditLine."Line No.":=GetFavObservationNo(DocNo);
                    END
                    ELSE
                    BEGIN
                        LocalAuditLine."Audit Line Type":=LocalAuditLine."Audit Line Type"::"Report Recommendation";
                        LocalAuditLine."Line No.":=GetUnFavObservationNo(DocNo);
                    END;
                    GlobalAuditLine.CALCFIELDS(Description);
                    LocalAuditLine.Description:=GlobalAuditLine.Description;
                    LocalAuditLine.INSERT;
                UNTIL GlobalAuditLine.NEXT = 0;
            END;
        END;
    end;
    procedure SendtoProjectManager(var RiskHeader: Record "Risk Header")
    var
        SentToPMSuccessfully: Label 'The Risk Document %1 has been sent Successfully to the Project Manager.';
        SendProjMgr: Label 'Dear %1,<br><br>There is an Identified Risk %2 that is related to your Project %3.<br><br>Thank you.<br><br>Regards,<br><br>%4';
    begin
        IF NOT CONFIRM(ConfirmSendtoPM, FALSE, RiskHeader."No.")THEN EXIT
        ELSE
        BEGIN
            Project.RESET;
            IF PAGE.RUNMODAL(PAGE::"Projects List", Project) = ACTION::LookupOK THEN BEGIN
                IF CONFIRM(ConfirmSendEmailtoProjectManager, FALSE)THEN BEGIN
                    Window.OPEN('Sending Risk: #1###############');
                    Window.UPDATE(1, RiskHeader."No.");
                    CompanyInfo.GET;
                    CompanyInfo.TESTFIELD(Name);
                    CompanyInfo.TESTFIELD("E-Mail");
                    SenderName:=CompanyInfo.Name;
                    SenderAddress:=CompanyInfo."E-Mail";
                    Receipient.Add(Project."Project Manager E-Mail");
                    ReceipientCC.Add(GetRiskOfficersEmails);
                    Subject:='Risk Identified';
                    TimeNow:=FORMAT(TIME);
                    Emailmessage.Create(Receipient, Subject, '', TRUE);
                    Emailmessage.AppendtoBody(STRSUBSTNO(SendProjMgr, 'Sir/Madam', RiskHeader."No.", Project."Project Code", CompanyInfo.Name));
                    IF ReceipientCC.Count <> 0 THEN //eddieSMTP.AddCC(ReceipientCC);
                        Email.send(Emailmessage);
                END;
                RiskHeader."Document Status":=RiskHeader."Document Status"::"Project Manager";
                RiskHeader."Project Code":=Project."Project Code";
                RiskHeader.MODIFY(TRUE);
                Window.CLOSE;
                MESSAGE(SentToPMSuccessfully);
            END;
        END;
    end;
    local procedure GetNextEntryNo()
    begin
        RiskRegister.LOCKTABLE;
        IF RiskRegister.FINDLAST THEN NextEntryNo:=RiskRegister."Entry No." + 1
        ELSE
            NextEntryNo:=1;
    end;
    procedure InsertAuditRecommendation(var AuditHeader: Record "Audit Header")
    var
        Recommendation: Record "Audit Recommendations";
        Auditline: Record "Audit Lines";
    begin
        Auditline.RESET;
        Auditline.SETRANGE("Document No.", AuditHeader."No.");
        Auditline.SETRANGE("Audit Line Type", Auditline."Audit Line Type"::"Report Recommendation");
        IF Auditline.FIND('-')THEN BEGIN
            REPEAT Recommendation.INIT;
                GetRecommendationEntryNo;
                Recommendation."Entry No.":=RecomEntryNo;
                Recommendation."Document No.":=AuditHeader."No.";
                Auditline.CALCFIELDS("Observation/Condition", Description);
                Recommendation."Audit Observation":=Auditline.Description;
                Recommendation."Audit Recommendation":=Auditline."Observation/Condition";
                Recommendation."Management Response":=Auditline.Remarks;
                Recommendation."Implementation Date":=Auditline.Date;
                Recommendation.INSERT(TRUE);
            UNTIL Auditline.NEXT = 0;
        END;
    end;
    local procedure GetRecommendationEntryNo()
    var
        AuditRecomm: Record "Audit Recommendations";
    begin
        AuditRecomm.LOCKTABLE;
        IF AuditRecomm.FINDLAST THEN RecomEntryNo:=AuditRecomm."Entry No." + 1
        ELSE
            RecomEntryNo:=1;
    end;
    procedure GetWorkPaperScope(var AuditHeader: Record "Audit Header")
    var
        AuditLineRec: Record "Audit Lines";
        ScopeList: Page "Select Scope - All";
        AuditLineRecCopy: Record "Audit Lines";
        AuditLine2: Record "Audit Lines";
    begin
        AuditLineRec.RESET;
        AuditLineRec.SETRANGE("Document No.", AuditHeader."Audit Program No.");
        AuditLineRec.SETRANGE("Audit Line Type", AuditLineRec."Audit Line Type"::Scope);
        AuditLineRec.SETRANGE("Scope Selected", FALSE);
        ScopeList.SETTABLEVIEW(AuditLineRec);
        ScopeList.LOOKUPMODE(TRUE);
        IF ScopeList.RUNMODAL = ACTION::LookupOK THEN BEGIN
            AuditLineRecCopy.COPY(AuditLineRec);
            AuditLineRecCopy.SETRANGE("Scope Selected", TRUE);
            IF AuditLineRecCopy.FIND('-')THEN BEGIN
                REPEAT AuditLine2.INIT;
                    AuditLine2."Document No.":=AuditHeader."No.";
                    AuditLine2."Audit Line Type":=AuditLine2."Audit Line Type"::"WorkPaper Scope";
                    AuditLine2."Line No.":=GetScopeNo(AuditHeader."No.");
                    AuditLineRecCopy.CALCFIELDS(Description);
                    AuditLine2.Description:=AuditLineRecCopy.Description;
                    AuditLine2."Scope Line No.":=AuditLineRecCopy."Line No.";
                    IF((NOT CheckProgScopeExits(AuditLine2."Document No.", AuditLine2."Scope Line No.")) AND (NOT CheckWorkpaperScopeIsNotSelected(AuditHeader."Audit Program No.", AuditLine2."Scope Line No.")))THEN AuditLine2.INSERT;
                UNTIL AuditLineRecCopy.NEXT = 0;
            END;
        END;
        OnAfterInsertWorkpaperScope(AuditHeader);
    end;
    local procedure GetDeptHOD(Dim1: Code[30]; Dim2: Code[30]): Text begin
        UserSetup.RESET;
        UserSetup.SETRANGE("Global Dimension 1 Code", Dim1);
        UserSetup.SETRANGE("Global Dimension 2 Code", Dim2);
        UserSetup.SETRANGE("HOD User", TRUE);
        IF UserSetup.FINDFIRST THEN IF Employee.GET(UserSetup."Employee No.")THEN EXIT(Employee."E-Mail");
    end;
    local procedure GetScopeLineNo(DocNo: Code[100]): Integer var
        ALine: Record "Audit Lines";
    begin
        ALine.LOCKTABLE;
        ALine.SETRANGE("Document No.", DocNo);
        ALine.SETRANGE("Audit Line Type", ALine."Audit Line Type"::"WorkPaper Scope");
        IF ALine.FINDLAST THEN ScopeLineNo:=ALine."Line No." + 1000
        ELSE
            ScopeLineNo:=1000;
    end;
    procedure GetFavObservationNo(DocNo: Code[100]): Integer var
        AuditLines: Record "Audit Lines";
    begin
        AuditLines.RESET;
        AuditLines.SETRANGE("Document No.", DocNo);
        AuditLines.SETRANGE("Audit Line Type", AuditLines."Audit Line Type"::"Report Observation");
        IF AuditLines.FINDLAST THEN EXIT(AuditLines."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;
    procedure GetUnFavObservationNo(DocNo: Code[100]): Integer var
        AuditLines: Record "Audit Lines";
    begin
        AuditLines.RESET;
        AuditLines.SETRANGE("Document No.", DocNo);
        AuditLines.SETRANGE("Audit Line Type", AuditLines."Audit Line Type"::"Report Recommendation");
        IF AuditLines.FINDLAST THEN EXIT(AuditLines."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;
    [EventSubscriber(ObjectType::Table, Database::"Audit Header", 'OnAfterInsertWorkingPapers', '', false, false)]
    procedure InsertAuditReportObservations(AuditLineRec: Record "Audit Lines")
    var
        LocalAuditLine: Record "Audit Lines";
    begin
    /*
        AuditLineRec.RESET;
        AuditLineRec.SETRANGE("Document No.", AuditRec."No.");
        AuditLineRec.SETRANGE("Audit Line Type", AuditLineRec."Audit Line Type"::"Report Workpapers");
        IF AuditLineRec.FIND('-') THEN BEGIN
            REPEAT
                GlobalAuditLine.RESET;
                GlobalAuditLine.SETRANGE("Document No.", AuditLineRec."Report Workpaper No.");
                GlobalAuditLine.SETRANGE("Audit Line Type", GlobalAuditLine."Audit Line Type"::"WorkPaper Conclusion");
                IF GlobalAuditLine.FIND('-') THEN BEGIN
                    REPEAT
                        LocalAuditLine.INIT;
                        LocalAuditLine."Document No." := AuditRec."No.";
                        IF GlobalAuditLine.Favourable THEN BEGIN
                            LocalAuditLine."Audit Line Type" := LocalAuditLine."Audit Line Type"::"Report Observation";
                            LocalAuditLine."Line No." := GetFavObservationNo(AuditRec."No.");
                        END ELSE BEGIN
                            LocalAuditLine."Audit Line Type" := LocalAuditLine."Audit Line Type"::"Report Recommendation";
                            LocalAuditLine."Line No." := GetUnFavObservationNo(AuditRec."No.");
                        END;
                        GlobalAuditLine.CALCFIELDS(Description);
                        LocalAuditLine.Description := GlobalAuditLine.Description;
                        LocalAuditLine.INSERT;
                    UNTIL GlobalAuditLine.NEXT = 0;
                END;
            UNTIL AuditLineRec.NEXT = 0;
        END;
        */
    end;
    local procedure GetScopeNo(DocNo: Code[50]): Integer begin
        GlobalAuditLine.RESET;
        GlobalAuditLine.SETRANGE("Document No.", DocNo);
        GlobalAuditLine.SETRANGE("Audit Line Type", GlobalAuditLine."Audit Line Type"::"WorkPaper Scope");
        GlobalAuditLine.SETCURRENTKEY("Line No.");
        IF GlobalAuditLine.FINDLAST THEN EXIT(GlobalAuditLine."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;
    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertWorkpaperScope(AuditRec: Record "Audit Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Internal Audit Management", 'OnAfterInsertWorkpaperScope', '', false, false)]
    local procedure UpdateProgramReview(AuditRec: Record "Audit Header")
    var
        LinesRec: Record "Audit Lines";
        AuditLineRec: Record "Audit Lines";
    begin
        //GetWorkpaperProgNo(AuditRec."No.");
        AuditLineRec.RESET;
        AuditLineRec.SETRANGE("Document No.", AuditRec."No.");
        AuditLineRec.SETRANGE("Audit Line Type", AuditLineRec."Audit Line Type"::"WorkPaper Scope");
        IF AuditLineRec.FIND('-')THEN BEGIN
            REPEAT //Modify Workpaper Program
                LinesRec.RESET;
                LinesRec.SETRANGE("Document No.", AuditRec."Audit Program No.");
                LinesRec.SETRANGE("Audit Line Type", LinesRec."Audit Line Type"::Review);
                LinesRec.SETRANGE("Review Scope No.", AuditLineRec."Scope Line No.");
                IF LinesRec.FINDSET THEN REPEAT LinesRec."WorkPlan Ref":=AuditRec."No.";
                        LinesRec.Date:=AuditRec.Date;
                        LinesRec."Done By":=AuditRec."Created By";
                        LinesRec.MODIFY;
                    UNTIL LinesRec.NEXT = 0;
            UNTIL AuditLineRec.NEXT = 0;
        END;
    end;
    local procedure GetWorkpaperProgNo(DocumentNo: Code[50])
    var
        AuditHeader: Record "Audit Header";
    begin
        IF AuditHeader.GET(DocumentNo)THEN BEGIN
            WorkpaperProgramNo:=AuditHeader."Audit Program No.";
            WorkpaperDoneBy:=AuditHeader."Created By";
            WorkpaperDate:=AuditHeader.Date;
            WorkpaperNo:=AuditHeader."No.";
        END;
    end;
    procedure GetRiskKRI(RiskLine: Record "Risk Line"; KRI: Boolean)
    var
        RiskLine2: Record "Risk Line";
        RiskLineCopy: Record "Risk Line";
        //SelectKRIs: Page Page51520661;
        LocRiskLine: Record "Risk Line";
        RiskLineCopy2: Record "Risk Line";
    begin
    /*
        RiskLine2.RESET;
        RiskLine2.FILTERGROUP(2);
        RiskLine2.SETRANGE("Document No.", RiskLine."Document No.");
        IF KRI THEN
            RiskLine2.SETRANGE(Type, RiskLine2.Type::"KRI(s)")
        ELSE
            RiskLine2.SETRANGE(Type, RiskLine2.Type::Response);
        RiskLine2.SETRANGE(Select, FALSE);

        SelectKRIs.SETTABLEVIEW(RiskLine2);
        IF KRI THEN
            SelectKRIs.SetControls(TRUE)
        ELSE
            SelectKRIs.SetControls(FALSE);
        SelectKRIs.LOOKUPMODE(TRUE);
        IF SelectKRIs.RUNMODAL = ACTION::LookupOK THEN BEGIN
            RiskLineCopy.COPY(RiskLine2);
            RiskLineCopy.SETRANGE(Select, TRUE);
            IF RiskLineCopy.FINDSET THEN BEGIN
                REPEAT
                    LocRiskLine.INIT;
                    LocRiskLine."Document No." := RiskLine."Document No.";
                    LocRiskLine."Line No." := GetRiskMELineNo(RiskLine."Document No.");
                    LocRiskLine.Type := LocRiskLine.Type::"M&E";
                    IF KRI THEN BEGIN
                        LocRiskLine."M & E Type" := LocRiskLine."M & E Type"::KRI;
                        LocRiskLine.Description := RiskLineCopy.Description;
                        LocRiskLine."ME Line No." := RiskLineCopy."Line No.";
                    END ELSE BEGIN
                        LocRiskLine."M & E Type" := LocRiskLine."M & E Type"::Mitigation;
                        LocRiskLine.Description := RiskLineCopy."Mitigation Actions";
                        LocRiskLine."ME Line No." := RiskLineCopy."Line No.";
                    END;
                    //IF NOT CheckMELineNoExist(LocRiskLine."Document No.",LocRiskLine."M & E Type",LocRiskLine."ME Line No.") THEN
                    LocRiskLine.INSERT;
                UNTIL RiskLineCopy.NEXT = 0;
            END;

            //update Selected to False
            RiskLineCopy2.COPY(RiskLineCopy);
            WITH RiskLineCopy2 DO
                REPEAT
                    RiskLineCopy2.Select := FALSE;
                    RiskLineCopy2.MODIFY(TRUE);
                UNTIL RiskLineCopy2.NEXT = 0;

        END;
        */
    end;
    procedure GetRiskMELineNo(DocNo: Code[50]): Integer var
        RiskLineRec: Record "Risk Line";
    begin
        RiskLineRec.RESET;
        RiskLineRec.SETRANGE("Document No.", DocNo);
        RiskLineRec.SETRANGE(Type, RiskLineRec.Type::"M&E");
        IF RiskLineRec.FINDLAST THEN EXIT(RiskLineRec."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;
    local procedure CheckMELineNoExist(DocNo: Code[50]; Type: Option " ", KRI, Mitigation; LineNo: Integer): Boolean var
        RiskLineRec: Record "Risk Line";
    begin
        RiskLineRec.RESET;
        RiskLineRec.SETRANGE("Document No.", DocNo);
        RiskLineRec.SETRANGE("M & E Type", Type);
        RiskLineRec.SETRANGE("ME Line No.", LineNo);
        IF RiskLineRec.FINDFIRST THEN EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;
    local procedure CheckProgScopeExits(DocNo: Code[50]; ScopeLineNo: Integer): Boolean var
        AuditLines: Record "Audit Lines";
    begin
        AuditLines.RESET;
        AuditLines.SETRANGE("Document No.", DocNo);
        AuditLines.SETRANGE("Audit Line Type", AuditLines."Audit Line Type"::"WorkPaper Scope");
        AuditLines.SETRANGE("Scope Line No.", ScopeLineNo);
        IF AuditLines.FINDFIRST THEN EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;
    local procedure CheckWorkpaperScopeIsNotSelected(ProgNo: Code[50]; ScopeLineNo: Integer): Boolean var
        AuditLineRec: Record "Audit Lines";
    begin
        AuditLineRec.RESET;
        AuditLineRec.SETRANGE("Document No.", ProgNo);
        AuditLineRec.SETRANGE("Audit Line Type", AuditLineRec."Audit Line Type"::Review);
        AuditLineRec.SETRANGE("Line No.", ScopeLineNo);
        IF AuditLineRec.FINDFIRST THEN IF AuditLineRec."WorkPlan Ref" <> '' THEN EXIT(TRUE)
            ELSE
                EXIT(FALSE);
    end;
    local procedure UpdateReviewWorkpaperRef(WorkPaperLine: Record "Audit Lines")
    var
        AuditLines: Record "Audit Lines";
        AuditLinesCopy: Record "Audit Lines";
    begin
        GetWorkpaperProgNo(WorkPaperLine."Document No.");
        AuditLines.RESET;
        AuditLines.SETRANGE("Document No.", WorkpaperProgramNo);
        AuditLines.SETRANGE("Audit Line Type", AuditLines."Audit Line Type"::Review);
        AuditLines.SETRANGE("Review Scope No.", ScopeLineNo);
        IF AuditLines.FINDSET THEN BEGIN
            AuditLinesCopy.COPY(AuditLines);
            REPEAT MESSAGE('Prog No - ' + AuditLinesCopy."Document No." + '-' + WorkpaperNo);
                MESSAGE('Scope No - ' + FORMAT(AuditLinesCopy."Review Scope No.") + '-' + FORMAT(ScopeLineNo));
                AuditLinesCopy."WorkPlan Ref":=WorkpaperNo;
                AuditLinesCopy."Done By":=WorkpaperDoneBy;
                AuditLinesCopy.Date:=WorkpaperDate;
                AuditLinesCopy.MODIFY(TRUE);
            UNTIL AuditLines.NEXT = 0;
        END;
    end;
    procedure SendToDepartmentRegister(var RiskReg: Record "Risk Register")
    var
        RiskReg2: Record "Risk Register";
        SendToDeptRegConfirm: Label 'Do you want to Send the Risk %1 to the Department Register?';
        SentSuccessFully: Label 'The Risk No. %1 has been sent Successfully to the Department Register.';
    begin
        IF NOT CONFIRM(SendToDeptRegConfirm, FALSE, RiskReg."Document No.")THEN EXIT
        ELSE
        BEGIN
            RiskReg2.RESET;
            RiskReg2.SETRANGE("Document No.", RiskReg."Document No.");
            IF RiskReg2.FIND('-')THEN BEGIN
                REPEAT RiskReg2.Type:=RiskReg2.Type::Department;
                    RiskReg2.MODIFY;
                UNTIL RiskReg2.NEXT = 0;
            END;
            MESSAGE(SentSuccessFully, RiskReg."Document No.");
        END;
    end;
    procedure RiskRegisterMEUpdate(var RiskLineRec: Record "Risk Line")
    var
        RiskRegister: Record "Risk Register";
        RiskLineCopy: Record "Risk Line";
        RiskLine: Record "Risk Line";
        NoLineSelected: Label 'You have not selected any of the Lines to send to Register!';
    begin
        RiskLine.RESET;
        RiskLine.SETRANGE("Document No.", RiskLineRec."Document No.");
        RiskLine.SETRANGE("Send to Register", TRUE);
        IF RiskLine.FIND('-')THEN BEGIN
            REPEAT RiskRegister.RESET;
                RiskRegister.SETRANGE("Document No.", RiskLine."Document No.");
                RiskRegister.SETRANGE("Document Line No.", RiskLine."ME Line No.");
                IF RiskRegister.FIND('-')THEN BEGIN
                    CASE RiskLine."M & E Type" OF RiskLine."M & E Type"::KRI: BEGIN
                        RiskRegister."KRI(s) Status":=RiskLine."KRI(s) Status";
                    END;
                    RiskLine."M & E Type"::Mitigation: BEGIN
                        RiskRegister."Mitigation Status":=RiskLine."Mitigation Status";
                        RiskRegister."Mitigation Owner":=RiskLine."Mitigation Owner";
                    END;
                    END;
                    RiskRegister.MODIFY;
                END;
                RiskLine."Send to Register":=FALSE;
                RiskLine.MODIFY;
            UNTIL RiskLine.NEXT = 0;
        END
        ELSE
            ERROR(NoLineSelected);
    end;
    var email: Codeunit "Email";
}

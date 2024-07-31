report 50414 "Enforcement Notification"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(EnforcementNonCompliance; "Enforcement NonCompliance")
        {
            DataItemTableView = where(Name = filter(<> ''));

            trigger OnafterGetrecord()
            var
                EnforcementCopy: Record "Enforcement NonCompliance";
                Header: record "Enforcement Header";
                HeaderNo: code[20];
                IssueDesc: Text[2048];
            begin
                EnforcementCopy.Reset();
                EnforcementCopy.SetCurrentKey("No.", Name);
                EnforcementCopy.SetRange("No.", "No.");
                EnforcementCopy.SetRange(Name, Name);
                if EnforcementCopy.FindFirst() then begin
                    if (EnforcementCopy.notified = false) and (EnforcementCopy.Type = EnforcementCopy.Type::General) and (EnforcementCopy."Action To be Taken" = EnforcementCopy."Action To be Taken"::"Given timeline to achieve compliance") and (EnforcementCopy."Compliance Dateline" <> 0D) and (EnforcementCopy."Compliance Dateline" < today) then begin
                        Header.SetRange("No.", "No.");
                        Header.SetFilter("Trader's Email", '<>%1', '');
                        if Header.FindFirst() then begin
                            Name := Header."Client Name";
                            //Send email
                            Clear(Receipient);
                            CompanyInfo.GET;
                            CompanyInfo.TESTFIELD(Name);
                            CompanyInfo.TESTFIELD("E-Mail");
                            SenderName := CompanyInfo.Name;
                            SenderAddress := CompanyInfo."E-Mail";
                            Receipient.Add(Header."Trader's Email");
                            TimeNow := FORMAT(TIME);
                            Subject := 'Compliance Deadline';
                            SMTP.Create(Receipient, Subject, '', TRUE);
                            SMTP.AppendTOBody(STRSUBSTNO(BodyTxt, Name, EnforcementCopy."No.", EnforcementCopy.Name, EnforcementCopy."Compliance Dateline"));
                            EMAIL.Send(SMTP);
                        end;
                        EnforcementCopy.Notified := true;
                        EnforcementCopy.Modify();
                    end;
                    if (EnforcementCopy.Overdue = false) and (EnforcementCopy.Complied = false) and (EnforcementCopy.Type = EnforcementCopy.Type::General) and (EnforcementCopy."Action To be Taken" = EnforcementCopy."Action To be Taken"::"Given timeline to achieve compliance") and (EnforcementCopy."Compliance Dateline" <> 0D) and (EnforcementCopy."Compliance Dateline" < today) then begin
                        EnforcementCopy.Overdue := true;
                        EnforcementCopy.Modify();
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
        Receipient: List of [Text];
        ReceipientCC: List of [Text];
        TimeNow: Text;
        Subject: Text;
        Name: Text[50];
        SMTP: Codeunit "email message";
        email: Codeunit email;
        BodyTxt: Label 'Dear %1, <br><br>This is to remind you that deadline of compliance for %2, non-compliance %3, is %4.<br><br>Thank you.<br><br>Kind Regards,<br><br>';
}

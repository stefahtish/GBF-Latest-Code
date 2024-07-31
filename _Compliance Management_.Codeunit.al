codeunit 50133 "Compliance Management"
{
    trigger OnRun()
    begin
    end;
    var Returns: Record "Monthly Form of Return";
    ReturnsLog: Record "Applicant Penalty Logs";
    ReturnsLogNew: Record "Applicant Penalty Logs";
    CompanyInfo: Record "Company Information";
    AuditSetup: Record "Audit Setup";
    TotalCessPenalty: decimal;
    TotalLevyPenalty: Decimal;
    procedure CalculatePayments(RefNo: Code[20]): Decimal var
        n: integer;
        r: decimal;
        d: integer;
        Penalty: boolean;
        EndDate: date;
        DueDate: date;
        MonthDate: date;
        NoofMonths: Integer;
        CessSetup: Record "Cess and Levy setup";
        PreviousCess: Decimal;
        PreviousLevy: Decimal;
        QAmount: Decimal;
        CAmount: Decimal;
        LAmount: Decimal;
        CMText: text[80];
    begin
        CessSetup.Get;
        CessSetup.TestField("Levy rate");
        CessSetup.TestField("Levy Penalty rate- Initial");
        CessSetup.TestField("Levy Penalty rate- subsequent");
        Returns.Reset();
        Returns.SetRange("No.", RefNo);
        if Returns.FindFirst()then begin
            ReturnsLog.SetRange("Document No.", Returns."No.");
            if ReturnsLog.Find('-')then ReturnsLog.DeleteAll();
            //reset to zero
            //levy
            Returns."Levy Amount":=0;
            Returns."Levy Penalty":=0;
            //Get number of due periods(n)
            Returns.CalcFields("Total Quantity");
            Returns.CalcFields("Total Costs");
            EndDate:=CALCDATE('<CM>', Returns."Base Date");
            DueDate:=CALCDATE('<CM-1M+15D>', Today);
            r:=(Today - EndDate) / 30;
            if Today < DueDate then n:=(ROUND(r, 1, '<'))
            else
                n:=(ROUND(r, 1, '<')) + 1;
            QAmount:=Returns."Total Quantity" * CessSetup."Levy rate";
            CAmount:=Returns."Total Costs" * CessSetup."Percentage of cost";
            if QAmount > CAmount then LAmount:=QAmount
            else
                LAmount:=CAmount;
            // get interest fo first month if any
            if n = 1 then begin
                //levy               
                Returns."Levy Amount":=LAmount;
                Returns."Levy Penalty":=Returns."Levy Amount" * CessSetup."Levy Penalty rate- Initial";
                Returns."Total Amount":=Returns."Levy Amount" + Returns."Levy Penalty";
                Returns.Modify();
                //logs
                ReturnsLogNew.Init();
                ReturnsLogNew."Document No.":=Returns."No.";
                ReturnsLogNew.Year:=Returns.Year;
                ReturnsLogNew.Month:=Returns.Month;
                ReturnsLognew."Levy Compounded":=LAmount;
                ReturnsLogNew.Total:=ReturnsLognew."Levy Compounded" + ReturnsLogNew."Levy Penalty";
                ReturnsLogNew."Update Date":=today;
                ReturnsLogNew.Insert(TRUE);
                ReturnsLogNew.Init();
                ReturnsLogNew."Document No.":=Returns."No.";
                MonthDate:=CALCDATE('1M', Returns."Base Date");
                ReturnsLogNew.Year:=Date2DMY(MonthDate, 3);
                ReturnsLogNew.Month:=Format(MonthDate, 0, '<Month Text>');
                ReturnsLognew."Levy Compounded":=Returns."Total Quantity" * CessSetup."Levy rate";
                ReturnsLogNew."Levy Penalty":=Returns."Levy Amount" * CessSetup."Levy Penalty rate- initial";
                ReturnsLogNew.Total:=ReturnsLognew."Levy Compounded" + ReturnsLogNew."Levy Penalty";
                ReturnsLogNew."Update Date":=today;
                ReturnsLogNew.Insert(TRUE);
            end;
            // get interest fo all months till date if  1
            if n > 1 then begin
                d:=n;
                //Return month
                ReturnsLogNew.Init();
                ReturnsLogNew."Document No.":=Returns."No.";
                ReturnsLogNew.Year:=Returns.Year;
                ReturnsLogNew.Month:=Returns.Month;
                ReturnsLognew."Levy Compounded":=LAmount;
                ReturnsLogNew.Total:=ReturnsLognew."Levy Compounded";
                ReturnsLogNew."Update Date":=today;
                ReturnsLogNew.Insert(TRUE);
                //Return next month
                ReturnsLogNew.Init();
                ReturnsLogNew."Document No.":=Returns."No.";
                MonthDate:=CALCDATE('1M', Returns."Base Date");
                ReturnsLogNew.Year:=Date2DMY(MonthDate, 3);
                ReturnsLogNew.Month:=Format(MonthDate, 0, '<Month Text>');
                ReturnsLognew."Levy Compounded":=LAmount;
                ReturnsLogNew."Levy Penalty":=ReturnsLognew."Levy Compounded" * CessSetup."Levy Penalty rate- initial";
                ReturnsLogNew.Total:=ReturnsLognew."Levy Compounded" + ReturnsLogNew."Levy Penalty";
                ReturnsLogNew."Update Date":=today;
                ReturnsLogNew.Insert(TRUE);
                d:=d - 1;
                //subsequent month logs
                repeat ReturnsLog.Reset();
                    ReturnsLog.SetRange("Document No.", Returns."No.");
                    NoofMonths:=ReturnsLog.Count;
                    if ReturnsLog.FindLast()then begin
                        PreviousCess:=ReturnsLog."Cess Compounded" + ReturnsLog."Cess Penalty";
                    end;
                    CMText:=format(NoofMonths) + 'M';
                    MonthDate:=CALCDATE(CMText, Returns."Base Date");
                    ReturnsLogNew.Init();
                    ReturnsLogNew."Document No.":=Returns."No.";
                    ReturnsLogNew.Year:=Date2DMY(MonthDate, 3);
                    ReturnsLogNew.Month:=Format(MonthDate, 0, '<Month Text>');
                    ReturnsLogNew."Levy Penalty":=PreviousLevy * CessSetup."Levy Penalty rate- subsequent";
                    ReturnsLognew."Levy Compounded":=PreviousLevy;
                    ReturnsLogNew.Total:=ReturnsLognew."Levy Compounded" + ReturnsLogNew."Levy Penalty";
                    ReturnsLogNew.Insert(TRUE);
                    d:=d - 1;
                until d = 0;
                ReturnsLog.Reset();
                ReturnsLog.SetRange("Document No.", Returns."No.");
                if ReturnsLog.Find('-')then begin
                    ReturnsLog.CalcSums("Levy Penalty");
                    TotalLevyPenalty:=ReturnsLog."Levy Penalty";
                end;
                ReturnsLog.Reset();
                ReturnsLog.SetRange("Document No.", Returns."No.");
                if ReturnsLog.FindFirst()then begin
                    Returns."Levy Amount":=ReturnsLog."Levy Compounded";
                    Returns."Levy Penalty":=TotalLevyPenalty;
                    Returns."Total Amount":=Returns."Levy Amount" + Returns."Levy Penalty";
                    Returns.Modify();
                end;
            end;
            //get amounts for no penalty due
            if n = 0 then begin
                Returns."Levy Amount":=LAmount;
                Returns."Total Amount":=LAmount;
                Returns.Modify();
                //logs
                ReturnsLogNew.Init();
                ReturnsLogNew."Document No.":=Returns."No.";
                ReturnsLogNew.Year:=Returns.Year;
                ReturnsLogNew.Month:=Returns.Month;
                ReturnsLognew."Levy Compounded":=LAmount;
                ReturnsLogNew.Total:=ReturnsLognew."Levy Compounded";
                ReturnsLogNew."Update Date":=today;
                ReturnsLogNew.Insert(TRUE);
            end;
            Returns.Validate("Total Amount");
            //  Returns.Submitted := true;
            Returns.Modify();
        end;
    end;
    procedure GenerateInvoices()
    begin
    end;
    procedure IssueLicense(RefNo: Code[20])
    var
        Application: Record "License Applications";
        IssuedLicense: Record "Issued Applicant License";
        IssuedLicenses: Record "Issued Applicant License";
        AppCategory: Record "License and Permit Category";
        LicenseNo: Code[100];
        StartMonth: Date;
        EndMonth: Date;
        NoOfLicenses: Integer;
        OthersCategoryCode: Code[20];
        CurrCategory: Code[20];
    begin
        Application.Reset();
        Application.SetRange("No.", RefNo);
        if Application.FindFirst()then begin
            //GetLicenseNo
            StartMonth:=DMY2DATE(1, 1, DATE2DMY(Today, 3));
            EndMonth:=CALCDATE('<1Y>', StartMonth);
            CurrCategory:=format(Application.Category, 3);
            NoOfLicenses:=0;
            IssuedLicenses.Reset();
            IssuedLicenses.SetRange("Issue date", StartMonth, EndMonth);
            if IssuedLicenses.Find('-')then repeat OthersCategoryCode:=format(IssuedLicenses.Category, 3);
                    if OthersCategoryCode = CurrCategory then NoOfLicenses+=1;
                until IssuedLicenses.Next() = 0;
            NoOfLicenses:=IssuedLicenses.Count;
            AppCategory.Reset();
            AppCategory.SetRange("License/Permit Category", Application.Category);
            if AppCategory.FindFirst()then // AppCategory.get(Application.Category);
                AppCategory.TestField("License Code");
            if LicenseNo = '' then begin
                LicenseNo:='KDB/' + AppCategory."License Code" + '/000' + format(NoOfLicenses + 1) + '/' + Format(DATE2DMY(Today, 3));
                Application."License No.":=LicenseNo;
            end;
            Application."Issued Date":=Today;
            Application."Expiry Date":=CalcDate('1Y', Application."Issued Date");
            Application.Status:=Application.Status::Archived;
            Application.Modify();
            IssuedLicense.Init();
            IssuedLicense."Applicant No.":=Application."Applicant No.";
            IssuedLicense."License/Permit":=Application.type;
            IssuedLicense.Category:=Application.Category;
            IssuedLicense."License No.":=Application."License No.";
            IssuedLicense."Issue date":=Application."Issued Date";
            IssuedLicense."Expiry date":=Application."Expiry Date";
            IssuedLicense.Outlet:=Application.Outlet;
            IssuedLicense.Insert();
            EmailLicense(RefNo);
        end;
    end;
    procedure EmailLicense(RefNo: Code[20])
    var
        CompanyInfo: Record "Company Information";
        SenderName: Text;
        EnforcementCopy: record "Enforcement NonCompliance";
        LicApplication: Record "License Applications";
        Applications: Record "Licensing dairy Enterprise";
        SenderAddress: Text;
        email: Codeunit Email;
        Receipient: List of[Text];
        ReceipientCC: List of[Text];
        TimeNow: Text;
        Subject: Text;
        Name: Text[50];
        Emailmessage: Codeunit "Email Message";
        FileName: Text[100];
        LicenseReport: Report "License File";
        BodyTxt: Label 'Dear %1, <br><br>This is to inform you that you have been issued a license from %2<br><br>Thank you.<br><br>Kind Regards,<br><br>';
    begin
        LicApplication.Reset();
        LicApplication.SetRange("No.", RefNo);
        if LicApplication.FindFirst()then begin
            Applications.Reset();
            Applications.SetRange("Application no", LicApplication."Applicant No.");
            if Applications.FindFirst()then begin
                if Applications."Customer Type" = Applications."Customer Type"::"Registered Entity" then Name:=Applications."Business Name"
                else
                    Name:=Applications."First Name";
                CompanyInfo.GET;
                FileName:=CompanyInfo."Document Path" + 'License' + '-' + '.pdf';
                LicenseReport.SetTableView(LicApplication);
                //EDDIELicenseReport.SaveAsPdf(FileName);
                Clear(Receipient);
                CompanyInfo.TESTFIELD(Name);
                CompanyInfo.TESTFIELD("E-Mail");
                SenderName:=CompanyInfo.Name;
                SenderAddress:=CompanyInfo."E-Mail";
                Receipient.Add(Applications."E-Mail");
                TimeNow:=FORMAT(TIME);
                Subject:='License Issue';
                Emailmessage.Create(Receipient, Subject, '', TRUE);
                Emailmessage.AppendtoBody(STRSUBSTNO(BodyTxt, Name, CompanyInfo.Name));
                Emailmessage.AddAttachment(FileName, 'License-' + LicApplication."License No." + '-' + '.pdf', '');
                email.Send(Emailmessage);
                email.Send(Emailmessage);
            end;
        end;
    end;
    procedure NotifyTrader(Var Header: record "Enforcement Header")
    var
        CompanyInfo: Record "Company Information";
        SenderName: Text;
        EnforcementCopy: record "Enforcement NonCompliance";
        SenderAddress: Text;
        Receipient: List of[Text];
        ReceipientCC: List of[Text];
        TimeNow: Text;
        Subject: Text;
        Email: Codeunit Email;
        Name: Text[50];
        Emailmessage: Codeunit "Email Message";
        BodyTxt: Label 'Dear %1, <br><br>This is to remind you that deadline of compliance for %2, non-compliance %3, is %4.<br><br>Thank you.<br><br>Kind Regards,<br><br>';
    begin
        EnforcementCopy.SetRange("No.", Header."No.");
        EnforcementCopy.SetCurrentKey("No.", Name);
        if EnforcementCopy.Find('-')then repeat Header.TestField("Trader's Email");
                Name:=Header."Client Name";
                //Send email
                Clear(Receipient);
                CompanyInfo.GET;
                CompanyInfo.TESTFIELD(Name);
                CompanyInfo.TESTFIELD("E-Mail");
                SenderName:=CompanyInfo.Name;
                SenderAddress:=CompanyInfo."E-Mail";
                Receipient.Add(Header."Trader's Email");
                TimeNow:=FORMAT(TIME);
                Subject:='Compliance Deadline';
                Emailmessage.Create(Receipient, Subject, '', TRUE);
                Emailmessage.AppendtoBody(STRSUBSTNO(BodyTxt, Name, EnforcementCopy."No.", EnforcementCopy.Name, EnforcementCopy."Compliance Dateline"));
                email.Send(Emailmessage);
            until EnforcementCopy.next = 0;
        Header.Submitted:=true;
        Header.Modify();
    end;
}

codeunit 50138 "Online Portal Services"
{
    trigger OnRun()
    begin
    end;
    var member: Record Vendor;
    DocRelease: Codeunit "Document Release";
    Committment: Codeunit Committment;
    Text001: Label 'Are you sure you want to send this record for Approval?';
    ApprovalMgt: Codeunit ApprovalMgtCuExtension;
    NoSeriesMgt: Codeunit NoSeriesManagement;
    PaymentsRec: Record Payments;
    IRHeader: Record "Internal Request Header";
    TrainingRequest: Record "Training Request";
    LeaveApplication: Record "Leave Application";
    MaintenanceRegistration: Record "Maintenance Registration";
    LoanApplication: Record "Loan Application";
    TravelRequests: Record "Travel Requests";
    ApprovalEntry: Record "Approval Entry";
    Employee: Record Employee;
    RepaymentSchedule: Record "Repayment Schedule";
    PLines: Record "Payment Lines";
    CashManagementSetup: Record "Cash Management Setups";
    GeneralLedgerSetup: Record "General Ledger Setup";
    Imprest: Report Imprest;
    ImprestSurrender: Report "Imprest Surrender";
    InterBankTransfer: Report "InterBank Transfer";
    StaffClaimVoucher: Report "Staff Claim Voucher";
    StoreRequest: Report "Store Request";
    PurchaseRequest: Report "Purchase Request";
    PettyCashVoucher: Report "Petty Cash Voucher";
    PettyCashSurrender: Report "Petty Cash Surrender";
    TransportReq: Report "Travel Request";
    Payslip: Report "New Payslipx";
    P9: Report "P9A Report";
    PaymentVoucher: Report "Payment Voucher";
    Training: Report Training;
    LoanRepaymentSchedule: Report "Loan Repayment Schedule-HR";
    ErrorMsg: Text;
    LeaveReport: Report "Leave Report";
    UserIncident: Record "User Support Incident";
    Appraisal: Record "Employee Appraisal";
    AuditHeader: Record "Audit Header";
    ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
    RegPermits: Record "License and Permit Category";
    procedure MemberStatement(file: Text; Path: Text; MemberNo: Text; EndDate: Date)
    var
        NewMemberNo: Text;
        Filename: Text;
    begin
    //EDDIE  NewMemberNo := MemberNo;
    // Filename := Path + 'MemberStatement' + NewMemberNo + '.pdf';
    // if Exists(Filename)
    //   then
    //     Erase(Filename);
    // member.Reset;
    // member.SetRange("No.", MemberNo);
    // member.SetRange("Date Filter", 0D, EndDate);
    // if member.Find('-') then begin
    //     REPORT.SaveAsPdf(51520155, Filename, member);
    // end;
    end;
    procedure GetPictureStream(MemberNo: Code[20]; Path: Text)
    var
        MemberRec: Record Vendor;
        fileName: Text;
        exportFile: File;
        dataOutStream: OutStream;
        "count": Integer;
        Text000: Label '%1 media file(s) were exported.';
    begin
        if MemberRec.Get(MemberNo)then // BEGIN
            //  REPEAT
            if MemberRec.Image.HasValue then begin
                fileName:=Path + Format(MemberRec."No.") + '.jpg';
            // EDDIE exportFile.Create(fileName);
            // exportFile.CreateOutStream(dataOutStream);
            // MemberRec.Image.ExportStream(dataOutStream);
            // count := count + 1;
            // exportFile.Close;
            //    END
            //  UNTIL MemberRec.NEXT < 1;
            //MESSAGE(Text000, count);
            end;
    end;
    procedure SetPictureStream(MemberNo: Code[20]; ext: Text; Path: Text)
    var
        MemberRec: Record Vendor;
        fileName: Text;
        importFile: File;
        imageInStream: InStream;
        imageID: Guid;
        Text000: Label 'An image with the following ID has been imported on item %1: %2';
    begin
    // EDDIE if MemberRec.Get(MemberNo) then begin
    //     fileName := Path + Format(MemberRec."No.") + ext;
    //     importFile.Open(fileName);
    //     importFile.CreateInStream(imageInStream);
    //     Clear(MemberRec.Image);
    //     imageID := MemberRec.Image.ImportStream(imageInStream, 'Image for member ' + Format(MemberRec."No."));
    //     MemberRec.Modify(true);
    //     //MESSAGE(Text000, MemberRec."No.", imageID);
    //     importFile.Close;
    //     if Erase(fileName) then;
    //  REPEAT
    //    fileName := 'C:\Users\Amos\source\repos\Zamara\Zamara\Storage\images\import\' + FORMAT(MemberRec."No.") + '.jpg';
    //
    //    IF FILE.EXISTS(fileName) THEN BEGIN
    //        importFile.OPEN(fileName);
    //        importFile.CREATEINSTREAM(imageInStream);
    //        CLEAR(MemberRec.Image);
    //        imageID := MemberRec.Image.IMPORTSTREAM(imageInStream, 'Image for member ' + FORMAT( MemberRec."No."));
    //        MemberRec.MODIFY(TRUE);
    //        MESSAGE(Text000, MemberRec."No.", imageID);
    //        importFile.CLOSE;
    //        //IF ERASE(fileName) THEN;
    //    END;
    //  UNTIL MemberRec.NEXT < 1;
    // end;
    end;
    procedure PostReceipt(RecNo: code[20])
    var
        ReceiptRec: Record Payments;
        RcptLines: Record "Payment Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        VATSetup: Record "VAT Posting Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLEntry: Record "G/L Entry";
        CMSetup: Record "Cash Management Setups";
        PaymentMethod: Record "Payment Method";
        Batch: Record "Gen. Journal Batch";
    begin
        ReceiptRec.SetRange("No.", RecNo);
        if ReceiptRec.Find('-')then begin
            if ReceiptRec.Posted then if GuiAllowed then Error('The receipt is already posted');
            ReceiptRec.TestField("Paying Bank Account");
            ReceiptRec.TestField("Received From");
            ReceiptRec.TestField(Date);
            ReceiptRec.TestField("Pay Mode");
            if ReceiptRec."Payment Release Date" = 0D then if GuiAllowed then Error('Please input posting date');
            if PaymentMethod.Get(ReceiptRec."Pay Mode")then;
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                ReceiptRec.TestField("Cheque No");
                ReceiptRec.TestField("Cheque Date");
            end;
            ReceiptRec.CalcFields("Receipt Amount");
            ReceiptRec.CalcFields("Imp Surr Receipt Amount");
            //Check Lines
            RcptLines.Amount:=ReceiptRec."Receipt Amount"; //Added this line to enable the receipts to pick the amount   //Carol
            if ReceiptRec."Imprest Surrender Doc. No" = '' then begin
                if ReceiptRec."Receipt Amount" = 0 then if GuiAllowed then Error('Amount cannot be zero');
            end;
            if ReceiptRec."Imprest Surrender Doc. No" <> '' then begin
                if ReceiptRec."Imp Surr Receipt Amount" = 0 then if GuiAllowed then Error('Imprest Receipt Amount cannot be zero');
            end;
            if ReceiptRec."Imprest Surrender Doc. No" = '' then begin
                RcptLines.Reset;
                //RcptLines.SETRANGE("Payment Type",ReceiptRec."Payment Type");
                RcptLines.SetRange(No, ReceiptRec."No.");
                if not RcptLines.FindLast then if GuiAllowed then Error('Receipt Lines cannot be empty');
            end;
            CMSetup.Get();
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", CMSetup."Receipt Template");
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", ReceiptRec."No.");
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get()then Batch."Journal Template Name":=CMSetup."Receipt Template";
            Batch.Name:=ReceiptRec."No.";
            if not Batch.Get(Batch."Journal Template Name", ReceiptRec."No.")then Batch.Insert;
            //Bank Entries
            LineNo:=LineNo + 10000;
            RcptLines.Reset;
            //RcptLines.SETRANGE("Payment Type",ReceiptRec."Payment Type");
            RcptLines.SetRange(No, ReceiptRec."No.");
            RcptLines.Validate(Amount);
            RcptLines.CalcSums(Amount);
            GenJnLine.Init;
            if CMSetup.Get then GenJnLine."Journal Template Name":=CMSetup."Receipt Template";
            GenJnLine."Journal Batch Name":=ReceiptRec."No.";
            GenJnLine."Line No.":=LineNo;
            GenJnLine."Account Type":=GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No.":=ReceiptRec."Paying Bank Account";
            GenJnLine.Validate(GenJnLine."Account No.");
            if ReceiptRec.Date = 0D then if GuiAllowed then Error('You must specify the Receipt date');
            //Removed under request of Utalii Accounts//
            //GenJnLine."Posting Date":=TODAY;
            GenJnLine."Posting Date":=ReceiptRec."Payment Release Date";
            GenJnLine."Document No.":=ReceiptRec."No.";
            GenJnLine."External Document No.":=ReceiptRec."Cheque No";
            GenJnLine."Payment Method Code":=ReceiptRec."Pay Mode";
            GenJnLine.Description:=ReceiptRec."Received From";
            if ReceiptRec."Imprest Surrender Doc. No" <> '' then GenJnLine.Amount:=ReceiptRec."Imp Surr Receipt Amount"
            else
                GenJnLine.Amount:=ReceiptRec."Receipt Amount";
            GenJnLine."Currency Code":=ReceiptRec.Currency;
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code":=ReceiptRec."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code":=ReceiptRec."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            //Receipt Lines Entries
            RcptLines.Reset;
            //RcptLines.SETRANGE("Payment Type",ReceiptRec."Payment Type");
            RcptLines.SetRange(No, ReceiptRec."No.");
            if RcptLines.FindFirst then begin
                repeat RcptLines.Validate(RcptLines.Amount);
                    LineNo:=LineNo + 10000;
                    GenJnLine.Init;
                    if CMSetup.Get then GenJnLine."Journal Template Name":=CMSetup."Receipt Template";
                    GenJnLine."Journal Batch Name":=ReceiptRec."No.";
                    GenJnLine."Line No.":=LineNo;
                    GenJnLine."Account Type":=RcptLines."Account Type";
                    GenJnLine."Account No.":=RcptLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    GenJnLine."Posting Date":=ReceiptRec."Payment Release Date";
                    GenJnLine."Document No.":=ReceiptRec."No.";
                    GenJnLine."External Document No.":=ReceiptRec."Cheque No";
                    GenJnLine."Payment Method Code":=ReceiptRec."Pay Mode";
                    GenJnLine.Description:=RcptLines.Description;
                    GenJnLine.Amount:=-RcptLines.Amount;
                    GenJnLine."Currency Code":=ReceiptRec.Currency;
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code":=RcptLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code":=RcptLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID":=RcptLines."Dimension Set ID";
                    GenJnLine."Gen. Posting Type":=RcptLines."Gen. Posting Type";
                    //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                    GenJnLine."Applies-to Doc. No.":=RcptLines."Applies-to Doc. No.";
                    GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                    GenJnLine."Applies-to ID":=RcptLines."Applies-to ID";
                    if ReceiptRec."Payment Type" = ReceiptRec."Payment Type"::"Receipt-Property" then GenJnLine."Loan No":=ReceiptRec."TPS Loan No.";
                    if ReceiptRec."Deposit Receipt" then GenJnLine.Deposit:=true;
                    if ReceiptRec."Service Charge Pmt" then GenJnLine."TPS Transaction Type":=GenJnLine."TPS Transaction Type"::"Service Charge Paid";
                    // GenJnLine."Reason Code" := RcptLines."General Expense Code";
                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                until RcptLines.Next = 0;
            end;
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", ReceiptRec."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.FindFirst then begin
                ReceiptRec.Posted:=true;
                ReceiptRec."Posted Date":=Today;
                ReceiptRec."Time Posted":=Time;
                ReceiptRec."Posted By":=UserId;
                ReceiptRec.Modify;
                if ReceiptRec."Imprest Surrender Doc. No" <> '' then begin
                    RcptLines.Reset;
                    RcptLines.SetRange(No, ReceiptRec."Imprest Surrender Doc. No");
                    if RcptLines.Find('-')then repeat RcptLines."Imprest Receipt No.":=ReceiptRec."No.";
                            RcptLines.Modify;
                        until RcptLines.Next = 0;
                end;
            end;
        end;
    end;
    procedure ImportPictures()
    var
        Text000: Label 'An image with the following ID has been imported on item %1: %2';
        MemberRec: Record Vendor;
        fileName: Text;
        imageID: Guid;
    begin
        if MemberRec.FindFirst()then begin
            repeat // fileName := 'C:\Users\Amos\source\repos\Zamara\Zamara\Storage\images\import\' + Format(MemberRec."No.") + '.jpg';
            // if FILE.Exists(fileName) then begin
            //     imageID := MemberRec.Image.ImportFile(fileName, 'Image for member ' + Format(MemberRec."No."));
            //     MemberRec.Modify;
            //     Message(Text000, MemberRec."No.", imageID)
            // end;
            until MemberRec.Next < 1;
        end;
    end;
    procedure ExportPictures()
    var
        MemberRec: Record Vendor;
        fileName: Text;
        "count": Integer;
        Text000: Label '%1 media file(s) were exported.';
    begin
        if member.FindFirst()then begin
            repeat //EDDIE  fileName := 'C:\Users\Amos\source\repos\Zamara\Zamara\Storage\images\export\' + Format(MemberRec."No.") + '.jpg';
            // if MemberRec.Image.ExportFile(fileName) then
            //     count := count + 1
            until MemberRec.Next < 1;
            Message(Text000, count);
        end;
    end;
    procedure CalculateAge(StartDate: Date; EndDate: Date)Age: Decimal var
        Dates: Codeunit "Dates Management";
        Months: Decimal;
        YearPos: Integer;
        YearString: Text[30];
        MonthString: Text[30];
        MonthPos: Integer;
        DayString: Text[30];
        DaysPos: Integer;
        Days: Decimal;
        AgeString: Text[80];
        Years: Decimal;
    begin
        AgeString:=Dates.DetermineAge(StartDate, EndDate);
        YearPos:=StrPos(AgeString, ' Years');
        if YearPos = 0 then YearPos:=StrPos(AgeString, ' Year');
        if YearPos > 1 then begin
            YearString:=CopyStr(AgeString, 1, YearPos);
            Evaluate(Years, YearString);
        end;
        MonthPos:=StrPos(AgeString, 'Months');
        if MonthPos = 0 then MonthPos:=StrPos(AgeString, 'Month');
        if MonthPos > 2 then begin
            MonthString:=CopyStr(AgeString, (MonthPos - 2), 2);
            Evaluate(Months, MonthString);
        end;
        Months:=Months / 12;
        DaysPos:=StrPos(AgeString, 'Days');
        if DaysPos = 0 then DaysPos:=StrPos(AgeString, 'Day');
        if DaysPos > 2 then begin
            DayString:=CopyStr(AgeString, DaysPos - 2, 2);
            Evaluate(Days, DayString);
        end;
        Days:=Days / 365;
        Age:=Years + Months + Days;
        exit(Age);
    end;
    procedure LeaveExists(EmpNo: Code[50])Msg: Text var
        LeaveApp: Record "Leave Application";
    begin
        //This function just checks for unutilized open leave docs
        LeaveApp.Reset;
        LeaveApp.SetRange(LeaveApp.Status, LeaveApp.Status::Open);
        LeaveApp.SetRange(LeaveApp."Employee No", EmpNo);
        if LeaveApp.Find('-')then begin
            if LeaveApp.Count > 0 then begin
                Msg:='There are still some untilized Leave Application Documents [ ' + LeaveApp."Application No" + ' ]. Please utilise them first';
            end;
        end;
        exit(Msg);
    end;
    procedure LeaveBalance(LeaveType: Code[100]; EmpNo: Code[50])Days: Decimal var
        LeaveApp: Record "Leave Application";
        HRLedgerEntries: record "HR Leave Ledger Entries";
        DaysAvailable: Decimal;
    begin
        //This function just checks for available leave balance\
        HRLedgerEntries.RESET;
        HRLedgerEntries.SETRANGE(HRLedgerEntries."Staff No.", EmpNo);
        HRLedgerEntries.SETRANGE(HRLedgerEntries."Leave Type", LeaveType);
        IF HRLedgerEntries.FIND('-')THEN BEGIN
            REPEAT Days+=HRLedgerEntries."No. of days";
            UNTIL HRLedgerEntries.NEXT = 0;
        END;
    end;
    procedure UpdateApprovalEntries(DocNo: Code[100]; SenderID: Code[100])
    var
        ApprovalEntryRec: Record "Approval Entry";
    begin
        //Update USERID on Approval Entries
        ApprovalEntryRec.Reset;
        ApprovalEntryRec.SetRange("Document No.", DocNo);
        ApprovalEntryRec.SetFilter(Status, '%1|%2', ApprovalEntryRec.Status::Created, ApprovalEntryRec.Status::Open);
        if ApprovalEntryRec.Find('-')then begin
            repeat ApprovalEntryRec."Sender ID":=SenderID;
                ApprovalEntryRec.Modify;
            until ApprovalEntryRec.Next = 0;
        end;
    end;
    procedure ApproveRequest(DocumentNo: Code[20]; ApproverID: Code[30]; Comment: Text[80])
    var
        AppMgt: Codeunit "Approvals Mgmt.";
        ApprovComments: Record "Approval Comment Line";
        ApprovalComments: Record "Approval Comment Line";
        EntryNo: Integer;
    begin
        SetApprovalFilters(DocumentNo, ApproverID);
        AppMgt.ApproveApprovalRequests(ApprovalEntry);
        ApprovalComments.Reset();
        if ApprovalComments.FindLast()then EntryNo:=ApprovalComments."Entry No." + 1
        else
            EntryNo:=1;
        ApprovComments.Init();
        ApprovComments."Table ID":=ApprovalEntry."Table ID";
        ApprovComments."Document No.":=ApprovalEntry."Document No.";
        ApprovComments."Approval Status":=ApprovComments."Approval Status"::Approved;
        ApprovComments.Comment:=Comment;
        ApprovComments."User ID":=ApprovalEntry."Approver ID";
        ApprovComments."Entry No.":=EntryNo;
        ApprovComments.Insert();
        ApprovComments.Validate("User ID");
        ApprovComments.Modify();
    end;
    procedure RejectRequest(DocumentNo: Code[20]; ApproverID: Code[30]; Rejectioncomment: Text[80])
    var
        AppMgt: Codeunit "Approvals Mgmt.";
        AppMmt2: Codeunit ApprovalMgtCuExtension;
    begin
        SetApprovalFilters(DocumentNo, ApproverID);
        AppMgt.RejectApprovalRequests(ApprovalEntry);
    //  AppMmt2.InsertRejectionComment(ApprovalEntry, Rejectioncomment, ApprovalEntry."Table ID");
    end;
    procedure DelegateRequest(DocumentNo: Code[20]; ApproverID: Code[30])
    var
        AppMgt: Codeunit "Approvals Mgmt.";
    begin
        SetApprovalFilters(DocumentNo, ApproverID);
        AppMgt.DelegateApprovalRequests(ApprovalEntry);
    end;
    local procedure SetApprovalFilters(DocumentNo: Code[20]; ApproverID: Code[30])
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document No.", DocumentNo);
        ApprovalEntry.SetRange("Approver ID", ApproverID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
    end;
    procedure SendPaymentsApproval(DocNo: Code[50]): Text begin
        CashManagementSetup.Get;
        GeneralLedgerSetup.Get;
        PaymentsRec.Reset;
        PaymentsRec.SetRange("No.", DocNo);
        if PaymentsRec.FindFirst then begin
            //TestFields
            case PaymentsRec."Payment Type" of PaymentsRec."Payment Type"::"Bank Transfer": begin
                PaymentsRec.TestField("Receiving Bank Amount");
                PaymentsRec.TestField("Source Bank Amount");
                PaymentsRec.TestField("Source Bank");
                PaymentsRec.TestField("Payment Narration");
                PaymentsRec.TestField("Account No.");
                PaymentsRec.TestField(Date);
                if PaymentsRec."Receiving Amount LCY" <> PaymentsRec."Source Amount LCY" then Error('Please make sure both Receiving and Source Amounts are the same');
            end;
            PaymentsRec."Payment Type"::Imprest: begin
                PaymentsRec.CalcFields("Imprest Amount");
                if PaymentsRec."Imprest Amount" <= 0 then Error('Imprest Amount can not be less than or equal to 0');
                PaymentsRec.TestField("Payment Narration");
                Committment.CheckImprestCommittment(PaymentsRec);
                Committment.ImprestCommittment(PaymentsRec, ErrorMsg);
                if ErrorMsg <> '' then Error(ErrorMsg);
                Commit;
            end;
            PaymentsRec."Payment Type"::"Imprest Surrender": begin
                PaymentsRec.TestField("Surrender Date");
            end;
            PaymentsRec."Payment Type"::"Payment Voucher": begin
                PaymentsRec.TestField("Paying Bank Account");
                PaymentsRec.TestField("Shortcut Dimension 1 Code");
                PaymentsRec.TestField("Shortcut Dimension 2 Code");
                PaymentsRec.TestField(Payee);
                PaymentsRec.TestField("Payment Narration");
                PLines.Reset;
                PLines.SetRange(No, PaymentsRec."No.");
                if PLines.Find('-')then begin
                    repeat if PLines."Account No" = '' then Error('Account No. Field is Blank. Please Fill the Line No. %1 with amount %2.', PLines."Line No", PLines.Amount);
                    until PLines.Next = 0;
                end;
                Committment.CheckPVCommittment(PaymentsRec);
                Committment.PVCommittment(PaymentsRec, ErrorMsg);
                if ErrorMsg <> '' then Error(ErrorMsg);
            end;
            PaymentsRec."Payment Type"::"Petty Cash": begin
                PaymentsRec.CalcFields("Petty Cash Amount");
                if PaymentsRec."Petty Cash Amount" <= 0 then Error('Petty Cash Amount can not be less than or equal to 0');
                if PaymentsRec."Petty Cash Amount" > CashManagementSetup."Petty Cash Max" then Error('Petty Cash amount can not be greater than %1.%2', GeneralLedgerSetup."LCY Code", CashManagementSetup."Petty Cash Max");
                Committment.CheckPettyCashCommittment(PaymentsRec);
                Committment.PettyCashCommittment(PaymentsRec, ErrorMsg);
                if ErrorMsg <> '' then Error(ErrorMsg);
            end;
            PaymentsRec."Payment Type"::"Petty Cash Surrender": begin
            end;
            PaymentsRec."Payment Type"::"Staff Claim": begin
                if PaymentsRec."Payment Narration" = '' then Error('Please define the Purpose for this claim');
                PLines.Reset;
                PLines.SetRange(PLines.No, PaymentsRec."No.");
                if PLines.Find('-')then begin
                    repeat PLines.TestField("Expenditure Date");
                        PLines.TestField("Expenditure Description");
                        if PLines.Amount <= 0 then Error('One of your lines has an amount less than or equal to 0');
                    until PLines.Next = 0;
                end;
                Committment.CheckStaffClaimCommittment(PaymentsRec);
                Committment.StaffClaimCommittment(PaymentsRec, ErrorMsg);
                if ErrorMsg <> '' then Error(ErrorMsg);
            end;
            end;
            if ApprovalMgt.CheckPaymentsApprovalsWorkflowEnabled(PaymentsRec)then ApprovalMgt.OnSendPaymentsForApproval(PaymentsRec);
            UpdateApprovalEntries(DocNo, PaymentsRec."Created By");
        end;
    end;
    procedure CancelPaymentsApproval(DocNo: Code[50]): Text begin
        PaymentsRec.Reset;
        PaymentsRec.SetRange("No.", DocNo);
        if PaymentsRec.FindFirst then begin
            case PaymentsRec."Payment Type" of PaymentsRec."Payment Type"::"Bank Transfer": begin
            end;
            PaymentsRec."Payment Type"::Imprest: begin
                Committment.CancelPaymentsCommitments(PaymentsRec);
                ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
            end;
            PaymentsRec."Payment Type"::"Imprest Surrender": begin
            end;
            /*"Payment Type"::"Payment Voucher":
            BEGIN
              PaymentVoucher.SETTABLEVIEW(PaymentsRec);
              PaymentVoucher.SAVEASPDF(filename);
            END;
            "Payment Type"::"Petty Cash":
            BEGIN
              PettyCashVoucher.SETTABLEVIEW(PaymentsRec);
              PettyCashVoucher.SAVEASPDF(filename);
            END;
            "Payment Type"::"Petty Cash Surrender":
            BEGIN
              PettyCashSurrender.SETTABLEVIEW(PaymentsRec);
              PettyCashSurrender.SAVEASPDF(filename);
            END;
            "Payment Type"::"Staff Claim":
            BEGIN
              StaffClaimVoucher.SETTABLEVIEW(PaymentsRec);
              StaffClaimVoucher.SAVEASPDF(filename);
            END;*/
            end;
            ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
        end;
    end;
    procedure SendRequisitionApproval(DocNo: Code[50])
    begin
        IRHeader.Get(DocNo);
        if ApprovalMgt.CheckReqWorkflowEnabled(IRHeader)then ApprovalMgt.OnSendReqRequestforApproval(IRHeader);
        UpdateApprovalEntries(DocNo, IRHeader."Requested By");
    end;
    procedure CancelRequisitionApproval(DocNo: Code[50])
    begin
        IRHeader.Get(DocNo);
        if GuiAllowed then;
        ApprovalMgt.OnCancelReqApprovalRequest(IRHeader);
    end;
    procedure SendTrainingRequestApproval(DocNo: Code[50])
    begin
        TrainingRequest.Get(DocNo);
        if ApprovalMgt.CheckTrainingRequestWorkflowEnabled(TrainingRequest)then ApprovalMgt.OnSendTrainingRequestforApproval(TrainingRequest);
        UpdateApprovalEntries(DocNo, TrainingRequest."User ID");
    end;
    procedure CancelTrainingRequestApproval(DocNo: Code[50])
    begin
        TrainingRequest.Get(DocNo);
        ApprovalMgt.OnCancelTrainingRequestApproval(TrainingRequest);
    end;
    procedure SendLeaveApproval(DocNo: Code[50])
    begin
        LeaveApplication.Get(DocNo);
        if ApprovalMgt.CheckLeaveRequestWorkflowEnabled(LeaveApplication)then ApprovalMgt.OnSendLeaveRequestApproval(LeaveApplication);
        UpdateApprovalEntries(DocNo, LeaveApplication."User ID");
    end;
    procedure CancelLeaveApproval(DocNo: Code[50])
    begin
        LeaveApplication.Get(DocNo);
        ApprovalMgt.OnCancelLeaveRequestApproval(LeaveApplication);
    end;
    procedure SendLoanApproval(DocNo: Code[50])
    begin
        LoanApplication.Get(DocNo);
        if ApprovalMgt.CheckLoanApplicationWorkflowEnabled(LoanApplication)then ApprovalMgt.OnSendLoanApplicationRequestforApproval(LoanApplication);
        UpdateApprovalEntries(DocNo, LoanApplication."User ID");
    end;
    procedure CancelLoanApproval(DocNo: Code[50])
    begin
        LoanApplication.Get(DocNo);
        ApprovalMgt.OnCancelLoanApplicationRequestApproval(LoanApplication);
    end;
    procedure SendTransportApproval(DocNo: Code[50])
    begin
        TravelRequests.Get(DocNo);
        if ApprovalMgt.CheckTransportWorkflowEnabled(TravelRequests)then ApprovalMgt.OnSendTransportApprovalRequest(TravelRequests);
        UpdateApprovalEntries(DocNo, TravelRequests."User ID");
    end;
    procedure CancelTransportApproval(DocNo: Code[50])
    begin
        TravelRequests.Get(DocNo);
        ApprovalMgt.OnCancelTransportApprovalRequest(TravelRequests);
    end;
    procedure PrintPayments(DocNo: Code[30]; Path: Text): Text var
        filename: Text;
    begin
        PaymentsRec.Reset;
        PaymentsRec.SetRange("No.", DocNo);
        if PaymentsRec.FindFirst then begin
            if PaymentsRec.Status <> PaymentsRec.Status::Released then Error('You can only print after the document is Approved');
            filename:=Path + Format(PaymentsRec."Payment Type") + '_' + DocNo + '_' + DocNo + '.pdf';
            //  if Exists(filename) then
            //EDDIE Erase(filename);
            case PaymentsRec."Payment Type" of PaymentsRec."Payment Type"::"Bank Transfer": begin
                InterBankTransfer.SetTableView(PaymentsRec);
            //EDDIE  InterBankTransfer.SaveAsPdf(filename);
            end;
            PaymentsRec."Payment Type"::Imprest: begin
                Imprest.SetTableView(PaymentsRec);
            //EDDIE Imprest.SaveAsPdf(filename);
            end;
            PaymentsRec."Payment Type"::"Imprest Surrender": begin
                ImprestSurrender.SetTableView(PaymentsRec);
            //EDDIE ImprestSurrender.SaveAsPdf(filename);
            end;
            PaymentsRec."Payment Type"::"Payment Voucher": begin
                PaymentVoucher.SetTableView(PaymentsRec);
            //EDDIE PaymentVoucher.SaveAsPdf(filename);
            end;
            PaymentsRec."Payment Type"::"Petty Cash": begin
                PettyCashVoucher.SetTableView(PaymentsRec);
            //EDDIE  PettyCashVoucher.SaveAsPdf(filename);
            end;
            PaymentsRec."Payment Type"::"Petty Cash Surrender": begin
                PettyCashSurrender.SetTableView(PaymentsRec);
            //EDDIE PettyCashSurrender.SaveAsPdf(filename);
            end;
            PaymentsRec."Payment Type"::"Staff Claim": begin
                StaffClaimVoucher.SetTableView(PaymentsRec);
            //EDDIE StaffClaimVoucher.SaveAsPdf(filename);
            end;
            end;
            exit(Format(PaymentsRec."Payment Type") + '_' + DocNo + '_' + PaymentsRec."No." + '.pdf');
        end;
    end;
    procedure PrintRequisitions(DocNo: Code[30]; Path: Text): Text var
        filename: Text;
    begin
        IRHeader.Reset;
        IRHeader.SetRange("No.", DocNo);
        if IRHeader.FindFirst then begin
            if IRHeader.Status <> IRHeader.Status::Released then Error('You can only print after the document is Approved');
            filename:=Path + Format(IRHeader."Document Type") + '_' + DocNo + '_' + IRHeader."No." + '.pdf';
            //EDDIE if Exists(filename) then
            //Erase(filename);
            case IRHeader."Document Type" of IRHeader."Document Type"::Purchase: begin
                IRHeader.Reset();
                IRHeader.SetFilter(IRHeader."No.", DocNo);
                if IRHeader.Find('-')then begin
                    PurchaseRequest.SetTableView(IRHeader);
                //EDDIE PurchaseRequest.SaveAsPdf(filename);
                end;
            end;
            IRHeader."Document Type"::Stock: begin
                IRHeader.Reset();
                IRHeader.SetFilter(IRHeader."No.", DocNo);
                if IRHeader.Find('-')then begin
                //EDDIE StoreRequest.SetTableView(IRHeader);
                // StoreRequest.SaveAsPdf(filename);
                end;
            end;
            end;
            exit(Format(IRHeader."Document Type") + '_' + DocNo + '_' + IRHeader."No." + '.pdf');
        end;
    end;
    // procedure PrintLeave(AppCode: Code[50]; Path: Text): Text
    // var
    //     HRLeave: Record "Employee Off/Holiday";
    //     Leave: Report "Employee Data";
    //     filename: Text;
    // begin
    //     LeaveApplication.Get(AppCode);
    //     filename := Path + 'Leave_' + AppCode + '-' + LeaveApplication."Employee No" + '.pdf';
    //     if Exists(filename) then
    //         Erase(filename);
    //     LeaveApplication.Reset();
    //     LeaveApplication.SetFilter(LeaveApplication."Application No", AppCode);
    //     if LeaveApplication.Find('-') then begin
    //         LeaveReport.SetTableView(LeaveApplication);
    //         LeaveReport.SaveAsPdf(filename);
    //     end;
    //     exit('Leave_' + AppCode + '-' + LeaveApplication."Employee No" + '.pdf');
    // end;
    procedure PrintLicense(LicenseNo: Code[50]; Path: Text): Text var
        LicenseApp: Record "License Applications";
        License: Report "License File";
        filename: Text;
        LicNo: Code[100];
    begin
        LicenseApp.Reset();
        LicenseApp.SetRange("License No.", LicenseNo);
        if LicenseApp.FindFirst()then begin
            LicNo:=DelChr(LicenseNo, '=', '/');
            filename:=Path + 'License_' + LicNo + '.pdf';
        //EDDIE  if Exists(filename) then
        //     Erase(filename);
        // License.SetTableView(LicenseApp);
        // License.SaveAsPdf(filename);
        end;
        exit('License_' + LicNo + '.pdf');
    end;
    procedure PrintMonthlyFormofReturn(ReturnNo: Code[50]; Path: Text): Text var
        FormofReturn: Record "Monthly Form of Return";
        Form: Report "Monthly Form of Return";
        filename: Text;
    begin
        FormofReturn.Get(ReturnNo);
        filename:=Path + 'MonthlyFormOfReturn' + ReturnNo + '.pdf';
        // EDDIE if Exists(filename) then
        //     Erase(filename);
        FormofReturn.Reset();
        FormofReturn.SetFilter(FormofReturn."No.", ReturnNo);
        if FormofReturn.Find('-')then begin
            Form.SetTableView(FormofReturn);
        //EDDIE  Form.SaveAsPdf(filename);
        end;
        exit('MonthlyFormOfReturn' + ReturnNo + '.pdf');
    end;
    // procedure PrintTraining(AppCode: Code[50]; Path: Text): Text
    // var
    //     HRLeave: Record "Employee Off/Holiday";
    //     Leave: Report "Employee Data";
    //     filename: Text;
    // begin
    //     TrainingRequest.Get(AppCode);
    //     filename := Path + 'Training_' + AppCode + '-' + TrainingRequest."Employee No" + '.pdf';
    //     if Exists(filename) then
    //         Erase(filename);
    //     Training.SetTableView(TrainingRequest);
    //     Training.SaveAsPdf(filename);
    //     exit('Training_' + AppCode + '-' + TrainingRequest."Employee No" + '.pdf');
    // end;
    // procedure PrintTransport(AppCode: Code[50]; Path: Text): Text
    // var
    //     HRLeave: Record "Employee Off/Holiday";
    //     Leave: Report "Employee Data";
    //     filename: Text;
    // begin
    //     TravelRequests.Get(AppCode);
    //     filename := Path + 'Transport_' + AppCode + '-' + TravelRequests."Employee No." + '.pdf';
    //     if Exists(filename) then
    //         Erase(filename);
    //     TravelRequests.Reset();
    //     TravelRequests.SetFilter(TravelRequests."Request No.", AppCode);
    //     if TravelRequests.Find('-') then begin
    //         TransportReq.SetTableView(TravelRequests);
    //         TransportReq.SaveAsPdf(filename);
    //     end;
    //     exit('Transport_' + AppCode + '-' + TravelRequests."Employee No." + '.pdf');
    // end;
    procedure PrintPaySlip(EmployeeNo: Code[50]; Path: Text; Period: Date): Text var
        filename: Text;
        PeriodText: Text;
    begin
        PeriodText:=DelChr(Format(Period), '=', '/|:');
        filename:=Path + 'PaySlip_' + PeriodText + '-' + EmployeeNo + '.pdf';
        //EDDIE  if Exists(filename) then
        //     Erase(filename);
        Employee.Reset;
        Employee.SetRange("No.", EmployeeNo);
        Employee.SetRange("Pay Period Filter", Period);
        if Employee.Find('-')then begin
            Payslip.SetTableView(Employee);
        //EDDIE Payslip.SaveAsPdf(filename);
        end;
        exit('PaySlip_' + PeriodText + '-' + EmployeeNo + '.pdf');
    end;
    procedure PrintP9(EmployeeNo: Code[50]; Path: Text; Year: Integer): Text var
        filename: Text;
        DateText: Text;
        NewDateText: Text;
        TimeText: Text;
        NewTimeText: Text;
    begin
        TimeText:=(Format(Time));
        DateText:=(Format(Today));
        NewTimeText:=DelChr(TimeText, '=', ':');
        NewDateText:=DelChr(DateText, '=', '/|:');
        filename:=Path + 'P9_' + EmployeeNo + '.pdf';
        // EDDIE if Exists(filename) then
        //     Erase(filename);
        Employee.Reset;
        Employee.SetRange("No.", EmployeeNo);
        if Employee.Find('-')then begin
            P9.SetTableView(Employee);
            P9.GetDefaults(Year);
        //EDDIE  P9.SaveAsPdf(filename);
        end;
        exit('P9_' + EmployeeNo + '.pdf');
    end;
    procedure GenerateLoanSchedule(LoanAppNo: Code[50])
    var
        PreviewShedule: Record "Repayment Schedule";
    begin
        LoanApplication.Reset();
        LoanApplication.SetRange("Loan No", LoanAppNo);
        if LoanApplication.FindFirst()then begin
            PreviewShedule.SetRange("Loan Category", LoanApplication."Loan Product Type");
            PreviewShedule.SetRange("Loan No", LoanAppNo);
            PreviewShedule.DeleteAll;
            if LoanApplication."Issued Date" = 0D then Error('You must Issue date');
            // if LoanApplication."Interest Calculation Method" = LoanApplication."Interest Calculation Method"::"Reducing Balance" then
            //     LoanApplication.CreateAnnuityLoan;
            if LoanApplication."Interest Calculation Method" = LoanApplication."Interest Calculation Method"::"Flat Rate" then LoanApplication.CreateFlatRateSchedule;
            if LoanApplication."Interest Calculation Method" = LoanApplication."Interest Calculation Method"::"Reducing Balance" then LoanApplication.CreateSaccoReducing;
            if LoanApplication."Interest Calculation Method" = LoanApplication."Interest Calculation Method"::Amortised then LoanApplication.CreateAmortizedLoan;
        end;
    end;
    procedure PrintLoanSchedule(EmployeeNo: Code[50]; LoanAppNo: Code[50]; Path: Text): Text var
        filename: Text;
        PeriodText: Text;
    begin
        filename:=Path + 'Loan Schedule_' + LoanAppNo + '-' + EmployeeNo + '.pdf';
        //EDDIE  if Exists(filename) then
        //     Erase(filename);
        RepaymentSchedule.Reset;
        RepaymentSchedule.SetRange("Employee No", EmployeeNo);
        RepaymentSchedule.SetRange("Loan No", LoanAppNo);
        if RepaymentSchedule.Find('-')then begin
            LoanRepaymentSchedule.SetTableView(RepaymentSchedule);
        //EDDIE LoanRepaymentSchedule.SaveAsPdf(filename);
        end;
        exit('Loan Schedule_' + LoanAppNo + '-' + EmployeeNo + '.pdf');
    end;
    procedure GetEmpIDFromUserID(UserCode: Code[100]): Code[50]var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserCode)then exit(UserSetup."Employee No.")
        else
            exit('');
    end;
    procedure GetUserIDFromEmpID(EmpID: Code[100]): Code[50]var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset;
        UserSetup.SetRange("Employee No.", EmpID);
        if UserSetup.FindFirst then exit(UserSetup."User ID");
    end;
    procedure AttachDocument(RecordID: RecordId; FileName: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        FileMgt: Codeunit "File Management";
        DocAttachment: Record "Document Attachment";
        RecRef: RecordRef;
        ServerPath: Text;
        Instr: InStream;
        OutStr: OutStream;
        ImportFile: File;
    begin
        // EDDIE ImportFile.Open(FileName);
        // ImportFile.CreateInStream(Instr);
        TempBlob.CreateOutStream(OutStr);
        CopyStream(OutStr, Instr);
        RecRef:=RecordID.GetRecord();
        if FileName <> '' then DocAttachment.SaveAttachment(RecRef, FileName, TempBlob);
    end;
    procedure CopyDocument(FromPath: Text; ToPath: Text; Replace: Boolean)
    var
        FileMgt: Codeunit "File Management";
    begin
    //EDDIE FileMgt.CopyServerFile(FromPath, ToPath, Replace);
    end;
    procedure GetFileExtension(FileName: Text)
    var
        FileMgt: Codeunit "File Management";
    begin
        FileMgt.GetExtension(FileName);
    end;
    procedure Execute(RecID: RecordId)
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        PurchSetup.get;
        PurchSetup.TestField("Procurement Documents Path");
        AttachDocument(RecID, PurchSetup."Procurement Documents Path");
    end;
    procedure CreateVendr(var Prequalifiedlist: Record "Prospective Suppliers"): Code[50]var
        Vend: Record Vendor;
        CategoryRec: Record "Supplier Category";
        PSetup: Record "Purchases & Payables Setup";
    begin
        PSetup.get;
        PSetup.TestField("Def Gen. Bus. Posting Group");
        PSetup.TestField("Default Vendor Posting Group");
        ;
        Prequalifiedlist.TestField(Prequalifiedlist."Company PIN No.");
        Vend.Reset();
        Vend.SetRange(Vend."KRA PIN", Prequalifiedlist."Company PIN No.");
        if Vend.FindFirst then exit(Vend."No.")
        else
        begin
            Vend.Init;
            Vend."No.":='';
            Vend.Name:=Prequalifiedlist.Name;
            Vend.Address:=Prequalifiedlist."Physical Address";
            Vend."Address 2":=Prequalifiedlist."Postal Address";
            Vend."E-Mail":=Prequalifiedlist."E-mail";
            Vend."Phone No.":=Prequalifiedlist."Telephone No";
            Vend."Telex No.":=Prequalifiedlist."Mobile No";
            Vend.Contact:=Prequalifiedlist."Contact Person Name";
            //Vend."KBA Code":=Prequalifiedlist."KBA Bank Code";
            //Vend."KBA Branch Code":=Prequalifiedlist."KBA Branch Code";
            Vend."Our Account No.":=Prequalifiedlist."Bank account No";
            //Vend."Vendor Type":=Prequalifiedlist."Vendor Type";
            Vend."KRA PIN":=Prequalifiedlist."Company PIN No.";
            //Vend.v:=Prequalifiedlist."Registration No";
            Vend."Vendor Posting Group":=PSetup."Default Vendor Posting Group";
            Vend."Gen. Bus. Posting Group":=PSetup."Def Gen. Bus. Posting Group";
            Vend."VAT Bus. Posting Group":=PSetup."Def VAT Bus. Posting Group";
            /*if CategoryRec.Get(Prequalifiedlist.Category) then begin
                Vend."Gen. Bus. Posting Group" := CategoryRec."Gen. Bus. Posting Group";
                Vend."VAT Bus. Posting Group" := CategoryRec."VAT Bus. Posting Group";
                Vend."Vendor Posting Group" := CategoryRec."Vendor Posting Group";
            end;*/
            Vend."PIN Certificate Expiry":=Prequalifiedlist."PIN Certificate Expiry";
            Vend.Insert(true);
            Prequalifiedlist."Vendor No":=Vend."No.";
            Prequalifiedlist.Modify;
            exit(Vend."No.");
        end;
    end;
    procedure ConfirmFundsReceipt(DocNo: Code[50])
    var
        PayRec: Record Payments;
    begin
        if PayRec.Get(DocNo)then begin
            if PayRec."Confirm Receipt" = true then Error('You cannot confirm more than once');
            PayRec."Confirm Receipt":=true;
            PayRec."Confirm Receipt Date-Time":=CurrentDateTime;
            PayRec."Confirm Receipt User":=UserId;
            PayRec.Modify();
        end;
    end;
    procedure SendIncidentForApproval(IncidentNo: Code[20])
    var
        Incident: Record "User Support Incident";
        AuditMgt: Codeunit "Internal Audit Management";
        ApprovalMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        Incident.Get(IncidentNo);
        if ApprovalsMgmt.CheckUserIncidencesWorkflowEnabled(Incident)then ApprovalsMgmt.OnSendUserIncidencesForApproval(Incident);
        UpdateApprovalEntries(Incident."Incident Reference", UserId);
        AuditMgt.SendRiskIncident(Incident);
    end;
    procedure CancelIncidentForApproval(IncidentNo: Code[20])
    var
        Incident: Record "User Support Incident";
        AuditMgt: Codeunit "Internal Audit Management";
        ApprovalMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        Incident.Get(IncidentNo);
        ApprovalsMgmt.OnCancelUserIncidencesApprovalRequest(Incident);
        UpdateApprovalEntries(Incident."Incident Reference", UserId);
    end;
    // RiskHeader
    procedure SendRiskForApproval(IncidentNo: Code[20])
    var
        Incident: Record "Risk Header";
        ApprovalMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        Incident.Get(IncidentNo);
        if ApprovalsMgmt.CheckRiskHeaderWorkflowEnabled(Incident)then ApprovalsMgmt.OnSendRiskHeaderForApproval(Incident);
        UpdateApprovalEntries(Incident."No.", UserId);
    end;
    procedure CancelRiskForApproval(IncidentNo: Code[20])
    var
        Incident: Record "Risk Header";
        ApprovalMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        Incident.Get(IncidentNo);
        ApprovalsMgmt.OnCancelRiskHeaderApprovalRequest(Incident);
        UpdateApprovalEntries(Incident."No.", UserId);
    end;
    //TransportIncident
    procedure SendTransportIncidentForApproval(IncidentNo: Code[20])
    var
        Incident: Record "Transport Incident";
        ApprovalMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        Incident.Get(IncidentNo);
        if ApprovalsMgmt.CheckTransportIncidentWorkflowEnabled(Incident)then ApprovalsMgmt.OnSendTransportIncidentForApproval(Incident);
        UpdateApprovalEntries(Incident."Incident Reference", UserId);
    end;
    procedure CancelTransportIncidentForApproval(IncidentNo: Code[20])
    var
        Incident: Record "Transport Incident";
        ApprovalMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        Incident.Get(IncidentNo);
        ApprovalsMgmt.OnCancelTransportIncidentApprovalRequest(Incident);
        UpdateApprovalEntries(Incident."Incident Reference", UserId);
    end;
    //DriverLogging
    procedure SendDriverLoggingForApproval(IncidentNo: Code[20])
    var
        Incident: Record "Driver Logging";
        ApprovalMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        Incident.Get(IncidentNo);
        if ApprovalsMgmt.CheckDriverLoggingWorkflowEnabled(Incident)then ApprovalsMgmt.OnSendDriverLoggingForApproval(Incident);
        UpdateApprovalEntries(Incident."Log No.", UserId);
    end;
    procedure CancelDriverLoggingForApproval(IncidentNo: Code[20])
    var
        Incident: Record "Driver Logging";
        ApprovalMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        Incident.Get(IncidentNo);
        ApprovalsMgmt.OnCancelDriverLoggingApprovalRequest(Incident);
        UpdateApprovalEntries(Incident."Log No.", UserId);
    end;
    //PrintIncident
    procedure PrintIncident(IncidentNo: Code[20]; Path: Text): Text var
        IncidentReport: Report "Incident Report";
        filename: Text;
    begin
        UserIncident.Get(IncidentNo);
        filename:=Path + 'Incident_' + IncidentNo + '-' + UserIncident."Incident Reference" + '.pdf';
        //EDDIE  if Exists(filename) then
        //     Erase(filename);
        UserIncident.Reset();
        UserIncident.SetFilter(UserIncident."Incident Reference", IncidentNo);
        if UserIncident.Find('-')then begin
            IncidentReport.SetTableView(UserIncident);
        //EDDIE  IncidentReport.SaveAsPdf(filename);
        end;
        exit('Incident_' + IncidentNo + '-' + UserIncident."Incident Reference" + '.pdf');
    end;
    procedure SendReviewAppraisal(AppraisalNo: Code[20])
    var
    begin
        Appraisal.Get(AppraisalNo);
        Appraisal.TestField("Appraisal Period");
        Appraisal.TestField("Employee No");
        Appraisal.TestField("Appraiser No");
        if ApprovalMgt.CheckNewEmpAppraisalWorkflowEnabled(Appraisal)then ApprovalMgt.OnSendNewEmpAppraisalRequestforApproval(Appraisal);
        UpdateApprovalEntries(AppraisalNo, Appraisal."Appraisee ID");
        Appraisal."Appraisal Status":=Appraisal."Appraisal Status"::Review;
        Appraisal.Modify;
    end;
    procedure PrintAppraisalObjectives(AppraisalNo: Code[20]; Path: Text): Text var
        AppraisalObjectives: Report "Employee Objectives - New";
        filename: Text;
    begin
        Appraisal.Get(AppraisalNo);
        filename:=Path + 'Appraisal_' + AppraisalNo + '-' + Appraisal."Appraisal No" + '.pdf';
        //EDDIE  if Exists(filename) then
        //     Erase(filename);
        Appraisal.Reset();
        Appraisal.SetFilter(Appraisal."Appraisal No", AppraisalNo);
        if Appraisal.Find('-')then begin
            AppraisalObjectives.SetTableView(Appraisal);
        //EDDIE AppraisalObjectives.SaveAsPdf(filename);
        end;
        exit('Appraisal_' + AppraisalNo + '-' + Appraisal."Appraisal No" + '.pdf');
    end;
    procedure PrintAppraisal(AppraisalNo: Code[20]; Path: Text): Text var
        AppraisalReport: Report "Employee Appraisal - New";
        filename: Text;
    begin
        Appraisal.Get(AppraisalNo);
        filename:=Path + 'Appraisal_' + AppraisalNo + '-' + Appraisal."Appraisal No" + '.pdf';
        // EDDIE if Exists(filename) then
        //     Erase(filename);
        Appraisal.Reset();
        Appraisal.SetFilter(Appraisal."Appraisal No", AppraisalNo);
        if Appraisal.Find('-')then begin
            AppraisalReport.SetTableView(Appraisal);
        //EDDIE AppraisalReport.SaveAsPdf(filename);
        end;
        exit('Appraisal_' + AppraisalNo + '-' + Appraisal."Appraisal No" + '.pdf');
    end;
    procedure CancelAppraisalApproval(DocNo: Code[50])
    begin
        Appraisal.Get(DocNo);
        ApprovalMgt.OnCancelEmployeeAppraisalApprovalRequest(Appraisal);
    end;
    procedure SendRiskSurvey(DocNo: Code[50])
    var
        AuditMgt: Codeunit "Internal Audit Management";
    begin
        AuditHeader.Get(DocNo);
        AuditMgt.MailRiskSurvey(AuditHeader);
        AuditMgt.InsertRiskRegister(AuditHeader);
        UpdateApprovalEntries(DocNo, AuditHeader."Created By");
    end;
    procedure PrintSurvey(SurveyNo: Code[20]; Path: Text): Text var
        Survey: Report "Risk Survey";
        filename: Text;
    begin
        AuditHeader.Get(SurveyNo);
        filename:=Path + 'Appraisal_' + SurveyNo + '-' + AuditHeader."No." + '.pdf';
        // EDDIE if Exists(filename) then
        //     Erase(filename);
        AuditHeader.Reset();
        AuditHeader.SetFilter(AuditHeader."No.", SurveyNo);
        if AuditHeader.Find('-')then begin
            Survey.SetTableView(Appraisal);
        //EDDIE  Survey.SaveAsPdf(filename);
        end;
        exit('Survey_' + SurveyNo + '-' + AuditHeader."No." + '.pdf');
    end;
    procedure PrintProcurementDocs(DocNo: Code[50]; Path: Text): Text var
        filename: Text;
        ProcReq: Record "Procurement Request";
        RFQReport: Report RFQ;
        RFPReport: Report RFP;
        EOIReport: Report EOI;
        TenderReport: Report Tender;
        BidderSelect: Record "Bidders Selection";
        SupplierSelect: Record "Supplier Selection";
    begin
        Commit();
        ProcReq.Reset();
        ProcReq.SetFilter("No.", '%1', DocNo);
        if ProcReq.FindFirst then begin
            //if ProcReq.Get(DocNo) then begin
            filename:=Path + Format(ProcReq."Process Type") + '_' + '-' + DocNo + '.pdf';
            // EDDIE if Exists(filename) then
            //     Erase(filename);
            case ProcReq."Process Type" of ProcReq."Process Type"::RFQ: begin
                SupplierSelect.Reset();
                SupplierSelect.SetRange("Reference No.", DocNo);
                if SupplierSelect.Find('-')then begin
                    RFQReport.SetTableView(SupplierSelect);
                //RFQReport.SaveAsPdf(filename);
                end;
            end;
            ProcReq."Process Type"::EOI: begin
                SupplierSelect.Reset();
                SupplierSelect.SetRange("Reference No.", DocNo);
                if SupplierSelect.Find('-')then begin
                    EOIReport.SetTableView(SupplierSelect);
                //EOIReport.SaveAsPdf(filename);
                end;
            end;
            ProcReq."Process Type"::RFP: begin
                SupplierSelect.Reset();
                SupplierSelect.SetRange("Reference No.", DocNo);
                if SupplierSelect.Find('-')then begin
                    RFPReport.SetTableView(SupplierSelect);
                //RFPReport.SaveAsPdf(filename);
                end;
            end;
            ProcReq."Process Type"::Tender: begin
                BidderSelect.Reset;
                BidderSelect.SetFilter(BidderSelect."Reference No.", DocNo);
                if BidderSelect.Find('-')then begin
                    TenderReport.SetTableView(BidderSelect);
                //TenderReport.SaveAsPdf(filename);
                end;
            end;
            end;
            exit(Format(ProcReq."Process Type") + '_' + '-' + DocNo + '.pdf');
        end;
    end;
    procedure CreatePurchaseRequestLine(DocumentNo: Code[20]; Procline: Code[20]; No: Code[20]; ItemCategory: Code[20]; Quantity: Integer; PlannedQty: integer; SpecificationTxt: Text; RequiredDate: date): Integer var
        InternalRequest: Record "Internal Request Header";
        InternalRequestLine, RequestLine: Record "Internal Request Line";
        ProcPlan: Record "Procurement Plan";
        LineNo: Integer;
        //TempBlob: Record "TempBlob";
        OutStream: OutStream;
        SpecificationBigTxt: BigText;
    begin
        if InternalRequest.Get(DocumentNo)then begin
            RequestLine.Reset();
            RequestLine.SetRange("Document No.", DocumentNo);
            if RequestLine.FindLast()then LineNo:=RequestLine."Line No." + 10000
            else
                LineNo:=10000;
            InternalRequestLine.Init();
            InternalRequestLine."Document No.":=DocumentNo;
            InternalRequestLine."Procurement Plan":=InternalRequest."Procurement Plan";
            InternalRequestLine."Shortcut Dimension 1 Code":=InternalRequest."Shortcut Dimension 1 Code";
            InternalRequestLine."Shortcut Dimension 2 Code":=InternalRequest."Shortcut Dimension 2 Code";
            InternalRequestLine."Item Category Code":=ItemCategory;
            //Specifications            
            SpecificationBigTxt.ADDTEXT(SpecificationTxt);
            InternalRequestLine.Specification2.CREATEOUTSTREAM(OutStream);
            SpecificationBigTxt.WRITE(OutStream);
            InternalRequestLine."Procurement Plan Item":=Procline;
            InternalRequestLine.Validate("Procurement Plan Item");
            ProcPlan.reset;
            ProcPlan.SetRange("Plan Item No", Procline);
            if ProcPlan.FindFirst()then begin
                InternalRequestLine."No.":=ProcPlan."No.";
            end;
            InternalRequestLine."No.":=No;
            InternalRequestLine."Document Type":=InternalRequestLine."Document Type"::Purchase;
            InternalRequestLine.Validate("No.");
            InternalRequestLine."Planned Quantity":=PlannedQty;
            InternalRequestLine.Quantity:=Quantity;
            InternalRequestLine.Validate(Quantity);
            InternalRequestLine."Line No.":=LineNo;
            InternalRequestLine."Requested Receipt Date":=RequiredDate;
            InternalRequestLine.Insert();
        end;
    end;
    procedure CreateStoreRequestLine(DocumentNo: Code[20]; No: Code[20]; Location: Code[30]; Quantity: Integer): Integer var
        InternalRequest: Record "Internal Request Header";
        InternalRequestLine, RequestLine: Record "Internal Request Line";
        LineNo: Integer;
    begin
        if InternalRequest.Get(DocumentNo)then begin
            RequestLine.Reset();
            RequestLine.SetRange("Document No.", DocumentNo);
            if RequestLine.FindLast()then LineNo:=RequestLine."Line No." + 10000
            else
                LineNo:=10000;
            InternalRequestLine.Init();
            InternalRequestLine."Document No.":=DocumentNo;
            InternalRequestLine.Validate("Document No.");
            InternalRequestLine."No.":=No;
            InternalRequestLine.Validate("No.");
            InternalRequestLine."Location Code":=Location;
            InternalRequestLine.Quantity:=Quantity;
            InternalRequestLine.Validate(Quantity);
            InternalRequestLine."Line No.":=LineNo;
            InternalRequestLine.Insert();
        end;
    end;
    procedure GetCoopPaymentAdvise(transactionReferenceCode: Code[200]; transactionDate: Date; totalAmount: Decimal; currency: Code[200]; documentReferenceNumber: Code[200]; bankCode: Code[200]; branchCode: Code[200]; paymentDate: Date; paymentReferenceCode: Code[200]; paymentCode: Code[200]; paymentMode: Code[200]; paymentAmount: Decimal; additionalInfo: Code[200]; accountNumber: Code[200]; institutionCode: Code[200])
    var
        myInt: Integer;
    begin
    end;
    procedure GetAccountName(accountNumber: Code[200])
    var
        myInt: Integer;
    begin
    end;
    procedure SubmitApplication(ApplicationNo: Code[20])
    var
        HRMgt: Codeunit "HR Management";
    begin
        HRMgt.SubmitAplication(ApplicationNo);
    end;
    procedure UploadLicenseApplicantDocument(AppNo: code[100]; DocName: text[100]; FilePath: text): Text var
        FilePath2: Text;
        OnlinePath: Text;
        RecID: RecordId;
        FileName: Text;
        TempFile: File;
        NewStream: InsTream;
        RecRef: RecordRef;
        TableID: Integer;
        RecLink: Record "Record Link";
        CompanyInfo: Record "Company Information";
        LineNo: Integer;
        DocNamePage: page "Document Name";
        FileUploadedSuccessTxt: Label 'File %1 uploaded successfully';
        FinalFilename: Text;
        FinalPath: Text;
        //FileSystem: DotNet MyDirectory;
        FileMgt: Codeunit "File Management";
        UploadFile: Text[250];
        AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
        DataInstream: InStream;
        DataOutstream: OutStream;
        Applicant: Record "Licensing dairy Enterprise";
        AppDocuments: Record "Licensing Required Documents";
    begin
        CompanyInfo.get;
        CompanyInfo.TestField("Document Path");
        CompanyInfo.TestField("Online Document Path");
        FilePath:=FilePath;
        //Add Record Link
        // Option Imprest,ImprestSurrender,Applicant,PurchaseRequest,Risk,Incident,Leave,Transport,StaffClaim,PettyCash,PettyCashSurrender,StoreRequest,Training,TrainingEvaluation
        RecLink.Reset();
        if RecLink.FindLast()then LineNo:=RecLink."Link ID" + 1
        else
            LineNo:=1;
        Commit();
        AppDocuments.Reset();
        AppDocuments.SetRange("No.", AppNo);
        AppDocuments.SetRange(Document, DocName);
        if AppDocuments.FindFirst()then RecID:=AppDocuments.RecordId;
        RecLink.Init();
        RecLink."Link ID":=LineNo;
        RecLink."Record ID":=RecID;
        RecLink.URL1:=FilePath; // + '/' + FileName
        RecLink.Description:=FilePath;
        RecLink.Type:=RecLink.Type::Link;
        RecLink.Created:=CurrentDateTime;
        RecLink.Company:=CompanyName;
        RecLink."User ID":=UserId;
        RecLink.Insert();
        exit(FileName);
        FilePath:='';
    end;
    procedure UploadLicensePermitDocument(AppNo: code[100]; DocName: text[100]; FilePath: text): Text var
        FilePath2: Text;
        OnlinePath: Text;
        RecID: RecordId;
        FileName: Text;
        TempFile: File;
        NewStream: InsTream;
        RecRef: RecordRef;
        TableID: Integer;
        RecLink: Record "Record Link";
        CompanyInfo: Record "Company Information";
        LineNo: Integer;
        DocNamePage: page "Document Name";
        FileUploadedSuccessTxt: Label 'File %1 uploaded successfully';
        FinalFilename: Text;
        FinalPath: Text;
        //FileSystem: DotNet MyDirectory;
        FileMgt: Codeunit "File Management";
        UploadFile: Text[250];
        AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
        DataInstream: InStream;
        DataOutstream: OutStream;
        Applicant: Record "License Applications";
        AppDocuments: Record "Licensing Required Documents";
    begin
        CompanyInfo.get;
        CompanyInfo.TestField("Document Path");
        CompanyInfo.TestField("Online Document Path");
        FilePath:=FilePath;
        //Add Record Link
        // Option Imprest,ImprestSurrender,Applicant,PurchaseRequest,Risk,Incident,Leave,Transport,StaffClaim,PettyCash,PettyCashSurrender,StoreRequest,Training,TrainingEvaluation
        RecLink.Reset();
        if RecLink.FindLast()then LineNo:=RecLink."Link ID" + 1
        else
            LineNo:=1;
        Commit();
        AppDocuments.Reset();
        AppDocuments.SetRange("No.", AppNo);
        AppDocuments.SetRange(Document, DocName);
        if AppDocuments.FindFirst()then RecID:=AppDocuments.RecordId;
        RecLink.Init();
        RecLink."Link ID":=LineNo;
        RecLink."Record ID":=RecID;
        RecLink.URL1:=FilePath; // + '/' + FileName
        RecLink.Description:=FilePath;
        RecLink.Type:=RecLink.Type::Link;
        RecLink.Created:=CurrentDateTime;
        RecLink.Company:=CompanyName;
        RecLink."User ID":=UserId;
        RecLink.Insert();
        exit(FileName);
        FilePath:='';
    end;
    procedure UploadProcurementDocument(ProspectID: code[100]; RefNo: code[100]; FilePath: text): Text var
        FilePath2: Text;
        OnlinePath: Text;
        RecID: RecordId;
        FileName: Text;
        TempFile: File;
        NewStream: InsTream;
        RecRef: RecordRef;
        TableID: Integer;
        RecLink: Record "Record Link";
        CompanyInfo: Record "Company Information";
        LineNo: Integer;
        DocNamePage: page "Document Name";
        DocName: Text;
        FileUploadedSuccessTxt: Label 'File %1 uploaded successfully';
        FinalFilename: Text;
        FinalPath: Text;
        //FileSystem: DotNet MyDirectory;
        FileMgt: Codeunit "File Management";
        UploadFile: Text[250];
        AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
        DataInstream: InStream;
        DataOutstream: OutStream;
        Applicant: Record Applicants2;
        Payments: Record Payments;
        Leave: Record "Leave Application";
        TenderLines: Record "Prospective Supplier Tender";
        // ProcurementDocs: Record "Procurement Document";
        ProcurementDocs: Record "Supplier Document Links";
        ProcurementDocsLinks: Record "Procurement Document Links";
        UrlPath: text;
        DocMgmt: codeunit "Document Management";
    begin
        CompanyInfo.get;
        CompanyInfo.TestField("Document Path");
        CompanyInfo.TestField("Online Document Path");
        RecLink.Reset();
        if RecLink.FindLast()then LineNo:=RecLink."Link ID" + 1
        else
            LineNo:=1;
        Commit();
        TenderLines.Reset();
        TenderLines.SetRange("Prospect No.", ProspectID);
        TenderLines.SetRange("Tender No.", RefNo);
        if TenderLines.FindFirst()then RecID:=TenderLines.RecordId;
        RecLink.Init();
        RecLink."Link ID":=LineNo;
        RecLink."Record ID":=RecID;
        RecLink.URL1:=FilePath; // + '/' + FileName
        RecLink.Description:=FilePath;
        RecLink.Type:=RecLink.Type::Link;
        RecLink.Created:=CurrentDateTime;
        RecLink.Company:=CompanyName;
        RecLink."User ID":=UserId;
        RecLink.Insert();
        ProcurementDocs.Init();
        ProcurementDocs."No.":=ProspectID;
        ProcurementDocs.LineNo:=LineNo;
        ProcurementDocs.Link:=FilePath;
        ProcurementDocs.Description:=FilePath;
        ProcurementDocs."Record ID":=(RecID);
        ProcurementDocs."Tender No":=RefNo;
        ProcurementDocs.Insert();
        exit(FileName);
        FilePath:='';
    end;
    procedure UploadRFQDocument(VendorNo: code[100]; RefNo: code[100]; FilePath: text): Text var
        FilePath2: Text;
        OnlinePath: Text;
        RecID: RecordId;
        FileName: Text;
        TempFile: File;
        NewStream: InsTream;
        RecRef: RecordRef;
        TableID: Integer;
        RecLink: Record "Record Link";
        CompanyInfo: Record "Company Information";
        LineNo: Integer;
        DocNamePage: page "Document Name";
        DocName: Text;
        FileUploadedSuccessTxt: Label 'File %1 uploaded successfully';
        FinalFilename: Text;
        FinalPath: Text;
        //FileSystem: DotNet MyDirectory;
        FileMgt: Codeunit "File Management";
        UploadFile: Text[250];
        AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
        DataInstream: InStream;
        DataOutstream: OutStream;
        Applicant: Record Applicants2;
        Payments: Record Payments;
        Leave: Record "Leave Application";
        QuoteEval: Record "Quote Evaluation";
    begin
        CompanyInfo.get;
        CompanyInfo.TestField("Document Path");
        CompanyInfo.TestField("Online Document Path");
        FilePath:=FilePath;
        //Add Record Link
        // Option Imprest,ImprestSurrender,Applicant,PurchaseRequest,Risk,Incident,Leave,Transport,StaffClaim,PettyCash,PettyCashSurrender,StoreRequest,Training,TrainingEvaluation
        RecLink.Reset();
        if RecLink.FindLast()then LineNo:=RecLink."Link ID" + 1
        else
            LineNo:=1;
        Commit();
        QuoteEval.Reset();
        QuoteEval.SetRange("Vendor No", VendorNo);
        QuoteEval.SetRange("Quote No", RefNo);
        if QuoteEval.FindFirst()then RecID:=QuoteEval.RecordId;
        RecLink.Init();
        RecLink."Link ID":=LineNo;
        RecLink."Record ID":=RecID;
        RecLink.URL1:=FilePath; // + '/' + FileName
        RecLink.Description:=FilePath;
        RecLink.Type:=RecLink.Type::Link;
        RecLink.Created:=CurrentDateTime;
        RecLink.Company:=CompanyName;
        RecLink."User ID":=UserId;
        RecLink.Insert();
        exit(FileName);
        FilePath:='';
    end;
    procedure UploadEducationDocument(AppNo: code[100]; LineNumber: Integer; FilePath: text): Text var
        FilePath2: Text;
        OnlinePath: Text;
        RecID: RecordId;
        FileName: Text;
        TempFile: File;
        NewStream: InsTream;
        RecRef: RecordRef;
        TableID: Integer;
        RecLink: Record "Record Link";
        ProcDocs: Record "Procurement Document Links";
        CompanyInfo: Record "Company Information";
        LineNo: Integer;
        DocNamePage: page "Document Name";
        DocName: Text;
        FileUploadedSuccessTxt: Label 'File %1 uploaded successfully';
        FinalFilename: Text;
        FinalPath: Text;
        //FileSystem: DotNet MyDirectory;
        FileMgt: Codeunit "File Management";
        UploadFile: Text[250];
        AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
        DataInstream: InStream;
        DataOutstream: OutStream;
        Applicant: Record "Applicant Job Education2";
    begin
        CompanyInfo.get;
        CompanyInfo.TestField("Document Path");
        CompanyInfo.TestField("Online Document Path");
        FilePath:=FilePath;
        //Add Record Link
        // Option Imprest,ImprestSurrender,Applicant,PurchaseRequest,Risk,Incident,Leave,Transport,StaffClaim,PettyCash,PettyCashSurrender,StoreRequest,Training,TrainingEvaluation
        RecLink.Reset();
        if RecLink.FindLast()then LineNo:=RecLink."Link ID" + 1
        else
            LineNo:=1;
        Commit();
        Applicant.Reset();
        Applicant.SetRange("Applicant No.", AppNo);
        Applicant.SetRange("Line No.", LineNumber);
        if Applicant.FindFirst()then RecID:=Applicant.RecordId;
        RecLink.Init();
        RecLink."Link ID":=LineNo;
        RecLink."Record ID":=RecID;
        RecLink.URL1:=FilePath; // + '/' + FileName
        RecLink.Description:=FilePath;
        RecLink.Type:=RecLink.Type::Link;
        RecLink.Created:=CurrentDateTime;
        RecLink.Company:=CompanyName;
        RecLink."User ID":=UserId;
        RecLink.Insert();
        ProcDocs.Init();
        ProcDocs."No.":=Format(LineNo);
        ProcDocs.Link:=FilePath; // + '/' + FileName;
        ProcDocs.Insert();
        exit(FileName);
        FilePath:='';
    end;
    // upload document
    procedure UploadDocument(DocID: code[100]; PageCaption: text; RecID: RecordId): Text var
        FilePath: Text;
        OnlinePath: Text;
        FileName: Text;
        TempFile: File;
        NewStream: InsTream;
        RecRef: RecordRef;
        TableID: Integer;
        RecLink: Record "Record Link";
        CompanyInfo: Record "Company Information";
        LineNo: Integer;
        //DocNamePage: page "Document Name";
        DocName: Text;
        FileUploadedSuccessTxt: Label 'File %1 uploaded successfully';
        FinalFilename: Text;
        FinalPath: Text;
    ///FileSystem: DotNet MyDirectory;
    begin
        CompanyInfo.get;
        CompanyInfo.TestField("Document Path");
        CompanyInfo.TestField("Online Document Path");
        FilePath:=CompanyInfo."Document Path" + '\' + DocID + PageCaption;
        OnlinePath:=CompanyInfo."Online Document Path" + '/' + DocID + PageCaption;
        // if not FileMgt.ServerDirectoryExists(FilePath) then
        //  FileMgt.ServerCreateDirectory(FilePath);
        if UploadIntoStream('Upload', '', AllFilesDescriptionTxt, FileName, DataInstream)then begin
            UploadFile:=FilePath + '\' + FileName;
            if FileMgt.ServerFileExists(UploadFile)then //FileMgt.DeleteServerFile(UploadFile);
                //WHOLE EDDIE
                // TempFile.Create(UploadFile);
                // TempFile.CreateOutStream(DataOutstream);
                // CopyStream(DataOutstream, DataInstream);
                // TempFile.Close();
                //Add Record Link
                RecLink.Reset();
            if RecLink.FindLast()then LineNo:=RecLink."Link ID" + 1
            else
                LineNo:=1;
            Commit();
            if CompanyInfo."Save to Sharepoint" then begin
                RecLink.Init();
                RecLink."Link ID":=LineNo;
                RecLink."Record ID":=RecID;
                RecLink.URL1:=OnlinePath + '\' + FileName;
                RecLink.Description:=OnlinePath + '\' + FileName;
                RecLink.Type:=RecLink.Type::Link;
                RecLink.Created:=CurrentDateTime;
                RecLink.Company:=CompanyName;
                RecLink."User ID":=UserId;
                RecLink.Insert();
                exit(FileName);
                FilePath:='';
            end
            else
            begin
                RecLink.Init();
                RecLink."Link ID":=LineNo;
                RecLink."Record ID":=RecID;
                RecLink.URL1:=FilePath + '\' + FileName;
                RecLink.Description:=FilePath + '\' + FileName;
                RecLink.Type:=RecLink.Type::Link;
                RecLink.Created:=CurrentDateTime;
                RecLink.Company:=CompanyName;
                RecLink."User ID":=UserId;
                RecLink.Insert();
                exit(FileName);
                FilePath:='';
            end;
        end;
    end;
    procedure UploadJobAppliedDocument(AppNo: code[100]; NeedCode: code[100]; FilePath: text): Text var
        FilePath2: Text;
        OnlinePath: Text;
        RecID: RecordId;
        FileName: Text;
        TempFile: File;
        NewStream: InsTream;
        RecRef: RecordRef;
        TableID: Integer;
        RecLink: Record "Record Link";
        CompanyInfo: Record "Company Information";
        LineNo: Integer;
        DocNamePage: page "Document Name";
        DocName: Text;
        FileUploadedSuccessTxt: Label 'File %1 uploaded successfully';
        FinalFilename: Text;
        FinalPath: Text;
        //FileSystem: DotNet MyDirectory;
        FileMgt: Codeunit "File Management";
        UploadFile: Text[250];
        AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
        DataInstream: InStream;
        DataOutstream: OutStream;
        Applicant: Record "Applicant job applied";
    begin
        CompanyInfo.get;
        CompanyInfo.TestField("Document Path");
        CompanyInfo.TestField("Online Document Path");
        FilePath:=FilePath;
        //Add Record Link
        // Option Imprest,ImprestSurrender,Applicant,PurchaseRequest,Risk,Incident,Leave,Transport,StaffClaim,PettyCash,PettyCashSurrender,StoreRequest,Training,TrainingEvaluation
        RecLink.Reset();
        if RecLink.FindLast()then LineNo:=RecLink."Link ID" + 1
        else
            LineNo:=1;
        Commit();
        Applicant.Reset();
        Applicant.SetRange("Application No.", AppNo);
        Applicant.SetRange("Need Code", NeedCode);
        if Applicant.FindFirst()then RecID:=Applicant.RecordId;
        RecLink.Init();
        RecLink."Link ID":=LineNo;
        RecLink."Record ID":=RecID;
        RecLink.URL1:=FilePath; // + '/' + FileName
        RecLink.Description:=FilePath;
        RecLink.Type:=RecLink.Type::Link;
        RecLink.Created:=CurrentDateTime;
        RecLink.Company:=CompanyName;
        RecLink."User ID":=UserId;
        RecLink.Insert();
        exit(FileName);
        FilePath:='';
    end;
    procedure SubmitLicenseRegistration(RefNo: Code[200])
    var
        LicenseApp: Record "Licensing dairy Enterprise";
        Paymgmt: Codeunit "Payments Management";
        CompSetup: Record "Compliance Setup";
    begin
        LicenseApp.Reset();
        LicenseApp.SetRange("Application no", RefNo);
        if LicenseApp.Find('-')then begin
            LicenseApp.TestField("Customer Type");
            if LicenseApp."Customer Type" = LicenseApp."Customer Type"::Individual then begin
                LicenseApp.TestField("Individual Pin Number");
                LicenseApp.TestField("ID Number");
            end;
            if LicenseApp."Customer Type" = LicenseApp."Customer Type"::"Registered Entity" then begin
                LicenseApp.TestField("Company Pin Number");
                LicenseApp.TestField("Company Registration Number");
            end;
            CompSetup.get;
            if CompSetup."Enforce Workflow" then begin
                if ApprovalsMgmt.CheckLicenseRegistrationWorkflowEnabled(LicenseApp)then ApprovalsMgmt.OnSendLicenseRegistrationForApproval(LicenseApp);
                UpdateApprovalEntries(LicenseApp."Application no", UserId);
            end
            else
            begin
                LicenseApp."Approval Status":=LicenseApp."Approval Status"::Approved;
                LicenseApp.Submitted:=true;
            end;
            exit;
        end;
    end;
    procedure SubmitLicenseApplication(RefNo: Code[200])
    var
        Paymgmt: codeunit "Payments Management";
        LicenseApp: Record "License Applications";
    begin
        LicenseApp.Reset();
        LicenseApp.SetRange("No.", RefNo);
        if LicenseApp.FindFirst()then begin
            LicenseApp.TestField(Category);
            if ApprovalsMgmt.CheckLicenseApplicationWorkflowEnabled(LicenseApp)then ApprovalsMgmt.OnSendLicenseApplicationForApproval(LicenseApp);
            //Paymgmt.InvoiceLicenseApplicant(LicenseApp."Applicant No.", LicenseApp."No.");
            UpdateApprovalEntries(LicenseApp."Applicant No.", UserId);
        end;
    end;
    procedure ChangeLicenseApplicationStatus(RefNo: Code[200]; Status: Option Open, "Pending inspection", "Station Manager", "Head Office", "Pending permit fee payment", Approved, Rejected, Archived)
    var
        Paymgmt: codeunit "Payments Management";
        LicenseApp: Record "License Applications";
    begin
        LicenseApp.Reset();
        LicenseApp.SetRange("No.", RefNo);
        if LicenseApp.FindFirst()then begin
            LicenseApp.Status:=Status;
            LicenseApp.Modify();
        end;
    end;
    procedure ApproveLicenseApplication(RefNo: Code[200])
    var
        Paymgmt: codeunit "Payments Management";
        LicenseApp: Record "License Applications";
    begin
        LicenseApp.Reset();
        LicenseApp.SetRange("No.", RefNo);
        if LicenseApp.FindFirst()then begin
            RegPermits.Reset();
            RegPermits.SetRange("License/Permit Category", LicenseApp.Category);
            if RegPermits.FindFirst()then begin
                if(RegPermits."Annual fees(Ksh)" <> 0)then LicenseApp.Status:=LicenseApp.Status::"Pending permit fee payment"
                else
                    LicenseApp.Status:=LicenseApp.Status::Approved;
                LicenseApp.Modify();
            end;
        end;
    end;
    procedure InsertLicenseApprovalComments(DocNo: code[20]; Comment: Text[2000]; Status: option "Station Manager", "Head Office", HOD; Type: Option Approval, Rejection; ApproverID: Code[50])
    var
        LicenseApp: record "License Approval Comments";
    begin
        LicenseApp.Init();
        LicenseApp."Document No":=DocNo;
        LicenseApp.Status:=Status;
        LicenseApp.Comment:=Comment;
        LicenseApp.Type:=Type;
        LicenseApp."Approver ID":=ApproverID;
        LicenseApp."Entry Date":=Today;
        LicenseApp.Insert(true);
    end;
    procedure StationManagerApproval(RefNo: Code[200]; Comment: Text[200])
    var
        Paymgmt: codeunit "Payments Management";
        LicenseApp: Record "License Applications";
        CompMgmt: codeunit "Compliance Management";
    begin
        LicenseApp.Reset();
        LicenseApp.SetRange("No.", RefNo);
        if LicenseApp.FindFirst()then begin
            LicenseApp.Status:=LicenseApp.Status::"Head Office";
            LicenseApp."Station Manager comment":=Comment;
            LicenseApp.Modify();
        end;
    end;
    procedure HeadOfficeApproval(RefNo: Code[200]; Comment: Text[200])
    var
        Paymgmt: codeunit "Payments Management";
        LicenseApp: Record "License Applications";
        CompMgmt: codeunit "Compliance Management";
    begin
        LicenseApp.Reset();
        LicenseApp.SetRange("No.", RefNo);
        if LicenseApp.FindFirst()then begin
            RegPermits.Reset();
            RegPermits.SetRange("License/Permit Category", LicenseApp.Category);
            if RegPermits.FindFirst()then begin
                if(RegPermits."Annual fees(Ksh)" <> 0)then begin
                    LicenseApp.Status:=LicenseApp.Status::"Pending permit fee payment";
                    Paymgmt.InvoiceLicenseAnnualFee(LicenseApp."Applicant No.", LicenseApp."No.");
                end
                else
                    LicenseApp.Status:=LicenseApp.Status::HOD;
                LicenseApp."Head office comment":=Comment;
                LicenseApp.Modify();
            end;
        end;
    end;
    procedure HODApproval(RefNo: Code[200])
    var
        Paymgmt: codeunit "Payments Management";
        LicenseApp: Record "License Applications";
        CompMgmt: codeunit "Compliance Management";
    begin
        CompMgmt.IssueLicense(RefNo);
    end;
    procedure InvoiceLicenseAnnualFee(RefNo: Code[200])
    var
        Paymgmt: codeunit "Payments Management";
        LicenseApp: Record "License Applications";
    begin
        LicenseApp.SetRange("No.", RefNo);
        if LicenseApp.FindFirst()then begin
            Paymgmt.InvoiceLicenseAnnualFee(LicenseApp."Applicant No.", LicenseApp."No.");
        end;
    end;
    procedure InvoiceMonthlyFormOfReturn(RefNo: Code[200])
    var
        Paymgmt: codeunit "Payments Management";
    begin
        Paymgmt.InvoiceMonthlyFormOfReturn(RefNo);
    end;
    // procedure SubmitLicenseRenewal(RefNo: Code[200])
    // var
    //     Paymgmt: codeunit "Payments Management";
    //     LicenseApp: Record "License Renewals";
    // begin
    //     LicenseApp.SetRange("No.", RefNo);
    //     if LicenseApp.FindFirst() then begin
    //         LicenseApp.TestField(Category);
    //         LicenseApp.Submitted := true;
    //         LicenseApp.Status := LicenseApp.Status::"Pending inspection";
    //         LicenseApp.Modify();
    //         //Paymgmt.InvoiceLicenseApplicationRenewal(LicenseApp."Applicant No.", LicenseApp."No.");
    //     end;
    // end;
    procedure SubmitApplicationLicenseRenewal(RefNo: Code[200])
    var
        Paymgmt: codeunit "Payments Management";
        LicenseApp: Record "License Renewals";
    begin
        LicenseApp.SetRange("No.", RefNo);
        if LicenseApp.FindFirst()then begin
            LicenseApp.TestField(Category);
            Paymgmt.InvoiceLicenseRenewal(LicenseApp."Applicant No.", LicenseApp."No.");
        end;
    end;
    procedure CalculateReturnPayments(RefNo: Code[20]): Decimal var
        ComplianceMgmt: Codeunit "Compliance Management";
    begin
        ComplianceMgmt.CalculatePayments(RefNo);
    end;
    procedure PostPayments()
    var
        MpesaIntegration: Codeunit "MPESA Integration";
    begin
        MpesaIntegration.PostMpesaPayments();
    end;
    procedure UploadProspectiveSupplierDocument(ProspectNo: code[100]): Text var
        FilePath: Text;
        OnlinePath: Text;
        FileName: Text;
        TempFile: File;
        NewStream: InsTream;
        RecRef: RecordRef;
        TableID: Integer;
        RecLink: Record "Record Link";
        CompanyInfo: Record "Company Information";
        LineNo: Integer;
        //DocNamePage: page "Document Name";
        DocName: Text;
        FileUploadedSuccessTxt: Label 'File %1 uploaded successfully';
        FinalFilename: Text;
        FinalPath: Text;
        //eddie allFileSystem: DotNet MyDirectory;
        RandomNo: Integer;
        RandomNoTxt: Guid;
        NewFileName: Text;
        NewTxt: Text;
        // ProcurementDocs: Record "Procurement Document Links";
        ProcurementDocs: Record "Supplier Document Links";
        RecID: RecordId;
        DocMgmt: Codeunit "Document Management";
        UrlPath: Text;
        ProspetiveSupp: Record "Prospective Suppliers";
    begin
        CompanyInfo.get;
        CompanyInfo.TestField("Document Path");
        CompanyInfo.TestField("Online Document Path");
        RandomNoTxt:=CreateGuid();
        ProspetiveSupp.Get(ProspectNo);
        RecID:=ProspetiveSupp.RecordId;
        //  FilePath := CompanyInfo."Document Path" + '\' + ProspectNo;
        FilePath:=CompanyInfo."Document Path";
        OnlinePath:=CompanyInfo."Online Document Path" + '/' + ProspectNo;
        // EDDIE 
        //if not FileMgt.ServerDirectoryExists(FilePath) then
        //     FileMgt.ServerCreateDirectory(FilePath);
        // if UploadIntoStream('Upload', '', AllFilesDescriptionTxt, FileName, DataInstream) then begin
        //     UploadFile := FilePath + '\' + ProspectNo + '_' + RandomNoTxt + '_' + FileName;
        //     if FileMgt.ServerFileExists(UploadFile) then
        //         FileMgt.DeleteServerFile(UploadFile);
        //     TempFile.Create(UploadFile);
        //     TempFile.CreateOutStream(DataOutstream);
        //     CopyStream(DataOutstream, DataInstream);
        //     TempFile.Close();
        //Add Record Link
        RecLink.Reset();
        if RecLink.FindLast()then LineNo:=RecLink."Link ID" + 1
        else
            LineNo:=1;
        Commit();
        if CompanyInfo."Save to Sharepoint" then begin
            RecLink.Init();
            RecLink."Link ID":=LineNo;
            RecLink."Record ID":=RecID;
            RecLink.URL1:=OnlinePath + '/' + ProspectNo + '_' + RandomNoTxt + '_' + FileName;
            RecLink.Description:=ProspectNo + '_' + RandomNoTxt + '_' + FileName;
            RecLink.Type:=RecLink.Type::Link;
            RecLink.Created:=CurrentDateTime;
            RecLink.Company:=CompanyName;
            RecLink."User ID":=UserId;
            RecLink.Insert();
            ProcurementDocs.Init();
            ProcurementDocs."No.":=ProspectNo;
            ProcurementDocs.Link:=FilePath + '\' + ProspectNo + '_' + RandomNoTxt + '_' + FileName;
            ProcurementDocs.Description:=Format(ProspectNo + '_' + RandomNoTxt + '_' + FileName);
            ProcurementDocs."Record ID":=(RecID);
            ProcurementDocs.Insert();
            OpenDocument(RecID, LineNo);
            exit(FileName);
            FilePath:='';
        end
        else
        begin
            RecLink.Init();
            RecLink."Link ID":=LineNo;
            RecLink."Record ID":=RecID;
            RecLink.URL1:=FilePath + '\' + ProspectNo + '_' + RandomNoTxt + '_' + FileName;
            RecLink.Description:=ProspectNo + '_' + RandomNoTxt + '_' + FileName;
            RecLink.Type:=RecLink.Type::Link;
            RecLink.Created:=CurrentDateTime;
            RecLink.Company:=CompanyName;
            RecLink."User ID":=UserId;
            RecLink.Insert();
            ProcurementDocs.Init();
            ProcurementDocs."No.":=ProspectNo;
            ProcurementDocs.LineNo:=LineNo;
            ProcurementDocs.Link:=FilePath + '\' + ProspectNo + '_' + RandomNoTxt + '_' + FileName;
            ProcurementDocs.Description:=ProspectNo + '_' + RandomNoTxt + '_' + FileName;
            ProcurementDocs."Record ID":=(RecID);
            ProcurementDocs.Insert();
            OpenDocument(RecID, LineNo);
            exit(FileName);
            FilePath:='';
        end;
    // end;
    end;
    procedure OpenDocument(RecId: RecordId; lineNo: integer): Boolean var
        RecLink: Record "Record Link";
        FileName: Text;
    begin
        RecLink.Reset();
        RecLink.SetRange("Record ID", RecId);
        RecLink.SetRange("Link ID", lineNo);
        IF RecLink.Findlast()then begin
            FileName:=FileMgt.GetFileName(RecLink.URL1);
            Clear(TempFile);
        // EDDIE if TempFile.Open(RecLink.URL1) then begin
        //     Download(RecLink.URL1, '', '', '', FileName);
        // end;
        end;
    end;
    procedure UploadApplicantDocument(DocID: code[100]; FilePath: text; DocType: text): Text var
        FilePath2: Text;
        OnlinePath: Text;
        RecID: RecordId;
        FileName: Text;
        TempFile: File;
        NewStream: InsTream;
        RecRef: RecordRef;
        TableID: Integer;
        RecLink: Record "Record Link";
        CompanyInfo: Record "Company Information";
        LineNo: Integer;
        DocNamePage: page "Document Name";
        DocName: Text;
        FileUploadedSuccessTxt: Label 'File %1 uploaded successfully';
        FinalFilename: Text;
        FinalPath: Text;
        // FileSystem: DotNet MyDirectory;
        FileMgt: Codeunit "File Management";
        UploadFile: Text[250];
        AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
        DataInstream: InStream;
        DataOutstream: OutStream;
        Applicant: Record Applicants2;
        Payments: Record Payments;
        Leave: Record "Leave Application";
        Transport: Record "Travel Requests";
        InternalRequest: Record "Internal Request Header";
        RiskHeader: Record "Risk Header";
        Training: Record "Training Request";
        Incident: Record "User Support Incident";
        TrainingEval: Record "Training Evaluation Header";
        PRequest: Record "Procurement Request";
        RiskSurvey: Record "Audit Header";
        LoanApp: Record "Loan Application";
        EnforcementHeader: Record "Enforcement Header";
        ProsppectiveSuppliers: Record "Prospective Suppliers";
    begin
        CompanyInfo.get;
        CompanyInfo.TestField("Document Path");
        CompanyInfo.TestField("Online Document Path");
        FilePath:=FilePath;
        //Add Record Link
        // Option Imprest,ImprestSurrender,Applicant,PurchaseRequest,Risk,Incident,Leave,Transport,StaffClaim,PettyCash,PettyCashSurrender,StoreRequest,Training,TrainingEvaluation
        RecLink.Reset();
        if RecLink.FindLast()then LineNo:=RecLink."Link ID" + 1
        else
            LineNo:=1;
        Commit();
        //Procurement Request
        if(DocType = 'ProcurementRequest')then begin
            PRequest.Reset();
            PRequest.SetRange("No.", DocID);
            if PRequest.FindFirst()then RecID:=PRequest.RecordId;
        end;
        //Applicants
        if(DocType = 'Applicant')then begin
            Applicant.Reset();
            Applicant.SetRange("No.", DocID);
            if Applicant.FindFirst()then RecID:=Applicant.RecordId;
        end;
        //StaffClaim
        if(DocType = 'StaffClaim')then begin
            Payments.Reset();
            Payments.SetRange("No.", DocID);
            Payments.SetRange("Payment Type", Payments."Payment Type"::"Staff Claim");
            if Payments.FindFirst()then RecID:=Payments.RecordId;
        end;
        //Impres
        if(DocType = 'Imprest')then begin
            Payments.Reset();
            Payments.SetRange("Payment Type", Payments."Payment Type"::Imprest);
            Payments.SetRange("No.", DocID);
            if Payments.FindFirst()then RecID:=Payments.RecordId;
        end;
        //PaymentRequest
        // if (DocType = 'PaymentRequest') then begin
        //     Payments.Reset();
        //     Payments.SetRange("Payment Type", Payments."Payment Type"::"Payment Request");
        //     Payments.SetRange("No.", DocID);
        //     if Payments.FindFirst() then
        //         RecID := Payments.RecordId;
        // end;
        //Imprest Surrender
        if(DocType = 'ImprestSurrender')then begin
            Payments.Reset();
            Payments.SetRange("Payment Type", Payments."Payment Type"::"Imprest Surrender");
            Payments.SetRange("No.", DocID);
            if Payments.FindFirst()then RecID:=Payments.RecordId;
        end;
        //Petty Cash
        if(DocType = 'PettyCash')then begin
            Payments.Reset();
            Payments.SetRange("Payment Type", Payments."Payment Type"::"Petty Cash");
            Payments.SetRange("No.", DocID);
            if Payments.FindFirst()then RecID:=Payments.RecordId;
        end;
        //Petty cash surrender
        if(DocType = 'PettyCashSurrender')then begin
            Payments.Reset();
            Payments.SetRange("Payment Type", Payments."Payment Type"::"Petty Cash Surrender");
            Payments.SetRange("No.", DocID);
            if Payments.FindFirst()then RecID:=Payments.RecordId;
        end;
        //Store request
        if(DocType = 'StoreRequest')then begin
            InternalRequest.Reset();
            InternalRequest.SetRange("Document Type", InternalRequest."Document Type"::Stock);
            InternalRequest.SetRange("No.", DocID);
            if InternalRequest.FindFirst()then RecID:=InternalRequest.RecordId;
        end;
        //Purchase Request
        if(DocType = 'PurchaseRequest')then begin
            InternalRequest.Reset();
            InternalRequest.SetRange("Document Type", InternalRequest."Document Type"::Purchase);
            InternalRequest.SetRange("No.", DocID);
            if InternalRequest.FindFirst()then RecID:=InternalRequest.RecordId;
        end;
        //Leave
        if(DocType = 'Leave')then begin
            Leave.Reset();
            Leave.SetRange("Application No", DocID);
            if Leave.FindFirst()then RecID:=Leave.RecordId;
        end;
        //Transport
        if(DocType = 'Transport')then begin
            Transport.Reset();
            Transport.SetRange("Request No.", DocID);
            if Transport.FindFirst()then RecID:=Transport.RecordId;
        end;
        //Training
        if(DocType = 'Training')then begin
            Training.Reset();
            Training.SetRange("Request No.", DocID);
            if Training.FindFirst()then RecID:=Training.RecordId;
        end;
        //Risk
        if(DocType = 'Risk')then begin
            RiskHeader.Reset();
            RiskHeader.SetRange("No.", DocID);
            if RiskHeader.FindFirst()then RecID:=RiskHeader.RecordId;
        end;
        //Incident
        if(DocType = 'Incident')then begin
            Incident.Reset();
            Incident.SetRange("Incident Reference", DocID);
            if Incident.FindFirst()then RecID:=Incident.RecordId;
        end;
        //Training evaluation
        if(DocType = 'TrainingEvaluation')then begin
            TrainingEval.Reset();
            TrainingEval.SetRange("Training evaluation No.", DocID);
            if TrainingEval.FindFirst()then RecID:=TrainingEval.RecordId;
        end;
        //Risk Survey
        if(DocType = 'RiskSurvey')then begin
            RiskSurvey.Reset();
            RiskSurvey.SetRange("No.", DocID);
            if RiskSurvey.FindFirst()then RecID:=RiskSurvey.RecordId;
        end;
        //Loan Application
        if(DocType = 'Loan')then begin
            LoanApp.Reset();
            LoanApp.SetRange("Loan No", DocID);
            if LoanApp.FindFirst()then RecID:=LoanApp.RecordId;
        end;
        //EnforcementHeader
        if(DocType = 'Enforcement')then begin
            EnforcementHeader.Reset();
            EnforcementHeader.SetRange("No.", DocID);
            if EnforcementHeader.FindFirst()then RecID:=EnforcementHeader.RecordId;
        end;
        //ProspectiveSuppliers
        if(DocType = 'ProsppectiveSuppliers')then begin
            ProsppectiveSuppliers.Reset();
            ProsppectiveSuppliers.SetRange("No.", DocID);
            if ProsppectiveSuppliers.FindFirst()then RecID:=ProsppectiveSuppliers.RecordId;
        end;
        RecLink.Init();
        RecLink."Link ID":=LineNo;
        RecLink."Record ID":=RecID;
        RecLink.URL1:=FilePath; // + '/' + FileName
        RecLink.Description:=FilePath;
        RecLink.Type:=RecLink.Type::Link;
        RecLink.Created:=CurrentDateTime;
        RecLink.Company:=CompanyName;
        RecLink."User ID":=UserId;
        RecLink.Insert();
        exit(FileName);
        FilePath:='';
    end;
    procedure UploadLinesDocument(DocID: code[100]; LineNumber: Integer; FilePath: text; DocType: text): Text var
        FilePath2: Text;
        OnlinePath: Text;
        RecID: RecordId;
        FileName: Text;
        TempFile: File;
        NewStream: InsTream;
        RecRef: RecordRef;
        TableID: Integer;
        RecLink: Record "Record Link";
        CompanyInfo: Record "Company Information";
        LineNo: Integer;
        DocNamePage: page "Document Name";
        DocName: Text;
        FileUploadedSuccessTxt: Label 'File %1 uploaded successfully';
        FinalFilename: Text;
        FinalPath: Text;
        //FileSystem: DotNet MyDirectory;
        FileMgt: Codeunit "File Management";
        UploadFile: Text[250];
        AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
        DataInstream: InStream;
        DataOutstream: OutStream;
        InternalRequest: Record "Internal Request Line";
    begin
        CompanyInfo.get;
        CompanyInfo.TestField("Document Path");
        CompanyInfo.TestField("Online Document Path");
        //Add Record Link
        // Option Imprest,ImprestSurrender,Applicant,PurchaseRequest,Risk,Incident,Leave,Transport,StaffClaim,PettyCash,PettyCashSurrender,StoreRequest,Training,TrainingEvaluation
        RecLink.Reset();
        if RecLink.FindLast()then LineNo:=RecLink."Link ID" + 1
        else
            LineNo:=1;
        Commit();
        //Procurement Request
        if(DocType = 'RequestForm')then begin
            InternalRequest.Reset();
            InternalRequest.SetRange("No.", DocID);
            InternalRequest.SetRange("Line No.", LineNumber);
            if InternalRequest.FindFirst()then RecID:=InternalRequest.RecordId;
        end;
        RecLink.Init();
        RecLink."Link ID":=LineNo;
        RecLink."Record ID":=RecID;
        RecLink.URL1:=FilePath; // + '/' + FileName
        RecLink.Description:=FilePath;
        RecLink.Type:=RecLink.Type::Link;
        RecLink.Created:=CurrentDateTime;
        RecLink.Company:=CompanyName;
        RecLink."User ID":=UserId;
        RecLink.Insert();
        exit(FileName);
        FilePath:='';
    end;
    procedure GetQuantitynStore(ItemCode: Code[20]; Location: Code[20]): Integer var
        InternalRequest: Record "Internal Request Header";
        InternalRequestLine, RequestLine: Record "Internal Request Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Qty: Integer;
    begin
        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetRange("Item No.", ItemCode);
        ItemLedgerEntry.SetRange("Location Code", Location);
        ItemLedgerEntry.CalcSums(Quantity);
        Qty:=ItemLedgerEntry.Quantity;
        exit(Qty);
    end;
    procedure ImportPicture()
    var
        DataInstream: InStream;
        DataOutstream: OutStream;
    begin
    end;
    procedure AttachImage(IncidentNo: Code[20]; FileName: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        FileMgt: Codeunit "File Management";
        DocAttachment: Record "Document Attachment";
        RecRef: RecordRef;
        ServerPath: Text;
        Instr: InStream;
        OutStr: OutStream;
        ImportFile: File;
        Incident: Record "User Support Incident";
    begin
        // ImportFile.Open(FileName);
        // ImportFile.CreateInStream(Instr);
        TempBlob.CreateOutStream(OutStr);
        CopyStream(OutStr, Instr);
        Incident.Reset();
        Incident.SetRange("Incident Reference", IncidentNo);
        if Incident.FindFirst()then begin
        //Incident."Screen Shot" := OutStr;
        end;
        if FileName <> '' then DocAttachment.SaveAttachment(RecRef, FileName, TempBlob);
    end;
    procedure SendICTWorkPlanforApproval(No: code[20])
    var
        Workplan: Record "ICT Workplan";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        if Workplan.Get(No)then begin
            if ApprovalsMgmt.CheckICTWorkplanWorkflowEnabled(Workplan)then ApprovalsMgmt.OnSendICTWorkplanForApproval(Workplan);
            UpdateApprovalEntries(No, UserId);
        end;
    end;
    procedure CancelICTWorkPlanApprovalRequest(No: code[20])
    var
        Workplan: Record "ICT Workplan";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        if Workplan.Get(No)then ApprovalsMgmt.OnCancelICTWorkplanApprovalRequest(Workplan);
        UpdateApprovalEntries(No, UserId);
    end;
    procedure SendActivityWorkProgrammeforApproval(No: code[20])
    var
        Workplan: Record "Activity Work Programme";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        if Workplan.Get(No)then begin
            if ApprovalsMgmt.CheckWorkprogrammeWorkflowEnabled(Workplan)then ApprovalsMgmt.OnSendWorkprogrammeForApproval(Workplan);
            UpdateApprovalEntries(No, UserId);
        end;
    end;
    procedure CancelActivityWorkProgrammeApprovalRequest(No: code[20])
    var
        Workplan: Record "Activity Work Programme";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        if Workplan.Get(No)then ApprovalsMgmt.OnCancelWorkprogrammeApprovalRequest(Workplan);
        UpdateApprovalEntries(No, UserId);
    end;
    procedure CancelLicenseRegistrationRequest(No: code[20])
    var
        Registration: Record "Licensing dairy Enterprise";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        if Registration.Get(No)then ApprovalsMgmt.OnCancelLicenseRegistrationApprovalRequest(Registration);
        UpdateApprovalEntries(No, UserId);
    end;
    procedure CancelLicenseApplicationRequest(No: code[20])
    var
        Application: Record "License Applications";
        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
    begin
        if Application.Get(No)then ApprovalsMgmt.OnCancelLicenseApplicationApprovalRequest(Application);
        UpdateApprovalEntries(No, UserId);
    end;
    //"Immprest Warranty"
    procedure PrintImprestWarranty(DocNo: Code[200]; Path: Text): Text var
        Pmts: Record Payments;
        Waranty: Report "Immprest Warranty";
        filename: text;
    begin
        filename:=Path + 'ImprestWarranty' + DocNo + '.pdf';
        // if Exists(filename) then
        //     Erase(filename);
        Pmts.Reset();
        Pmts.SetRange("No.", DocNo);
        if Pmts.FindFirst()then begin
            Waranty.SetTableView(Pmts);
        //EDDIE Waranty.SaveAsPdf(filename);
        end;
        exit('ImprestWarranty' + DocNo + '.pdf');
    end;
    procedure SubmitEnforcement(DocNo: code[20])
    var
        CompMgmt: Codeunit "Compliance Management";
        EnfHeader: Record "Enforcement Header";
    begin
        EnfHeader.Reset();
        EnfHeader.SetRange("No.", DocNo);
        if EnfHeader.FindFirst()then CompMgmt.NotifyTrader(EnfHeader);
    end;
    //  procedure AttachScreenshot(DocID: code[20]; FileName: Text): Text
    // var
    //     RecLink: Record "Record Link";
    //     CompanyInfo: Record "Company Information";
    //     FilePath: Text;
    //     OnlinePath: Text;
    //     TempFile: File;
    //     LineNo: Integer;
    //     MemoryStream: DotNet MemoryStream;
    //     // RegEx: DotNet BCRegex;
    //     // Match: DotNet BCMatch;
    //     // Convert: DotNet BCConvert;
    //     // ClientContext: DotNet ClientContext;
    //     // NetworkCredential: DotNet NetworkCredential;
    //     // FileCreationInformation: DotNet FileCreationInformation;
    //     // Web: DotNet Web;
    //     // FolderName: DotNet FolderName;
    //     // MyList: DotNet MyList;
    //     // FileContent: DotNet FileContent;
    // begin
    //     CompanyInfo.Get();
    //     CompanyInfo.TestField(Name);
    //     CompanyInfo.TestField("Document Path");
    //     CompanyInfo.TestField("Online Document Path");
    //     FilePath := CompanyInfo."Document Path" + '\' + CompanyInfo.Name + '\' + PageCaption + '\' + DocID + '\';
    //     OnlinePath := CompanyInfo."Online Document Path" + '/' + CompanyInfo.Name + '/' + PageCaption + '/' + DocID;
    //     if not FileMgt.ServerDirectoryExists(FilePath) then
    //         FileMgt.ServerCreateDirectory(FilePath);
    //     UploadFile := FilePath + '\' + FileName;
    //     if Exists(UploadFile) then
    //         Erase(UploadFile);
    //     TempFile.Create(UploadFile);
    //     TempFile.CreateOutStream(DataOutstream);
    //     RegEx := RegEx.Regex('data\:.*/(.*?);base64,(.*)');
    //     Match := RegEx.Match(Data);
    //     DataInstream := MemoryStream.MemoryStream(Convert.FromBase64String(Match.Groups.Item(2).Value));
    //     CopyStream(DataOutstream, DataInstream);
    //     TempFile.Close();
    //     if CompanyInfo."Save to Sharepoint" then begin
    //         CompanyInfo.TestField("Sharepoint URL");
    //         CompanyInfo.TestField("Sharepoint Username");
    //         CompanyInfo.TestField("Sharepoint Password");
    //         CompanyInfo.TestField("Sharepoint Domain");
    //         CompanyInfo.TestField("Sharepoint Library");
    //         CompanyInfo.TestField("Sharepoint Folder");
    //         ClientContext := ClientContext.ClientContext(CompanyInfo."Sharepoint URL");
    //         ClientContext.Credentials := NetworkCredential.NetworkCredential(CompanyInfo."Sharepoint Username", CompanyInfo."Sharepoint Password", CompanyInfo."Sharepoint Domain");
    //         FileCreationInformation := FileCreationInformation.FileCreationInformation;
    //         FileCreationInformation.Content := FileContent.ReadAllBytes(UploadFile);
    //         FileCreationInformation.Url := FileMgt.GetFileName(UploadFile);
    //         FileCreationInformation.Overwrite := TRUE;
    //         Web := ClientContext.Web;
    //         MyList := Web.Lists.GetByTitle(CompanyInfo."Sharepoint Library");
    //         //Folder
    //         FolderName := MyList.RootFolder.Folders.GetByUrl(CompanyInfo."Sharepoint Folder");
    //         FolderName.AddSubFolder(CompanyInfo.Name);
    //         if PageCaption <> '' then
    //             FolderName.AddSubFolder(PageCaption);
    //         FolderName.AddSubFolder(DocID);
    //         FolderName.Files.Add(FileCreationInformation);
    //         //Library
    //         MyList.RootFolder.Files.Add(FileCreationInformation);
    //         ClientContext.ExecuteQuery;
    //         //OnlinePath := FolderName.Path.ToString();
    //     end;
    //         //Add Record Link
    //         RecLink.Reset();
    //         if RecLink.FindLast() then
    //             LineNo := RecLink."Link ID" + 1
    //         else
    //             LineNo := 1;
    //         RecLink.Init();
    //         RecLink."Link ID" := LineNo;
    //         RecLink."Record ID" := RecID;
    //         if CompanyInfo."Save to Sharepoint" then
    //         RecLink.URL1 := OnlinePath + '/' + FileName
    //         else
    //         RecLink.URL1 := FilePath + '\' + FileName;
    //         RecLink.Description := FileName;
    //         RecLink.Type := RecLink.Type::Link;
    //         RecLink.Created := CurrentDateTime;
    //         RecLink.Company := CompanyName;
    //         RecLink."User ID" := UserId;
    //         RecLink.Insert();
    //         exit(FileName);
    //         FilePath := '';
    // end;
    //51521000
    procedure PrintInspectionOrder(DocNo: Code[30]; Path: Text): Text var
        EnforcementHeader: Record "Enforcement Header";
        Inspection: Report InspectionOrder;
        filename: Text;
    begin
        filename:=Path + 'InspectionOrder_' + DocNo + '.pdf';
        // if Exists(filename) then
        //     Erase(filename);
        EnforcementHeader.Reset();
        EnforcementHeader.SetFilter("No.", DocNo);
        if EnforcementHeader.Find('-')then begin
            Inspection.SetTableView(EnforcementHeader);
        // Inspection.SaveAsPdf(filename);
        end;
        exit('InspectionOrder_' + DocNo + '.pdf');
    end;
    procedure PrintConfiscationNote(DocNo: Code[30]; Path: Text): Text var
        EnforcementHeader: Record "Enforcement Header";
        ConfiscationNote: Report ConfiscationNote;
        filename: Text;
    begin
        filename:=Path + 'ConfiscationNote_' + DocNo + '.pdf';
        // if Exists(filename) then
        //     Erase(filename);
        EnforcementHeader.Reset();
        EnforcementHeader.SetFilter("No.", DocNo);
        if EnforcementHeader.Find('-')then begin
            ConfiscationNote.SetTableView(EnforcementHeader);
        // ConfiscationNote.SaveAsPdf(filename);
        end;
        exit('ConfiscationNote_' + DocNo + '.pdf');
    end;
    var FileMgt: Codeunit "File Management";
    Email: Codeunit email;
    // PathHelper: DotNet Path;
    //ClientFileHelper: DotNet File;
    DataInstream: InStream;
    DataOutstream: OutStream;
    TempFile: File;
    UploadFile: Text;
    ErrorText: Text;
    AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
}

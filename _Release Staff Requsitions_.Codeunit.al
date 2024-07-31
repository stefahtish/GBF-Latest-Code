codeunit 50107 "Release Staff Requsitions"
{
    TableNo = "Staff Travel Request";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        OnBeforeReleaseStaffReq(Rec);
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        SendApprovalEmail(Rec);
        OnAfterReleaseStaffReq(Rec);
    end;
    var Text001: Label 'There is nothing to release for Staf Travel Request %1.';
    Text002: Label 'This document can only be released when the approval process is complete.';
    Text003: Label 'The approval process must be canceled or completed to reopen this document.';
    Text004: Label 'There are unposted prepayment amounts on the document of type %1 with the number %2.';
    Text005: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.';
    Committment: Codeunit Committment;
    Text006: Label 'There''s no staff Travel requisition Selected!';
    StaffReq: Record "Staff Travel Request";
    StaffReqLine: Record "Staff Travel Line";
    Subject: Text;
    Receipient: List of[Text];
    ReceipientCC: List of[text];
    SenderEmail: Text;
    SenderName: Text;
    EmailMessage: Codeunit "Email Message";
    Email: Codeunit Email;
    EmailSubject: Label 'TRAVEL REQUISTION NO %1';
    EmailBody: Label '<p>The Travel Request No: %1 has been approved and need to be actioned ';
    EmailBody1: Label '<P>See the attachment for details';
    MailEnd: Label '<p>Thank you!!';
    CompanyInfo: Record "Company Information";
    PurchasesSetup: Record "Purchases & Payables Setup";
    FileName: Text;
    EmployeeRec: Record Employee;
    EmailBody2: Label '<p>The Travel Request No: %1 has been actioned, be ready for pickup ';
    procedure Reopen(var StaffReq: Record "Staff Travel Request")
    begin
        OnBeforeReopenStaffReq(StaffReq);
        if StaffReq.Status = StaffReq.Status::Open then exit;
        StaffReq.Status:=StaffReq.Status::Open;
        StaffReq.Modify(true);
        OnAfterReopenStaffReq(StaffReq);
    end;
    procedure PerformManualRelease(var StaffReq: Record "Staff Travel Request")
    var
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        // IF ApprovalsMgmt.IsStaffReqApprovalsWorkflowEnabled(StaffReq) AND (StaffReq.Status = StaffReq.Status::Open) THEN
        //  ERROR(Text002);
        CODEUNIT.Run(CODEUNIT::"Release Staff Requsitions", StaffReq);
    end;
    procedure PerformManualReopen(var StaffReq: Record "Staff Travel Request")
    begin
        if StaffReq.Status = StaffReq.Status::"Pending Approval" then Error(Text003);
        Reopen(StaffReq);
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeReleaseStaffReq(var StaffReq: Record "Staff Travel Request")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnAfterReleaseStaffReq(var StaffReq: Record "Staff Travel Request")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeReopenStaffReq(var StaffReq: Record "Staff Travel Request")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnAfterReopenStaffReq(var StaffReq: Record "Staff Travel Request")
    begin
    end;
    procedure MoveStaffReqToFinance(var StaffReqLine: Record "Staff Travel Line")
    begin
        StaffReqLine.TestField("Supplier Code");
        StaffReqLine.TestField("Rate per km");
        StaffReqLine.TestField("KM Covered");
        StaffReqLine.TestField(Amount);
        // StaffReq.TESTFIELD(PUWT);
        //StaffReq.TESTFIELD(STPWT);
        StaffReqLine.TestField(Tax);
        StaffReqLine.TestField("Total price");
        StaffReqLine.TestField("Amount Inc VAT");
        StaffReqLine."Payment Status":=StaffReqLine."Payment Status"::Finance;
        StaffReqLine.Select:=false;
        StaffReqLine.Modify;
    end;
    procedure MoveStaffReqToProc(var StaffReqLine: Record "Staff Travel Line")
    begin
        StaffReqLine.TestField("Supplier Code");
        StaffReqLine.TestField("Rate per km");
        StaffReqLine.TestField("KM Covered");
        StaffReqLine.TestField(Amount);
        //StaffReq.TESTFIELD(PUWT);
        //StaffReq.TESTFIELD(STPWT);
        StaffReqLine.TestField(Tax);
        StaffReqLine.TestField("Total price");
        StaffReqLine.TestField("Amount Inc VAT");
        StaffReqLine."Payment Status":=StaffReqLine."Payment Status"::Procurement;
        StaffReqLine.Select:=false;
        StaffReqLine.Modify;
    end;
    procedure GenerateInvoices(Selected: Boolean)
    var
        StaffReq: Record "Staff Travel Request";
        Vendor: array[1000]of Code[20];
        DimSetID: array[5000]of Integer;
        i: Integer;
        VendorAmount: array[5000]of Decimal;
        PurchSetup: Record "Purchases & Payables Setup";
        PurchHeader: Record "Purchase Header";
        DocNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchLine: Record "Purchase Line";
        z: Integer;
        LineNo: Integer;
        Desc: array[5000]of Text;
        Committment: Codeunit Committment;
        StaffReqNo: array[5000]of Code[20];
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8]of Code[20];
        StaffReqLine: Record "Staff Travel Line";
        StaffReqLineNo: array[5000]of Integer;
    begin
        if Selected then begin
            i:=1;
            StaffReqLine.Reset;
            StaffReqLine.SetCurrentKey(Status, "Payment Status", "Supplier Code");
            StaffReqLine.SetRange(Status, StaffReqLine.Status::Released);
            StaffReqLine.SetRange("Payment Status", StaffReqLine."Payment Status"::Procurement);
            StaffReqLine.SetRange(Select, true);
            if StaffReqLine.Find('-')then begin
                repeat Vendor[i]:=StaffReqLine."Supplier Code";
                    VendorAmount[i]:=StaffReqLine."Total price";
                    DimSetID[i]:=StaffReqLine."Dimension Set ID";
                    Desc[i]:=StaffReqLine."Pick up Point" + ' To ' + StaffReqLine."Drop off Point";
                    StaffReqNo[i]:=StaffReqLine."No.";
                    StaffReqLineNo[i]:=StaffReqLine."Line No.";
                    i:=i + 1;
                until StaffReqLine.Next = 0;
            end
            else
                Error(Text006);
        end
        else
        begin
            i:=1;
            StaffReqLine.Reset;
            StaffReqLine.SetCurrentKey(Status, "Payment Status", "Supplier Code");
            StaffReqLine.SetRange(Status, StaffReqLine.Status::Released);
            StaffReqLine.SetRange("Payment Status", StaffReqLine."Payment Status"::Procurement);
            if StaffReq.Find('-')then repeat Vendor[i]:=StaffReqLine."Supplier Code";
                    VendorAmount[i]:=StaffReqLine."Total price";
                    DimSetID[i]:=StaffReqLine."Dimension Set ID";
                    Desc[i]:=StaffReqLine."Pick up Point" + ' To ' + StaffReqLine."Drop off Point";
                    StaffReqNo[i]:=StaffReqLine."No.";
                    StaffReqLineNo[i]:=StaffReqLine."Line No.";
                    i:=i + 1;
                until StaffReqLine.Next = 0;
        end;
        for z:=1 to i do begin
            //Create the Invoices
            if Vendor[z] <> '' then begin
                PurchSetup.Get;
                if z <> 1 then begin
                    if((z <> 1) and (Vendor[z - 1] <> Vendor[z])) or (z = 1)then begin
                        PurchSetup.TestField("Invoice Nos.");
                        PurchSetup.TestField("Default Staff Req. G/L");
                        LineNo:=0;
                        PurchSetup.Get;
                        DocNo:=NoSeriesMgt.GetNextNo(PurchSetup."Invoice Nos.", 0D, true);
                        PurchHeader.Init;
                        PurchHeader."No.":=DocNo;
                        PurchHeader."Document Type":=PurchHeader."Document Type"::Invoice;
                        PurchHeader.Status:=PurchHeader.Status::Open;
                        PurchHeader."Buy-from Vendor No.":=Vendor[z];
                        PurchHeader.Validate("Buy-from Vendor No.");
                        PurchHeader."Document Date":=Today;
                        PurchHeader."Posting Date":=Today;
                        PurchHeader.Validate("Posting Date");
                        if Vendor[z] <> '' then PurchHeader.Insert;
                    end;
                end
                else
                begin
                    PurchSetup.TestField("Invoice Nos.");
                    PurchSetup.TestField("Default Staff Req. G/L");
                    LineNo:=0;
                    PurchSetup.Get;
                    DocNo:=NoSeriesMgt.GetNextNo(PurchSetup."Invoice Nos.", 0D, true);
                    PurchHeader.Init;
                    PurchHeader."No.":=DocNo;
                    PurchHeader."Document Type":=PurchHeader."Document Type"::Invoice;
                    PurchHeader.Status:=PurchHeader.Status::Open;
                    PurchHeader."Buy-from Vendor No.":=Vendor[z];
                    PurchHeader.Validate("Buy-from Vendor No.");
                    PurchHeader."Document Date":=Today;
                    PurchHeader."Posting Date":=Today;
                    PurchHeader.Validate("Posting Date");
                    PurchHeader.Insert;
                end;
                //insert lines
                LineNo:=LineNo + 1000;
                PurchLine.Init;
                PurchLine."Document No.":=DocNo;
                PurchLine."Document Type":=PurchLine."Document Type"::Invoice;
                PurchLine."Line No.":=LineNo;
                PurchLine.Type:=PurchLine.Type::"G/L Account";
                PurchLine."No.":=PurchSetup."Default Staff Req. G/L";
                PurchLine.Validate("No.");
                PurchLine.Description:=Desc[z];
                PurchLine."Direct Unit Cost":=VendorAmount[z];
                PurchLine."Quantity Received":=0;
                PurchLine.Validate(Quantity, 1);
                DimMgt.GetShortcutDimensions(DimSetID[z], ShortcutDimCode);
                PurchLine."Shortcut Dimension 1 Code":=ShortcutDimCode[1];
                PurchLine."Shortcut Dimension 2 Code":=ShortcutDimCode[2];
                PurchLine."Dimension Set ID":=DimSetID[z];
                PurchLine.Insert;
                //Uncomit & Encumber
                if StaffReq.Get(StaffReqNo[z])then;
                Committment.UncommitPurchInvoiceStaffReq(StaffReq);
                Committment.EncumberPOStaffReq(PurchLine, PurchHeader);
                StaffReq."Payment Status":=StaffReq."Payment Status"::Invoiced;
                StaffReq.Modify;
                if StaffReqLine.Get(StaffReqNo[z], StaffReqLineNo[z])then;
                StaffReqLine."Payment Status":=StaffReqLine."Payment Status"::Invoiced;
                StaffReqLine.Modify;
                Message('Purchase Invoice No. %1 has been created successfully', DocNo);
            end;
        end;
    end;
    local procedure GetDimSetID(StaffReq: Record "Staff Travel Request"): Integer var
        StaffReqLines: Record "Staff Travel Line";
    begin
        StaffReqLines.Reset;
        StaffReqLines.SetRange("No.", StaffReq."No.");
        if StaffReqLines.Find('-')then exit(StaffReqLines."Dimension Set ID");
    end;
    procedure SendToFin()
    var
        Text000: Label 'Are you sure you want to move the selected Travel requisitions to Finance?';
        Text001: Label 'There''s no record selected \ Please select records before moving to finance';
    begin
        if Confirm(Text000, false)then begin
            StaffReqLine.Reset;
            StaffReqLine.SetRange(Status, StaffReqLine.Status::Released);
            StaffReqLine.SetRange("Payment Status", StaffReqLine."Payment Status"::Admin);
            StaffReqLine.SetRange(Select, true);
            if StaffReqLine.Find('-')then begin
                repeat MoveStaffReqToFinance(StaffReqLine);
                until StaffReqLine.Next = 0;
            end
            else
                Error(Text001);
        end;
    end;
    procedure SendToAdmin()
    var
        Text000: Label 'Are you sure you want to move the selected Travel requisitions to Admin?';
        Text001: Label 'There''s no record selected \ Please select records before moving to Admin';
    begin
        if Confirm(Text000, false)then begin
            StaffReqLine.Reset;
            StaffReqLine.SetRange(Status, StaffReqLine.Status::Released);
            StaffReqLine.SetRange("Payment Status", StaffReqLine."Payment Status"::Finance);
            StaffReqLine.SetRange(Select, true);
            if StaffReqLine.Find('-')then begin
                repeat MoveStaffReqToAdmin(StaffReqLine);
                until StaffReqLine.Next = 0;
            end
            else
                Error(Text001);
        end;
    end;
    procedure MoveStaffReqToAdmin(var StaffReqLine: Record "Staff Travel Line")
    begin
        StaffReqLine.TestField("Supplier Code");
        StaffReqLine.TestField("Rate per km");
        StaffReqLine.TestField("KM Covered");
        StaffReqLine.TestField(Amount);
        // StaffReq.TESTFIELD(PUWT);
        //StaffReq.TESTFIELD(STPWT);
        StaffReqLine.TestField(Tax);
        StaffReqLine.TestField("Total price");
        StaffReqLine.TestField("Amount Inc VAT");
        StaffReqLine."Payment Status":=StaffReqLine."Payment Status"::Admin;
        StaffReqLine.Select:=false;
        StaffReqLine.Modify;
    end;
    local procedure NotifyUser()
    begin
    end;
    procedure SendToProcurement()
    var
        Text000: Label 'Are you sure you want to move the selected Travel requisitions to Procurement?';
        Text001: Label 'There''s no record selected \ Please select records before moving to Procurement';
    begin
        if Confirm(Text000, false)then begin
            StaffReqLine.Reset;
            StaffReqLine.SetRange(Status, StaffReqLine.Status::Released);
            StaffReqLine.SetRange("Payment Status", StaffReqLine."Payment Status"::Finance);
            StaffReqLine.SetRange(Select, true);
            if StaffReqLine.Find('-')then begin
                repeat MoveStaffReqToProc(StaffReqLine);
                until StaffReqLine.Next = 0;
            end
            else
                Error(Text001);
        end;
    end;
    procedure SendBackToFin()
    var
        Text000: Label 'Are you sure you want to move the selected Travel requisitions to Finance?';
        Text001: Label 'There''s no record selected \ Please select records before moving to finance';
    begin
        if Confirm(Text000, false)then begin
            StaffReqLine.Reset;
            StaffReqLine.SetRange(Status, StaffReqLine.Status::Released);
            StaffReqLine.SetRange("Payment Status", StaffReqLine."Payment Status"::Procurement);
            StaffReqLine.SetRange(Select, true);
            if StaffReqLine.Find('-')then begin
                repeat MoveStaffReqToFinance(StaffReqLine);
                until StaffReqLine.Next = 0;
            end
            else
                Error(Text001);
        end;
    end;
    procedure SendApprovalEmail(var StaffRequestRec: Record "Staff Travel Request")
    begin
        FileName:='D:\Emails\' + StaffRequestRec."No." + '.pdf';
        CompanyInfo.Get;
        PurchasesSetup.Get;
        StaffReq.Reset;
        StaffReq.SetRange("No.", StaffRequestRec."No.");
        //EDDIEREPORT.SaveAsPdf(39003902, FileName, StaffReq);
        SenderEmail:=CompanyInfo."E-Mail";
        SenderName:=CompanyInfo.Name;
        Receipient.Add(PurchasesSetup."Admin Email");
        Subject:=StrSubstNo(EmailSubject, StaffRequestRec."No.");
        EmailMessage.Create(Receipient, Subject, 'Dear Sir/Madam', true);
        EmailMessage.AppendToBody(StrSubstNo(EmailBody, StaffRequestRec."No."));
        EmailMessage.AppendToBody(EmailBody1);
        EmailMessage.AppendToBody(MailEnd);
        EmailMessage.AddAttachment(FileName, StaffRequestRec."No." + '.pdf', '');
        if EmployeeRec.Get(StaffRequestRec."Employee No.")then begin
            ReceipientCC.Add(EmployeeRec."E-Mail");
        //eddieEmailMessage.AddCC(ReceipientCC);
        end;
        StaffReqLine.Reset;
        StaffReqLine.SetRange("No.", StaffRequestRec."No.");
        if StaffReqLine.FindFirst then repeat if EmployeeRec.Get(StaffReqLine."Employee No.")then begin
                    ReceipientCC.Add(EmployeeRec."E-Mail");
                //eddie SMTP.AddCC(ReceipientCC);
                end;
            until StaffReqLine.Next = 0;
        Email.Send(EmailMessage);
    end;
    procedure SendActionEmail(var StaffRequestRec: Record "Staff Travel Request")
    begin
        if Confirm('Do you want to send notification??', true, false)then begin
            FileName:='D:\Emails\' + StaffRequestRec."No." + '.pdf';
            CompanyInfo.Get;
            PurchasesSetup.Get;
            StaffReq.Reset;
            StaffReq.SetRange("No.", StaffRequestRec."No.");
            //EDDIE REPORT.SaveAsExcel(39003902, FileName, StaffReq);
            SenderEmail:=CompanyInfo."E-Mail";
            SenderName:=CompanyInfo.Name;
            Receipient.Add(PurchasesSetup."Admin Email");
            Subject:=StrSubstNo(EmailSubject, StaffRequestRec."No.");
            EmailMessage.create(Receipient, Subject, 'Dear Sir/Madam', true);
            EmailMessage.AppendToBody(StrSubstNo(EmailBody2, StaffRequestRec."No."));
            EmailMessage.AppendToBody(EmailBody1);
            EmailMessage.AppendToBody(MailEnd);
            EmailMessage.AddAttachment(FileName, StaffRequestRec."No." + '.pdf', '');
            if EmployeeRec.Get(StaffRequestRec."Employee No.")then begin
                ReceipientCC.Add(EmployeeRec."E-Mail");
            //eddieSMTP.AddCC(ReceipientCC);
            end;
            StaffReqLine.Reset;
            StaffReqLine.SetRange("No.", StaffRequestRec."No.");
            if StaffReqLine.FindFirst then repeat if EmployeeRec.Get(StaffReqLine."Employee No.")then begin
                        ReceipientCC.Add(EmployeeRec."E-Mail");
                    //eddieSMTP.AddCC(ReceipientCC);
                    end;
                until StaffReqLine.Next = 0;
            Email.Send(EmailMessage);
        end;
    end;
}

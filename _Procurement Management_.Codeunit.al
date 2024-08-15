codeunit 50126 "Procurement Management"
{
    trigger OnRun()
    begin
    end;

    var
        Text001: Label 'Please contact administrator for posting setup';
        Text003: Label 'IR %1 Posted Successfully';
        Text002: Label 'Quantity to issue exceeds quantity requested for Item No %1';
        Text004: Label 'Committe Setup Successfully updated';
        NoseriesMgt: Codeunit NoSeriesManagement;
        Committment: Codeunit Committment;
        PurchSetup: Record "Purchases & Payables Setup";
        CompanyInformation: Record "Company Information";
        Text005: Label 'The %1 has been sucessfully Reversed';
        PurchSetup2: Record "Purchases & Payables Setup";
        TenderCommitteeNotExistErr2: Label 'There is no approved %1 committee for %1 No. %2 in Committees Setup';
        EOICommitteeNotExistErr: Label 'There is no approved EOI committee for EOI %1 in Committees Setup';
        TenderCommitteeNotExistErr: Label 'There is no approved tender committee for tender %1 in Committees Setup';
        SupplierMovedToEvaluationMsg: Label 'Supplier %1 has been sent for evaluation successfully';
        SetupTenderDocsErr: Label 'Please setup Documents Required for Tender No. %1';
        SetupQuotationDocsErr: Label 'Please setup Documents Required for Quotation No. %1';
        SetupEOIDocsErr: Label 'Please setup Documents Required for EOI No. %1';
        SetupRFPDocsErr: Label 'Please setup Documents Required for RFP No. %1';
        SetupScoresErr: Label 'Please setup Supplier Evaluation Scores in Supplier Evaluation Scores Setup';
        Employee: Record Employee;
        Emailmessage: Codeunit "Email Message";
        Email: Codeunit Email;
        //SMTPSetup: Record "SMTP Mail Setup";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: List of [Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;

    procedure CancelApprovedLPO(LPONo: Code[70])
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        CommitmentEntries: Record "Commitment Entries";
        ApprovalEntry: Record "Approval Entry";
        RejectionComments: Page "Rejection Comments";
        RejectComment: Text;
    begin
        if Confirm('Are you sure you want to cancel LPO No.%1', false, LPONo) = true then begin
            PurchaseHeader.Reset;
            PurchaseHeader.SetRange("No.", LPONo);
            if PurchaseHeader.Find('-') then begin
                //Uncheck commitments
                PurchaseLine.Reset;
                PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                if PurchaseLine.Find('-') then begin
                    repeat
                        PurchaseLine.Committment := false;
                        PurchaseLine.Modify;
                    until PurchaseLine.Next = 0;
                end;
                //Clear commitments
                CommitmentEntries.Reset;
                CommitmentEntries.SetRange("Document No", LPONo);
                CommitmentEntries.DeleteAll;
                //Clear Approvals
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", LPONo);
                ApprovalEntry.DeleteAll;
                //Prompt and Insert Rejection Comment
                if RejectionComments.RunModal = ACTION::OK then begin
                    RejectComment := RejectionComments.GetRejectComment;
                    if RejectComment = '' then Error('Please input rejection comment');
                    PurchaseHeader."Cancel Comments" := RejectComment;
                    PurchaseHeader.Status := PurchaseHeader.Status::Open;
                    PurchaseHeader."Cancelled By" := UserId;
                    PurchaseHeader.Modify;
                end;
            end;
            Message('LPO %1 cancelled successfully', LPONo);
        end
        else
            exit;
    end;

    procedure CloseAndUncommitLPO(PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        CommitmentEntries: Record "Commitment Entries";
        Committment: Codeunit Committment;
        ClosingComments: Page "Rejection Comments";
        CloseComment: Text;
    begin
        //Uncommit Entries
        if PurchaseHeader."LPO Type" <> PurchaseHeader."LPO Type"::"Cost of Sales" then begin
            Message('Kindly note that LPO %1 has committment entries which will be reveresed!', PurchaseHeader."No.");
            Committment.UncommitLPO(PurchaseHeader);
        end;
        Commit;
        //Prompt and Insert Closing Comment
        if ClosingComments.RunModal = ACTION::OK then begin
            CloseComment := ClosingComments.GetRejectComment;
            if CloseComment = '' then Error('Please input Closing comment');
            PurchaseHeader."Close Comments" := CloseComment;
            PurchaseHeader."Closed By" := UserId;
            PurchaseHeader."LPO Closed" := true;
            PurchaseHeader.Modify;
        end;
        Commit;
        Message('LPO %1 has been closed successfully', PurchaseHeader."No.");
    end;
    // procedure CreateEOIEvaluation(EOINo: code[20])
    // var
    //     ProspectiveList: Record "Prospective Suppliers";
    //     ProcurementRequestLine: Record "Prospective Tender Line";
    //     QuoteEvaluation: Record "EOI Evaluation Line";
    //     PPSetup: Record "Purchases & Payables Setup";
    //     QuoteEvaluationHeader: Record "EOI Evaluation Header";
    //     ProcurementRequest: Record "Procurement Request";
    //     TendersApplied: Record "Prospective Supplier Tender";
    //     BiddersSelect: Record "Bidders Selection";
    // begin
    //     ProcurementRequest.Reset();
    //     ProcurementRequest.SetRange("No.", EOINo);
    //     if ProcurementRequest.FindFirst() then begin
    //         BiddersSelect.Reset();
    //         BiddersSelect.SetRange("Reference No.", EOINo);
    //         if BiddersSelect.Find('-') then begin
    //             QuoteEvaluationHeader.Init;
    //             QuoteEvaluationHeader."Quote No" := ProcurementRequest."No.";
    //             QuoteEvaluationHeader.Title := ProcurementRequest.Title;
    //             QuoteEvaluationHeader."Requisition No" := ProcurementRequest."Requisition No";
    //             QuoteEvaluationHeader."Creation Date" := Today;
    //             QuoteEvaluationHeader."Shortcut Dimension 1 Code" := ProcurementRequest."Shortcut Dimension 1 Code";
    //             QuoteEvaluationHeader."Shortcut Dimension 2 Code" := ProcurementRequest."Shortcut Dimension 2 Code";
    //             QuoteEvaluationHeader."Dimension Set ID" := ProcurementRequest."Dimension Set ID";
    //             if not QuoteEvaluationHeader.Get(ProcurementRequest."No.") then
    //                 QuoteEvaluationHeader.Insert;
    //             //Insert Lines
    //             repeat
    //                 //Insert Lines
    //                 ProspectiveList.Reset();
    //                 ProspectiveList.SetRange("No.", BiddersSelect."Supplier Code");
    //                 if ProspectiveList.Find('-') then begin
    //                     ProcurementRequestLine.Reset;
    //                     ProcurementRequestLine.SetRange("Response No", BiddersSelect."Supplier Code");
    //                     ProcurementRequestLine.SetRange("Tender No.", BiddersSelect."Reference No.");
    //                     if ProcurementRequestLine.Find('-') then begin
    //                         repeat
    //                             QuoteEvaluation.Init;
    //                             QuoteEvaluation."Quote No" := EOINo;
    //                             QuoteEvaluation."Vendor No" := ProspectiveList."Vendor No";
    //                             QuoteEvaluation.Validate(QuoteEvaluation."Vendor No");
    //                             QuoteEvaluation.Type := ProcurementRequestLine.Type;
    //                             QuoteEvaluation."No." := ProcurementRequestLine.No;
    //                             QuoteEvaluation.Description := ProcurementRequestLine.Description;
    //                             QuoteEvaluation."Unit of Measure" := ProcurementRequestLine."Unit of Measure";
    //                             QuoteEvaluation.Quantity := ProcurementRequestLine.Quantity;
    //                             QuoteEvaluation."Unit Amount" := ProcurementRequestLine."Unit Price";
    //                             QuoteEvaluation.Amount := ProcurementRequestLine.Amount;
    //                             QuoteEvaluation."Line No" := ProcurementRequestLine."Line No";
    //                             QuoteEvaluation."Shortcut Dimension 1 Code" := ProcurementRequestLine."Shortcut Dimension 1 Code";
    //                             QuoteEvaluation.Validate("Shortcut Dimension 1 Code");
    //                             QuoteEvaluation."Shortcut Dimension 2 Code" := ProcurementRequestLine."Shortcut Dimension 2 Code";
    //                             QuoteEvaluation.Validate("Shortcut Dimension 2 Code");
    //                             QuoteEvaluation.Committed := ProcurementRequestLine.Committed;
    //                             QuoteEvaluation."Procurement Plan" := ProcurementRequestLine."Procurement Plan";
    //                             QuoteEvaluation."Procurement Plan Item" := ProcurementRequestLine."Procurement Plan Item";
    //                             QuoteEvaluation."Budget Line" := ProcurementRequestLine."Budget Line";
    //                             QuoteEvaluation."Request Date" := ProcurementRequestLine."Request Date";
    //                             QuoteEvaluation."Expected Receipt Date" := ProcurementRequestLine."Expected Receipt Date";
    //                             QuoteEvaluation."Requisition No" := ProcurementRequest."Requisition No";
    //                             QuoteEvaluation."VAT Prod. Posting Group" := ProcurementRequestLine."VAT Prod. Posting Group";
    //                             QuoteEvaluation."VAT %" := ProcurementRequestLine."VAT %";
    //                             QuoteEvaluation."Amount Inclusive VAT" := ProcurementRequestLine."Amount Inclusive VAT";
    //                             if ProcurementRequest.Get(EOINo) then
    //                                 QuoteEvaluation.Title := ProcurementRequest.Title;
    //                             if not QuoteEvaluation.Get(EOINo, ProspectiveList."Vendor No", ProcurementRequestLine.No) then
    //                                 QuoteEvaluation.Insert;
    //                         until ProcurementRequestLine.Next = 0;
    //                     end;
    //                 end;
    //             until BiddersSelect.Next() = 0;
    //             Message('EOI Evaluation generated successfully');
    //             //Archive the quotation
    //             ProcurementRequest.Status := ProcurementRequest.Status::Archived;
    //             ProcurementRequest.Modify;
    //         end;
    //     end;
    // end;
    procedure CreateEOIEvaluation(EOINo: Code[20])
    var
        PreQualifiedList: Record "Prequalified Suppliers";
        ProcurementRequestLine: Record "Prospective Tender Line";
        QuoteEvaluation: Record "EOI Evaluation Line";
        EOILines: Record "EOI Evaluation Line";
        PPSetup: Record "Purchases & Payables Setup";
        QuoteEvaluationHeader: Record "EOI Evaluation Header";
        ProcurementRequest: Record "Procurement Request";
        SupplierSelection: Record "Bidders Selection";
        Prospectives: Record "Prospective Suppliers";
    begin
        ProcurementRequest.Reset();
        ProcurementRequest.SetRange("No.", EOINo);
        if ProcurementRequest.FindFirst() then begin
            //Insert Header
            QuoteEvaluationHeader.Init;
            QuoteEvaluationHeader."Quote No" := EOINo;
            QuoteEvaluationHeader.Title := ProcurementRequest.Title;
            QuoteEvaluationHeader."Requisition No" := ProcurementRequest."Requisition No";
            QuoteEvaluationHeader."Creation Date" := Today;
            QuoteEvaluationHeader."Shortcut Dimension 1 Code" := ProcurementRequest."Shortcut Dimension 1 Code";
            QuoteEvaluationHeader."Shortcut Dimension 2 Code" := ProcurementRequest."Shortcut Dimension 2 Code";
            QuoteEvaluationHeader."Dimension Set ID" := ProcurementRequest."Dimension Set ID";
            if not QuoteEvaluationHeader.Get(EOINo) then QuoteEvaluationHeader.Insert;
            EOILines.Reset();
            EOILines.SetRange("Quote No", EOINo);
            EOILines.DeleteAll();
            SupplierSelection.Reset();
            SupplierSelection.SetRange("Reference No.", EOINo);
            if SupplierSelection.Find('-') then begin
                repeat //Insert Lines
                    ProcurementRequestLine.Reset;
                    ProcurementRequestLine.SetRange("Tender No.", EOINo);
                    ProcurementRequestLine.SetRange("Response No", SupplierSelection."Supplier Code");
                    if ProcurementRequestLine.Find('-') then begin
                        repeat
                            QuoteEvaluation.Init;
                            QuoteEvaluation."Quote No" := EOINo;
                            QuoteEvaluation."Vendor No" := SupplierSelection."Supplier Code";
                            QuoteEvaluation.Validate("Vendor No");
                            QuoteEvaluation.Type := ProcurementRequestLine.Type;
                            QuoteEvaluation."No." := ProcurementRequestLine.No;
                            QuoteEvaluation.Description := ProcurementRequestLine.Description;
                            QuoteEvaluation."Unit of Measure" := ProcurementRequestLine."Unit of Measure";
                            QuoteEvaluation.Quantity := ProcurementRequestLine.Quantity;
                            QuoteEvaluation."Unit Amount" := ProcurementRequestLine."Unit Price";
                            QuoteEvaluation.Amount := ProcurementRequestLine.Amount;
                            QuoteEvaluation."Line No" := ProcurementRequestLine."Line No";
                            QuoteEvaluation."Shortcut Dimension 1 Code" := ProcurementRequestLine."Shortcut Dimension 1 Code";
                            QuoteEvaluation.Validate("Shortcut Dimension 1 Code");
                            QuoteEvaluation."Shortcut Dimension 2 Code" := ProcurementRequestLine."Shortcut Dimension 2 Code";
                            QuoteEvaluation.Validate("Shortcut Dimension 2 Code");
                            QuoteEvaluation.Committed := ProcurementRequestLine.Committed;
                            QuoteEvaluation."Procurement Plan" := ProcurementRequestLine."Procurement Plan";
                            QuoteEvaluation."Procurement Plan Item" := ProcurementRequestLine."Procurement Plan Item";
                            QuoteEvaluation."Budget Line" := ProcurementRequestLine."Budget Line";
                            QuoteEvaluation."Request Date" := ProcurementRequestLine."Request Date";
                            QuoteEvaluation."Expected Receipt Date" := ProcurementRequestLine."Expected Receipt Date";
                            QuoteEvaluation."Requisition No" := ProcurementRequest."Requisition No";
                            QuoteEvaluation."VAT Prod. Posting Group" := ProcurementRequestLine."VAT Prod. Posting Group";
                            QuoteEvaluation."VAT %" := ProcurementRequestLine."VAT %";
                            QuoteEvaluation."Amount Inclusive VAT" := ProcurementRequestLine."Amount Inclusive VAT";
                            if ProcurementRequest.Get(SupplierSelection."Reference No.") then QuoteEvaluation.Title := ProcurementRequest.Title;
                            if not QuoteEvaluation.Get(SupplierSelection."Reference No.", Prospectives."Vendor No", ProcurementRequestLine.No) then QuoteEvaluation.Insert;
                        until ProcurementRequestLine.Next = 0;
                    end;
                until SupplierSelection.Next() = 0;
                Message('EOI Evaluation generated successfully');
            end;
            //Archive the quotation
            ProcurementRequest.Status := ProcurementRequest.Status::Archived;
            ProcurementRequest.Modify;
        end;
    end;

    procedure CreaTenderEvaluation(var Tender: Record "Procurement Request")
    var
        PreQualifiedList: Record "Prospective Suppliers";
        ProcurementRequestLine: Record "Prospective Tender Line";
        QuoteEvaluation: Record "Tender Evaluation Line";
        PPSetup: Record "Purchases & Payables Setup";
        QuoteEvaluationHeader: Record "Tender Evaluation Header";
        QuoteEvaluationHeader2: Record "Tender Evaluation Header";
        ProcurementRequest: Record "Procurement Request";
        SupplierSelection: Record "Bidders Selection";
    begin
        SupplierSelection.Reset();
        SupplierSelection.SetRange("Reference No.", Tender."No.");
        SupplierSelection.SetRange("Passed Preliminary", true);
        if SupplierSelection.Find('-') then
            repeat
                PreQualifiedList.Reset;
                PreQualifiedList.SetRange("No.", SupplierSelection.Supplier);
                if PreQualifiedList.Find('-') then begin
                    //Insert Header
                    QuoteEvaluationHeader.Init;
                    QuoteEvaluationHeader."Quote No" := Tender."No.";
                    QuoteEvaluationHeader.Title := Tender.Title;
                    QuoteEvaluationHeader."Requisition No" := Tender."Requisition No";
                    QuoteEvaluationHeader."Creation Date" := Today;
                    QuoteEvaluationHeader."Shortcut Dimension 1 Code" := Tender."Shortcut Dimension 1 Code";
                    QuoteEvaluationHeader."Shortcut Dimension 2 Code" := Tender."Shortcut Dimension 2 Code";
                    QuoteEvaluationHeader."Dimension Set ID" := Tender."Dimension Set ID";
                    QuoteEvaluationHeader."Ref No." := Tender."Ref No.";
                    if not QuoteEvaluationHeader.Get(Tender."No.") then QuoteEvaluationHeader.Insert;
                    //Insert Lines
                    ProcurementRequestLine.Reset;
                    ProcurementRequestLine.SetRange("Tender No.", SupplierSelection."Reference No.");
                    ProcurementRequestLine.SetRange("Response No", SupplierSelection."Supplier Code");
                    if ProcurementRequestLine.Find('-') then begin
                        repeat
                            PPSetup.Get;
                            QuoteEvaluation.Init;
                            QuoteEvaluation."Quote No" := SupplierSelection."Reference No.";
                            //QuoteEvaluation."Vendor No" := PreQualifiedList."Vendor No";
                            QuoteEvaluation."Vendor No" := PreQualifiedList."No.";
                            QuoteEvaluation.Validate(QuoteEvaluation."Vendor No");
                            QuoteEvaluation.Type := ProcurementRequestLine.Type;
                            QuoteEvaluation."No." := ProcurementRequestLine.No;
                            QuoteEvaluation.Description := ProcurementRequestLine.Description;
                            QuoteEvaluation."Unit of Measure" := ProcurementRequestLine."Unit of Measure";
                            QuoteEvaluation.Quantity := ProcurementRequestLine.Quantity;
                            QuoteEvaluation."Unit Amount" := ProcurementRequestLine."Unit Price";
                            QuoteEvaluation.Amount := ProcurementRequestLine.Amount;
                            QuoteEvaluation."Line No" := ProcurementRequestLine."Line No";
                            QuoteEvaluation."Shortcut Dimension 1 Code" := ProcurementRequestLine."Shortcut Dimension 1 Code";
                            QuoteEvaluation.Validate("Shortcut Dimension 1 Code");
                            QuoteEvaluation."Shortcut Dimension 2 Code" := ProcurementRequestLine."Shortcut Dimension 2 Code";
                            QuoteEvaluation.Validate("Shortcut Dimension 2 Code");
                            QuoteEvaluation.Committed := ProcurementRequestLine.Committed;
                            QuoteEvaluation."Procurement Plan" := ProcurementRequestLine."Procurement Plan";
                            QuoteEvaluation."Procurement Plan Item" := ProcurementRequestLine."Procurement Plan Item";
                            QuoteEvaluation."Budget Line" := ProcurementRequestLine."Budget Line";
                            QuoteEvaluation."Request Date" := ProcurementRequestLine."Request Date";
                            QuoteEvaluation."Expected Receipt Date" := ProcurementRequestLine."Expected Receipt Date";
                            QuoteEvaluation."Requisition No" := ProcurementRequest."Requisition No";
                            QuoteEvaluation."VAT Prod. Posting Group" := ProcurementRequestLine."VAT Prod. Posting Group";
                            QuoteEvaluation."VAT %" := ProcurementRequestLine."VAT %";
                            QuoteEvaluation."Amount Inclusive VAT" := ProcurementRequestLine."Amount Inclusive VAT";
                            if ProcurementRequest.Get(SupplierSelection."Reference No.") then QuoteEvaluation.Title := ProcurementRequest.Title;
                            if not QuoteEvaluation.Get(SupplierSelection."Reference No.", SupplierSelection."Supplier Code", ProcurementRequestLine.No) then QuoteEvaluation.Insert;
                        until ProcurementRequestLine.Next = 0;
                    end;
                end;
            until SupplierSelection.Next() = 0;
        //Archive the quotation
        QuoteEvaluationHeader2.Reset();
        QuoteEvaluationHeader2.SetRange("Quote No", Tender."No.");
        if QuoteEvaluationHeader2.FindFirst() then begin
            Tender.Stage := Tender.Stage::Technical;
            Tender.Modify;
            Message('Tender Evaluation generated successfully');
        end
        else
            Message('Tender evaluation not generated');
    end;
    //EOI Mail Qualified Suppliers
    procedure MailQualified(EOI: Record "EOI Evaluation Header")
    var
        ProcurementRequest: Record "Procurement Request";
        SupplierSelection: Record "EOI Evaluation Line";
        ProsSupp: Record "Prospective Suppliers";
        BidSec: Record "Bidders Selection";
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        SupplierSelection2: Record "EOI Evaluation Line";
        SupSelection: Record "Supplier Selection";
        SenderName: Text;
        SenderAddress: Text;
        Recipient: list of [text];
        Subject: Label 'BPIT EOI Progress';
        FileName: Text;
        TimeNow: Text;
        Email: Codeunit Email;
        RecipientCC: list of [text];
        RecordLink: Record "Record Link";
        Attachment: Text;
        ErrorMsg: Text;
        CompanyInfo: Record "Company Information";
        ProqRequest: Record "Procurement Request";
        EmailBodyText: Text;
        AdditionalAttachments: array[10] of Text;
        AdditionalFilename: array[10] of Text;
        i: Integer;
        SuppEmail: Text;
        NoOfRecipients: Integer;
        NewBody: Label 'Dear %1, <br>Congratulations for passing through the EOI Stage. <br><br>Kind Regards, <br><br><Strong>BPIT Procurement Committee</Strong>.  ';
    begin
        CompanyInformation.Get;
        CompanyInformation.TestField(Name);
        CompanyInformation.TestField("E-Mail");
        PurchSetup.Get;
        PurchSetup.TestField("RFQ Path");
        SenderName := CompanyInformation.Name;
        SenderAddress := CompanyInformation."E-Mail";
        ProqRequest.Reset();
        if ProqRequest.Get(EOI."Quote No") then begin
            SupplierSelection.Reset;
            SupplierSelection.SetRange("Quote No", EOI."Quote No");
            SupplierSelection.SetRange(Suggested, true);
            SupplierSelection.SetRange(Awarded, true);
            if SupplierSelection.Find('-') then begin
                repeat //Mail
                    FileName := PurchSetup."RFQ Path" + EOI."Quote No" + '_' + SupplierSelection."Vendor No" + '.pdf';
                    SupplierSelection.CalcFields("Supplier E-mail");
                    Receipient.Add(SupplierSelection."Supplier E-mail");
                    // Message('%1', "Supplier E-mail");
                    SupplierSelection2.Reset;
                    SupplierSelection2.SetRange(SupplierSelection2."Vendor No", SupplierSelection."Vendor No");
                    if SupplierSelection2.FindFirst then begin
                        //EDDIEREPORT.SaveAsPdf(Report::"Award Letter", FileName, SupplierSelection2);
                        Emailmessage.Create(Receipient, Subject, '', true);
                        Emailmessage.AppendToBody(StrSubstNo(NewBody, SupplierSelection."Vendor Name", EOI."Quote No", CompanyInformation.Name));
                    end;
                    Emailmessage.AddAttachment(FileName, Attachment, '');
                    //Add other attachments
                    RecordLink.Reset;
                    RecordLink.SetRange("Record ID", ProqRequest.RecordId);
                    if RecordLink.Find('-') then begin
                        i := 1;
                        repeat
                            AdditionalFilename[i] := RecordLink.URL1;
                            //Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i]),'';
                            Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i], '');
                            i := i + 1;
                        until RecordLink.Next = 0;
                    end;
                    NoOfRecipients := RecipientCC.Count;
                    if NoOfRecipients > 0 then // eddie.AddCC(RecipientCC);
                        Email.Send(Emailmessage);
                    //Delete saved pdf after sending mail
                    //FileManagement.DeleteClientFile(FileName);
                    SupSelection.Reset();
                    SupSelection.SetRange("Supplier Code", SupplierSelection."Vendor No");
                    If SupSelection.FindFirst() then SupSelection.Notified := true;
                    SupplierSelection.Modify;
                until SupplierSelection.Next = 0;
                Message('Successfull suppliers have been notified');
            end;
        end;
    end;
    //Mail Unqualified Suppliers
    procedure MailUnqualified(EOI: Record "EOI Evaluation Header")
    var
        ProcurementRequest: Record "Procurement Request";
        SupplierSelection: Record "EOI Evaluation Line";
        ProsSupp: Record "Prospective Suppliers";
        BidSec: Record "Bidders Selection";
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        SupplierSelection2: Record "EOI Evaluation Line";
        SupSelection: Record "Supplier Selection";
        SenderName: Text;
        SenderAddress: Text;
        Recipient: list of [text];
        Subject: Label 'BPIT EOI Progress';
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [text];
        RecordLink: Record "Record Link";
        Attachment: Text;
        ErrorMsg: Text;
        CompanyInfo: Record "Company Information";
        ProqRequest: Record "Procurement Request";
        EmailBodyText: Text;
        AdditionalAttachments: array[10] of Text;
        AdditionalFilename: array[10] of Text;
        i: Integer;
        NoOfRecipients: Integer;
        SuppEmail: Text;
        NewBody: Label 'Dear %1, <br>We trust you are well and keeping safe.We would like to thank you for expressing your interest for the EOI Ref no. %2. Unfortunately, we regret to inform you that your application was unsuccessful on this occasion. We would like to thank you for the time invested during this process and encourage you to regularly view our website for any other opportunities.Once again, we thank you for your cooperation throughout this process and wish you the very best in your future endeavors.. <br><br>Kind Regards, <br><br><Strong>BPIT Procurement Committee</Strong>.  ';
    begin
        CompanyInformation.Get;
        CompanyInformation.TestField(Name);
        CompanyInformation.TestField("E-Mail");
        PurchSetup.Get;
        PurchSetup.TestField("RFQ Path");
        /*Clear(FileSystem);
        if Create(FileSystem, false, true) then begin
            if not FileSystem.FolderExists(PurchSetup."RFQ Path") then
                FileSystem.CreateFolder(PurchSetup."RFQ Path");
        end;*/
        SenderName := CompanyInformation.Name;
        SenderAddress := CompanyInformation."E-Mail";
        ProqRequest.Reset();
        if ProqRequest.Get(EOI."Quote No") then begin
            SupplierSelection.Reset;
            SupplierSelection.SetRange("Quote No", EOI."Quote No");
            SupplierSelection.SetRange(Awarded, false);
            if SupplierSelection.Find('-') then begin
                repeat //Mail
                    FileName := PurchSetup."RFQ Path" + EOI."Quote No" + '_' + SupplierSelection."Vendor No" + '.pdf';
                    SupplierSelection.CalcFields("Supplier E-mail");
                    Receipient.Add(SupplierSelection."Supplier E-mail");
                    SupplierSelection2.Reset;
                    SupplierSelection2.SetRange(SupplierSelection2."Vendor No", SupplierSelection."Vendor No");
                    if SupplierSelection2.FindFirst then begin
                        //EDDIEREPORT.SaveAsPdf(Report::"Regret Letter", FileName, SupplierSelection2);
                        Emailmessage.Create(Receipient, Subject, '', true);
                        Emailmessage.AppendToBody(StrSubstNo(NewBody, SupplierSelection."Vendor Name", EOI."Quote No"));
                    end;
                    Emailmessage.AddAttachment(FileName, Attachment, '');
                    //Add other attachments
                    RecordLink.Reset;
                    RecordLink.SetRange("Record ID", ProqRequest.RecordId);
                    if RecordLink.Find('-') then begin
                        i := 1;
                        repeat
                            AdditionalFilename[i] := RecordLink.URL1;
                            //Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i]),'';
                            Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i], '');
                            i := i + 1;
                        until RecordLink.Next = 0;
                    end;
                    NoOfRecipients := RecipientCC.Count;
                    if NoOfRecipients > 0 then //EDDIEEmailmessage.AddCC(RecipientCC);
                        EMAIL.Send(Emailmessage);
                    //Delete saved pdf after sending mail
                    //FileManagement.DeleteClientFile(FileName);
                    SupSelection.Reset();
                    SupSelection.SetRange("Supplier Code", SupplierSelection."Vendor No");
                    If SupSelection.FindFirst() then SupSelection.Notified := true;
                    SupplierSelection.Modify;
                until SupplierSelection.Next = 0;
                Message('Successfull suppliers have been notified');
            end;
        end;
    end;
    //RFP Mail Qualified Suppliers
    procedure MailRFPQualified(RFP: Record "RFP Evaluation Header")
    var
        ProcurementRequest: Record "Procurement Request";
        SupplierSelection: Record "EOI Evaluation Line";
        ProsSupp: Record "Prospective Suppliers";
        BidSec: Record "Bidders Selection";
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        // SMTPSetup: Record "SMTP Mail Setup";
        SupplierSelection2: Record "EOI Evaluation Line";
        SupSelection: Record "Supplier Selection";
        SenderName: Text;
        SenderAddress: Text;
        Recipient: list of [text];
        Subject: Label 'BPIT RFP Progress';
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [text];
        RecordLink: Record "Record Link";
        Attachment: Text;
        ErrorMsg: Text;
        CompanyInfo: Record "Company Information";
        ProqRequest: Record "Procurement Request";
        EmailBodyText: Text;
        AdditionalAttachments: array[10] of Text;
        AdditionalFilename: array[10] of Text;
        i: Integer;
        SuppEmail: Text;
        NoOfRecipients: Integer;
        NewBody: Label 'Dear %1, <br>Congratulations for passing through the RFP Stage. <br><br>Kind Regards, <br><br><Strong>BPIT Procurement Committee</Strong>.  ';
    begin
        CompanyInformation.Get;
        CompanyInformation.TestField(Name);
        CompanyInformation.TestField("E-Mail");
        PurchSetup.Get;
        PurchSetup.TestField("RFQ Path");
        SenderName := CompanyInformation.Name;
        SenderAddress := CompanyInformation."E-Mail";
        ProqRequest.Reset();
        if ProqRequest.Get(RFP."Quote No") then begin
            SupplierSelection.Reset;
            SupplierSelection.SetRange("Quote No", RFP."Quote No");
            SupplierSelection.SetRange(Suggested, true);
            SupplierSelection.SetRange(Awarded, true);
            if SupplierSelection.Find('-') then begin
                repeat //Mail
                    FileName := PurchSetup."RFQ Path" + RFP."Quote No" + '_' + SupplierSelection."Vendor No" + '.pdf';
                    SupplierSelection.CalcFields("Supplier E-mail");
                    Receipient.Add(SupplierSelection."Supplier E-mail");
                    // Message('%1', "Supplier E-mail");
                    SupplierSelection2.Reset;
                    SupplierSelection2.SetRange(SupplierSelection2."Vendor No", SupplierSelection."Vendor No");
                    if SupplierSelection2.FindFirst then begin
                        //EDDDIE REPORT.SaveAsPdf(Report::"Award Letter", FileName, SupplierSelection2);
                        Emailmessage.Create(Receipient, Subject, '', true);
                        Emailmessage.AppendToBody(StrSubstNo(NewBody, SupplierSelection."Vendor Name", RFP."Quote No", CompanyInformation.Name));
                    end;
                    Emailmessage.AddAttachment(FileName, Attachment, '');
                    //Add other attachments
                    RecordLink.Reset;
                    RecordLink.SetRange("Record ID", ProqRequest.RecordId);
                    if RecordLink.Find('-') then begin
                        i := 1;
                        repeat
                            AdditionalFilename[i] := RecordLink.URL1;
                            Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i], '');
                            i := i + 1;
                        until RecordLink.Next = 0;
                    end;
                    NoOfRecipients := RecipientCC.Count;
                    if NoOfRecipients > 0 then //eddieSMTP.AddCC(RecipientCC);
                        EMAIL.Send(Emailmessage);
                    //Delete saved pdf after sending mail
                    //FileManagement.DeleteClientFile(FileName);
                    SupSelection.Reset();
                    SupSelection.SetRange("Supplier Code", SupplierSelection."Vendor No");
                    If SupSelection.FindFirst() then SupSelection.Notified := true;
                    SupplierSelection.Modify;
                until SupplierSelection.Next = 0;
                Message('Successfull suppliers have been notified');
            end;
        end;
    end;
    //RFP Mail Unqualified Suppliers
    procedure MailRFPUnqualified(RFP: Record "RFP Evaluation Header")
    var
        ProcurementRequest: Record "Procurement Request";
        SupplierSelection: Record "EOI Evaluation Line";
        ProsSupp: Record "Prospective Suppliers";
        BidSec: Record "Bidders Selection";
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        SupplierSelection2: Record "EOI Evaluation Line";
        SupSelection: Record "Supplier Selection";
        SenderName: Text;
        SenderAddress: Text;
        Recipient: list of [text];
        Subject: Label 'BPIT EOI Progress';
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [text];
        RecordLink: Record "Record Link";
        Attachment: Text;
        ErrorMsg: Text;
        CompanyInfo: Record "Company Information";
        ProqRequest: Record "Procurement Request";
        EmailBodyText: Text;
        AdditionalAttachments: array[10] of Text;
        AdditionalFilename: array[10] of Text;
        i: Integer;
        NoOfRecipients: Integer;
        SuppEmail: Text;
        NewBody: Label 'Dear %1, <br>We trust you are well and keeping safe.We would like to thank you for expressing your interest for the RFP Ref no. %2. Unfortunately, we regret to inform you that your application was unsuccessful on this occasion. We would like to thank you for the time invested during this process and encourage you to regularly view our website for any other opportunities.Once again, we thank you for your cooperation throughout this process and wish you the very best in your future endeavors.. <br><br>Kind Regards, <br><br><Strong>BPIT Procurement Committee</Strong>.  ';
    begin
        CompanyInformation.Get;
        CompanyInformation.TestField(Name);
        CompanyInformation.TestField("E-Mail");
        PurchSetup.Get;
        PurchSetup.TestField("RFQ Path");
        /*Clear(FileSystem);
        if Create(FileSystem, false, true) then begin
            if not FileSystem.FolderExists(PurchSetup."RFQ Path") then
                FileSystem.CreateFolder(PurchSetup."RFQ Path");
        end;*/
        SenderName := CompanyInformation.Name;
        SenderAddress := CompanyInformation."E-Mail";
        ProqRequest.Reset();
        if ProqRequest.Get(RFP."Quote No") then begin
            SupplierSelection.Reset;
            SupplierSelection.SetRange("Quote No", RFP."Quote No");
            SupplierSelection.SetRange(Awarded, false);
            if SupplierSelection.Find('-') then begin
                repeat //Mail
                    FileName := PurchSetup."RFQ Path" + RFP."Quote No" + '_' + SupplierSelection."Vendor No" + '.pdf';
                    SupplierSelection.CalcFields("Supplier E-mail");
                    Receipient.Add(SupplierSelection."Supplier E-mail");
                    SupplierSelection2.Reset;
                    SupplierSelection2.SetRange(SupplierSelection2."Vendor No", SupplierSelection."Vendor No");
                    if SupplierSelection2.FindFirst then begin
                        //EDDIE REPORT.SaveAsPdf(Report::"Regret Letter", FileName, SupplierSelection2);
                        Emailmessage.Create(Receipient, Subject, '', true);
                        Emailmessage.AppendToBody(StrSubstNo(NewBody, SupplierSelection."Vendor Name", RFP."Quote No"));
                    end;
                    Emailmessage.AddAttachment(FileName, Attachment, '');
                    //Add other attachments
                    RecordLink.Reset;
                    RecordLink.SetRange("Record ID", ProqRequest.RecordId);
                    if RecordLink.Find('-') then begin
                        i := 1;
                        repeat
                            AdditionalFilename[i] := RecordLink.URL1;
                            //SMTP.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i]);
                            Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i], '');
                            i := i + 1;
                        until RecordLink.Next = 0;
                    end;
                    NoOfRecipients := RecipientCC.Count;
                    if NoOfRecipients > 0 then //EDDIE SMTP.AddCC(RecipientCC);
                        EMAIL.Send(Emailmessage);
                    //Delete saved pdf after sending mail
                    //FileManagement.DeleteClientFile(FileName);
                    SupSelection.Reset();
                    SupSelection.SetRange("Supplier Code", SupplierSelection."Vendor No");
                    If SupSelection.FindFirst() then SupSelection.Notified := true;
                    SupplierSelection.Modify;
                until SupplierSelection.Next = 0;
                Message('Successfull suppliers have been notified');
            end;
        end;
    end;
    //Tender Mail Qualified Suppliers
    procedure MailTenderQualified(Tender: Record "Tender Evaluation Header")
    var
        ProcurementRequest: Record "Procurement Request";
        SupplierSelection: Record "EOI Evaluation Line";
        ProsSupp: Record "Prospective Suppliers";
        BidSec: Record "Bidders Selection";
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        //SMTPSetup: Record "SMTP Mail Setup";
        SupplierSelection2: Record "EOI Evaluation Line";
        SupSelection: Record "Supplier Selection";
        SenderName: Text;
        SenderAddress: Text;
        Recipient: list of [text];
        Subject: Label 'BPIT Tender Progress';
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [text];
        RecordLink: Record "Record Link";
        Attachment: Text;
        ErrorMsg: Text;
        CompanyInfo: Record "Company Information";
        ProqRequest: Record "Procurement Request";
        EmailBodyText: Text;
        AdditionalAttachments: array[10] of Text;
        AdditionalFilename: array[10] of Text;
        i: Integer;
        SuppEmail: Text;
        NoOfRecipients: Integer;
        NewBody: Label 'Dear %1, <br>Congratulations for passing through the Tender Stage. <br><br>Kind Regards, <br><br><Strong>BPIT Procurement Committee</Strong>.  ';
    begin
        CompanyInformation.Get;
        CompanyInformation.TestField(Name);
        CompanyInformation.TestField("E-Mail");
        PurchSetup.Get;
        PurchSetup.TestField("RFQ Path");
        SenderName := CompanyInformation.Name;
        SenderAddress := CompanyInformation."E-Mail";
        ProqRequest.Reset();
        if ProqRequest.Get(Tender."Quote No") then begin
            SupplierSelection.Reset;
            SupplierSelection.SetRange("Quote No", Tender."Quote No");
            SupplierSelection.SetRange(Suggested, true);
            SupplierSelection.SetRange(Awarded, true);
            if SupplierSelection.Find('-') then begin
                repeat //Mail
                    FileName := PurchSetup."RFQ Path" + Tender."Quote No" + '_' + SupplierSelection."Vendor No" + '.pdf';
                    SupplierSelection.CalcFields("Supplier E-mail");
                    Receipient.Add(SupplierSelection."Supplier E-mail");
                    // Message('%1', "Supplier E-mail");
                    SupplierSelection2.Reset;
                    SupplierSelection2.SetRange(SupplierSelection2."Vendor No", SupplierSelection."Vendor No");
                    if SupplierSelection2.FindFirst then begin
                        //EDDIEREPORT.SaveAsPdf(Report::TenderAwardLetter, FileName, SupplierSelection2);
                        Emailmessage.Create(Receipient, Subject, '', true);
                        Emailmessage.AppendToBody(StrSubstNo(NewBody, SupplierSelection."Vendor Name", Tender."Quote No", CompanyInformation.Name));
                    end;
                    Emailmessage.AddAttachment(FileName, Attachment, '');
                    //Add other attachments
                    RecordLink.Reset;
                    RecordLink.SetRange("Record ID", ProqRequest.RecordId);
                    if RecordLink.Find('-') then begin
                        i := 1;
                        repeat
                            AdditionalFilename[i] := RecordLink.URL1;
                            Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i], '');
                            i := i + 1;
                        until RecordLink.Next = 0;
                    end;
                    NoOfRecipients := RecipientCC.Count;
                    if NoOfRecipients > 0 then //EDDIE SMTP.AddCC(RecipientCC);
                        EMAIL.Send(Emailmessage);
                    //Delete saved pdf after sending mail
                    //FileManagement.DeleteClientFile(FileName);
                    SupSelection.Reset();
                    SupSelection.SetRange("Supplier Code", SupplierSelection."Vendor No");
                    If SupSelection.FindFirst() then SupSelection.Notified := true;
                    SupplierSelection.Modify;
                until SupplierSelection.Next = 0;
                Message('Successfull suppliers have been notified');
            end;
        end;
    end;
    //quotation Mail Qualified Suppliers
    procedure MailRFQQualified(Quotation: Record "Quote Evaluation Header")
    var
        ProcurementRequest: Record "Procurement Request";
        SupplierSelection: Record "EOI Evaluation Line";
        ProsSupp: Record "Prospective Suppliers";
        BidSec: Record "Bidders Selection";
        //FileSystem: Automation BC;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        // SMTPSetup: Record "SMTP Mail Setup";
        SupplierSelection2: Record "EOI Evaluation Line";
        SupSelection: Record "Supplier Selection";
        SenderName: Text;
        SenderAddress: Text;
        Recipient: list of [text];
        Subject: Label 'BPIT RFQ Progress';
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [text];
        RecordLink: Record "Record Link";
        Attachment: Text;
        ErrorMsg: Text;
        CompanyInfo: Record "Company Information";
        ProqRequest: Record "Procurement Request";
        EmailBodyText: Text;
        AdditionalAttachments: array[10] of Text;
        AdditionalFilename: array[10] of Text;
        i: Integer;
        SuppEmail: Text;
        NoOfRecipients: Integer;
        NewBody: Label 'Dear %1, <br>Congratulations for passing through the RFQ Stage. <br><br>Kind Regards, <br><br><Strong>BPIT Procurement Committee</Strong>.  ';
    begin
        CompanyInformation.Get;
        CompanyInformation.TestField(Name);
        CompanyInformation.TestField("E-Mail");
        PurchSetup.Get;
        PurchSetup.TestField("RFQ Path");
        SenderName := CompanyInformation.Name;
        SenderAddress := CompanyInformation."E-Mail";
        ProqRequest.Reset();
        if ProqRequest.Get(Quotation."Quote No") then begin
            SupplierSelection.Reset;
            SupplierSelection.SetRange("Quote No", Quotation."Quote No");
            SupplierSelection.SetRange(Suggested, true);
            SupplierSelection.SetRange(Awarded, true);
            if SupplierSelection.Find('-') then begin
                repeat //Mail
                    FileName := PurchSetup."RFQ Path" + Quotation."Quote No" + '_' + SupplierSelection."Vendor No" + '.pdf';
                    SupplierSelection.CalcFields("Supplier E-mail");
                    Receipient.Add(SupplierSelection."Supplier E-mail");
                    // Message('%1', "Supplier E-mail");
                    SupplierSelection2.Reset;
                    SupplierSelection2.SetRange(SupplierSelection2."Vendor No", SupplierSelection."Vendor No");
                    if SupplierSelection2.FindFirst then begin
                        //EDDIE REPORT.SaveAsPdf(Report::"RFQ Award Letter", FileName, SupplierSelection2);
                        Emailmessage.Create(Receipient, Subject, '', true);
                        Emailmessage.AppendToBody(StrSubstNo(NewBody, SupplierSelection."Vendor Name", Quotation."Quote No", CompanyInformation.Name));
                    end;
                    Emailmessage.AddAttachment(FileName, Attachment, '');
                    //Add other attachments
                    RecordLink.Reset;
                    RecordLink.SetRange("Record ID", ProqRequest.RecordId);
                    if RecordLink.Find('-') then begin
                        i := 1;
                        repeat
                            AdditionalFilename[i] := RecordLink.URL1;
                            Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i], '');
                            i := i + 1;
                        until RecordLink.Next = 0;
                    end;
                    NoOfRecipients := RecipientCC.Count;
                    if NoOfRecipients > 0 then //EDDIE SMTP.AddCC(RecipientCC);
                        EMAIL.Send(Emailmessage);
                    //Delete saved pdf after sending mail
                    //FileManagement.DeleteClientFile(FileName);
                    SupSelection.Reset();
                    SupSelection.SetRange("Supplier Code", SupplierSelection."Vendor No");
                    If SupSelection.FindFirst() then SupSelection.Notified := true;
                    SupplierSelection.Modify;
                until SupplierSelection.Next = 0;
                Message('Successfull suppliers have been notified');
            end;
        end;
    end;

    procedure CreateQuote(var SupplierSelection: Record "Supplier Selection")
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchaseRequest: Record "Procurement Request";
        PreQualifiedList: Record "Prequalified Suppliers";
        ProcurementRequestLine: Record "Procurement Request Lines";
    begin
        //Create a supplier from the list of Pre-Qualified Suppliers
        if SupplierSelection.Invited then begin
            PreQualifiedList.Reset;
            PreQualifiedList.SetRange(PreQualifiedList.Name, SupplierSelection."Supplier Name");
            //PreQualifiedList.SETRANGE(PreQualifiedList.Category,SupplierSelection."Supplier Category");
            if PreQualifiedList.Find('-') then begin
                if PreQualifiedList."Vendor No" = '' then
                    if Confirm('The system will create Vendor %1 Do you want to continue?', true, SupplierSelection."Supplier Name") then begin
                        PreQualifiedList.CreateVend(PreQualifiedList);
                    end;
                PurchaseHeader.Init;
                PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Quote;
                PurchaseHeader."No." := '';
                PurchaseHeader."Buy-from Vendor No." := PreQualifiedList."Vendor No";
                PurchaseHeader.Validate(PurchaseHeader."Buy-from Vendor No.");
                PurchaseHeader.Insert(true);
                ProcurementRequestLine.Reset;
                ProcurementRequestLine.SetRange(ProcurementRequestLine."Requisition No", SupplierSelection."Reference No.");
                if ProcurementRequestLine.Find('-') then
                    repeat
                        PurchaseLine.Init;
                        PurchaseLine."Document Type" := PurchaseHeader."Document Type";
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine."Line No." := ProcurementRequestLine."Line No";
                        PurchaseLine."Buy-from Vendor No." := PreQualifiedList."Vendor No";
                        PurchaseLine.Type := ProcurementRequestLine.Type;
                        PurchaseLine."No." := ProcurementRequestLine.No;
                        PurchaseLine.Validate(PurchaseLine."No.");
                        PurchaseLine.Description := ProcurementRequestLine.Description;
                        PurchaseLine."Unit of Measure" := ProcurementRequestLine."Unit of Measure";
                        PurchaseLine.Quantity := ProcurementRequestLine.Quantity;
                        PurchaseLine.Insert;
                    until ProcurementRequestLine.Next = 0;
            end;
        end;
    end;

    procedure CreateQuoteEvaluation(QuoteNo: code[20])
    var
        ProspectiveList: Record "Prospective Suppliers";
        ProcurementRequestLine: Record "Prospective Tender Line";
        QuoteEvaluation: Record "Quote Evaluation";
        PPSetup: Record "Purchases & Payables Setup";
        QuoteEvaluationHeader: Record "Quote Evaluation Header";
        ProcurementRequest: Record "Procurement Request";
        TendersApplied: Record "Prospective Supplier Tender";
        BiddersSelect: Record "Bidders Selection";
    begin
        ProcurementRequest.Reset();
        ProcurementRequest.SetRange("No.", QuoteNo);
        if ProcurementRequest.FindFirst() then begin
            BiddersSelect.Reset();
            BiddersSelect.SetRange("Reference No.", QuoteNo);
            if BiddersSelect.Find('-') then begin
                ProspectiveList.Reset;
                ProspectiveList.SetRange("No.", BiddersSelect.Supplier);
                if ProspectiveList.Find('-') then begin
                    if ProspectiveList."Vendor No" = '' then
                        if Confirm('The system will create Vendor %1 Do you want to continue?', true, ProspectiveList.Name) then begin
                            ProspectiveList.CreateVendr(ProspectiveList);
                        end;
                end;
                //Insert Header
                QuoteEvaluationHeader."Quote No" := ProcurementRequest."No.";
                QuoteEvaluationHeader.Title := ProcurementRequest.Title;
                QuoteEvaluationHeader."Requisition No" := ProcurementRequest."Requisition No";
                //QuoteEvaluationHeader.Status := ProcurementRequest.Status;
                QuoteEvaluationHeader."Creation Date" := Today;
                QuoteEvaluationHeader."Quotation Deadline" := ProcurementRequest."Quotation Deadline";
                QuoteEvaluationHeader."Expected Closing Time" := ProcurementRequest."Expected Closing Time";
                QuoteEvaluationHeader."Shortcut Dimension 1 Code" := ProcurementRequest."Shortcut Dimension 1 Code";
                QuoteEvaluationHeader."Shortcut Dimension 2 Code" := ProcurementRequest."Shortcut Dimension 2 Code";
                QuoteEvaluationHeader."Dimension Set ID" := ProcurementRequest."Dimension Set ID";
                if not QuoteEvaluationHeader.Get(ProcurementRequest."No.") then QuoteEvaluationHeader.Insert;
                repeat //Insert Lines
                    ProspectiveList.Reset();
                    ProspectiveList.SetRange("No.", BiddersSelect.Supplier);
                    if ProspectiveList.Find('-') then begin
                        ProcurementRequestLine.Reset;
                        ProcurementRequestLine.SetRange("Response No", BiddersSelect.Supplier);
                        ProcurementRequestLine.SetRange("Tender No.", BiddersSelect."Reference No.");
                        if ProcurementRequestLine.Find('-') then begin
                            repeat
                                PPSetup.Get;
                                QuoteEvaluation.Init;
                                QuoteEvaluation."Quote No" := QuoteNo;
                                QuoteEvaluation."Vendor No" := ProspectiveList."Vendor No";
                                QuoteEvaluation.Validate(QuoteEvaluation."Vendor No");
                                QuoteEvaluation.Type := ProcurementRequestLine.Type;
                                QuoteEvaluation."No." := ProcurementRequestLine.No;
                                QuoteEvaluation.Description := ProcurementRequestLine.Description;
                                QuoteEvaluation."Unit of Measure" := ProcurementRequestLine."Unit of Measure";
                                QuoteEvaluation.Quantity := ProcurementRequestLine.Quantity;
                                QuoteEvaluation."Unit Amount" := ProcurementRequestLine."Unit Price";
                                QuoteEvaluation.Amount := ProcurementRequestLine.Amount;
                                QuoteEvaluation."Line No" := ProcurementRequestLine."Line No";
                                QuoteEvaluation."Shortcut Dimension 1 Code" := ProcurementRequestLine."Shortcut Dimension 1 Code";
                                QuoteEvaluation.Validate("Shortcut Dimension 1 Code");
                                QuoteEvaluation."Shortcut Dimension 2 Code" := ProcurementRequestLine."Shortcut Dimension 2 Code";
                                QuoteEvaluation.Validate("Shortcut Dimension 2 Code");
                                QuoteEvaluation.Committed := ProcurementRequestLine.Committed;
                                QuoteEvaluation."Procurement Plan" := ProcurementRequestLine."Procurement Plan";
                                QuoteEvaluation."Procurement Plan Item" := ProcurementRequestLine."Procurement Plan Item";
                                QuoteEvaluation."Budget Line" := ProcurementRequestLine."Budget Line";
                                QuoteEvaluation."Request Date" := ProcurementRequestLine."Request Date";
                                QuoteEvaluation."Expected Receipt Date" := ProcurementRequestLine."Expected Receipt Date";
                                QuoteEvaluation."Requisition No" := ProcurementRequest."Requisition No";
                                QuoteEvaluation."VAT Prod. Posting Group" := ProcurementRequestLine."VAT Prod. Posting Group";
                                QuoteEvaluation."VAT %" := ProcurementRequestLine."VAT %";
                                QuoteEvaluation."Amount Inclusive VAT" := ProcurementRequestLine."Amount Inclusive VAT";
                                if ProcurementRequest.Get(BiddersSelect."Reference No.") then QuoteEvaluation.Title := ProcurementRequest.Title;
                                if not QuoteEvaluation.Get(BiddersSelect."Reference No.", ProspectiveList."Vendor No", ProcurementRequestLine.No) then QuoteEvaluation.Insert;
                            until ProcurementRequestLine.Next = 0;
                        end;
                    end;
                until BiddersSelect.Next() = 0;
                Message('Quote Evaluation generated successfully');
                ProcurementRequest.status := ProcurementRequest.status::Archived;
                ProcurementRequest.modify();
            end;
        end;
    end;

    procedure CreateQuoteEvaluation2(var SupplierSelection: Record "Supplier Selection")
    var
        PreQualifiedList: Record "Prequalified Suppliers";
        ProcurementRequestLine: Record "Procurement Request Lines";
        QuoteEvaluation: Record "Quote Evaluation";
        PPSetup: Record "Purchases & Payables Setup";
        QuoteEvaluationHeader: Record "Quote Evaluation Header";
        ProcurementRequest: Record "Procurement Request";
    begin
        //Create a supplier from the list of Pre-Qualified Suppliers
        if SupplierSelection.Invited then begin
            PreQualifiedList.Reset;
            PreQualifiedList.SetRange(PreQualifiedList."Vendor No", SupplierSelection."Supplier Code");
            //PreQualifiedList.SETRANGE(PreQualifiedList.Category,SupplierSelection."Supplier Category");
            if PreQualifiedList.Find('-') then begin
                if PreQualifiedList."Vendor No" = '' then
                    if Confirm('The system will create Vendor %1 Do you want to continue?', true, SupplierSelection."Supplier Name") then begin
                        PreQualifiedList.CreateVend(PreQualifiedList);
                    end;
                //Insert Header
                if ProcurementRequest.Get(SupplierSelection."Reference No.") then begin
                    QuoteEvaluationHeader.Init;
                    QuoteEvaluationHeader."Quote No" := ProcurementRequest."No.";
                    QuoteEvaluationHeader.Title := ProcurementRequest.Title;
                    QuoteEvaluationHeader."Requisition No" := ProcurementRequest."Requisition No";
                    QuoteEvaluationHeader.Status := ProcurementRequest.Status;
                    QuoteEvaluationHeader."Creation Date" := Today;
                    QuoteEvaluationHeader."Quotation Deadline" := ProcurementRequest."Quotation Deadline";
                    QuoteEvaluationHeader."Expected Closing Time" := ProcurementRequest."Expected Closing Time";
                    QuoteEvaluationHeader."Shortcut Dimension 1 Code" := ProcurementRequest."Shortcut Dimension 1 Code";
                    QuoteEvaluationHeader."Shortcut Dimension 2 Code" := ProcurementRequest."Shortcut Dimension 2 Code";
                    QuoteEvaluationHeader."Dimension Set ID" := ProcurementRequest."Dimension Set ID";
                    if not QuoteEvaluationHeader.Get(ProcurementRequest."No.") then QuoteEvaluationHeader.Insert;
                end;
                //Insert Lines
                ProcurementRequestLine.Reset;
                ProcurementRequestLine.SetRange(ProcurementRequestLine."Requisition No", SupplierSelection."Reference No.");
                if ProcurementRequestLine.FindFirst then begin
                    repeat
                        PPSetup.Get;
                        QuoteEvaluation.Init;
                        QuoteEvaluation."Quote No" := SupplierSelection."Reference No.";
                        QuoteEvaluation."Vendor No" := PreQualifiedList."Vendor No";
                        QuoteEvaluation.Validate(QuoteEvaluation."Vendor No");
                        QuoteEvaluation.Type := ProcurementRequestLine.Type;
                        QuoteEvaluation."No." := ProcurementRequestLine.No;
                        QuoteEvaluation.Description := ProcurementRequestLine.Description;
                        QuoteEvaluation."Unit of Measure" := ProcurementRequestLine."Unit of Measure";
                        QuoteEvaluation.Quantity := ProcurementRequestLine.Quantity;
                        QuoteEvaluation."Unit Amount" := ProcurementRequestLine."Unit Price";
                        QuoteEvaluation.Amount := ProcurementRequestLine.Amount;
                        QuoteEvaluation."Line No" := ProcurementRequestLine."Line No";
                        QuoteEvaluation."Shortcut Dimension 1 Code" := ProcurementRequestLine."Shortcut Dimension 1 Code";
                        QuoteEvaluation.Validate("Shortcut Dimension 1 Code");
                        QuoteEvaluation."Shortcut Dimension 2 Code" := ProcurementRequestLine."Shortcut Dimension 2 Code";
                        QuoteEvaluation.Validate("Shortcut Dimension 2 Code");
                        QuoteEvaluation.Committed := ProcurementRequestLine.Committed;
                        QuoteEvaluation."Procurement Plan" := ProcurementRequestLine."Procurement Plan";
                        QuoteEvaluation."Procurement Plan Item" := ProcurementRequestLine."Procurement Plan Item";
                        QuoteEvaluation."Budget Line" := ProcurementRequestLine."Budget Line";
                        QuoteEvaluation."Request Date" := ProcurementRequestLine."Request Date";
                        QuoteEvaluation."Expected Receipt Date" := ProcurementRequestLine."Expected Receipt Date";
                        QuoteEvaluation."Requisition No" := ProcurementRequest."Requisition No";
                        QuoteEvaluation."VAT Prod. Posting Group" := ProcurementRequestLine."VAT Prod. Posting Group";
                        QuoteEvaluation."VAT %" := ProcurementRequestLine."VAT %";
                        QuoteEvaluation."Amount Inclusive VAT" := ProcurementRequestLine."Amount Inclusive VAT";
                        if ProcurementRequest.Get(SupplierSelection."Reference No.") then QuoteEvaluation.Title := ProcurementRequest.Title;
                        if not QuoteEvaluation.Get(SupplierSelection."Reference No.", PreQualifiedList."Vendor No", ProcurementRequestLine.No) then QuoteEvaluation.Insert;
                    until ProcurementRequestLine.Next = 0;
                end;
                Message('Quote Evaluation generated successfully');
            end;
            //Archive the quotation
            if ProcurementRequest.Get(SupplierSelection."Reference No.") then ProcurementRequest.Status := ProcurementRequest.Status::Archived;
            ProcurementRequest.Modify;
            //MESSAGE(FORMAT('The Quation Has Been Created'));
        end;
    end;
    // procedure CreateRFPEvaluation(RFPNO: code[20])
    // var
    //     ProspectiveList: Record "Prospective Suppliers";
    //     ProcurementRequestLine: Record "Prospective Tender Line";
    //     QuoteEvaluation: Record "RFP Evaluation Line";
    //     PPSetup: Record "Purchases & Payables Setup";
    //     QuoteEvaluationHeader: Record "RFP Evaluation Header";
    //     ProcurementRequest: Record "Procurement Request";
    //     TendersApplied: Record "Prospective Supplier Tender";
    //     BiddersSelect: Record "Bidders Selection";
    // begin
    //     ProcurementRequest.Reset();
    //     ProcurementRequest.SetRange("No.", RFPNO);
    //     if ProcurementRequest.FindFirst() then begin
    //         //ProspectiveRec.TestField("Tender No.");
    //         BiddersSelect.Reset();
    //         BiddersSelect.SetRange("Reference No.", RFPNO);
    //         if BiddersSelect.Find('-') then begin
    //             QuoteEvaluationHeader.Init;
    //             QuoteEvaluationHeader."Quote No" := ProcurementRequest."No.";
    //             QuoteEvaluationHeader.Title := ProcurementRequest.Title;
    //             QuoteEvaluationHeader."Requisition No" := ProcurementRequest."Requisition No";
    //             QuoteEvaluationHeader."Creation Date" := Today;
    //             QuoteEvaluationHeader."Shortcut Dimension 1 Code" := ProcurementRequest."Shortcut Dimension 1 Code";
    //             QuoteEvaluationHeader."Shortcut Dimension 2 Code" := ProcurementRequest."Shortcut Dimension 2 Code";
    //             QuoteEvaluationHeader."Dimension Set ID" := ProcurementRequest."Dimension Set ID";
    //             if not QuoteEvaluationHeader.Get(ProcurementRequest."No.") then
    //                 QuoteEvaluationHeader.Insert;
    //             repeat
    //                 //Insert Lines
    //                 ProspectiveList.Reset();
    //                 ProspectiveList.SetRange("No.", BiddersSelect."Supplier Code");
    //                 if ProspectiveList.Find('-') then begin
    //                     ProcurementRequestLine.Reset;
    //                     ProcurementRequestLine.SetRange("Response No", BiddersSelect."Supplier Code");
    //                     ProcurementRequestLine.SetRange("Tender No.", BiddersSelect."Reference No.");
    //                     if ProcurementRequestLine.Find('-') then begin
    //                         repeat
    //                             PPSetup.Get;
    //                             QuoteEvaluation.Init;
    //                             QuoteEvaluation."Quote No" := RFPNO;
    //                             QuoteEvaluation."Vendor No" := ProspectiveList."Vendor No";
    //                             QuoteEvaluation.Validate(QuoteEvaluation."Vendor No");
    //                             QuoteEvaluation.Type := ProcurementRequestLine.Type;
    //                             QuoteEvaluation."No." := ProcurementRequestLine.No;
    //                             QuoteEvaluation.Description := ProcurementRequestLine.Description;
    //                             QuoteEvaluation."Unit of Measure" := ProcurementRequestLine."Unit of Measure";
    //                             QuoteEvaluation.Quantity := ProcurementRequestLine.Quantity;
    //                             QuoteEvaluation."Unit Amount" := ProcurementRequestLine."Unit Price";
    //                             QuoteEvaluation.Amount := ProcurementRequestLine.Amount;
    //                             QuoteEvaluation."Line No" := ProcurementRequestLine."Line No";
    //                             QuoteEvaluation."Shortcut Dimension 1 Code" := ProcurementRequestLine."Shortcut Dimension 1 Code";
    //                             QuoteEvaluation.Validate("Shortcut Dimension 1 Code");
    //                             QuoteEvaluation."Shortcut Dimension 2 Code" := ProcurementRequestLine."Shortcut Dimension 2 Code";
    //                             QuoteEvaluation.Validate("Shortcut Dimension 2 Code");
    //                             QuoteEvaluation.Committed := ProcurementRequestLine.Committed;
    //                             QuoteEvaluation."Procurement Plan" := ProcurementRequestLine."Procurement Plan";
    //                             QuoteEvaluation."Procurement Plan Item" := ProcurementRequestLine."Procurement Plan Item";
    //                             QuoteEvaluation."Budget Line" := ProcurementRequestLine."Budget Line";
    //                             QuoteEvaluation."Request Date" := ProcurementRequestLine."Request Date";
    //                             QuoteEvaluation."Expected Receipt Date" := ProcurementRequestLine."Expected Receipt Date";
    //                             QuoteEvaluation."Requisition No" := ProcurementRequest."Requisition No";
    //                             QuoteEvaluation."VAT Prod. Posting Group" := ProcurementRequestLine."VAT Prod. Posting Group";
    //                             QuoteEvaluation."VAT %" := ProcurementRequestLine."VAT %";
    //                             QuoteEvaluation."Amount Inclusive VAT" := ProcurementRequestLine."Amount Inclusive VAT";
    //                             if ProcurementRequest.Get(RFPNO) then
    //                                 QuoteEvaluation.Title := ProcurementRequest.Title;
    //                             if not QuoteEvaluation.Get(RFPNO, ProspectiveList."Vendor No", ProcurementRequestLine.No) then
    //                                 QuoteEvaluation.Insert;
    //                         until BiddersSelect.Next = 0;
    //                     end;
    //                 end;
    //             until BiddersSelect.Next() = 0;
    //             Message('RFP Evaluation generated successfully');
    //             //Archive the quotation
    //             ProcurementRequest.Status := ProcurementRequest.Status::Archived;
    //             ProcurementRequest.Modify;
    //         end;
    //     end;
    // end;
    procedure CreateRFPEvaluation(RFPNO: code[20])
    var
        ProspectiveList: Record "Prospective Suppliers";
        ProcurementRequestLine: Record "Prospective Tender Line";
        QuoteEvaluation: Record "RFP Evaluation Line";
        PPSetup: Record "Purchases & Payables Setup";
        QuoteEvaluationHeader: Record "RFP Evaluation Header";
        ProcurementRequest: Record "Procurement Request";
        TendersApplied: Record "Prospective Supplier Tender";
        BiddersSelect: Record "Bidders Selection";
        RFPLines: Record "RFP Evaluation Line";
        ScoreSetup: Record "Supplier Evaluation SetUp";
        PurchSetup: Record "Purchases & Payables Setup";
        SuppScore: Record "Supplier Evaluation Score";
        SupEval: Record "Supplier Evaluation Header";
        TotalPassMark: Decimal;
        TotalTechnicalScore: Decimal;
        TotalScore: Decimal;
    begin
        PurchSetup.Get();
        PurchSetup.TestField("Technical Percentage");
        ProcurementRequest.Reset();
        ProcurementRequest.SetRange("No.", RFPNO);
        if ProcurementRequest.FindFirst() then begin
            QuoteEvaluationHeader.Init;
            QuoteEvaluationHeader."Quote No" := ProcurementRequest."No.";
            QuoteEvaluationHeader.Title := ProcurementRequest.Title;
            QuoteEvaluationHeader."Requisition No" := ProcurementRequest."Requisition No";
            QuoteEvaluationHeader."Creation Date" := Today;
            QuoteEvaluationHeader."Shortcut Dimension 1 Code" := ProcurementRequest."Shortcut Dimension 1 Code";
            QuoteEvaluationHeader."Shortcut Dimension 2 Code" := ProcurementRequest."Shortcut Dimension 2 Code";
            QuoteEvaluationHeader."Dimension Set ID" := ProcurementRequest."Dimension Set ID";
            if not QuoteEvaluationHeader.Get(ProcurementRequest."No.") then QuoteEvaluationHeader.Insert;
            //Insert Lines
            RFPLines.Reset();
            RFPLines.SetRange("Quote No", RFPNO);
            RFPLines.DeleteAll();
            BiddersSelect.Reset();
            BiddersSelect.SetRange("Reference No.", RFPNO);
            if BiddersSelect.Find('-') then begin
                repeat
                    TotalScore := 0;
                    TotalPassMark := 0;
                    //Check Score and above pass mark to suggested = true
                    SupEval.Reset();
                    SupEval.SetRange("Quote No", RFPNO);
                    If SupEval.Findfirst() then begin
                        // repeat
                        // Send suppliers who have passed the pass mark
                        ScoreSetup.Reset();
                        ScoreSetup.SetRange("Procurement Ref No.", RFPNO);
                        ScoreSetup.SetRange(Active, true);
                        If ScoreSetup.FindFirst() then begin
                            If ScoreSetup."Score Criteria" = ScoreSetup."Score Criteria"::Score then begin
                                SuppScore.Reset();
                                SuppScore.SetRange("Document No.", SupEval."No.");
                                if SuppScore.FindFirst() then begin
                                    SuppScore.CalcFields("Total Score");
                                    TotalScore := SuppScore."Total Score";
                                    // SuppScore.CalcFields("Total Passmark");
                                    TotalPassMark := ScoreSetup."RFP Passmark";
                                    // Award highest combined score of (technical and financial)
                                    // TotalTechnicalScore := TotalScore * PurchSetup."Technical Percentage" / 100;
                                    If TotalScore >= TotalPassMark then begin
                                        ProcurementRequestLine.Reset;
                                        ProcurementRequestLine.SetRange("Tender No.", RFPNO);
                                        ProcurementRequestLine.SetRange("Response No", BiddersSelect."Supplier");
                                        if ProcurementRequestLine.Find('-') then begin
                                            repeat
                                                PPSetup.Get;
                                                QuoteEvaluation.Init;
                                                QuoteEvaluation."Quote No" := RFPNO;
                                                QuoteEvaluation."Vendor No" := BiddersSelect."Supplier";
                                                QuoteEvaluation.Validate("Vendor No");
                                                QuoteEvaluation.Type := ProcurementRequestLine.Type;
                                                QuoteEvaluation."No." := ProcurementRequestLine.No;
                                                QuoteEvaluation.Description := ProcurementRequestLine.Description;
                                                QuoteEvaluation."Unit of Measure" := ProcurementRequestLine."Unit of Measure";
                                                QuoteEvaluation.Quantity := ProcurementRequestLine.Quantity;
                                                QuoteEvaluation."Unit Amount" := ProcurementRequestLine."Unit Price";
                                                QuoteEvaluation.Amount := ProcurementRequestLine.Amount;
                                                QuoteEvaluation."Line No" := ProcurementRequestLine."Line No";
                                                QuoteEvaluation."Shortcut Dimension 1 Code" := ProcurementRequestLine."Shortcut Dimension 1 Code";
                                                QuoteEvaluation.Validate("Shortcut Dimension 1 Code");
                                                QuoteEvaluation."Shortcut Dimension 2 Code" := ProcurementRequestLine."Shortcut Dimension 2 Code";
                                                QuoteEvaluation.Validate("Shortcut Dimension 2 Code");
                                                QuoteEvaluation.Committed := ProcurementRequestLine.Committed;
                                                QuoteEvaluation."Procurement Plan" := ProcurementRequestLine."Procurement Plan";
                                                QuoteEvaluation."Procurement Plan Item" := ProcurementRequestLine."Procurement Plan Item";
                                                QuoteEvaluation."Budget Line" := ProcurementRequestLine."Budget Line";
                                                QuoteEvaluation."Request Date" := ProcurementRequestLine."Request Date";
                                                QuoteEvaluation."Expected Receipt Date" := ProcurementRequestLine."Expected Receipt Date";
                                                QuoteEvaluation."Requisition No" := ProcurementRequest."Requisition No";
                                                QuoteEvaluation."VAT Prod. Posting Group" := ProcurementRequestLine."VAT Prod. Posting Group";
                                                QuoteEvaluation."VAT %" := ProcurementRequestLine."VAT %";
                                                QuoteEvaluation."Amount Inclusive VAT" := ProcurementRequestLine."Amount Inclusive VAT";
                                                if ProcurementRequest.Get(RFPNO) then QuoteEvaluation.Title := ProcurementRequest.Title;
                                                if not QuoteEvaluation.Get(RFPNO, ProspectiveList."Vendor No", ProcurementRequestLine.No) then QuoteEvaluation.Insert;
                                            // Message('%1,%2,%3', TotalScore, TotalPassMark, BiddersSelect."Supplier Name");
                                            until ProcurementRequestLine.Next() = 0;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                        // until SupEval.Next() = 0;
                    end;
                until BiddersSelect.Next() = 0;
                Message('RFP Evaluation generated successfully');
                //Archive the quotation
                ProcurementRequest.Status := ProcurementRequest.Status::Archived;
                ProcurementRequest.Modify;
            end;
        end;
    end;

    procedure CreateRFQ(var IR: Record "Internal Request Header")
    var
        IRHeader: Record "Internal Request Header";
        IRLine: Record "Internal Request Line";
        IRLine2: Record "Internal Request Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        DocNo: Code[20];
        Committement: Codeunit Committment;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
    begin
        IRLine.Reset;
        IRLine.SetRange("Document No.", IR."No.");
        IRLine.SetFilter("Qty. to Receive", '>%1', 0);
        if IRLine.Find('-') then begin
            PurchSetup.Get;
            DocNo := NoseriesMgt.GetNextNo(PurchSetup."RFQ Nos.", 0D, true);
            IRHeader.Init;
            IRHeader.TransferFields(IR);
            IRHeader."No." := DocNo;
            IRHeader."Document Type" := IR."Document Type"::RFQ;
            IRHeader."Requisition No." := IR."No.";
            IRHeader.Insert;
            repeat //insert lines
                IRLine2.Init;
                IRLine2.TransferFields(IRLine);
                IRLine2."Document No." := DocNo;
                IRLine2."No." := IRLine2."Charge to No.";
                IRLine.Type := IRLine2.Type2;
                IRLine2."Document Type" := IRLine."Document Type"::RFQ;
                IRLine2.Validate(Quantity, IRLine."Qty. to Receive");
                IRLine2."Requisition No." := IR."No.";
                IRLine2.Insert;
            until IRLine.Next = 0;
            IR."Fully Ordered" := true;
            IR.Modify;
            Message('RFQ %1 has been successfully created', DocNo);
        end;
    end;

    procedure CreateRFQEvaluation(var SupplierSelection: Record "Bidders Selection")
    var
        PreQualifiedList: Record "Prospective Suppliers";
        ProcurementRequestLine: Record "Prospective Tender Line";
        QuoteEvaluation: Record "Quote Evaluation";
        PPSetup: Record "Purchases & Payables Setup";
        QuoteEvaluationHeader: Record "Quote Evaluation Header";
        ProcurementRequest: Record "Procurement Request";
    begin
        //Create a supplier from the list of Pre-Qualified Suppliers
        if SupplierSelection.Invited then begin
            PreQualifiedList.Reset;
            PreQualifiedList.SetRange("No.", SupplierSelection."Supplier Code");
            //PreQualifiedList.SETRANGE(PreQualifiedList.Category,SupplierSelection."Supplier Category");
            if PreQualifiedList.Find('-') then begin
                /* if PreQualifiedList."Vendor No" = '' then
                    if Confirm('The system will create Vendor %1 Do you want to continue?', true, SupplierSelection."Supplier Name") then begin
                        PreQualifiedList.CreateVendr(PreQualifiedList);
                    end; */
                //Insert Header
                if ProcurementRequest.Get(SupplierSelection."Reference No.") then begin
                    QuoteEvaluationHeader.Init;
                    QuoteEvaluationHeader."Quote No" := ProcurementRequest."No.";
                    QuoteEvaluationHeader.Title := ProcurementRequest.Title;
                    QuoteEvaluationHeader."Requisition No" := ProcurementRequest."Requisition No";
                    QuoteEvaluationHeader."Creation Date" := Today;
                    QuoteEvaluationHeader."Shortcut Dimension 1 Code" := ProcurementRequest."Shortcut Dimension 1 Code";
                    QuoteEvaluationHeader."Shortcut Dimension 2 Code" := ProcurementRequest."Shortcut Dimension 2 Code";
                    QuoteEvaluationHeader."Dimension Set ID" := ProcurementRequest."Dimension Set ID";
                    // QuoteEvaluationHeader."Ref No." := ProcurementRequest."Ref No.";
                    if not QuoteEvaluationHeader.Get(ProcurementRequest."No.") then QuoteEvaluationHeader.Insert;
                end;
                //Insert Lines
                ProcurementRequestLine.Reset;
                ProcurementRequestLine.SetRange(ProcurementRequestLine."Tender No.", SupplierSelection."Reference No.");
                ProcurementRequestLine.SetRange(ProcurementRequestLine."Response No", SupplierSelection."Supplier Code");
                if ProcurementRequestLine.FindFirst then begin
                    repeat
                        PPSetup.Get;
                        QuoteEvaluation.Init;
                        QuoteEvaluation."Quote No" := SupplierSelection."Reference No.";
                        //QuoteEvaluation."Vendor No" := PreQualifiedList."Vendor No";
                        QuoteEvaluation."Vendor No" := PreQualifiedList."No.";
                        QuoteEvaluation.Validate(QuoteEvaluation."Vendor No");
                        QuoteEvaluation.Type := ProcurementRequestLine.Type;
                        QuoteEvaluation."No." := ProcurementRequestLine.No;
                        QuoteEvaluation.Description := ProcurementRequestLine.Description;
                        QuoteEvaluation."Unit of Measure" := ProcurementRequestLine."Unit of Measure";
                        QuoteEvaluation.Quantity := ProcurementRequestLine.Quantity;
                        QuoteEvaluation."Unit Amount" := ProcurementRequestLine."Unit Price";
                        QuoteEvaluation.Amount := ProcurementRequestLine.Amount;
                        QuoteEvaluation."Line No" := ProcurementRequestLine."Line No";
                        QuoteEvaluation."Shortcut Dimension 1 Code" := ProcurementRequestLine."Shortcut Dimension 1 Code";
                        QuoteEvaluation.Validate("Shortcut Dimension 1 Code");
                        QuoteEvaluation."Shortcut Dimension 2 Code" := ProcurementRequestLine."Shortcut Dimension 2 Code";
                        QuoteEvaluation.Validate("Shortcut Dimension 2 Code");
                        QuoteEvaluation.Committed := ProcurementRequestLine.Committed;
                        QuoteEvaluation."Procurement Plan" := ProcurementRequestLine."Procurement Plan";
                        QuoteEvaluation."Procurement Plan Item" := ProcurementRequestLine."Procurement Plan Item";
                        QuoteEvaluation."Budget Line" := ProcurementRequestLine."Budget Line";
                        QuoteEvaluation."Request Date" := ProcurementRequestLine."Request Date";
                        QuoteEvaluation."Expected Receipt Date" := ProcurementRequestLine."Expected Receipt Date";
                        QuoteEvaluation."Requisition No" := ProcurementRequest."Requisition No";
                        QuoteEvaluation."VAT Prod. Posting Group" := ProcurementRequestLine."VAT Prod. Posting Group";
                        QuoteEvaluation."VAT %" := ProcurementRequestLine."VAT %";
                        QuoteEvaluation."Amount Inclusive VAT" := ProcurementRequestLine."Amount Inclusive VAT";
                        if ProcurementRequest.Get(SupplierSelection."Reference No.") then QuoteEvaluation.Title := ProcurementRequest.Title;
                        if not QuoteEvaluation.Get(SupplierSelection."Reference No.", PreQualifiedList."Vendor No", ProcurementRequestLine.No) then QuoteEvaluation.Insert;
                    until ProcurementRequestLine.Next = 0;
                end;
                Message('Quote Evaluation generated successfully');
            end;
            //Archive the quotation
            if ProcurementRequest.Get(SupplierSelection."Reference No.") then ProcurementRequest.Status := ProcurementRequest.Status::Archived;
            ProcurementRequest.Modify;
            //MESSAGE(FORMAT('The Quation Has Been Created'));
        end;
    end;

    procedure CreateRFQFromSelected()
    var
        IRHeader: Record "Internal Request Header";
        IRLine: Record "Internal Request Line";
        IRLine2: Record "Internal Request Line";
        ReqLine: Record "Internal Request Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        DocNo: Code[20];
        Committement: Codeunit Committment;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        LineNo: Integer;
        IRHeader2: Record "Internal Request Header";
    begin
        IRLine.Reset;
        IRLine.SetRange("Document Type", IRLine."Document Type"::Purchase);
        IRLine.SetRange("Header Status", IRLine."Header Status"::Released);
        IRLine.SetRange(Selected, true);
        IRLine.SetRange("RFQ Created", false);
        IRLine.SetRange("Selected By", UserId);
        IRLine.SetRange(Reversed, false);
        if IRLine.Find('-') then begin
            LineNo := 0;
            PurchSetup.Get;
            PurchSetup.TestField("RFQ Nos.");
            DocNo := NoseriesMgt.GetNextNo(PurchSetup."RFQ Nos.", 0D, true);
            IRHeader.Init;
            //IRHeader.TRANSFERFIELDS(IR);
            IRHeader."No." := DocNo;
            IRHeader."Document Type" := IRHeader."Document Type"::RFQ;
            IRHeader."Document Date" := Today;
            IRHeader."Order Date" := Today;
            IRHeader."Expected Receipt Date" := Today;
            IRHeader."Posting Description" := 'GPR' + ' ' + DocNo;
            IRHeader."Requested By" := UserId;
            //IRHeader."Requisition No.":="No.";
            IRHeader.Insert;
            repeat
                LineNo := LineNo + 10000;
                //insert lines
                IRLine2.Init;
                IRLine2.TransferFields(IRLine);
                IRLine2."Document No." := DocNo;
                IRLine2."No." := IRLine2."Charge to No.";
                IRLine2.Type := IRLine2.Type2;
                IRLine2."Line No." := LineNo;
                IRLine2."Document Type" := IRLine."Document Type"::RFQ;
                //IRLine2.VALIDATE(Quantity,IRLine."Qty. to Receive");
                IRLine2."Requisition No." := IRLine."Document No.";
                IRLine2.Insert;
                Commit;
                //Modify selected records as rfq created
                IRLine."RFQ Created" := true;
                IRLine."RFQ No" := DocNo;
                IRLine.Modify;
                //Check if all lines are selected so as to archive Requisition
                if IRHeader2.Get(IRLine."Document No.") then begin
                    IRHeader2.Archived := true;
                    IRHeader.Modify;
                    ReqLine.Reset;
                    ReqLine.SetRange("Document No.", IRHeader2."No.");
                    ReqLine.SetRange(Selected, false);
                    if not ReqLine.Find('-') then
                        IRHeader2."GPR Created For All Lines" := true
                    else
                        IRHeader2."GPR Created For All Lines" := false;
                    IRHeader2.Modify;
                end;
            until IRLine.Next = 0;
            Message('GPR %1 has been successfully created', DocNo);
        end
        else
            Message('You have not selected any items');
    end;

    procedure GetFirstVendor(IR: Record "Internal Request Header") Vendor: Code[30]
    var
        IRLine: Record "Internal Request Line";
    begin
        IRLine.Reset;
        IRLine.SetRange("Document No.", IR."No.");
        IRLine.SetRange("Document Type", IR."Document Type");
        if IRLine.FindFirst then begin
            Vendor := IRLine.Supplier;
        end;
    end;

    procedure GetInspectionDecision(PuchLine: Record "Purchase Line")
    var
        InspectionLines: Record "Inspection Lines";
        InspectionLines2: Record "Inspection Lines";
        PuchHeader: Record "Purchase Header";
        NoOfLines: Integer;
        LinesWithDecision: Integer;
        Accepted: Integer;
    begin
        repeat
            InspectionLines.SetRange("Order No", PuchLine."Document No.");
            InspectionLines.SetRange("Item No", PuchLine."No.");
            NoOfLines := InspectionLines.Count;
            InspectionLines.SetFilter(InspectionLines."Inspection Decision", '<>%1', InspectionLines."Inspection Decision"::" ");
            if InspectionLines.Find('-') then begin
                LinesWithDecision := InspectionLines.Count;
                if LinesWithDecision = NoOfLines then begin
                    InspectionLines.SetRange("Inspection Decision", InspectionLines."Inspection Decision"::Accept);
                    if InspectionLines.Find('-') then begin
                        Accepted := InspectionLines.Count;
                        if LinesWithDecision = Accepted then
                            PuchLine."Inspection Decisions" := PuchLine."Inspection Decisions"::Accept
                        else begin
                            PuchLine."Inspection Decisions" := PuchLine."Inspection Decisions"::Reject;
                            PuchLine."Qty. to Receive" := 0;
                        end;
                        PuchLine.Modify();
                    end;
                end;
            end;
        until PuchLine.Next() = 0;
    end;

    procedure SubmitInspectionDecision(InspHeder: Record "Inspection Header")
    var
        InspectionLines: Record "Inspection Lines";
        InspectionLines2: Record "Inspection Lines";
        PuchHeader: Record "Purchase Header";
        PurchLines: Record "Purchase Line";
        PurchLines2: Record "Purchase Line";
        NoOfLines: Integer;
        NoRejected: Integer;
    begin
        InspectionLines.Reset();
        InspectionLines.SetRange("Inspection No", InspHeder."Inspection No");
        if InspectionLines.Find('-') then
            repeat
                PurchLines.Reset();
                PurchLines.SetRange("Document No.", InspectionLines."Order No");
                PurchLines.SetRange("No.", InspectionLines."Item No");
                if PurchLines.FindFirst() then begin
                    if InspectionLines."Inspection Decision" = InspectionLines."Inspection Decision"::Accept then begin
                        PurchLines."Inspection Decisions" := PurchLines."Inspection Decisions"::Accept;
                        PurchLines."Qty. to Receive" := InspectionLines."Quantity Received";
                        PurchLines."Qty. to Invoice" := InspectionLines."Quantity Received";
                        PurchLines.Modify();
                    end;
                    if InspectionLines."Inspection Decision" = InspectionLines."Inspection Decision"::Reject then begin
                        PurchLines."Inspection Decisions" := PurchLines."Inspection Decisions"::Reject;
                        PurchLines."Qty. to Receive" := 0;
                        PurchLines."Qty. to Invoice" := 0;
                        PurchLines.Modify();
                    end;
                end;
            until InspectionLines.Next() = 0;
        PurchLines2.Reset();
        PurchLines2.SetRange("Document No.", InspHeder."Order No");
        NoOfLines := PurchLines2.Count;
        PurchLines2.Reset();
        PurchLines2.SetRange("Document No.", InspHeder."Order No");
        PurchLines2.SetRange("Inspection Decisions", PurchLines2."Inspection Decisions"::Reject);
        NoRejected := PurchLines2.Count;
        if NoOfLines = NoRejected then begin
            PuchHeader.Reset();
            PuchHeader.SetRange("No.", InspHeder."Order No");
            if PuchHeader.FindFirst() then begin
                PuchHeader.Archived := true;
                PuchHeader.Modify();
            end;
        end;
    end;

    procedure GetOpenEvaluationPeriod(): Code[20]
    var
        EvalPeriod: Record "Vendor Evaluation Periods";
    begin
        EvalPeriod.Reset;
        EvalPeriod.SetRange(Active, true);
        if EvalPeriod.FindFirst then
            exit(EvalPeriod.Code)
        else
            Error('Please define an active vendor evaluation period');
    end;

    procedure GetPreliminaryEvaluationDecision(QuoteNo: Code[20])
    var
        EvalHeader: Record "Supplier Evaluation Header";
        EvalLines: Record "Supplier Evaluation Document";
        EvalLines2: Record "Supplier Evaluation Document";
        Mandatory: Integer;
        Submitted: Integer;
        Passed: Integer;
        Total: Integer;
        Text001: Label 'Not all the mandatory documents have been submitted, supplier No. %1 will be archived.';
    begin
        EvalHeader.Reset();
        EvalHeader.SetFilter("No.", '%1', QuoteNo);
        if EvalHeader.FindFirst() then begin
            EvalLines.Reset();
            EvalLines.SetFilter("Quote No.", '%1', EvalHeader."No.");
            EvalLines.SetFilter("Tender No.", '%1', EvalHeader."Quote No");
            EvalLines.SetRange(Mandatory, true);
            Total := EvalLines.Count;
            EvalLines2.Reset();
            EvalLines2.SetFilter("Quote No.", '%1', EvalHeader."No.");
            EvalLines2.SetFilter("Tender No.", '%1', EvalHeader."Quote No");
            EvalLines2.SetRange(Submitted, true);
            Passed := EvalLines2.Count;
            if Total = Passed then begin
                EvalHeader.Stage := EvalHeader.Stage::Technical;
                EvalHeader.Processed := true;
                EvalHeader.Status := EvalHeader.Status::New;
                EvalHeader.Modify();
                Message('Successfully submitted');
            end
            else begin
                if Confirm(Text001, false, EvalHeader."Supplier Code") then begin
                    EvalHeader.Processed := true;
                    EvalHeader.Stage := EvalHeader.Stage::Archived;
                    EvalHeader.Modify();
                    Message('Successfully archived');
                end;
            end;
        end;
        // EvalHeader2.Status := EvalHeader2.Status::Approved;
        // EvalHeader2.Modify();
        // commit;
        // EvalHeader.reset();
        // EvalHeader.SetRange("Quote No", EvalHeader2."Quote No");
        // EvalHeader.SetRange("Supplier code", EvalHeader2."Supplier Code");
        // Total := EvalHeader.Count;
        // Message('Total, %1', Total);
        // EvalHeader.SetRange(Status, EvalHeader.Status::Approved);
        // Approved := EvalHeader.Count;
        // Message('Total approved, %1', Approved);
        // if EvalHeader.Find('-') then begin
        //     if Approved = Total then begin
        //         EvalLines.SetRange("Supplier code", EvalHeader2."Supplier Code");
        //         EvalLines.SetRange("Tender No.", EvalHeader2."Quote No");
        //         EvalLines.SetRange(Mandatory, true);
        //         Mandatory := EvalLines.Count;
        //         Message('Total mandatory, %1', Mandatory);
        //         EvalLines.SetRange(Submitted, true);
        //         if EvalLines.Find('-') then begin
        //             Submitted := EvalLines.Count;
        //             Message('Total mandatory submitted, %1', Submitted);
        //             // if Submitted = Mandatory then
        //             //     repeat
        //             //         EvalHeader.Stage := EvalHeader.Stage::Technical;
        //             //         EvalHeader.Status := EvalHeader.Status::New;
        //             //         EvalHeader.Modify();
        //             //     until EvalHeader.Next() = 0
        //             // else
        //             //     repeat
        //             //         EvalHeader.Stage := EvalHeader.Stage::Archived;
        //             //         EvalHeader.Modify();
        //             //     until EvalHeader.Next() = 0;
        //         end;
        //     end;
        // end;
    end;

    procedure GetTechnicalEvaluationDecision(var EvalHeader2: Record "Supplier Evaluation Header")
    var
        EvalHeader: Record "Supplier Evaluation Header";
        EvalLines: Record "Supplier Evaluation Score Line";
        Submitted: Integer;
        Passed: Integer;
        Approved: Integer;
        Passmark: Integer;
        Total: Integer;
    begin
        EvalHeader2.Status := EvalHeader2.Status::Approved;
        EvalHeader2.Modify();
        commit;
        EvalHeader.reset();
        EvalHeader.SetRange("Quote No", EvalHeader2."Quote No");
        EvalHeader.SetRange("Supplier code", EvalHeader2."Supplier Code");
        Total := EvalHeader.Count;
        //Message('Total, %1', Total);
        EvalHeader.SetRange(Status, EvalHeader.Status::Approved);
        Approved := EvalHeader.Count;
        // Message('Total approved, %1', Approved);
        if EvalHeader.Find('-') then begin
            if Approved = Total then begin
                EvalLines.SetRange("Supplier code", EvalHeader2."Supplier Code");
                EvalLines.SetRange("Document No.", EvalHeader2."Quote No");
                EvalLines.SetFilter(Passmark, '>%1', 0);
                if EvalLines.Find('-') then begin
                    Passmark := EvalLines.Count;
                    //Message('Total mandatory, %1', Mandatory);
                    EvalLines.SetFilter(Score, '>=%1', EvalLines.Passmark);
                    if EvalLines.Find('-') then begin
                        Passed := EvalLines.Count;
                        //Message('Total mandatory submitted, %1', Submitted);
                        if Passed = Passmark then
                            repeat
                                EvalHeader.Stage := EvalHeader.Stage::Prices;
                                EvalHeader.Modify();
                            until EvalHeader.Next() = 0
                        else
                            repeat
                                EvalHeader.Stage := EvalHeader.Stage::Archived;
                                EvalHeader.Modify();
                            until EvalHeader.Next() = 0;
                    end;
                end;
            end;
        end;
    end;

    procedure IndentTenderAmounts(DocNo: Code[20]; Type: integer)
    var
        TenderAmountLines: Record "Tender Amount";
        Window: Dialog;
        AccNo: array[10] of Code[20];
        i: Integer;
        EndTotalMissingBeginTotalErr: Label 'End-Total %1 is missing a matching Begin-Total.';
    begin
        //Window.OPEN(Text004);
        TenderAmountLines.SetRange("Tender No.", DocNo);
        if TenderAmountLines.Find('-') then
            repeat //Window.UPDATE(1,"Line No");
                case TenderAmountLines."Scope Type" of
                    TenderAmountLines."Scope Type"::"Objective Heading", TenderAmountLines."Scope Type"::"Objective Heading End":
                        i := 0;
                    TenderAmountLines."Scope Type"::"Sub-Heading", TenderAmountLines."Scope Type"::"Sub-Heading End":
                        i := 1;
                    TenderAmountLines."Scope Type"::"Scope Parameter":
                        i := 2;
                end;
                if TenderAmountLines."Scope Type" = TenderAmountLines."Scope Type"::"Sub-Heading End" then begin
                    if i < 1 then Error(EndTotalMissingBeginTotalErr, TenderAmountLines."Line No.");
                    //i := i - 1;
                end;
                TenderAmountLines.Indentation := i;
                TenderAmountLines.Modify;
            /*IF "Scope Type" = "Scope Type"::"Sub-Heading" THEN BEGIN
              i := i + 1;
              AccNo[i] := FORMAT("Line No");
            END;*/
            until TenderAmountLines.Next = 0;
        //Window.CLOSE;
    end;

    procedure IndentTenderScopeOfWork(DocNo: Code[20]; Type: integer)
    var
        ScopeLines: Record "Tender Scope of Work";
        Window: Dialog;
        AccNo: array[10] of Code[20];
        i: Integer;
        EndTotalMissingBeginTotalErr: Label 'End-Total %1 is missing a matching Begin-Total.';
    begin
        //Window.OPEN(Text004);
        ScopeLines.SetRange("Tender No.", DocNo);
        if ScopeLines.Find('-') then
            repeat //Window.UPDATE(1,"Line No");
                case ScopeLines."Scope Type" of
                    ScopeLines."Scope Type"::"Objective Heading", ScopeLines."Scope Type"::"Objective Heading End":
                        i := 0;
                    ScopeLines."Scope Type"::"Sub-Heading", ScopeLines."Scope Type"::"Sub-Heading End":
                        i := 1;
                    ScopeLines."Scope Type"::"Scope Parameter":
                        i := 2;
                end;
                if ScopeLines."Scope Type" = ScopeLines."Scope Type"::"Sub-Heading End" then begin
                    if i < 1 then Error(EndTotalMissingBeginTotalErr, ScopeLines."Line No.");
                    //i := i - 1;
                end;
                ScopeLines.Indentation := i;
                ScopeLines.Modify;
            /*IF "Scope Type" = "Scope Type"::"Sub-Heading" THEN BEGIN
              i := i + 1;
              AccNo[i] := FORMAT("Line No");
            END;*/
            until ScopeLines.Next = 0;
        //Window.CLOSE;
    end;

    procedure MakeSalesQuote(var FADisposal: Record "FA Disposal")
    var
        DisposalLine: Record "Procurement Request Lines";
        QuoteHeader: Record "Procurement Request";
        IRLine2: Record "Internal Request Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        DocNo: Code[20];
        Committement: Codeunit Committment;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        HeaderCreated: Boolean;
        LineNo: Integer;
        CustNo: Code[20];
        Prospectives: Record "Prospective Customers";
        UserSetup: Record "User Setup";
        ProcMgmt: Codeunit "Procurement Management";
        SalesHeader: Record "Sales Header";
        SalesLines: Record "Sales Line";
        FA: Record "Fixed Asset";
    begin
        PurchSetup.Get;
        DisposalLine.Reset;
        DisposalLine.SetRange("FA Disposal Doc No.", FADisposal."No.");
        DisposalLine.SetRange(Awarded, true);
        if DisposalLine.Find('-') then begin
            QuoteHeader.Reset();
            QuoteHeader.SetRange("No.", DisposalLine."Requisition No");
            if QuoteHeader.FindFirst() then begin
                if QuoteHeader."Customer Type" = QuoteHeader."Customer Type"::Existing then CustNo := QuoteHeader."Customer No.";
                if QuoteHeader."Customer Type" = QuoteHeader."Customer Type"::Staff then begin
                    UserSetup.reset();
                    UserSetup.SetRange("Employee No.", QuoteHeader."Employee No.");
                    if UserSetup.FindFirst() then begin
                        UserSetup.TestField("Customer No.");
                        CustNo := UserSetup."Customer No.";
                    end;
                end;
                if QuoteHeader."Customer Type" = QuoteHeader."Customer Type"::New then begin
                    Prospectives.reset();
                    Prospectives.SetRange("No.", QuoteHeader."Prospect No");
                    if Prospectives.FindFirst() then begin
                        if Prospectives."Customer No" <> '' then CustNo := Prospectives."Customer No";
                        if Prospectives."Customer No" = '' then begin
                            ProcMgmt.CreateCustomer(Prospectives);
                            CustNo := Prospectives."Customer No";
                        end;
                    end;
                end;
                SalesHeader.Init();
                SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
                SalesHeader."Sell-to Customer No." := CustNo;
                SalesHeader.Validate("Sell-to Customer No.");
                SalesHeader."Document Date" := Today;
                SalesHeader.Insert(true);
                repeat
                    SalesLines.init();
                    SalesLines."Document No." := SalesHeader."No.";
                    SalesLines."Document Type" := SalesLines."Document Type"::Quote;
                    SalesLines.Type := DisposalLine.Type;
                    SalesLines."No." := DisposalLine.No;
                    SalesLines.Amount := DisposalLine.Amount;
                    SalesLines."VAT Prod. Posting Group" := DisposalLine."VAT Prod. Posting Group";
                    SalesLines.Quantity := DisposalLine.Quantity;
                    SalesLines."Line Amount" := DisposalLine."Unit Price";
                    SalesLines.Insert();
                    FA.Reset();
                    FA.SetRange("No.", DisposalLine.No);
                    if FA.FindFirst() then begin
                        FA.Disposed := true;
                        FA.Modify();
                    end;
                until DisposalLine.Next() = 0;
                FADisposal."Quote generated" := true;
                FADisposal.Modify();
                Message('Sales quote No. %1 has been created', SalesHeader."No.");
            end;
        end;
    end;

    procedure MakeOrder(var IR: Record "Internal Request Header")
    var
        IRLine: Record "Internal Request Line";
        IRLine2: Record "Internal Request Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        DocNo: Code[20];
        Committement: Codeunit Committment;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        HeaderCreated: Boolean;
        LineNo: Integer;
    begin
        PurchSetup.Get;
        IRLine.Reset;
        IRLine.SetRange("Document No.", IR."No.");
        IRLine.SetRange(LPO, true);
        IRLine.SetRange("Document Created", IRLine."Document Created"::" ");
        //IRLine.SETFILTER("Qty. to Receive",'>%1',0);
        if IRLine.Find('-') then begin
            repeat
                IRLine2.Reset;
                IRLine2.SetRange("Document No.", IR."No.");
                IRLine2.SetRange(IRLine2.Supplier, IRLine.Supplier);
                if IRLine2.Find('-') then begin
                    //IF "Combine Order"=TRUE THEN BEGIN
                    DocNo := NoseriesMgt.GetNextNo(PurchSetup."Order Nos.", 0D, true);
                    PurchHeader.Init;
                    //PurchHeader.TransferFields(IR);
                    PurchHeader.Validate("No.");
                    PurchHeader."No." := DocNo;
                    PurchHeader.Replenishment := false;
                    PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
                    PurchHeader.Status := PurchHeader.Status::Open;
                    IRLine2.TestField(Supplier);
                    PurchHeader.InitRecord;
                    PurchHeader."Buy-from Vendor No." := IRLine2.Supplier;
                    PurchHeader.Validate("Buy-from Vendor No.");
                    PurchHeader."Pay-to Vendor No." := IRLine2.Supplier;
                    PurchHeader."Document Date" := Today;
                    PurchHeader."Posting Date" := Today;
                    PurchHeader."Assigned User ID" := UserId;
                    PurchHeader."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                    PurchHeader."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                    PurchHeader."Dimension Set ID" := IR."Dimension Set ID";
                    PurchHeader."Document Date" := Today;
                    PurchHeader."Requisition No." := IR."No.";
                    PurchHeader.Insert;
                    repeat
                        LineNo := LineNo + 10000;
                        //insert lines
                        PurchLine.Init;
                        PurchLine.TransferFields(IRLine2);
                        PurchLine."Line No." := LineNo;
                        PurchLine.Type := IRLine2.Type2;
                        PurchLine."No." := IRLine2."Charge to No.";
                        PurchLine."Document No." := DocNo;
                        PurchLine."Document Type" := PurchLine."Document Type"::Order;
                        PurchLine."Buy-from Vendor No." := IRLine2.Supplier;
                        PurchLine."Pay-to Vendor No." := IRLine2.Supplier;
                        PurchLine."Unit of Measure" := IRLine2."Unit of Measure";
                        PurchLine."Quantity Received" := 0;
                        PurchLine.Validate(Quantity, IRLine2.Quantity);
                        PurchLine."Direct Unit Cost" := IRLine2."Unit Cost";
                        PurchLine."VAT %" := IRLine2."VAT %";
                        PurchLine.Validate("Unit Cost");
                        PurchLine.Amount := IRLine2.Amount;
                        PurchLine.Validate(Amount);
                        PurchLine."Requisition No." := IR."No.";
                        // PurchLine."General expense Codes" := IRLine2."General Expense Code";
                        IRLine2.CalcFields(Specification2);
                        PurchLine.Specification2 := IRLine2.Specification2;
                        PurchLine.Insert;
                        Committement.UncommitPurchReq(IRLine2, IR);
                        Committement.EncumberPO(PurchLine, PurchHeader);
                        // IRLine2."Quantity Received" := IRLine2."Quantity Received" + IRLine2."Qty. to Receive";
                        // IRLine2."Qty. to Receive" := IRLine2.Quantity - IRLine2."Quantity Received";
                        IRLine2."Document Created" := IRLine2."Document Created"::LPO;
                        IRLine2.Modify;
                    until IRLine2.Next = 0;
                    Message('LPO No %1 has been created', DocNo);
                end;
            until IRLine.Next = 0;
            IRLine.Reset;
            IRLine.SetRange("Document No.", IR."No.");
            IRLine.SetRange(LPO, true);
            IRLine.SetRange("Document Created", IRLine."Document Created"::" ");
            if IRLine.Count = 0 then begin
                IR."Fully Ordered" := true; //Mark fully ordered when all LPOs have been created
                IR.Modify;
            end;
        end
        else
            Message('All purchase request lines have been fulfilled');
        /*
            END ELSE IF "Combine Order"=FALSE THEN
              BEGIN
                DocNo:=NoseriesMgt.GetNextNo(PurchSetup."Order Nos.",0D,TRUE);
                PurchHeader.INIT;
                PurchHeader.TRANSFERFIELDS(IR);
                PurchHeader.VALIDATE("No.");
                PurchHeader."No.":=DocNo;
                PurchHeader."Document Type":=PurchHeader."Document Type"::Order;
                PurchHeader.Status:=PurchHeader.Status::Open;
                PurchHeader."Buy-from Vendor No.":=IRLine.Supplier;
                PurchHeader.VALIDATE("Buy-from Vendor No.");
                PurchHeader."Document Date":=TODAY;
                PurchHeader."Requisition No.":="No.";
                PurchHeader.INSERT;
              PurchSetup.GET;
              //insert lines
              PurchLine.INIT;
              PurchLine.TRANSFERFIELDS(IRLine);
              PurchLine."Document No.":=DocNo;
              PurchLine."Document Type":=PurchLine."Document Type"::Order;
              PurchLine."Quantity Received":=0;
              PurchLine.VALIDATE(Quantity,IRLine."Qty. to Receive");
              PurchLine."Requisition No.":="No.";
              PurchLine."Gen. Bus. Posting Group":='GENERAL';
              PurchLine."Gen. Prod. Posting Group":='GENERAL';
        //      PurchLine."VAT Bus. Posting Group":="VAT Bus. Posting Group";
              PurchLine.INSERT;
              Committement.UncommitPurchReq(IRLine,IR);
              Committement.EncumberPO(PurchLine,PurchHeader);
              IRLine."Quantity Received":=IRLine."Quantity Received"+IRLine."Qty. to Receive";
              IRLine."Qty. to Receive":=IRLine.Quantity-IRLine."Quantity Received";
              IRLine.MODIFY;
              MESSAGE('Order No %1 has been created',DocNo);
              END;
            END;*/
        ////IF CheckifFullyordered(IR)=TRUE THEN
    end;

    procedure MakeOrderFromEOI(var IR: Record "EOI Evaluation Header")
    var
        LineNo: Integer;
        IRLine: Record "EOI Evaluation Line";
        IRLine2: Record "EOI Evaluation Line";
        InternalReq: Record "Internal Request Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        DocNo: Code[20];
        Committement: Codeunit Committment;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
    begin
        PurchSetup.Get;
        PurchSetup.TestField("Def VAT Bus. Posting Group");
        PurchSetup.TestField("Def VAT Prod. Posting Group");
        IRLine.Reset;
        IRLine.SetRange(IRLine."Quote No", IR."Quote No");
        IRLine.SetRange(IRLine.Awarded, true);
        IRLine.SetFilter(IRLine.Quantity, '>%1', 0);
        if IRLine.Find('-') then begin
            repeat
                IRLine2.Reset;
                IRLine2.SetRange(IRLine2."Quote No", IRLine."Quote No");
                IRLine2.SetRange(IRLine2.Awarded, IRLine.Awarded);
                IRLine2.SetRange(IRLine2."Vendor No", IRLine."Vendor No");
                if IRLine2.Find('-') then begin
                    //REPEAT
                    DocNo := NoseriesMgt.GetNextNo(PurchSetup."Order Nos.", 0D, true);
                    PurchHeader.Init;
                    PurchHeader.Validate("No.");
                    PurchHeader."No." := DocNo;
                    PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
                    PurchHeader."No. Printed" := 0;
                    PurchHeader."Procurement Method" := 'EOI';
                    PurchHeader."Tender/Quotation ref no" := IR."Quote No";
                    PurchHeader.Status := PurchHeader.Status::Open;
                    PurchHeader.InitRecord;
                    PurchHeader."Buy-from Vendor No." := IRLine2."Vendor No";
                    PurchHeader.Validate("Buy-from Vendor No.");
                    PurchHeader."Document Date" := Today;
                    PurchHeader."Requisition No." := IR."Requisition No";
                    PurchHeader."Posting Date" := Today;
                    PurchHeader."Order Date" := GetQuoteDate(IRLine2."Quote No");
                    PurchHeader."Due Date" := GetQuoteDueDate(IRLine2."Quote No");
                    PurchHeader."Assigned User ID" := UserId;
                    PurchHeader."Document Date" := IR."Creation Date";
                    PurchHeader."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                    PurchHeader."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                    PurchHeader."Dimension Set ID" := IR."Dimension Set ID";
                    PurchHeader.Insert;
                    repeat //insert lines
                        LineNo := LineNo + 1000;
                        PurchLine.Init;
                        PurchLine."Document No." := DocNo;
                        PurchLine."Line No." := LineNo;
                        PurchLine."Document Type" := PurchLine."Document Type"::Order;
                        PurchLine.Type := IRLine2.Type;
                        PurchLine.Validate(Type);
                        PurchLine."No." := IRLine2."No.";
                        PurchLine.Validate("No.");
                        InternalReq.Reset();
                        InternalReq.SetRange("Document No.", IRLine."Requisition No");
                        InternalReq.SetRange("No.", IRLine2."No.");
                        if InternalReq.FindFirst() then begin
                            InternalReq.CalcFields(Specification2);
                            PurchLine.Specification2 := InternalReq.Specification2;
                        end;
                        PurchLine."Unit of Measure" := IRLine2."Unit of Measure";
                        PurchLine.Validate(Quantity, IRLine2.Quantity);
                        PurchLine."Quantity Received" := 0;
                        PurchLine."VAT Prod. Posting Group" := PurchSetup."Def VAT Prod. Posting Group";
                        PurchLine."VAT Bus. Posting Group" := PurchSetup."Def VAT Bus. Posting Group";
                        PurchLine.Validate("VAT Prod. Posting Group");
                        PurchLine."Direct Unit Cost" := IRLine2."Unit Amount";
                        PurchLine.Validate("Direct Unit Cost");
                        PurchLine."Requisition No." := IR."Requisition No";
                        PurchLine."Expected Receipt Date" := IRLine2."Expected Receipt Date";
                        PurchLine."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                        PurchLine."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                        PurchLine."Dimension Set ID" := IR."Dimension Set ID";
                        PurchLine.Insert;
                        Committement.UncommitPurchReqOnQuote(IR."Quote No", IR."Requisition No");
                        Committement.EncumberPO(PurchLine, PurchHeader);
                        IRLine2."Quantity Received" := IRLine2."Quantity Received" + IRLine.Quantity;
                        IRLine2.Quantity := IRLine2.Quantity - IRLine2."Quantity Received";
                        IRLine2.Modify;
                    until IRLine2.Next = 0;
                end;
                Message('Order No %1 has been created', DocNo);
            until IRLine.Next = 0;
        end;
    end;

    procedure MakeOrderFromQuote(var IR: Record "Quote Evaluation Header")
    var
        LineNo: Integer;
        IRLine: Record "Quote Evaluation";
        IRLine2: Record "Quote Evaluation";
        PurchHeader: Record "Purchase Header";
        InternalReq: Record "Internal Request Line";
        PurchLine: Record "Purchase Line";
        DocNo: Code[20];
        Committement: Codeunit Committment;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
    begin
        PurchSetup.Get;
        PurchSetup.TestField("Def VAT Bus. Posting Group");
        PurchSetup.TestField("Def VAT Prod. Posting Group");
        IRLine.Reset;
        IRLine.SetRange(IRLine."Quote No", IR."Quote No");
        IRLine.SetRange(IRLine.Awarded, true);
        IRLine.SetFilter(IRLine.Quantity, '>%1', 0);
        if IRLine.Find('-') then begin
            repeat
                IRLine2.Reset;
                IRLine2.SetRange(IRLine2."Quote No", IRLine."Quote No");
                IRLine2.SetRange(IRLine2.Awarded, IRLine.Awarded);
                IRLine2.SetRange("Quote Generated", false);
                IRLine2.SetFilter(IRLine2.Quantity, '>%1', 0);
                IRLine2.SetRange(IRLine2."Vendor No", IRLine."Vendor No");
                if IRLine2.Find('-') then begin
                    //REPEAT
                    DocNo := NoseriesMgt.GetNextNo(PurchSetup."Order Nos.", 0D, true);
                    PurchHeader.Init;
                    PurchHeader.Validate("No.");
                    PurchHeader."No." := DocNo;
                    PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
                    PurchHeader."No. Printed" := 0;
                    PurchHeader."Procurement Method" := 'RFQ';
                    PurchHeader."Tender/Quotation ref no" := IR."Quote No";
                    PurchHeader.Status := PurchHeader.Status::Open;
                    PurchHeader.InitRecord;
                    PurchHeader."Buy-from Vendor No." := IRLine2."Vendor No";
                    PurchHeader.Validate("Buy-from Vendor No.");
                    PurchHeader."Document Date" := Today;
                    PurchHeader."Requisition No." := IR."Requisition No";
                    PurchHeader."Posting Date" := Today;
                    PurchHeader."Order Date" := GetQuoteDate(IRLine2."Quote No");
                    PurchHeader."Due Date" := GetQuoteDueDate(IRLine2."Quote No");
                    PurchHeader."Assigned User ID" := UserId;
                    PurchHeader."Document Date" := IR."Creation Date";
                    PurchHeader."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                    PurchHeader."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                    PurchHeader."Prices Including VAT" := true;
                    PurchHeader."Dimension Set ID" := IR."Dimension Set ID";
                    PurchHeader.Insert;
                    repeat //insert lines
                        LineNo := LineNo + 1000;
                        PurchLine.Init;
                        PurchLine."Document No." := DocNo;
                        PurchLine."Line No." := LineNo;
                        PurchLine."Document Type" := PurchLine."Document Type"::Order;
                        PurchLine.Type := IRLine2.Type;
                        PurchLine.Validate(Type);
                        PurchLine."No." := IRLine2."No.";
                        PurchLine.Validate("No.");
                        InternalReq.Reset();
                        InternalReq.SetRange("Document No.", IRLine."Requisition No");
                        InternalReq.SetRange("No.", IRLine2."No.");
                        if InternalReq.FindFirst() then begin
                            InternalReq.CalcFields(Specification2);
                            PurchLine.Specification2 := InternalReq.Specification2;
                        end;
                        PurchLine."Unit of Measure" := IRLine2."Unit of Measure";
                        PurchLine.Validate(Quantity, IRLine2.Quantity);
                        PurchLine."Quantity Received" := 0;
                        PurchLine."VAT Prod. Posting Group" := PurchSetup."Def VAT Prod. Posting Group";
                        PurchLine."VAT Bus. Posting Group" := PurchSetup."Def VAT Bus. Posting Group";
                        PurchLine.Validate("VAT Prod. Posting Group");
                        PurchLine."Direct Unit Cost" := IRLine2."Unit Amount";
                        PurchLine.Validate("Direct Unit Cost");
                        // PurchLine.Validate(Amount);
                        PurchLine."Requisition No." := IR."Requisition No";
                        PurchLine."Expected Receipt Date" := IRLine2."Expected Receipt Date";
                        PurchLine."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                        PurchLine."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                        PurchLine."Dimension Set ID" := IR."Dimension Set ID";
                        PurchLine.Insert;
                        Committement.UncommitPurchReqOnQuote(IR."Quote No", IR."Requisition No");
                        Committement.EncumberPO(PurchLine, PurchHeader);
                        IRLine2."Quantity Received" := IRLine2."Quantity Received" + IRLine.Quantity;
                        IRLine2.Quantity := IRLine2.Quantity - IRLine2."Quantity Received";
                        IRLine2."Quote Generated" := true;
                        IRLine2.Modify;
                    until IRLine2.Next = 0;
                end;
                Message('Order No %1 has been created', DocNo);
            until IRLine.Next = 0;
            IR."Quote Generated" := true;
            IR.modify();
        end;
    end;

    procedure MakeOrderFromRFP(var IR: Record "RFP Evaluation Header")
    var
        LineNo: Integer;
        IRLine: Record "RFP Evaluation Line";
        IRLine2: Record "RFP Evaluation Line";
        PurchHeader: Record "Purchase Header";
        InternalReq: Record "Internal Request Line";
        PurchLine: Record "Purchase Line";
        DocNo: Code[20];
        Committement: Codeunit Committment;
        ProspectiveSuppliers: Record "Prospective Suppliers";
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        VendNo: Code[50];
    begin
        PurchSetup.Get;
        PurchSetup.TestField("Def VAT Bus. Posting Group");
        PurchSetup.TestField("Def VAT Prod. Posting Group");
        IRLine.Reset;
        IRLine.SetRange(IRLine."Quote No", IR."Quote No");
        IRLine.SetRange(IRLine.Awarded, true);
        IRLine.SetFilter(IRLine.Quantity, '>%1', 0);
        if IRLine.Find('-') then begin
            if ProspectiveSuppliers.Get(IRLine."Vendor No") then begin
                if ProspectiveSuppliers."Vendor No" = '' then
                    VendNo := ProspectiveSuppliers.CreateVendr(ProspectiveSuppliers)
                else
                    VendNo := ProspectiveSuppliers."Vendor No";
            end;
            repeat
                IRLine2.Reset;
                IRLine2.SetRange(IRLine2."Quote No", IRLine."Quote No");
                IRLine2.SetRange(IRLine2.Awarded, IRLine.Awarded);
                IRLine2.SetRange(IRLine2."Vendor No", IRLine."Vendor No");
                if IRLine2.Find('-') then begin
                    //REPEAT
                    DocNo := NoseriesMgt.GetNextNo(PurchSetup."Order Nos.", 0D, true);
                    PurchHeader.Init;
                    PurchHeader.Validate("No.");
                    PurchHeader."No." := DocNo;
                    PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
                    PurchHeader."No. Printed" := 0;
                    PurchHeader."Procurement Method" := 'RFP';
                    PurchHeader."Tender/Quotation ref no" := IR."Quote No";
                    PurchHeader.Status := PurchHeader.Status::Open;
                    PurchHeader.InitRecord;
                    IRLine2.CalcFields("Supplier Code");
                    PurchHeader."Buy-from Vendor No." := VendNo;
                    PurchHeader.Validate("Buy-from Vendor No.");
                    PurchHeader."Document Date" := Today;
                    PurchHeader."Requisition No." := IR."Requisition No";
                    PurchHeader."Posting Date" := Today;
                    PurchHeader."Order Date" := GetQuoteDate(IRLine2."Quote No");
                    PurchHeader."Due Date" := GetQuoteDueDate(IRLine2."Quote No");
                    PurchHeader."Assigned User ID" := UserId;
                    PurchHeader."Document Date" := IR."Creation Date";
                    PurchHeader."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                    PurchHeader."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                    PurchHeader."Dimension Set ID" := IR."Dimension Set ID";
                    PurchHeader.Insert;
                    repeat //insert lines
                        LineNo := LineNo + 1000;
                        PurchLine.Init;
                        PurchLine."Document No." := DocNo;
                        PurchLine."Line No." := LineNo;
                        PurchLine."Document Type" := PurchLine."Document Type"::Order;
                        PurchLine.Type := IRLine2.Type;
                        PurchLine.Validate(Type);
                        PurchLine."No." := IRLine2."No.";
                        PurchLine.Validate("No.");
                        InternalReq.Reset();
                        InternalReq.SetRange("Document No.", IRLine."Requisition No");
                        InternalReq.SetRange("No.", IRLine2."No.");
                        if InternalReq.FindFirst() then begin
                            InternalReq.CalcFields(Specification2);
                            PurchLine.Specification2 := InternalReq.Specification2;
                        end;
                        PurchLine."Unit of Measure" := IRLine2."Unit of Measure";
                        PurchLine.Validate(Quantity, IRLine2.Quantity);
                        PurchLine."Quantity Received" := 0;
                        PurchLine."VAT Prod. Posting Group" := PurchSetup."Def VAT Prod. Posting Group";
                        PurchLine."VAT Bus. Posting Group" := PurchSetup."Def VAT Bus. Posting Group";
                        PurchLine.Validate("VAT Prod. Posting Group");
                        PurchLine."Direct Unit Cost" := IRLine2."Unit Amount";
                        PurchLine.Validate("Direct Unit Cost");
                        PurchLine."Requisition No." := IR."Requisition No";
                        PurchLine."Expected Receipt Date" := IRLine2."Expected Receipt Date";
                        PurchLine."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                        PurchLine."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                        PurchLine."Dimension Set ID" := IR."Dimension Set ID";
                        PurchLine.Insert;
                        Committement.UncommitPurchReqOnQuote(IR."Quote No", IR."Requisition No");
                        Committement.EncumberPO(PurchLine, PurchHeader);
                        IRLine2."Quantity Received" := IRLine2."Quantity Received" + IRLine.Quantity;
                        IRLine2.Quantity := IRLine2.Quantity - IRLine2."Quantity Received";
                        IRLine2.Modify;
                    until IRLine2.Next = 0;
                end;
                Message('Order No %1 has been created', DocNo);
            until IRLine.Next = 0;
            IR."RFP Generated" := true;
            IR.modify();
        end;
    end;

    procedure MakeOrderFromSelected(IRHeader: Record "Internal Request Header"; IRSelected: Boolean)
    var
        DocNo: Code[30];
        Committement: Codeunit Committment;
        LineNo: Integer;
        IRLine: Record "Internal Request Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
    begin
        IRHeader.Reset;
        IRHeader.SetRange(Selected, IRSelected);
        if IRHeader.Find('-') then begin
            PurchSetup.Get;
            DocNo := NoseriesMgt.GetNextNo(PurchSetup."Order Nos.", 0D, true);
            PurchHeader.Init;
            PurchHeader.TransferFields(IRHeader);
            PurchHeader.Validate("No.");
            PurchHeader."No." := DocNo;
            PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
            PurchHeader.Status := PurchHeader.Status::Open;
            PurchHeader."Buy-from Vendor No." := GetFirstVendor(IRHeader);
            PurchHeader.Validate("Buy-from Vendor No.");
            PurchHeader."Document Date" := Today;
            PurchHeader.Insert;
            repeat
                IRLine.Reset;
                IRLine.SetRange("Document No.", IRHeader."No.");
                IRLine.SetFilter("Qty. to Receive", '>%1', 0);
                if IRLine.Find('-') then begin
                    repeat
                        LineNo := LineNo + 10000;
                        PurchLine.Init;
                        PurchLine.TransferFields(IRLine);
                        PurchLine."Document No." := DocNo;
                        PurchLine."Document Type" := PurchLine."Document Type"::Order;
                        PurchLine."Line No." := LineNo;
                        PurchLine."Quantity Received" := 0;
                        PurchLine.Validate(Quantity, IRLine."Qty. to Receive");
                        PurchLine."Gen. Bus. Posting Group" := 'GENERAL';
                        PurchLine."Gen. Prod. Posting Group" := 'GENERAL';
                        PurchLine."VAT Bus. Posting Group" := 'GENERAL';
                        PurchLine."Requisition No." := IRHeader."No.";
                        PurchLine.Insert;
                        Committement.UncommitPurchReq(IRLine, IRHeader);
                        Committement.EncumberPO(PurchLine, PurchHeader);
                        IRLine."Quantity Received" := IRLine."Quantity Received" + IRLine."Qty. to Receive";
                        IRLine."Qty. to Receive" := IRLine.Quantity - IRLine."Quantity Received";
                        IRLine.Modify;
                    until IRLine.Next = 0;
                end;
                if CheckifFullyordered(IRHeader) = true then begin
                    IRHeader."Fully Ordered" := true;
                    IRHeader.Selected := false;
                    IRHeader.Modify;
                end;
            until IRHeader.Next = 0;
            Message('Order No %1 has been created', DocNo);
        end;
    end;

    procedure MakeOrderFromTender(var IR: Record "Procurement Request")
    var
        LineNo: Integer;
        IRLine: Record "Tender Evaluation Line";
        IRLine2: Record "Tender Evaluation Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        InternalReq: Record "Internal Request Line";
        DocNo: Code[20];
        Committement: Codeunit Committment;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        ProspectiveSuppliers: Record "Prospective Suppliers";
        SupplierSelection: Record "Bidders Selection";
        VendNo: Code[50];
    begin
        PurchSetup.Get;
        PurchSetup.TestField("Def VAT Bus. Posting Group");
        PurchSetup.TestField("Def VAT Prod. Posting Group");
        IRLine.Reset;
        IRLine.SetRange(IRLine."Quote No", IR."No.");
        IRLine.SetRange(Awarded, true);
        IRLine.SetFilter(Quantity, '>%1', 0);
        if IRLine.FindFirst() then begin
            //Get Vendor No.
            if ProspectiveSuppliers.Get(IRLine."Vendor No") then begin
                if ProspectiveSuppliers."Vendor No" = '' then //VendNo := ProspectiveSuppliers.CreateVendr(ProspectiveSuppliers)
                    Error('Please create a related vendor for prospective supplier %1.', ProspectiveSuppliers."No.")
                else
                    VendNo := ProspectiveSuppliers."Vendor No";
            end;
        end;
        repeat
            IRLine2.Reset;
            IRLine2.SetRange(IRLine2."Quote No", IRLine."Quote No");
            IRLine2.SetRange(IRLine2.Awarded, true);
            IRLine2.SetFilter(IRLine2."Vendor No", '%1', VendNo);
            if IRLine2.Find('-') then begin
                DocNo := NoseriesMgt.GetNextNo(PurchSetup."Order Nos.", 0D, true);
                PurchHeader.Init;
                PurchHeader.Validate("No.");
                PurchHeader."No." := DocNo;
                PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
                PurchHeader."No. Printed" := 0;
                PurchHeader."Quote No." := IR."No.";
                PurchHeader.Status := PurchHeader.Status::Open;
                PurchHeader.InitRecord;
                PurchHeader."Buy-from Vendor No." := VendNo;
                PurchHeader."Procurement Method" := 'Tender';
                PurchHeader.Validate("Buy-from Vendor No.");
                PurchHeader."Document Date" := Today;
                PurchHeader."Requisition No." := IR."Requisition No";
                PurchHeader."Prices Including VAT" := true;
                PurchHeader."Posting Date" := Today;
                PurchHeader."Tender/Quotation ref no" := IRLine2."Quote No";
                PurchHeader."Order Date" := GetQuoteDate(IRLine2."Quote No");
                PurchHeader."Due Date" := GetQuoteDueDate(IRLine2."Quote No");
                PurchHeader."Assigned User ID" := UserId;
                PurchHeader."Document Date" := IR."Creation Date";
                PurchHeader."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                PurchHeader."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                PurchHeader."Dimension Set ID" := IR."Dimension Set ID";
                PurchHeader.Insert;
                repeat //insert lines
                    LineNo := LineNo + 1000;
                    PurchLine.Init;
                    PurchLine."Document No." := DocNo;
                    PurchLine."Line No." := LineNo;
                    PurchLine."Document Type" := PurchLine."Document Type"::Order;
                    PurchLine.Type := IRLine2.Type;
                    PurchLine.Validate(Type);
                    PurchLine."No." := IRLine2."No.";
                    PurchLine.Validate("No.");
                    InternalReq.Reset();
                    InternalReq.SetRange("Document No.", IRLine."Quote No");
                    InternalReq.SetRange("No.", IRLine2."No.");
                    if InternalReq.FindFirst() then begin
                        InternalReq.CalcFields(Specification2);
                        PurchLine.Specification2 := InternalReq.Specification2;
                    end;
                    PurchLine."Unit of Measure" := IRLine2."Unit of Measure";
                    PurchLine."Quantity Received" := 0;
                    PurchLine.Validate(Quantity, IRLine2.Quantity);
                    PurchLine."VAT Prod. Posting Group" := PurchSetup."Def VAT Prod. Posting Group";
                    PurchLine."VAT Bus. Posting Group" := PurchSetup."Def VAT Bus. Posting Group";
                    PurchLine.Validate("VAT Prod. Posting Group");
                    PurchLine."Direct Unit Cost" := IRLine2."Unit Amount";
                    PurchLine.Validate("Direct Unit Cost");
                    PurchLine."Requisition No." := IR."Requisition No";
                    PurchLine."Expected Receipt Date" := IRLine2."Expected Receipt Date";
                    PurchLine."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                    PurchLine."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                    PurchLine."Dimension Set ID" := IR."Dimension Set ID";
                    PurchLine.Insert;
                    Committement.UncommitPurchReqOnQuote(IR."No.", IR."Requisition No");
                    Committement.EncumberPO(PurchLine, PurchHeader);
                //IRLine2."Quantity Received" := IRLine2."Quantity Received" + IRLine.Quantity;
                //IRLine2.Quantity := IRLine2.Quantity - IRLine2."Quantity Received";
                //IRLine2.Modify;
                until IRLine2.Next = 0;
            end;
            Message('Order No %1 has been created', DocNo);
        until IRLine.Next = 0;
    end;
    //Quotation
    procedure MakeOrderFromQuote(var IR: Record "Procurement Request")
    var
        LineNo: Integer;
        IRLine: Record "Tender Evaluation Line";
        IRLine2: Record "Tender Evaluation Line";
        TenderEvalsLine: Record "Tender Evaluation Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        InternalReq: Record "Internal Request Line";
        DocNo: Code[20];
        Committement: Codeunit Committment;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        ProspectiveSuppliers: Record "Prospective Suppliers";
        SupplierSelection: Record "Bidders Selection";
        VendNo: Code[50];
        SuppTender: Record "Prospective Supplier Tender";
        InStrm: InStream;
        SpecificationBigTxt: BigText;
        SpecificationTxt: Text;
        ProspTenderLine: Record "Prospective Tender Line";
        GRNo: Code[50];
    begin
        PurchSetup.Get;
        PurchSetup.TestField("Def VAT Bus. Posting Group");
        PurchSetup.TestField("Def VAT Prod. Posting Group");
        PurchSetup.TestField("Default Vendor Posting Group");
        PurchSetup.TestField("Def Gen. Bus. Posting Group");
        PurchSetup.TestField("Def Gen. Prod Posting");
        PurchSetup.TestField("GRN Nos");
        SuppTender.Reset();
        SuppTender.SetFilter("Passed Financial", '%1', true);
        SuppTender.SetRange("Tender No.", IR."No.");
        if SuppTender.FindSet() then begin
            repeat
                IRLine.Reset;
                IRLine.SetRange(IRLine."Quote No", IR."No.");
                IRLine.SetRange(IRLine."Vendor No", SuppTender."Prospect No.");
                IRLine.SetRange(Awarded, true);
                IRLine.SetFilter(Quantity, '>%1', 0);
                if IRLine.FindFirst() then begin
                    if ProspectiveSuppliers.Get(IRLine."Vendor No") then begin
                        if ProspectiveSuppliers."Vendor No" = '' then
                            Error('Please create a related vendor for prospective supplier %1.', ProspectiveSuppliers."No.")
                        else
                            VendNo := ProspectiveSuppliers."Vendor No";
                    end;
                    //Message(VendNo);
                    IRLine2.Reset;
                    IRLine2.SetRange(IRLine2."Quote No", IR."No.");
                    IRLine2.SetRange(IRLine2.Awarded, true);
                    IRLine2.SetFilter(IRLine2."Vendor No", '%1', IRLine."Vendor No");
                    if IRLine2.Find('-') then begin
                        DocNo := NoseriesMgt.GetNextNo(PurchSetup."Order Nos.", 0D, true);
                        GRNo := NoseriesMgt.GetNextNo(PurchSetup."GRN Nos", 0D, true);
                        PurchHeader.Init;
                        PurchHeader.Validate("No.");
                        PurchHeader."No." := DocNo;
                        PurchHeader."GRN Nos" := GRNo;
                        PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
                        PurchHeader."No. Printed" := 0;
                        PurchHeader."Quote No." := IR."No.";
                        PurchHeader.Status := PurchHeader.Status::Open;
                        PurchHeader.InitRecord;
                        PurchHeader."Buy-from Vendor No." := VendNo;
                        PurchHeader."Procurement Method" := 'RFQ';
                        PurchHeader.Validate("Buy-from Vendor No.");
                        PurchHeader."Document Date" := Today;
                        PurchHeader."Requisition No." := IR."Requisition No";
                        PurchHeader."Prices Including VAT" := true;
                        PurchHeader."Posting Date" := Today;
                        PurchHeader."Tender/Quotation ref no" := IRLine2."Quote No";
                        PurchHeader."Order Date" := GetQuoteDate(IRLine2."Quote No");
                        PurchHeader."Due Date" := GetQuoteDueDate(IRLine2."Quote No");
                        PurchHeader."Assigned User ID" := UserId;
                        PurchHeader."Document Date" := IR."Creation Date";
                        PurchHeader."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                        PurchHeader."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                        PurchHeader."Dimension Set ID" := IR."Dimension Set ID";
                        //Adding Missing Fields in the Purchase Order:
                        PurchHeader."Buy-from Vendor Name" := IRLine2."Vendor Name";
                        PurchHeader."Pay-to Vendor No." := VendNo;
                        PurchHeader."Pay-to Name" := IRLine2."Vendor Name";
                        PurchHeader."Vendor Posting Group" := PurchSetup."Default Vendor Posting Group";
                        PurchHeader."Gen. Bus. Posting Group" := PurchSetup."Def Gen. Bus. Posting Group";
                        PurchHeader."VAT Bus. Posting Group" := PurchSetup."Def VAT Bus. Posting Group";
                        PurchHeader."Posting Description" := 'Order' + Format(DocNo);
                        PurchHeader.Insert;
                        repeat //insert lines
                            LineNo := LineNo + 1000;
                            PurchLine.Init;
                            PurchLine."Document No." := DocNo;
                            PurchLine."Line No." := LineNo;
                            PurchLine."Document Type" := PurchLine."Document Type"::Order;
                            PurchLine.Type := IRLine2.Type;
                            PurchLine.Validate(Type);
                            PurchLine."No." := IRLine2."No.";
                            PurchLine.Validate("No.");
                            //Reading the Blob Value in Specification field in Tender Evaluation Line:
                            TenderEvalsLine.Reset();
                            TenderEvalsLine.SetRange("Quote No", IRLine2."Quote No");
                            TenderEvalsLine.SetRange(TenderEvalsLine.Awarded, true);
                            TenderEvalsLine.SetFilter(TenderEvalsLine."Vendor No", '%1', IRLine2."Vendor No");
                            TenderEvalsLine.SetRange("Line No", IRLine2."Line No");
                            if TenderEvalsLine.FindFirst() then begin
                                TenderEvalsLine.CalcFields(Specification2);
                                TenderEvalsLine.Specification2.CreateInStream(InStrm);
                                SpecificationBigTxt.Read(InStrm);
                                SpecificationTxt := Format(SpecificationBigTxt);
                                PurchLine.Specifications := SpecificationTxt;
                            end;
                            PurchLine."Unit of Measure" := IRLine2."Unit of Measure";
                            //  PurchLine."Quantity Received" := 0;
                            //    PurchLine.Validate(Quantity, IRLine2.Quantity);
                            PurchLine."VAT Prod. Posting Group" := PurchSetup."Def VAT Prod. Posting Group";
                            PurchLine."VAT Bus. Posting Group" := PurchSetup."Def VAT Bus. Posting Group";
                            PurchLine.Validate("VAT Prod. Posting Group");
                            PurchLine."Direct Unit Cost" := IRLine2."Unit Amount";
                            PurchLine.Validate("Direct Unit Cost");
                            PurchLine."Requisition No." := IR."Requisition No";
                            //Inserting the Missing Fields:
                            PurchLine."Amount Including VAT" := IRLine2."Amount Inclusive VAT";
                            PurchLine."Expected Receipt Date" := IRLine2."Expected Receipt Date";
                            PurchLine."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                            PurchLine."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                            PurchLine."Dimension Set ID" := IR."Dimension Set ID";
                            //Adding Misssing Fields in Purchase Line:
                            PurchLine."Buy-from Vendor No." := VendNo;
                            PurchLine."Pay-to Vendor No." := VendNo;
                            PurchLine.Quantity := IRLine2.Quantity;
                            PurchLine."Gen. Bus. Posting Group" := PurchSetup."Def Gen. Bus. Posting Group";
                            PurchLine."Gen. Prod. Posting Group" := PurchSetup."Def Gen. Prod Posting";
                            PurchLine."Unit of Measure" := IRLine2."Unit of Measure";
                            PurchLine."Unit Cost" := IRLine2."Unit Amount";
                            PurchLine."Unit Cost (LCY)" := IRLine2."Unit Amount";
                            PurchLine.Amount := IRLine2.Amount;
                            PurchLine."Line Amount" := IRLine2.Amount;
                            PurchLine."Amount Including VAT" := IRLine2."Amount Inclusive VAT";
                            PurchLine."Outstanding Amount" := IRLine2.Amount;
                            PurchLine."Outstanding Amount (LCY)" := IRLine2.Amount;
                            PurchLine."Outstanding Amt. Ex. VAT (LCY)" := IRLine2.Amount;
                            PurchLine.Insert;
                            Committement.UncommitPurchReqOnQuote(IR."No.", IR."Requisition No");
                            Committement.EncumberPO(PurchLine, PurchHeader);
                        until IRLine2.Next = 0;
                    end;
                end;
                Message('Order No %1 has been created', DocNo);
            until SuppTender.Next() = 0;
        end;
    end;

    procedure MakeQuote(var IR: Record "Internal Request Header")
    var
        IRLine: Record "Internal Request Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        DocNo: Code[20];
        Committement: Codeunit Committment;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
    begin
        IRLine.Reset;
        IRLine.SetRange("Document No.", IR."No.");
        //IRLine.SETFILTER("Qty. to Receive",'>%1',0);
        if IRLine.Find('-') then begin
            PurchSetup.Get;
            if IR."Combine Order" then begin
                DocNo := NoseriesMgt.GetNextNo(PurchSetup."Quote Nos.", 0D, true);
                PurchHeader.Init;
                PurchHeader.TransferFields(IR);
                PurchHeader."Document Type" := PurchHeader."Document Type"::Quote;
                PurchHeader."No." := DocNo;
                PurchHeader.Status := PurchHeader.Status::Open;
                PurchHeader."Buy-from Vendor No." := IRLine.Supplier;
                PurchHeader.Validate("Buy-from Vendor No.");
                PurchHeader."Document Date" := Today;
                PurchHeader."Requisition No." := IR."No.";
                PurchHeader.Insert;
                repeat
                    PurchSetup.Get;
                    //insert lines
                    PurchLine.Init;
                    PurchLine.TransferFields(IRLine);
                    PurchLine."Document No." := DocNo;
                    PurchLine."Document Type" := PurchLine."Document Type"::Quote;
                    PurchLine."Quantity Received" := 0;
                    PurchLine.Validate(Quantity, IRLine."Qty. to Receive");
                    PurchLine."Requisition No." := IR."No.";
                    //      PurchLine."Gen. Bus. Posting Group":='GENERAL';
                    //      PurchLine."Gen. Prod. Posting Group":='GENERAL';
                    //      PurchLine."VAT Bus. Posting Group":='GENERAL';
                    //PurchLine.VALIDATE(Type);
                    //PurchLine.VALIDATE("No.");
                    PurchLine.Insert;
                    //      Committement.UncommitPurchReq(IRLine,IR);
                    //      Committement.EncumberPO(PurchLine,PurchHeader);
                    IRLine."Quantity Received" := IRLine."Quantity Received" + IRLine."Qty. to Receive";
                    IRLine."Qty. to Receive" := IRLine.Quantity - IRLine."Quantity Received";
                    //IRLine.MODIFY;
                    Message('Quote No %1 has been created', DocNo);
                until IRLine.Next = 0;
            end
            else if IR."Combine Order" = false then begin
                DocNo := NoseriesMgt.GetNextNo(PurchSetup."Quote Nos.", 0D, true);
                PurchHeader.Init;
                PurchHeader.TransferFields(IR);
                PurchHeader.Validate("No.");
                PurchHeader."No." := DocNo;
                PurchHeader."Document Type" := PurchHeader."Document Type"::Quote;
                PurchHeader.Status := PurchHeader.Status::Open;
                //PurchHeader."Buy-from Vendor No.":=IRLine.Supplier;
                //PurchHeader.VALIDATE("Buy-from Vendor No.");
                PurchHeader."Document Date" := Today;
                PurchHeader."Requisition No." := IR."No.";
                PurchHeader.Insert;
                PurchSetup.Get;
                //insert lines
                PurchLine.Init;
                PurchLine.TransferFields(IRLine);
                PurchLine.Validate(Type);
                PurchLine.Validate("No.");
                PurchLine."Document No." := DocNo;
                PurchLine."Document Type" := PurchLine."Document Type"::Quote;
                PurchLine."Quantity Received" := 0;
                PurchLine.Validate(Quantity, IRLine."Qty. to Receive");
                PurchLine."Requisition No." := IR."No.";
                //      PurchLine."Gen. Bus. Posting Group":='GENERAL';
                //      PurchLine."Gen. Prod. Posting Group":='GENERAL';
                //      PurchLine."VAT Bus. Posting Group":="VAT Bus. Posting Group";
                PurchLine.Insert;
                //      Committement.UncommitPurchReq(IRLine,IR);
                //      Committement.EncumberPO(PurchLine,PurchHeader);
                IRLine."Quantity Received" := IRLine."Quantity Received" + IRLine."Qty. to Receive";
                IRLine."Qty. to Receive" := IRLine.Quantity - IRLine."Quantity Received";
                //IRLine.MODIFY;
                Message('Quote No %1 has been created', DocNo);
            end;
        end;
        //    IF CheckifFullyordered(IR)=TRUE THEN
        //      IR."Fully Ordered":=TRUE;
        //      IR.MODIFY;
    end;

    procedure NotifyCommitteeMembers(DocNo: Code[20])
    var
        TenderCommittee: Record "Tender Committees";
        CommiteeMembers: Record "Commitee Member";
        CompanyInfo: Record "Company Information";
        RecallMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to inform you that you were appointed as a commitee member for %2 with reference number %3. The commitee appointment number is %4.<br><br>Kind regards,<br><br><Strong>Thank you<Strong></p>';
        OpeningCommitteeSubject: Text;
        TenderCommitteeSubject: Text;
        PurchSetup: Record "Purchases & Payables Setup";
        Instr: InStream;
        FilePath: Text;
        OpeningCommitteeRept: Report "Open Committee Report";
        EvaluationReport: Report "Evaluation Committee Report";
        EmployeeRec: Record Employee;
        FileMgt: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailScenario: Enum "Email Scenario";
        Recipient: Text;
        CommitteeType: Text;
        CommitteeMemberRec: Record "Commitee Member";
        tenderCommittees: Record "Tender Committees";
    begin
        Clear(OpeningCommitteeRept);
        Clear(EvaluationReport);
        Clear(CommitteeType);
        PurchSetup.Get();
        PurchSetup.TestField("Committee File Path");
        tenderCommittees.Reset();
        tenderCommittees.SetRange("Appointment No", DocNo);
        if tenderCommittees.FindFirst() then begin
            case tenderCommittees."Committee Type" of
                tenderCommittees."Committee Type"::Evaluation:
                    begin
                        Clear(Instr);
                        TenderCommittee.Reset();
                        TenderCommittee.SetRange("Appointment No", DocNo);
                        EvaluationReport.SetTableView(TenderCommittee);
                        CommitteeType := 'EVALUATION_';
                        FileName := CommitteeType + DocNo + ' Appointment Committee' + '.pdf';
                        FilePath := PurchSetup."Committee File Path" + '\' + FileName;
                        //EDDIE if not Exists(FilePath) then
                        //     EvaluationReport.SaveAsPdf(FilePath);
                        TenderCommitteeSubject := 'Appointment to the Evaluation committee for tender ' + tenderCommittees."Tender/Quotation No";
                        CommitteeMemberRec.Reset();
                        CommitteeMemberRec.SetRange("Appointment No", DocNo);
                        //CommitteeMemberRec.SetRange("Committee Type", CommitteeMemberRec."Committee Type"::Evaluation);
                        if CommitteeMemberRec.FindSet() then
                            repeat
                                Clear(Recipient);
                                EmployeeRec.Reset();
                                EmployeeRec.SetRange("No.", CommitteeMemberRec."Employee No");
                                if EmployeeRec.FindFirst() then begin
                                    EmployeeRec.TestField("Company E-Mail");
                                    Recipient := EmployeeRec."Company E-Mail";
                                end;
                                EmailMessage.Create(Recipient, TenderCommitteeSubject, StrSubstNo(RecallMsg, EmployeeRec."First Name", 'evaluation', CommitteeMemberRec."Tender No.", CommitteeMemberRec."Appointment No"), true);
                                //EDDIEFileMgt.BLOBImportFromServerFile(TempBlob, FilePath);
                                TempBlob.CreateInStream(Instr);
                                EmailMessage.AddAttachment(FileName, 'PDF', Instr);
                                Email.Send(EmailMessage, EmailScenario::Default);
                            until CommitteeMemberRec.Next() = 0;
                    end;
                tenderCommittees."Committee Type"::Opening:
                    begin
                        Clear(Instr);
                        TenderCommittee.Reset();
                        TenderCommittee.SetRange("Appointment No", DocNo);
                        OpeningCommitteeRept.SetTableView(TenderCommittee);
                        CommitteeType := 'OPENING_';
                        FileName := CommitteeType + DocNo + ' Appointment Committee' + '.pdf';
                        FilePath := PurchSetup."Committee File Path" + '\' + FileName;
                        // EDDIE if not Exists(FilePath) then
                        //     OpeningCommitteeRept.SaveAsPdf(FilePath);
                        OpeningCommitteeSubject := 'Appointment to the Opening Evaluation committee for tender ' + tenderCommittees."Tender/Quotation No";
                        CommitteeMemberRec.Reset();
                        CommitteeMemberRec.SetRange("Appointment No", DocNo);
                        //CommitteeMemberRec.SetRange("Committee Type", CommitteeMemberRec."Committee Type"::Evaluation);
                        if CommitteeMemberRec.FindSet() then
                            repeat
                                Clear(Recipient);
                                EmployeeRec.Reset();
                                EmployeeRec.SetRange("No.", CommitteeMemberRec."Employee No");
                                if EmployeeRec.FindFirst() then begin
                                    EmployeeRec.TestField("Company E-Mail");
                                    Recipient := EmployeeRec."Company E-Mail";
                                end;
                                EmailMessage.Create(Recipient, OpeningCommitteeSubject, StrSubstNo(RecallMsg, EmployeeRec."First Name", 'evaluation', CommitteeMemberRec."Tender No.", CommitteeMemberRec."Appointment No"), true);
                                //EDDIE FileMgt.BLOBImportFromServerFile(TempBlob, FilePath);
                                TempBlob.CreateInStream(Instr);
                                EmailMessage.AddAttachment(FileName, 'PDF', Instr);
                                Email.Send(EmailMessage, EmailScenario::Default);
                            until CommitteeMemberRec.Next() = 0;
                    end;
            end;
        end;
        Message('Email notifications have been sent to the committee members');
    end;

    procedure NotifyRFPSuppliers(RFPNo: Code[20])
    var
        //FileSystem: Automation BC;
        EmailBodyBigText: BigText;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        Instr: InStream;
        i: Integer;
        ProqRequest: Record "Procurement Request";
        PurchSetup: Record "Purchases & Payables Setup";
        SupplierSelection: Record "RFP Supplier Selection";
        SupplierSelection2: Record "RFP Supplier Selection";
        //SMTPSetup: Record "SMTP Mail Setup";
        RecordLink: Record "Record Link";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: list of [Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [Text];
        Attachment: Text;
        ErrorMsg: Text;
        SupplierMail: Text;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Please find attached Request For Proposal.</p><p style="font-family:Verdana,Arial;font-size:9pt">RFQ reference number is <b>%2</b>.</p><br>Please use this link to register as a Supplier: https://BPITeprocurement.agilebiz.co.ke <br>Kind Regards,<p>%3</p>';
        EmailBodyText: Text;
        AdditionalAttachments: array[10] of Text;
        AdditionalFilename: array[10] of Text;
        NoOfRecipients: Integer;
    begin
        CompanyInformation.Get;
        CompanyInformation.TestField(Name);
        CompanyInformation.TestField("E-Mail");
        PurchSetup.Get;
        PurchSetup.TestField("RFQ Path");
        /*Clear(FileSystem);
        if Create(FileSystem, false, true) then begin
            if not FileSystem.FolderExists(PurchSetup."RFQ Path") then
                FileSystem.CreateFolder(PurchSetup."RFQ Path");
        end;*/
        SenderName := CompanyInformation.Name;
        SenderAddress := CompanyInformation."E-Mail";
        if ProqRequest.Get(RFPNo) then begin
            if ProqRequest."Specify Body" then begin
                ProqRequest.TestField("E-Mail Subject");
                ProqRequest.TestField("E-Mail Body Text");
                Subject := ProqRequest."E-Mail Subject";
                ProqRequest.CalcFields("E-Mail Body Text");
                ProqRequest."E-Mail Body Text".CreateInStream(Instr);
                EmailBodyBigText.Read(Instr);
                EmailBodyText := Format(EmailBodyBigText);
            end
            else
                Subject := 'Request For Proposal-' + RFPNo;
            SupplierSelection.Reset;
            SupplierSelection.SetRange("Reference No.", RFPNo);
            SupplierSelection.SetRange(Invited, true);
            //SETRANGE(Notified,FALSE);
            if SupplierSelection.Find('-') then begin
                repeat //Mail
                    FileName := PurchSetup."RFQ Path" + RFPNo + '_' + SupplierSelection."Supplier Code" + '.pdf';
                    Receipient.Add(SupplierSelection."Supplier Email");
                    SupplierSelection2.Reset;
                    SupplierSelection2.SetRange(SupplierSelection2."Supplier Code", SupplierSelection."Supplier Code");
                    if SupplierSelection2.FindFirst then //EDDIEREPORT.SaveAsPdf(Report::RFP, FileName, SupplierSelection2);
                        if ProqRequest."Specify Body" then begin
                            Emailmessage.Create(Receipient, Subject, '', false);
                            Emailmessage.AppendToBody(EmailBodyText);
                        end
                        else begin
                            Emailmessage.Create(Receipient, Subject, '', true);
                            Emailmessage.AppendToBody(StrSubstNo(NewBody, SupplierSelection."Supplier Name", RFPNo, CompanyInformation.Name));
                        end;
                    Emailmessage.AddAttachment(FileName, Attachment, '');
                    //Add other attachments
                    RecordLink.Reset;
                    RecordLink.SetRange("Record ID", ProqRequest.RecordId);
                    if RecordLink.Find('-') then begin
                        i := 1;
                        repeat
                            AdditionalFilename[i] := RecordLink.URL1;
                            //Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i]),'';
                            Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i], '');
                            i := i + 1;
                        until RecordLink.Next = 0;
                    end;
                    NoOfRecipients := RecipientCC.Count;
                    if NoOfRecipients > 0 then //EDDIE SMTP.AddCC(RecipientCC);
                        EMAIL.Send(Emailmessage);
                    //Delete saved pdf after sending mail
                    //FileManagement.DeleteClientFile(FileName);
                    SupplierSelection.Notified := true;
                    SupplierSelection.Modify;
                until SupplierSelection.Next = 0;
                Message('Selected suppliers have been successfully notified');
            end;
        end;
    end;

    procedure NotifySuppliers(RFQNo: Code[20])
    var
        //FileSystem: Automation BC;
        EmailBodyBigText: BigText;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        Instr: InStream;
        i: Integer;
        ProqRequest: Record "Procurement Request";
        PurchSetup: Record "Purchases & Payables Setup";
        SupplierSelection: Record "Supplier Selection";
        SupplierSelection2: Record "Supplier Selection";
        // SMTPSetup: Record "SMTP Mail Setup";
        RecordLink: Record "Record Link";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: list of [Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [Text];
        Attachment: Text;
        ErrorMsg: Text;
        SupplierMail: Text;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Please find attached Request For Quotation. The RFQ document should be filled and be attached on the portal.</p><p style="font-family:Verdana,Arial;font-size:9pt">RFQ reference number is <b>%2</b>.</p><br>Please use this link to respond: https://eprocurement.BPIT.or.ke <br>Manual responses will not be considered.</br> <br>Kind Regards,<p>%3</p>';
        EmailBodyText: Text;
        AdditionalAttachments: array[10] of Text;
        AdditionalFilename: array[10] of Text;
        NoOfRecipients: Integer;
    begin
        CompanyInformation.Get;
        CompanyInformation.TestField(Name);
        CompanyInformation.TestField("E-Mail");
        PurchSetup.Get;
        PurchSetup.TestField("RFQ Path");
        SenderName := CompanyInformation.Name;
        SenderAddress := CompanyInformation."E-Mail";
        if ProqRequest.Get(RFQNo) then begin
            if ProqRequest."Specify Body" then begin
                ProqRequest.TestField("E-Mail Subject");
                ProqRequest.TestField("E-Mail Body Text");
                Subject := ProqRequest."E-Mail Subject";
                ProqRequest.CalcFields("E-Mail Body Text");
                ProqRequest."E-Mail Body Text".CreateInStream(Instr);
                EmailBodyBigText.Read(Instr);
                EmailBodyText := Format(EmailBodyBigText);
            end
            else
                Subject := 'Request For Quotation-' + RFQNo;
            SupplierSelection.Reset;
            SupplierSelection.SetRange("Reference No.", RFQNo);
            SupplierSelection.SetRange(Invited, true);
            //SETRANGE(Notified,FALSE);
            if SupplierSelection.Find('-') then begin
                repeat //Mail
                    FileName := PurchSetup."RFQ Path" + RFQNo + '_' + SupplierSelection."Supplier Code" + '.pdf';
                    Receipient.Add(SupplierSelection."Supplier Email");
                    SupplierSelection2.Reset;
                    SupplierSelection2.SetRange(SupplierSelection2."Supplier Code", SupplierSelection."Supplier Code");
                    SupplierSelection2.SetRange("Reference No.", RFQNo);
                    if SupplierSelection2.FindFirst then //EDDIE REPORT.SaveAsPdf(Report::RFQ, FileName, SupplierSelection2);
                        if ProqRequest."Specify Body" then begin
                            Emailmessage.Create(Receipient, Subject, '', false);
                            Emailmessage.AppendToBody(EmailBodyText);
                        end
                        else begin
                            Emailmessage.Create(Receipient, Subject, '', true);
                            Emailmessage.AppendToBody(StrSubstNo(NewBody, SupplierSelection."Supplier Name", RFQNo, CompanyInformation.Name));
                        end;
                    Emailmessage.AddAttachment(FileName, Attachment, '');
                    //Add other attachments
                    RecordLink.Reset;
                    RecordLink.SetRange("Record ID", ProqRequest.RecordId);
                    if RecordLink.Find('-') then begin
                        i := 1;
                        repeat
                            AdditionalFilename[i] := RecordLink.URL1;
                            //Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i]),'';
                            Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i], '');
                            i := i + 1;
                        until RecordLink.Next = 0;
                    end;
                    NoOfRecipients := RecipientCC.Count;
                    if NoOfRecipients > 0 then //EDDIE SMTP.AddCC(RecipientCC);
                        EMAIL.Send(Emailmessage);
                    //Delete saved pdf after sending mail
                    //FileManagement.DeleteClientFile(FileName);
                    SupplierSelection.Notified := true;
                    SupplierSelection.Modify;
                until SupplierSelection.Next = 0;
                Message('Selected suppliers have been successfully notified');
            end;
        end;
    end;

    procedure NotifyEOISuppliers(EOINO: Code[20])
    var
        //FileSystem: Automation BC;
        EmailBodyBigText: BigText;
        FileManagement: Codeunit "File Management";
        Emailmessage: Codeunit "Email Message";
        Instr: InStream;
        i: Integer;
        ProqRequest: Record "Procurement Request";
        PurchSetup: Record "Purchases & Payables Setup";
        SupplierSelection: Record "Supplier Selection";
        SupplierSelection2: Record "Supplier Selection";
        //SMTPSetup: Record "SMTP Mail Setup";
        RecordLink: Record "Record Link";
        SenderName: Text;
        SenderAddress: Text;
        Receipient: list of [Text];
        Subject: Text;
        FileName: Text;
        TimeNow: Text;
        RecipientCC: list of [Text];
        Attachment: Text;
        ErrorMsg: Text;
        SupplierMail: Text;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Please find attached Expression Of Interest.</p><p style="font-family:Verdana,Arial;font-size:9pt">EOI reference number is <b>%2</b>.</p><br>Please use this link to register as a Supplier: https://eprocurement.agilebiz.co.ke/ <br>Kind Regards,<p>%3</p>';
        EmailBodyText: Text;
        AdditionalAttachments: array[10] of Text;
        AdditionalFilename: array[10] of Text;
        NoOfRecipients: Integer;
    begin
        CompanyInformation.Get;
        CompanyInformation.TestField(Name);
        CompanyInformation.TestField("E-Mail");
        PurchSetup.Get;
        PurchSetup.TestField("RFQ Path");
        /*Clear(FileSystem);
        if Create(FileSystem, false, true) then begin
            if not FileSystem.FolderExists(PurchSetup."RFQ Path") then
                FileSystem.CreateFolder(PurchSetup."RFQ Path");
        end;*/
        SenderName := CompanyInformation.Name;
        SenderAddress := CompanyInformation."E-Mail";
        if ProqRequest.Get(EOINO) then begin
            if ProqRequest."Specify Body" then begin
                ProqRequest.TestField("E-Mail Subject");
                ProqRequest.TestField("E-Mail Body Text");
                Subject := ProqRequest."E-Mail Subject";
                ProqRequest.CalcFields("E-Mail Body Text");
                ProqRequest."E-Mail Body Text".CreateInStream(Instr);
                EmailBodyBigText.Read(Instr);
                EmailBodyText := Format(EmailBodyBigText);
            end
            else
                Subject := 'Request For Quotation-' + EOINO;
            SupplierSelection.Reset;
            SupplierSelection.SetRange("Reference No.", EOINO);
            SupplierSelection.SetRange(Invited, true);
            //SETRANGE(Notified,FALSE);
            if SupplierSelection.Find('-') then begin
                repeat //Mail
                    FileName := PurchSetup."RFQ Path" + EOINO + '_' + SupplierSelection."Supplier Code" + '.pdf';
                    Receipient.Add(SupplierSelection."Supplier Email");
                    SupplierSelection2.Reset;
                    SupplierSelection2.SetRange(SupplierSelection2."Supplier Code", SupplierSelection."Supplier Code");
                    if SupplierSelection2.FindFirst then //EDDIE REPORT.SaveAsPdf(Report::RFQ, FileName, SupplierSelection2);
                        if ProqRequest."Specify Body" then begin
                            Emailmessage.Create(Receipient, Subject, '', false);
                            Emailmessage.AppendToBody(EmailBodyText);
                        end
                        else begin
                            Emailmessage.Create(Receipient, Subject, '', true);
                            Emailmessage.AppendToBody(StrSubstNo(NewBody, SupplierSelection."Supplier Name", EOINO, CompanyInformation.Name));
                        end;
                    Emailmessage.AddAttachment(FileName, Attachment, '');
                    //Add other attachments
                    RecordLink.Reset;
                    RecordLink.SetRange("Record ID", ProqRequest.RecordId);
                    if RecordLink.Find('-') then begin
                        i := 1;
                        repeat
                            AdditionalFilename[i] := RecordLink.URL1;
                            //Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i], '');
                            Emailmessage.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i], '');
                            i := i + 1;
                        until RecordLink.Next = 0;
                    end;
                    NoOfRecipients := RecipientCC.Count;
                    if NoOfRecipients > 0 then //EDDIE Emailmessage.AddCC(RecipientCC);
                        EMAIL.Send(Emailmessage);
                    //Delete saved pdf after sending mail
                    //FileManagement.DeleteClientFile(FileName);
                    SupplierSelection.Notified := true;
                    SupplierSelection.Modify;
                until SupplierSelection.Next = 0;
                Message('Selected suppliers have been successfully notified');
            end;
        end;
    end;

    procedure PostInternalRequest(IR: Record "Internal Request Header")
    var
        ItemJnlLine: Record "Item Journal Line";
        "Line No": Integer;
        IRLine: Record "Internal Request Line";
        UserPosting: Record "User Posting Template";
        ItemLedgerEntry: Record "Item Ledger Entry";
        QuantitynotIssued: Decimal;
        TotalQuantitynotIssued: Decimal;
    begin
        // IF NOT UserPosting.GET(USERID) THEN
        //  ERROR(Text001);
        if IR."Applies-to Doc. Type" = IR."Applies-to Doc. Type"::Job then begin
            PostJobItem(IR);
        end
        else begin
            PostStockItem(IR);
        end;
    end;

    procedure PostJobItem(IR: Record "Internal Request Header")
    var
        JobJnlLine: Record "Job Journal Line";
        "Line No": Integer;
        IRLine: Record "Internal Request Line";
        UserPosting: Record "User Posting Template";
        JobLedgerEntry: Record "Job Ledger Entry";
        QuantitynotIssued: Decimal;
        TotalQuantitynotIssued: Decimal;
    begin
        UserPosting.Get(UserId);
        UserPosting.TestField("Job Journal Template");
        UserPosting.TestField("Job Journal Batch");
        JobJnlLine.Reset;
        JobJnlLine.SetRange("Journal Template Name", UserPosting."Job Journal Template");
        JobJnlLine.SetRange("Journal Batch Name", UserPosting."Job Journal Batch");
        JobJnlLine.DeleteAll;
        if JobJnlLine.FindLast then "Line No" := JobJnlLine."Line No." + 1000;
        IRLine.Reset;
        IRLine.SetRange("Document Type", IRLine."Document Type"::Stock);
        IRLine.SetRange("Document No.", IR."No.");
        if IRLine.Find('-') then
            repeat
                "Line No" := "Line No" + 1000;
                JobJnlLine.Init;
                JobJnlLine."Journal Template Name" := UserPosting."Job Journal Template";
                JobJnlLine.Validate("Journal Template Name");
                JobJnlLine."Journal Batch Name" := UserPosting."Job Journal Batch";
                JobJnlLine.Validate("Journal Batch Name");
                JobJnlLine."Document No." := IR."No.";
                JobJnlLine."Line No." := "Line No";
                JobJnlLine."Posting Date" := IR."Posting Date";
                JobJnlLine.Validate("Posting Date");
                JobJnlLine."Entry Type" := JobJnlLine."Entry Type"::Usage;
                JobJnlLine.Type := JobJnlLine.Type::Item;
                JobJnlLine."No." := IRLine."No.";
                JobJnlLine.Validate("No.");
                JobJnlLine.Quantity := IRLine."Qty. to Issue";
                JobJnlLine.Validate(Quantity);
                JobJnlLine.Description := IRLine.Description;
                JobJnlLine.Validate(Description);
                JobJnlLine."Shortcut Dimension 1 Code" := IRLine."Shortcut Dimension 1 Code";
                JobJnlLine.Validate("Shortcut Dimension 1 Code");
                JobJnlLine."Shortcut Dimension 2 Code" := IRLine."Shortcut Dimension 2 Code";
                JobJnlLine.Validate("Shortcut Dimension 2 Code");
                JobJnlLine.ValidateShortcutDimCode(3, IRLine."Shortcut Dimension 3 Code");
                if IRLine."Qty. to Issue" > 0 then JobJnlLine.Insert(true);
                QuantitynotIssued := IRLine.Quantity - (IRLine."Qty. to Issue" + IRLine."Quantity Issued");
                TotalQuantitynotIssued += IRLine.Quantity - (IRLine."Qty. to Issue" + IRLine."Quantity Issued");
                if QuantitynotIssued < 0 then Error(Text002, IRLine."No.");
            until IRLine.Next = 0;
        JobJnlLine.Reset;
        JobJnlLine.SetRange("Journal Template Name", UserPosting."Job Journal Template");
        JobJnlLine.SetRange("Journal Batch Name", UserPosting."Job Journal Batch");
        JobJnlLine.SetRange("Document No.", IR."No.");
        CODEUNIT.Run(CODEUNIT::"Job Jnl.-Post", JobJnlLine);
        JobLedgerEntry.Reset;
        JobLedgerEntry.SetRange("Document No.", IR."No.");
        JobLedgerEntry.SetRange("Posting Date", IR."Posting Date");
        if JobLedgerEntry.FindSet then begin
            if TotalQuantitynotIssued <= 0 then begin
                IR.Posted := true;
                IR."Completely Received" := true;
            end
            else
                IR."Partially Posted" := true;
            IR."Doc. No. Occurrence" := IR."Doc. No. Occurrence" + 1;
            IR."Date Posted" := Today;
            IR."Time Posted" := Time;
            IR."Posted By" := UserId;
            if IR.Modify(true) then begin
                IRLine.Reset;
                IRLine.SetRange("Document No.", IR."No.");
                if IRLine.FindSet then begin
                    IRLine."Quantity Issued" := IRLine."Qty. to Issue";
                    IRLine."Quantity Received" := IRLine."Qty. to Issue";
                    IRLine.Posted := true;
                    IRLine.Modify(true);
                end;
            end;
            Message(Text003, IR."No.");
        end;
    end;

    procedure PostStockItem(IR: Record "Internal Request Header")
    var
        ItemJnlLine: Record "Item Journal Line";
        "Line No": Integer;
        IRLine: Record "Internal Request Line";
        UserPosting: Record "User Posting Template";
        ItemLedgerEntry: Record "Item Ledger Entry";
        QuantitynotIssued: Decimal;
        TotalQuantitynotIssued: Decimal;
        Batch: Record "Item Journal Batch";
    begin
        //UserPosting.GET(USERID);
        // UserPosting.TESTFIELD("Item Journal Template");
        // UserPosting.TESTFIELD("Item Journal Batch")
        IR.TestField(Status, IR.Status::Released);
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange("Journal Template Name", 'ITEM'); //UserPosting."Item Journal Template");
        ItemJnlLine.SetRange("Journal Batch Name", 'DEFAULT'); //UserPosting."Item Journal Batch");
        ItemJnlLine.DeleteAll;
        //Insert Default Batch
        Batch.Init;
        Batch."Journal Template Name" := 'ITEM';
        Batch.Name := 'DEFAULT';
        if not Batch.Get(Batch."Journal Template Name", Batch.Name) then Batch.Insert;
        if ItemJnlLine.FindLast then "Line No" := ItemJnlLine."Line No." + 1000;
        IRLine.Reset;
        IRLine.SetRange("Document Type", IRLine."Document Type"::Stock);
        IRLine.SetRange("Document No.", IR."No.");
        if IRLine.Find('-') then begin
            repeat
                if ((IRLine.Quantity = 0) and (IRLine."Qty. to Issue" = 0)) then Error('Both Quantity Requested and Quantity to issue can not be 0');
                //Check Availability
                IRLine.CalcFields("Quantity In Stock");
                if IRLine."Qty. to Issue" > IRLine."Quantity In Stock" then Error('Requested Quantity %1 of Item %2 is less than the actual Quantity in Stock of %3 in %4 Store', IRLine.Quantity, IRLine."No.", IRLine."Quantity In Stock", IR."Location Code");
            until IRLine.Next = 0;
        end;
        IRLine.Reset;
        IRLine.SetRange("Document Type", IRLine."Document Type"::Stock);
        IRLine.SetRange("Document No.", IR."No.");
        if IRLine.Find('-') then
            repeat
                "Line No" := "Line No" + 1000;
                ItemJnlLine.Init;
                ItemJnlLine."Journal Template Name" := 'ITEM'; //UserPosting."Item Journal Template";
                ItemJnlLine.Validate("Journal Template Name");
                ItemJnlLine."Journal Batch Name" := 'DEFAULT'; //UserPosting."Item Journal Batch";
                ItemJnlLine.Validate("Journal Batch Name");
                ItemJnlLine."Document No." := IR."No.";
                ItemJnlLine."Line No." := "Line No";
                ItemJnlLine."Posting Date" := Today; //IR."Posting Date";
                ItemJnlLine.Validate("Posting Date");
                ItemJnlLine."Gen. Prod. Posting Group" := IRLine."Gen. Prod. Posting Group";
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                ItemJnlLine."Item No." := IRLine."No.";
                ItemJnlLine.Validate("Item No.");
                ItemJnlLine.Quantity := IRLine."Qty. to Issue";
                ItemJnlLine.Validate(Quantity);
                ItemJnlLine.Description := IRLine.Description;
                ItemJnlLine.Validate(Description);
                ItemJnlLine."Location Code" := IRLine."Location Code";
                //ItemJnlLine.Validate("Location Code");
                ItemJnlLine."Bin Code" := IRLine."Bin Code";
                ItemJnlLine."Shortcut Dimension 1 Code" := IRLine."Shortcut Dimension 1 Code";
                ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                ItemJnlLine."Shortcut Dimension 2 Code" := IRLine."Shortcut Dimension 2 Code";
                ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                ItemJnlLine.ValidateShortcutDimCode(3, IRLine."Shortcut Dimension 3 Code");
                if IRLine."Budgeted FA No." <> '' then ItemJnlLine."Item Reference No." := IRLine."Budgeted FA No.";
                if IRLine."Qty. to Issue" > 0 then ItemJnlLine.Insert(true);
                QuantitynotIssued := IRLine.Quantity - (IRLine."Qty. to Issue" + IRLine."Quantity Issued");
                TotalQuantitynotIssued += IRLine.Quantity - (IRLine."Qty. to Issue" + IRLine."Quantity Issued");
                if QuantitynotIssued < 0 then Error(Text002, IRLine."No.");
            until IRLine.Next = 0;
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange("Journal Template Name", 'ITEM'); //UserPosting."Item Journal Template");
        ItemJnlLine.SetRange("Journal Batch Name", 'DEFAULT'); //UserPosting."Item Journal Batch");
        ItemJnlLine.SetRange("Document No.", IR."No.");
        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJnlLine);
        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetRange("Document No.", IR."No.");
        ItemLedgerEntry.SetRange("Posting Date", Today);
        if ItemLedgerEntry.FindSet then begin
            if TotalQuantitynotIssued <= 0 then begin
                IR.Posted := true;
                IR."Completely Received" := true;
            end
            else
                IR.Posted := true;
            IR."Partially Posted" := true;
            IR."Doc. No. Occurrence" := IR."Doc. No. Occurrence" + 1;
            IR."Date Posted" := Today;
            IR."Posting Date" := Today;
            IR."Time Posted" := Time;
            IR."Posted By" := UserId;
            if IR.Modify(true) then begin
                IRLine.Reset;
                IRLine.SetRange("Document No.", IR."No.");
                if IRLine.FindSet then begin
                    repeat
                        IRLine."Quantity Issued" := IRLine."Qty. to Issue";
                        IRLine."Quantity Received" := IRLine."Qty. to Issue";
                        IRLine.Posted := true;
                        IRLine.Modify(true);
                    until IRLine.Next = 0;
                    Committment.UncommitStoreReq(IR);
                end;
            end;
            Message(Text003, IR."No.");
        end;
        Commit;
    end;

    procedure ReverseGPRDocument(var RecIRHeader: Record "Internal Request Header")
    var
        IRHeader: Record "Internal Request Header";
        IRLine: Record "Internal Request Line";
        IRLine2: Record "Internal Request Line";
        ReqLine: Record "Internal Request Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        DocNo: Code[20];
        Committement: Codeunit Committment;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        LineNo: Integer;
        IRHeader2: Record "Internal Request Header";
        IRLineReqNo: Code[20];
    begin
        //ERROR('WORK IN PROGRESS');
        //Begin Modify GPR Created
        IRLine.Reset;
        IRLine.SetCurrentKey("No.", "Requisition No.");
        IRLine.SetRange("Document No.", RecIRHeader."No.");
        IRLine.SetRange("Document Type", IRLine."Document Type"::RFQ);
        if IRLine.Find('-') then begin
            repeat
                IRLineReqNo := IRLine."Requisition No.";
                IRLine.Reversed := true;
                IRLine."Reversed GPR No." := RecIRHeader."No.";
                ReverseIRLines(IRLine."No.", IRLineReqNo, IRLine."Document Type"::Purchase);
                IRLine.Modify;
            until IRLine.Next = 0;
        end;
        //Modify The Header Reversed
        IRHeader.Reset;
        IRHeader.SetRange("No.", RecIRHeader."No.");
        if IRHeader.FindFirst then begin
            IRHeader.Init;
            IRHeader.Status := IRHeader.Status::Reversed;
            IRHeader.Reversed := true;
            IRHeader."Reversed By" := UserId;
            IRHeader.Modify;
        end;
        Message(Text005, RecIRHeader."No.");
    end;

    procedure ReverseIRLines("DocumentNo.": Code[20]; ReqNo: Code[20]; DocumentType: Option Stock,Purchase,CAPEX,"Return Order",RFQ)
    var
        IRHeader2: Record "Internal Request Header";
        IRLine2: Record "Internal Request Line";
    begin
        //Modify Corresponding IRLine Entry
        IRLine2.Reset;
        IRLine2.SetRange(IRLine2."No.", "DocumentNo.");
        IRLine2.SetRange(IRLine2."Document No.", ReqNo);
        if IRLine2.Find('-') then begin
            IRLine2."RFQ Created" := false;
            IRLine2.Selected := false;
            IRLine2."RFQ No" := '';
            IRLine2."Selected By" := '';
            IRLine2."Cleared For Rfq" := false;
            IRLine2.Modify;
        end;
        //End of Modification of Corresponding IRLine Entry
    end;

    procedure SendOrderForAcknowledgement(POrder: record "Purchase Header")
    var
        AckHeader: Record "Acknowledgement Header";
        PLines: Record "Purchase Line";
        AckLines: Record "Acknowledgement Lines";
        PurchSetup: Record "Purchases & Payables Setup";
        LineNo: Integer;
        AckNo: Code[20];
    begin
        AckHeader.reset;
        AckHeader.SetRange("Order No", POrder."No.");
        if AckHeader.FindFirst then
            error('Acknowledgement already exists for this order %1', POrder."No.")
        else begin //Insert header
            AckHeader.init;
            AckHeader."No." := '';
            AckHeader."Order No" := POrder."No.";
            AckHeader."Supplier Name" := POrder."Buy-from Vendor Name";
            AckHeader."Document Date" := Today;
            AckHeader.Insert(true);
            AckNo := AckHeader."No.";
            PLines.reset;
            PLines.SetRange("Document No.", POrder."No.");
            if PLines.Find('-') then begin
                repeat
                    LineNo := LineNo + 10000;
                    AckLines.Init();
                    AckLines."Document No." := AckNo;
                    AckLines."Order No" := POrder."No.";
                    AckLines."Item No" := PLines."No.";
                    AckLines.Description := PLines.Description;
                    AckLines."Quantity Received" := PLines."Quantity Received";
                    AckLines."Line No" := LineNo;
                    AckLines.Insert();
                until PLines.Next() = 0;
            end;
            Message('Acknowledgement %1 created successfullly', AckNo);
        end;
    end;

    procedure SendOrderForInspection(Var POrder: record "Purchase Header")
    var
        InspectionCommittee: Record "Tender Committees";
        CommitteeMembers: Record "Commitee Member";
        InspectionHeader: Record "Inspection Header";
        PLines: Record "Purchase Line";
        InspectionLines: Record "Inspection Lines";
        PurchSetup: Record "Purchases & Payables Setup";
        LineNo: Integer;
        InspectionNo: Code[20];
    begin
        InspectionCommittee.reset;
        InspectionCommittee.SetRange("Tender/Quotation No", POrder."Tender/Quotation ref no");
        InspectionCommittee.SetRange("Committee Type", InspectionCommittee."Committee Type"::Inspection);
        InspectionCommittee.SetRange(Status, InspectionCommittee.Status::Released);
        if not InspectionCommittee.FindFirst then
            error(TenderCommitteeNotExistErr2, POrder."Procurement Method", POrder."Tender/Quotation ref no")
        else begin
            //Create evaluation for each committee member
            CommitteeMembers.Reset();
            CommitteeMembers.SetRange("Appointment No", InspectionCommittee."Appointment No");
            if CommitteeMembers.Find('-') then begin
                //Removed to enable one document
                //  repeat
                //Insert header
                InspectionHeader.init;
                InspectionHeader."Inspection No" := '';
                InspectionHeader."Tender No." := POrder."Tender/Quotation ref no";
                InspectionHeader."Commitee Appointment No" := InspectionCommittee."Appointment No";
                InspectionHeader."Order No" := POrder."No.";
                InspectionHeader."Supplier Name" := POrder."Buy-from Vendor Name";
                //Removed to enable one document
                //  InspectionHeader.User := InspectionCommittee.GetEmpUserID(CommitteeMembers."Employee No");
                InspectionHeader.Insert(true);
                InspectionNo := InspectionHeader."Inspection No";
                PLines.reset;
                PLines.SetRange("Document No.", POrder."No.");
                if PLines.Find('-') then begin
                    repeat
                        LineNo := LineNo + 10000;
                        InspectionLines.Init();
                        InspectionLines."Inspection No" := InspectionNo;
                        InspectionLines."Order No" := POrder."No.";
                        InspectionLines."Item No" := PLines."No.";
                        InspectionLines.Description := PLines.Description;
                        InspectionLines."Quantity Ordered" := PLines.Quantity;
                        InspectionLines."Line No" := LineNo;
                        InspectionLines.Insert();
                    until PLines.Next() = 0;
                end;
                //Removed to enable one document
                //until CommitteeMembers.Next = 0;
                POrder."Sent for Inspection" := true;
                POrder.modify();
                Message('Purchase Order %1 has been sent for inspection successfully', POrder."No.");
            end;
        end;
    end;

    procedure SendProspectiveSuppliersForEvaluation(TenderNo: Code[20])
    var
        TenderCommittee: Record "Tender Committees";
        CommitteeMembers: Record "Commitee Member";
        SupplierEval: Record "Supplier Evaluation Header";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SupplierEvalDocs: Record "Supplier Evaluation Document";
        TenderRec: Record "Procurement Request";
        TenderDocs: Record "Document required";
        TendersApplied: Record "Prospective Supplier Tender";
        ProspectiveRec: Record "Prospective Suppliers";
        BiddersSelect: Record "Bidders Selection";
        ScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLine: Record "Supplier Evaluation Setup Line";
        Scores: Record "Supplier Evaluation Score";
        ScoreLines: Record "Supplier Evaluation Score Line";
        Instrm: InStream;
        Outstrm: OutStream;
        ScoreDescBigTxt: BigText;
    begin
        //ProspectiveRec.TestField("Tender No.");
        BiddersSelect.Reset();
        BiddersSelect.SetRange("Reference No.", TenderNo);
        if BiddersSelect.Find('-') then begin
            repeat
                TendersApplied.Reset();
                TendersApplied.SetRange("Tender No.", TenderNo);
                TendersApplied.SetRange("Prospect No.", BiddersSelect.Supplier);
                //TendersApplied.SetRange("Sent for Evaluation", false);
                if TendersApplied.Find('-') then begin
                    TenderCommittee.reset;
                    TenderCommittee.SetRange("Tender/Quotation No", TenderNo);
                    TenderCommittee.SetRange("Committee Type", TenderCommittee."Committee Type"::Evaluation);
                    TenderCommittee.SetRange(Status, TenderCommittee.Status::Released);
                    if not TenderCommittee.FindFirst then
                        error(TenderCommitteeNotExistErr, TenderNo)
                    else begin
                        //Create evaluation for each committee member
                        CommitteeMembers.Reset();
                        CommitteeMembers.SetRange("Tender No.", TenderNo);
                        CommitteeMembers.SetRange("Committee Type", CommitteeMembers."Committee Type"::Evaluation);
                        if CommitteeMembers.Find('-') then
                            repeat //Insert header
                                SupplierEval.init;
                                SupplierEval."No." := '';
                                SupplierEval."Procurement Method" := SupplierEval."Procurement Method"::Tender;
                                SupplierEval."Quote No" := TenderCommittee."Tender/Quotation No";
                                SupplierEval.Validate("Quote No");
                                SupplierEval.Type := SupplierEval.Type::Tender;
                                SupplierEval.Stage := SupplierEval.Stage::Preliminary;
                                SupplierEval.User := TenderCommittee.GetEmpUserID(CommitteeMembers."Employee No");
                                SupplierEval."Supplier Code" := BiddersSelect.Supplier;
                                SupplierEval.Validate("Supplier Code");
                                SupplierEval."Committee No." := TenderCommittee."Appointment No";
                                SupplierEval.Insert(true);
                                //Insert Documents
                                if TenderRec.Get(TenderNo) then begin
                                    TenderDocs.Reset();
                                    TenderDocs.SetRange("Quote No", TenderRec."No.");
                                    if TenderDocs.Find('-') then begin
                                        repeat
                                            SupplierEvalDocs.Init();
                                            SupplierEvalDocs."Quote No." := SupplierEval."No.";
                                            SupplierEvalDocs."Document Code" := TenderDocs."Document Code";
                                            SupplierEvalDocs."Document Name" := TenderDocs."Document Name";
                                            SupplierEvalDocs.Mandatory := TenderDocs.Mandatory;
                                            SupplierEvalDocs."Supplier Code" := BiddersSelect.Supplier;
                                            SupplierEvalDocs."Tender No." := SupplierEval."Quote No";
                                            SupplierEvalDocs.Insert(true);
                                        until TenderDocs.Next = 0;
                                    end
                                    else
                                        Error(SetupTenderDocsErr, TenderRec."No.");
                                    //Insert Scores
                                    ScoreSetup.Reset();
                                    ScoreSetup.SetRange(Active, true);
                                    ScoreSetup.SetRange("Procurement Ref No.", TenderNo);
                                    ScoreSetup.SetRange(Type, ScoreSetup.Type::Tender);
                                    if ScoreSetup.Find('-') then begin
                                        repeat
                                            Scores.Init();
                                            Scores."Document No." := SupplierEval."No.";
                                            Scores."Supplier Code" := BiddersSelect.Supplier;
                                            Scores."Score Parameter" := ScoreSetup.Code;
                                            Scores."Score Description" := ScoreSetup."Evalueation Description";
                                            Scores."Maximum Score" := ScoreSetup."Maximum Score";
                                            Scores."Minimum Score" := ScoreSetup."Minimum Score";
                                            ScoreSetup.CalcFields(Description);
                                            ScoreSetup.Description.CreateInStream(Instrm);
                                            ScoreDescBigTxt.Read(Instrm);
                                            Scores.Description := ScoreSetup.Description;
                                            Scores."Score Criteria" := ScoreSetup."Score Criteria";
                                            Scores."Tender No." := TenderNo;
                                            Scores.Insert();
                                            //Insert Lines
                                            ScoreSetupLine.Reset();
                                            ScoreSetupLine.SetRange(Code, ScoreSetup.Code);
                                            if ScoreSetupLine.Find('-') then begin
                                                repeat
                                                    ScoreLines.Init();
                                                    ScoreLines."Document No." := SupplierEval."No.";
                                                    ScoreLines."Supplier Code" := BiddersSelect.Supplier;
                                                    ScoreLines."Score Parameter" := ScoreSetup.Code;
                                                    ScoreLines."Line No." := ScoreSetupLine."Line No.";
                                                    ScoreLines.Passmark := ScoreSetupLine.Passmark;
                                                    ScoreLines."Maximum Score" := ScoreSetupLine."Maximum Score";
                                                    ScoreSetupLine.CalcFields(Description);
                                                    ScoreLines."Score Description" := ScoreSetupLine.Description;
                                                    ScoreLines."Score Criteria" := ScoreSetup."Score Criteria";
                                                    ScoreLines."Tender No." := TenderNo;
                                                    ScoreLines.Insert();
                                                until ScoreSetupLine.Next = 0;
                                            end;
                                        until ScoreSetup.Next = 0;
                                    end
                                    else
                                        Error('There is no score setup for tender %1', TenderNo);
                                end;
                            until CommitteeMembers.Next = 0;
                    end;
                    TendersApplied."Sent for Evaluation" := true;
                    TendersApplied.Modify();
                end;
                ProspectiveRec.Reset();
                ProspectiveRec.SetRange("No.", BiddersSelect."Supplier");
                if ProspectiveRec.FindFirst() then begin
                    ProspectiveRec."Supplier Status" := ProspectiveRec."Supplier Status"::Evaluation;
                    ProspectiveRec."Pre Qualified" := true;
                    ProspectiveRec.modify;
                end;
            //Message(SupplierMovedToEvaluationMsg, BiddersSelect."Supplier Name");
            until BiddersSelect.Next() = 0;
        end
        else
            Error('Please select suppliers before proceeding');
        Message('Suppliers have been successfully sent for evaluation');
    end;

    procedure SendProspectiveSuppliersForEvaluationQuotation(QuoteREC: Record "Procurement Request")
    var
        TenderCommittee: Record "Tender Committees";
        CommitteeMembers: Record "Commitee Member";
        SupplierEval: Record "Supplier Evaluation Header";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SupplierEvalDocs: Record "Supplier Evaluation Document";
        TenderRec: Record "Procurement Request";
        TenderDocs: Record "Document required";
        ScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLine: Record "Supplier Evaluation Setup Line";
        Scores: Record "Supplier Evaluation Score";
        ScoreLines: Record "Supplier Evaluation Score Line";
        Instrm: InStream;
        Outstrm: OutStream;
        ScoreDescBigTxt: BigText;
        TendersApplied: Record "Prospective Supplier Tender";
        ProspectiveRec: Record "Prospective Suppliers";
        //BiddersSelect: Record "Bidders Selection";
        BiddersSelect: Record "Prospective Supplier Tender";
        QuoteNo: Code[20];
        lvSCoreLines: Record "Supplier Evaluation Setup Line";
    begin
        //ProspectiveRec.TestField("Tender No.");
        QuoteNo := QuoteREC."No.";
        //BiddersSelect.Reset();
        //BiddersSelect.SetRange(BiddersSelect."Tender No.", QuoteNo);
        //if BiddersSelect.Find('-') then
        // repeat
        TendersApplied.Reset();
        TendersApplied.SetRange("Tender No.", QuoteNo);
        //TendersApplied.SetRange("Prospect No.", BiddersSelect."Prospect No.");
        TendersApplied.SetRange("Sent for Evaluation", false);
        if TendersApplied.FindSet then begin
            repeat
                TenderCommittee.reset;
                TenderCommittee.SetRange("Tender/Quotation No", QuoteNo);
                TenderCommittee.SetRange(Status, TenderCommittee.Status::Released);
                TenderCommittee.SetRange("Committee Type", TenderCommittee."Committee Type"::Evaluation);
                if not TenderCommittee.FindFirst then
                    error(TenderCommitteeNotExistErr, QuoteNo)
                else begin
                    //Message('ONE');
                    //Create evaluation for each committee member except Secretary
                    CommitteeMembers.Reset();
                    CommitteeMembers.SetRange("Appointment No", TenderCommittee."Appointment No");
                    CommitteeMembers.SetFilter(Role, '<>%1', CommitteeMembers.Role::Secretary);
                    if CommitteeMembers.Find('-') then
                        repeat //Insert header
                            SupplierEval.init;
                            SupplierEval."No." := '';
                            SupplierEval.Validate("No.");
                            SupplierEval."Procurement Method" := SupplierEval."Procurement Method"::Quotation;
                            SupplierEval."Quote No" := TenderCommittee."Tender/Quotation No";
                            SupplierEval.Validate("Quote No");
                            SupplierEval.Type := SupplierEval.Type::quotation;
                            SupplierEval.Stage := SupplierEval.Stage::Preliminary;
                            SupplierEval.User := TenderCommittee.GetEmpUserID(CommitteeMembers."Employee No");
                            SupplierEval."Supplier Code" := TendersApplied."Prospect No.";
                            SupplierEval.Validate("Supplier Code");
                            SupplierEval."Committee No." := TenderCommittee."Appointment No";
                            SupplierEval.Insert(true);
                            //Message(SupplierEval.User);
                            //Insert Documents
                            if TenderRec.Get(QuoteNo) then begin
                                TenderDocs.Reset();
                                TenderDocs.SetRange("Quote No", TenderRec."No.");
                                if TenderDocs.Find('-') then begin
                                    repeat
                                        SupplierEvalDocs.Init();
                                        SupplierEvalDocs."Quote No." := SupplierEval."No.";
                                        SupplierEvalDocs."Document Code" := TenderDocs."Document Code";
                                        SupplierEvalDocs."Document Name" := TenderDocs."Document Name";
                                        SupplierEvalDocs.Mandatory := TenderDocs.Mandatory;
                                        SupplierEvalDocs."Supplier Code" := TendersApplied."Prospect No.";
                                        SupplierEvalDocs."Tender No." := SupplierEval."Quote No";
                                        SupplierEvalDocs.Insert(true);
                                    until TenderDocs.Next = 0;
                                end;
                                //else
                                //Error(SetupQUOTATIONDocsErr, TenderRec."No.");
                                //Insert Scores
                                ScoreSetup.Reset();
                                ScoreSetup.SetRange(Active, true);
                                ScoreSetup.SetRange("Procurement Ref No.", QuoteNo);
                                ScoreSetup.SetRange(Type, ScoreSetup.Type::RFQ);
                                //ScoreSetup.SetRange("Evaluation Stage", ScoreSetup."Evaluation Stage"::Preliminary);
                                if ScoreSetup.Find('-') then begin
                                    if ScoreSetup."Score Criteria" = ScoreSetup."Score Criteria"::Score then begin
                                        lvSCoreLines.Reset();
                                        lvSCoreLines.SetRange(Code, ScoreSetup.Code);
                                        if lvSCoreLines.FindSet() then
                                            repeat
                                                if (lvSCoreLines.Passmark = 0) or (lvSCoreLines."Maximum Score" = 0) then Error('Please make sure that the evaluation lines have both the passmark and maximum marks to be attained');
                                            until lvSCoreLines.Next() = 0;
                                    end;
                                    repeat
                                        Scores.Init();
                                        Scores."Document No." := SupplierEval."No.";
                                        Scores."Supplier Code" := TendersApplied."Prospect No.";
                                        Scores."Score Parameter" := ScoreSetup.Code;
                                        Scores."Score Description" := ScoreSetup."Evalueation Description";
                                        Scores."Maximum Score" := ScoreSetup."Maximum Score";
                                        Scores."Minimum Score" := ScoreSetup."Minimum Score";
                                        ScoreSetup.CalcFields(Description);
                                        ScoreSetup.Description.CreateInStream(Instrm);
                                        ScoreDescBigTxt.Read(Instrm);
                                        Scores.Description := ScoreSetup.Description;
                                        Scores."Score Criteria" := ScoreSetup."Score Criteria";
                                        Scores.Insert();
                                        //Insert Lines
                                        ScoreSetupLine.Reset();
                                        ScoreSetupLine.SetRange(Code, ScoreSetup.Code);
                                        if ScoreSetupLine.Find('-') then begin
                                            repeat
                                                ScoreLines.Init();
                                                ScoreLines."Document No." := SupplierEval."No.";
                                                ScoreLines."Supplier Code" := TendersApplied."Prospect No.";
                                                ScoreLines."Score Parameter" := ScoreSetup.Code;
                                                ScoreLines."Line No." := ScoreSetupLine."Line No.";
                                                ScoreLines.Passmark := ScoreSetupLine.Passmark;
                                                ScoreLines."Maximum Score" := ScoreSetupLine."Maximum Score";
                                                ScoreSetupLine.CalcFields(Description);
                                                ScoreLines."Score Description" := ScoreSetupLine.Description;
                                                ScoreLines."Score Criteria" := ScoreSetup."Score Criteria";
                                                ScoreLines."Criteria Code" := ScoreSetupLine."Criteria Code";
                                                ScoreLines.Insert();
                                            until ScoreSetupLine.Next = 0;
                                        end;
                                    until ScoreSetup.Next = 0;
                                end
                                else
                                    Error('There is no score setup for Quotation Number %1', QuoteNo);
                            end;
                        until CommitteeMembers.Next = 0;
                end;
                TendersApplied."Sent for Evaluation" := true;
                TendersApplied.Modify();
            until TendersApplied.Next() = 0;
        end;
        ProspectiveRec.Reset();
        ProspectiveRec.SetRange("No.", TendersApplied."Prospect No.");
        if ProspectiveRec.FindFirst() then begin
            ProspectiveRec."Supplier Status" := ProspectiveRec."Supplier Status"::Evaluation;
            ProspectiveRec."Pre Qualified" := true;
            ProspectiveRec.modify;
        end;
        //Message(SupplierMovedToEvaluationMsg, BiddersSelect."Supplier Name");
        //until BiddersSelect.Next() = 0;
    end;
    //Opening Quote...START
    procedure SendProspectiveSuppliersForOpeningQuotation(QuoteREC: Record "Procurement Request")
    var
        TenderCommittee: Record "Tender Committees";
        CommitteeMembers: Record "Commitee Member";
        SupplierEval: Record "Supplier Evaluation Header";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SupplierEvalDocs: Record "Supplier Evaluation Document";
        TenderRec: Record "Procurement Request";
        TenderDocs: Record "Document required";
        ScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLine: Record "Supplier Evaluation Setup Line";
        Scores: Record "Supplier Evaluation Score";
        ScoreLines: Record "Supplier Evaluation Score Line";
        Instrm: InStream;
        Outstrm: OutStream;
        ScoreDescBigTxt: BigText;
        TendersApplied: Record "Prospective Supplier Tender";
        ProspectiveRec: Record "Prospective Suppliers";
        //BiddersSelect: Record "Bidders Selection";
        BiddersSelect: Record "Prospective Supplier Tender";
        QuoteNo: Code[20];
    begin
        //ProspectiveRec.TestField("Tender No.");
        QuoteNo := QuoteREC."No.";
        //BiddersSelect.Reset();
        //BiddersSelect.SetRange(BiddersSelect."Tender No.", QuoteNo);
        //if BiddersSelect.Find('-') then
        // repeat
        TendersApplied.Reset();
        TendersApplied.SetRange("Tender No.", QuoteNo);
        //TendersApplied.SetRange("Prospect No.", BiddersSelect."Prospect No.");
        TendersApplied.SetRange("Sent for Evaluation", false);
        if TendersApplied.FindSet then begin
            repeat
                TenderCommittee.reset;
                TenderCommittee.SetRange("Tender/Quotation No", QuoteNo);
                TenderCommittee.SetRange(Status, TenderCommittee.Status::Released);
                TenderCommittee.SetRange("Committee Type", TenderCommittee."Committee Type"::Opening);
                if not TenderCommittee.FindFirst then
                    error(TenderCommitteeNotExistErr, QuoteNo)
                else begin
                    //Create evaluation for each committee member
                    CommitteeMembers.Reset();
                    CommitteeMembers.SetRange("Appointment No", TenderCommittee."Appointment No");
                    CommitteeMembers.SetFilter(Role, '<>%1', CommitteeMembers.Role::Secretary);
                    if CommitteeMembers.Find('-') then
                        repeat //Insert header
                            SupplierEval.init;
                            SupplierEval."No." := '';
                            SupplierEval.Validate("No.");
                            SupplierEval."Procurement Method" := SupplierEval."Procurement Method"::Quotation;
                            SupplierEval."Quote No" := TenderCommittee."Tender/Quotation No";
                            SupplierEval.Validate("Quote No");
                            SupplierEval.Type := SupplierEval.Type::quotation;
                            SupplierEval.Stage := SupplierEval.Stage::Opening;
                            SupplierEval.User := TenderCommittee.GetEmpUserID(CommitteeMembers."Employee No");
                            SupplierEval."Supplier Code" := TendersApplied."Prospect No.";
                            SupplierEval.Validate("Supplier Code");
                            SupplierEval."Committee No." := TenderCommittee."Appointment No";
                            SupplierEval.Insert(true);
                            if TenderRec.Get(QuoteNo) then begin
                                TenderDocs.Reset();
                                TenderDocs.SetRange("Quote No", TenderRec."No.");
                                if TenderDocs.Find('-') then begin
                                    repeat
                                        SupplierEvalDocs.Init();
                                        SupplierEvalDocs."Quote No." := SupplierEval."No.";
                                        SupplierEvalDocs."Document Code" := TenderDocs."Document Code";
                                        SupplierEvalDocs."Document Name" := TenderDocs."Document Name";
                                        SupplierEvalDocs.Mandatory := TenderDocs.Mandatory;
                                        SupplierEvalDocs."Supplier Code" := TendersApplied."Prospect No.";
                                        SupplierEvalDocs."Tender No." := SupplierEval."Quote No";
                                        SupplierEvalDocs.Insert(true);
                                    until TenderDocs.Next = 0;
                                end;
                            end;
                        until CommitteeMembers.Next = 0;
                end;
            //TendersApplied."Sent for Evaluation" := true;
            //TendersApplied.Modify();
            until TendersApplied.Next() = 0;
        end;
    end;
    //Opening Quote...END
    //Evaluation Based on Setup...START
    procedure SendProspectiveSuppliersForTechnicalEvaluationQuotation(QuoteREC: Record "Procurement Request")
    var
        TenderCommittee: Record "Tender Committees";
        CommitteeMembers: Record "Commitee Member";
        SupplierEval: Record "Supplier Evaluation Header";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SupplierEvalDocs: Record "Supplier Evaluation Document";
        TenderRec: Record "Procurement Request";
        TenderDocs: Record "Document required";
        ScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLine: Record "Supplier Evaluation Setup Line";
        Scores: Record "Supplier Evaluation Score";
        ScoreLines: Record "Supplier Evaluation Score Line";
        Instrm: InStream;
        Outstrm: OutStream;
        ScoreDescBigTxt: BigText;
        TendersApplied: Record "Prospective Supplier Tender";
        ProspectiveRec: Record "Prospective Suppliers";
        //BiddersSelect: Record "Bidders Selection";
        BiddersSelect: Record "Prospective Supplier Tender";
        QuoteNo: Code[20];
        lvSCoreLines: Record "Supplier Evaluation Setup Line";
    begin
        //ProspectiveRec.TestField("Tender No.");
        QuoteNo := QuoteREC."No.";
        //BiddersSelect.Reset();
        //BiddersSelect.SetRange(BiddersSelect."Tender No.", QuoteNo);
        //if BiddersSelect.Find('-') then
        // repeat
        TendersApplied.Reset();
        TendersApplied.SetRange("Tender No.", QuoteNo);
        TendersApplied.SetRange(TendersApplied."Passed Preliminary", true);
        if TendersApplied.FindSet then begin
            repeat
                TenderCommittee.reset;
                TenderCommittee.SetRange("Tender/Quotation No", QuoteNo);
                TenderCommittee.SetRange(Status, TenderCommittee.Status::Released);
                TenderCommittee.SetRange("Committee Type", TenderCommittee."Committee Type"::Evaluation);
                if not TenderCommittee.FindFirst then
                    error(TenderCommitteeNotExistErr, QuoteNo)
                else begin
                    //Create evaluation for each committee member
                    CommitteeMembers.Reset();
                    CommitteeMembers.SetRange("Appointment No", TenderCommittee."Appointment No");
                    CommitteeMembers.SetFilter(Role, '<>%1', CommitteeMembers.Role::Secretary);
                    if CommitteeMembers.Find('-') then
                        repeat //Insert header
                            SupplierEval.init;
                            SupplierEval."No." := '';
                            SupplierEval.Validate("No.");
                            SupplierEval."Procurement Method" := SupplierEval."Procurement Method"::Quotation;
                            SupplierEval."Quote No" := TenderCommittee."Tender/Quotation No";
                            SupplierEval.Validate("Quote No");
                            SupplierEval.Type := SupplierEval.Type::quotation;
                            SupplierEval.Stage := SupplierEval.Stage::Technical;
                            SupplierEval.User := TenderCommittee.GetEmpUserID(CommitteeMembers."Employee No");
                            SupplierEval."Supplier Code" := TendersApplied."Prospect No.";
                            SupplierEval.Validate("Supplier Code");
                            SupplierEval."Committee No." := TenderCommittee."Appointment No";
                            SupplierEval.Insert(true);
                            //Insert Documents
                            if TenderRec.Get(QuoteNo) then begin
                                TenderDocs.Reset();
                                //  TenderDocs.SetRange("Quote No", TenderRec."No.");
                                // if TenderDocs.Find('-') then begin
                                //     repeat
                                //         SupplierEvalDocs.Init();
                                //         SupplierEvalDocs."Quote No." := SupplierEval."No.";
                                //         SupplierEvalDocs."Document Code" := TenderDocs."Document Code";
                                //         SupplierEvalDocs."Document Name" := TenderDocs."Document Name";
                                //         SupplierEvalDocs.Mandatory := TenderDocs.Mandatory;
                                //         SupplierEvalDocs."Supplier Code" := TendersApplied."Prospect No.";
                                //         SupplierEvalDocs."Tender No." := SupplierEval."Quote No";
                                //         SupplierEvalDocs.Insert(true);
                                //     until TenderDocs.Next = 0;
                                // end;
                                //else
                                //Error(SetupQUOTATIONDocsErr, TenderRec."No.");
                                //Insert Scores
                                ScoreSetup.Reset();
                                ScoreSetup.SetRange(Active, true);
                                ScoreSetup.SetRange("Procurement Ref No.", QuoteNo);
                                ScoreSetup.SetRange(Type, ScoreSetup.Type::RFQ);
                                if ScoreSetup.Find('-') then begin
                                    if ScoreSetup."Score Criteria" = ScoreSetup."Score Criteria"::Score then begin
                                        lvSCoreLines.Reset();
                                        lvSCoreLines.SetRange(Code, ScoreSetup.Code);
                                        if lvSCoreLines.FindSet() then
                                            repeat
                                                if (lvSCoreLines.Passmark = 0) or (lvSCoreLines."Maximum Score" = 0) then Error('Please make sure that the evaluation lines have both the passmark and maximum marks to be attained');
                                            until lvSCoreLines.Next() = 0;
                                    end;
                                    repeat
                                        Scores.Init();
                                        Scores."Document No." := SupplierEval."No.";
                                        Scores."Supplier Code" := TendersApplied."Prospect No.";
                                        Scores."Score Parameter" := ScoreSetup.Code;
                                        Scores."Score Description" := ScoreSetup."Evalueation Description";
                                        Scores."Maximum Score" := ScoreSetup."Maximum Score";
                                        Scores."Minimum Score" := ScoreSetup."Minimum Score";
                                        ScoreSetup.CalcFields(Description);
                                        ScoreSetup.Description.CreateInStream(Instrm);
                                        ScoreDescBigTxt.Read(Instrm);
                                        Scores.Description := ScoreSetup.Description;
                                        Scores."Score Criteria" := ScoreSetup."Score Criteria";
                                        Scores."Tender No." := QuoteNo;
                                        Scores.Insert();
                                        //Insert Lines
                                        ScoreSetupLine.Reset();
                                        ScoreSetupLine.SetRange(Code, ScoreSetup.Code);
                                        if ScoreSetupLine.Find('-') then begin
                                            repeat
                                                ScoreLines.Init();
                                                ScoreLines."Document No." := SupplierEval."No.";
                                                ScoreLines."Supplier Code" := TendersApplied."Prospect No.";
                                                ScoreLines."Score Parameter" := ScoreSetup.Code;
                                                ScoreLines."Line No." := ScoreSetupLine."Line No.";
                                                ScoreLines.Passmark := ScoreSetupLine.Passmark;
                                                ScoreLines."Maximum Score" := ScoreSetupLine."Maximum Score";
                                                ScoreSetupLine.CalcFields(Description);
                                                ScoreLines."Score Description" := ScoreSetupLine.Description;
                                                ScoreLines."Score Criteria" := ScoreSetup."Score Criteria";
                                                ScoreLines."Criteria Code" := ScoreSetupLine."Criteria Code";
                                                ScoreLines."Tender No." := QuoteNo;
                                                ScoreLines.Insert();
                                            until ScoreSetupLine.Next = 0;
                                        end;
                                    until ScoreSetup.Next = 0;
                                end
                                else
                                    Error('There is no evaluation setup for Quotation Number %1', QuoteNo);
                            end;
                        until CommitteeMembers.Next = 0;
                end;
                TendersApplied."Sent for Evaluation" := true;
                TendersApplied.Modify();
            until TendersApplied.Next() = 0;
            Message('Evaluation Entries successfully generated');
        end;
        ProspectiveRec.Reset();
        ProspectiveRec.SetRange("No.", TendersApplied."Prospect No.");
        if ProspectiveRec.FindFirst() then begin
            ProspectiveRec."Supplier Status" := ProspectiveRec."Supplier Status"::Evaluation;
            ProspectiveRec."Pre Qualified" := true;
            ProspectiveRec.modify;
        end;
        //Message(SupplierMovedToEvaluationMsg, BiddersSelect."Supplier Name");
        //until BiddersSelect.Next() = 0;
    end;
    //Evaluation Based on Setup...END
    // procedure SendProspectiveSuppliersForEvaluationEOI(EOINO: Code[20])
    procedure SendProspectiveSuppliersForEvaluationEOI(EOINO: Code[20])
    var
        TenderCommittee: Record "Tender Committees";
        CommitteeMembers: Record "Commitee Member";
        SupplierEval: Record "Supplier Evaluation Header";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SupplierEvalDocs: Record "Supplier Evaluation Document";
        TenderRec: Record "Procurement Request";
        TenderDocs: Record "Document required";
        ScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLine: Record "Supplier Evaluation Setup Line";
        Scores: Record "Supplier Evaluation Score";
        ScoreLines: Record "Supplier Evaluation Score Line";
        Instrm: InStream;
        Outstrm: OutStream;
        ScoreDescBigTxt: BigText;
        TendersApplied: Record "Prospective Supplier Tender";
        ProspectiveRec: Record "Prospective Suppliers";
        BiddersSelect: Record "Bidders Selection";
    begin
        //EOINO := EOIRec."No.";
        //ProspectiveRec.TestField("Tender No.");
        BiddersSelect.Reset();
        BiddersSelect.SetRange("Reference No.", EOINO);
        if BiddersSelect.Find('-') then
            repeat
                TendersApplied.SetRange("Tender No.", EOINO);
                TendersApplied.SetRange("Prospect No.", BiddersSelect."Supplier");
                TendersApplied.SetRange("Sent for Evaluation", false);
                if TendersApplied.Find('-') then begin
                    TenderCommittee.reset;
                    TenderCommittee.SetRange("Tender/Quotation No", EOINO);
                    TenderCommittee.SetRange("Committee Type", TenderCommittee."Committee Type"::Evaluation);
                    TenderCommittee.SetRange(Status, TenderCommittee.Status::Released);
                    if not TenderCommittee.FindFirst then
                        error(EOICommitteeNotExistErr, EOINO)
                    else begin
                        //Create evaluation for each committee member
                        CommitteeMembers.Reset();
                        CommitteeMembers.SetRange("Appointment No", TenderCommittee."Appointment No");
                        if CommitteeMembers.Find('-') then
                            repeat //Insert header
                                SupplierEval.init;
                                SupplierEval."No." := '';
                                SupplierEval.Validate("No.");
                                SupplierEval."Procurement Method" := SupplierEval."Procurement Method"::EOI;
                                SupplierEval."Quote No" := TenderCommittee."Tender/Quotation No";
                                SupplierEval.Validate("Quote No");
                                SupplierEval.Type := SupplierEval.Type::EOI;
                                SupplierEval.Stage := SupplierEval.Stage::Preliminary;
                                SupplierEval.User := TenderCommittee.GetEmpUserID(CommitteeMembers."Employee No");
                                SupplierEval."Supplier Code" := BiddersSelect."Supplier";
                                SupplierEval.Validate("Supplier Code");
                                SupplierEval."Committee No." := TenderCommittee."Appointment No";
                                SupplierEval.Insert(true);
                                //Insert Documents
                                if TenderRec.Get(EOINO) then begin
                                    TenderDocs.Reset();
                                    TenderDocs.SetRange("Quote No", TenderRec."No.");
                                    if TenderDocs.Find('-') then begin
                                        repeat
                                            SupplierEvalDocs.Init();
                                            SupplierEvalDocs."Quote No." := SupplierEval."No.";
                                            SupplierEvalDocs."Document Code" := TenderDocs."Document Code";
                                            SupplierEvalDocs."Document Name" := TenderDocs."Document Name";
                                            SupplierEvalDocs.Mandatory := TenderDocs.Mandatory;
                                            SupplierEvalDocs."Supplier Code" := BiddersSelect."Supplier";
                                            SupplierEvalDocs."Tender No." := SupplierEval."Quote No";
                                            SupplierEvalDocs.Insert(true);
                                        until TenderDocs.Next = 0;
                                    end;
                                    //else
                                    //     Error(SetupTenderDocsErr, TenderRec."No.");
                                    //Insert Scores
                                    ScoreSetup.Reset();
                                    ScoreSetup.SetRange(Active, true);
                                    ScoreSetup.SetRange("Procurement Ref No.", EOINO);
                                    ScoreSetup.SetRange(Type, ScoreSetup.Type::EOI);
                                    if ScoreSetup.Find('-') then begin
                                        repeat
                                            Scores.Init();
                                            Scores."Document No." := SupplierEval."No.";
                                            Scores."Supplier Code" := BiddersSelect."Supplier";
                                            Scores."Score Parameter" := ScoreSetup.Code;
                                            Scores."Score Description" := ScoreSetup."Evalueation Description";
                                            Scores."Maximum Score" := ScoreSetup."Maximum Score";
                                            Scores."Minimum Score" := ScoreSetup."Minimum Score";
                                            ScoreSetup.CalcFields(Description);
                                            ScoreSetup.Description.CreateInStream(Instrm);
                                            ScoreDescBigTxt.Read(Instrm);
                                            Scores.Description := ScoreSetup.Description;
                                            Scores."Score Criteria" := ScoreSetup."Score Criteria";
                                            Scores.Insert();
                                            //Insert Lines
                                            ScoreSetupLine.Reset();
                                            ScoreSetupLine.SetRange(Code, ScoreSetup.Code);
                                            if ScoreSetupLine.Find('-') then begin
                                                repeat
                                                    ScoreLines.Init();
                                                    ScoreLines."Document No." := SupplierEval."No.";
                                                    ScoreLines."Supplier Code" := BiddersSelect."Supplier";
                                                    ScoreLines."Score Parameter" := ScoreSetup.Code;
                                                    ScoreLines."Line No." := ScoreSetupLine."Line No.";
                                                    ScoreLines.Passmark := ScoreSetupLine.Passmark;
                                                    ScoreLines."Maximum Score" := ScoreSetupLine."Maximum Score";
                                                    ScoreSetupLine.CalcFields(Description);
                                                    ScoreLines."Score Description" := ScoreSetupLine.Description;
                                                    ScoreLines."Score Criteria" := ScoreSetup."Score Criteria";
                                                    ScoreLines.Insert();
                                                until ScoreSetupLine.Next = 0;
                                            end;
                                        until ScoreSetup.Next = 0;
                                    end
                                    else
                                        Error('There is no score setup for EOI %1', EOINO);
                                end;
                            until CommitteeMembers.Next = 0;
                    end;
                    TendersApplied."Sent for Evaluation" := true;
                    TendersApplied.Modify();
                end;
                ProspectiveRec.Reset();
                ProspectiveRec.SetRange("No.", BiddersSelect."Supplier");
                if ProspectiveRec.FindFirst() then begin
                    ProspectiveRec."Supplier Status" := ProspectiveRec."Supplier Status"::Evaluation;
                    ProspectiveRec."Pre Qualified" := true;
                    ProspectiveRec.modify;
                end;
                Message(SupplierMovedToEvaluationMsg, BiddersSelect."Supplier Name");
            until BiddersSelect.Next() = 0;
    end;

    procedure SendProspectiveSuppliersForEvaluationRFP(RFPREC: RECORD "Procurement Request")
    var
        TenderCommittee: Record "Tender Committees";
        CommitteeMembers: Record "Commitee Member";
        SupplierEval: Record "Supplier Evaluation Header";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SupplierEvalDocs: Record "Supplier Evaluation Document";
        TenderRec: Record "Procurement Request";
        TenderDocs: Record "Document required";
        ScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLine: Record "Supplier Evaluation Setup Line";
        Scores: Record "Supplier Evaluation Score";
        ScoreLines: Record "Supplier Evaluation Score Line";
        Instrm: InStream;
        Outstrm: OutStream;
        ScoreDescBigTxt: BigText;
        TendersApplied: Record "Prospective Supplier Tender";
        ProspectiveRec: Record "Prospective Suppliers";
        BiddersSelect: Record "Bidders Selection";
        RFPNo: Code[20];
    begin
        //ProspectiveRec.TestField("Tender No.");
        RFPNo := RFPREC."No.";
        BiddersSelect.Reset();
        BiddersSelect.SetRange("Reference No.", RFPNo);
        if BiddersSelect.Find('-') then
            repeat
                TendersApplied.SetRange("Tender No.", RFPNo);
                TendersApplied.SetRange("Prospect No.", BiddersSelect."Supplier");
                TendersApplied.SetRange("Sent for Evaluation", false);
                if TendersApplied.Find('-') then begin
                    TenderCommittee.reset;
                    TenderCommittee.SetRange("Tender/Quotation No", RFPNo);
                    TenderCommittee.SetRange("Committee Type", TenderCommittee."Committee Type"::Evaluation);
                    TenderCommittee.SetRange(Status, TenderCommittee.Status::Released);
                    if not TenderCommittee.FindFirst then
                        error(TenderCommitteeNotExistErr, RFPNo)
                    else begin
                        //Create evaluation for each committee member
                        CommitteeMembers.Reset();
                        CommitteeMembers.SetRange("Appointment No", TenderCommittee."Appointment No");
                        if CommitteeMembers.Find('-') then
                            repeat //Insert header
                                SupplierEval.init;
                                SupplierEval."No." := '';
                                SupplierEval."Procurement Method" := SupplierEval."Procurement Method"::RFP;
                                SupplierEval."Quote No" := TenderCommittee."Tender/Quotation No";
                                SupplierEval.Validate("Quote No");
                                SupplierEval.Type := SupplierEval.Type::RFP;
                                SupplierEval.Stage := SupplierEval.Stage::Preliminary;
                                SupplierEval.User := TenderCommittee.GetEmpUserID(CommitteeMembers."Employee No");
                                SupplierEval."Supplier Code" := BiddersSelect."Supplier";
                                SupplierEval.Validate("Supplier Code");
                                SupplierEval."Committee No." := TenderCommittee."Appointment No";
                                SupplierEval.Insert(true);
                                //Insert Documents
                                if TenderRec.Get(RFPNo) then begin
                                    TenderDocs.Reset();
                                    TenderDocs.SetRange("Quote No", TenderRec."No.");
                                    if TenderDocs.Find('-') then begin
                                        repeat
                                            SupplierEvalDocs.Init();
                                            SupplierEvalDocs."Quote No." := SupplierEval."No.";
                                            SupplierEvalDocs."Document Code" := TenderDocs."Document Code";
                                            SupplierEvalDocs."Document Name" := TenderDocs."Document Name";
                                            SupplierEvalDocs.Mandatory := TenderDocs.Mandatory;
                                            SupplierEvalDocs."Supplier Code" := BiddersSelect."Supplier";
                                            SupplierEvalDocs."Tender No." := SupplierEval."Quote No";
                                            SupplierEvalDocs.Insert(true);
                                        until TenderDocs.Next = 0;
                                    end;
                                    // else
                                    //Error(SetupTenderDocsErr, TenderRec."No.");
                                    //Insert Scores
                                    ScoreSetup.Reset();
                                    ScoreSetup.SetRange(Active, true);
                                    ScoreSetup.SetRange("Procurement Ref No.", RFPNo);
                                    ScoreSetup.SetRange(Type, ScoreSetup.Type::RFP);
                                    if ScoreSetup.Find('-') then begin
                                        repeat
                                            Scores.Init();
                                            Scores."Document No." := SupplierEval."No.";
                                            Scores."Supplier Code" := BiddersSelect."Supplier";
                                            Scores."Score Parameter" := ScoreSetup.Code;
                                            Scores."Score Description" := ScoreSetup."Evalueation Description";
                                            Scores."Maximum Score" := ScoreSetup."Maximum Score";
                                            Scores."Minimum Score" := ScoreSetup."Minimum Score";
                                            ScoreSetup.CalcFields(Description);
                                            ScoreSetup.Description.CreateInStream(Instrm);
                                            ScoreDescBigTxt.Read(Instrm);
                                            Scores.Description := ScoreSetup.Description;
                                            Scores."Score Criteria" := ScoreSetup."Score Criteria";
                                            Scores.Insert();
                                            //Insert Lines
                                            ScoreSetupLine.Reset();
                                            ScoreSetupLine.SetRange(Code, ScoreSetup.Code);
                                            if ScoreSetupLine.Find('-') then begin
                                                repeat
                                                    ScoreLines.Init();
                                                    ScoreLines."Document No." := SupplierEval."No.";
                                                    ScoreLines."Supplier Code" := BiddersSelect."Supplier";
                                                    ScoreLines."Score Parameter" := ScoreSetup.Code;
                                                    ScoreLines."Line No." := ScoreSetupLine."Line No.";
                                                    ScoreLines.Passmark := ScoreSetupLine.Passmark;
                                                    ScoreLines."Maximum Score" := ScoreSetupLine."Maximum Score";
                                                    ScoreSetupLine.CalcFields(Description);
                                                    ScoreLines."Score Description" := ScoreSetupLine.Description;
                                                    ScoreLines."Score Criteria" := ScoreSetup."Score Criteria";
                                                    ScoreLines.Insert();
                                                until ScoreSetupLine.Next = 0;
                                            end;
                                        until ScoreSetup.Next = 0;
                                    end
                                    else
                                        Error('There is no score setup for RFP %1', RFPNo);
                                end;
                            until CommitteeMembers.Next = 0;
                    end;
                    TendersApplied."Sent for Evaluation" := true;
                    TendersApplied.Modify();
                end;
                ProspectiveRec.Reset();
                ProspectiveRec.SetRange("No.", BiddersSelect."Supplier");
                if ProspectiveRec.FindFirst() then begin
                    ProspectiveRec."Supplier Status" := ProspectiveRec."Supplier Status"::Evaluation;
                    ProspectiveRec."Pre Qualified" := true;
                    ProspectiveRec.modify;
                end;
                Message(SupplierMovedToEvaluationMsg, BiddersSelect."Supplier Name");
            until BiddersSelect.Next() = 0;
    end;
    // RFP Sent To technical Directly
    procedure SendRFPProspectiveSuppliersForEvaluationRFP(RFPREC: RECORD "Procurement Request")
    var
        TenderCommittee: Record "Tender Committees";
        CommitteeMembers: Record "Commitee Member";
        SupplierEval: Record "Supplier Evaluation Header";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SupplierEvalDocs: Record "Supplier Evaluation Document";
        TenderRec: Record "Procurement Request";
        TenderDocs: Record "Document required";
        ScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLine: Record "Supplier Evaluation Setup Line";
        Scores: Record "Supplier Evaluation Score";
        ScoreLines: Record "Supplier Evaluation Score Line";
        Instrm: InStream;
        Outstrm: OutStream;
        ScoreDescBigTxt: BigText;
        TendersApplied: Record "Prospective Supplier Tender";
        ProspectiveRec: Record "Prospective Suppliers";
        BiddersSelect: Record "Bidders Selection";
        RFPNo: Code[20];
    begin
        //ProspectiveRec.TestField("Tender No.");
        RFPNo := RFPREC."No.";
        BiddersSelect.Reset();
        BiddersSelect.SetRange("Reference No.", RFPNo);
        if BiddersSelect.Find('-') then
            repeat
                TendersApplied.SetRange("Tender No.", RFPNo);
                TendersApplied.SetRange("Prospect No.", BiddersSelect."Supplier");
                TendersApplied.SetRange("Sent for Evaluation", false);
                if TendersApplied.Find('-') then begin
                    TenderCommittee.reset;
                    TenderCommittee.SetRange("Tender/Quotation No", RFPNo);
                    TenderCommittee.SetRange("Committee Type", TenderCommittee."Committee Type"::Evaluation);
                    TenderCommittee.SetRange(Status, TenderCommittee.Status::Released);
                    if not TenderCommittee.FindFirst then
                        error(TenderCommitteeNotExistErr, RFPNo)
                    else begin
                        //Create evaluation for each committee member
                        CommitteeMembers.Reset();
                        CommitteeMembers.SetRange("Appointment No", TenderCommittee."Appointment No");
                        if CommitteeMembers.Find('-') then
                            repeat //Insert header
                                SupplierEval.init;
                                SupplierEval."No." := '';
                                SupplierEval."Procurement Method" := SupplierEval."Procurement Method"::RFP;
                                SupplierEval."Quote No" := TenderCommittee."Tender/Quotation No";
                                SupplierEval.Validate("Quote No");
                                SupplierEval.Type := SupplierEval.Type::RFP;
                                SupplierEval.Stage := SupplierEval.Stage::Technical;
                                SupplierEval.Status := SupplierEval.Status::New;
                                SupplierEval.User := TenderCommittee.GetEmpUserID(CommitteeMembers."Employee No");
                                SupplierEval."Supplier Code" := BiddersSelect."Supplier";
                                SupplierEval.Validate("Supplier Code");
                                SupplierEval."Committee No." := TenderCommittee."Appointment No";
                                SupplierEval.Insert(true);
                                //Insert Documents
                                if TenderRec.Get(RFPNo) then begin
                                    TenderDocs.Reset();
                                    TenderDocs.SetRange("Quote No", TenderRec."No.");
                                    if TenderDocs.Find('-') then begin
                                        repeat
                                            SupplierEvalDocs.Init();
                                            SupplierEvalDocs."Quote No." := SupplierEval."No.";
                                            SupplierEvalDocs."Document Code" := TenderDocs."Document Code";
                                            SupplierEvalDocs."Document Name" := TenderDocs."Document Name";
                                            SupplierEvalDocs.Mandatory := TenderDocs.Mandatory;
                                            SupplierEvalDocs."Supplier Code" := BiddersSelect."Supplier";
                                            SupplierEvalDocs."Tender No." := SupplierEval."Quote No";
                                            SupplierEvalDocs.Insert(true);
                                        until TenderDocs.Next = 0;
                                    end;
                                    // else
                                    //Error(SetupTenderDocsErr, TenderRec."No.");
                                    //Insert Scores
                                    ScoreSetup.Reset();
                                    ScoreSetup.SetRange(Active, true);
                                    ScoreSetup.SetRange("Procurement Ref No.", RFPNo);
                                    ScoreSetup.SetRange(Type, ScoreSetup.Type::RFP);
                                    if ScoreSetup.Find('-') then begin
                                        repeat
                                            Scores.Init();
                                            Scores."Document No." := SupplierEval."No.";
                                            Scores."Supplier Code" := BiddersSelect."Supplier";
                                            Scores."Score Parameter" := ScoreSetup.Code;
                                            Scores."Score Description" := ScoreSetup."Evalueation Description";
                                            Scores."Maximum Score" := ScoreSetup."Maximum Score";
                                            Scores."Minimum Score" := ScoreSetup."Minimum Score";
                                            ScoreSetup.CalcFields(Description);
                                            ScoreSetup.Description.CreateInStream(Instrm);
                                            ScoreDescBigTxt.Read(Instrm);
                                            Scores.Description := ScoreSetup.Description;
                                            Scores."Score Criteria" := ScoreSetup."Score Criteria";
                                            Scores.Insert();
                                            //Insert Lines
                                            ScoreSetupLine.Reset();
                                            ScoreSetupLine.SetRange(Code, ScoreSetup.Code);
                                            if ScoreSetupLine.Find('-') then begin
                                                repeat
                                                    ScoreLines.Init();
                                                    ScoreLines."Document No." := SupplierEval."No.";
                                                    ScoreLines."Supplier Code" := BiddersSelect."Supplier";
                                                    ScoreLines."Score Parameter" := ScoreSetup.Code;
                                                    ScoreLines."Line No." := ScoreSetupLine."Line No.";
                                                    ScoreLines.Passmark := ScoreSetupLine.Passmark;
                                                    ScoreLines."Maximum Score" := ScoreSetupLine."Maximum Score";
                                                    ScoreSetupLine.CalcFields(Description);
                                                    ScoreLines."Score Description" := ScoreSetupLine.Description;
                                                    ScoreLines."Score Criteria" := ScoreSetup."Score Criteria";
                                                    ScoreLines.Insert();
                                                until ScoreSetupLine.Next = 0;
                                            end;
                                        until ScoreSetup.Next = 0;
                                    end
                                    else
                                        Error('There is no score setup for RFP %1', RFPNo);
                                end;
                            until CommitteeMembers.Next = 0;
                    end;
                    TendersApplied."Sent for Evaluation" := true;
                    TendersApplied.Modify();
                end;
                ProspectiveRec.Reset();
                ProspectiveRec.SetRange("No.", BiddersSelect."Supplier");
                if ProspectiveRec.FindFirst() then begin
                    ProspectiveRec."Supplier Status" := ProspectiveRec."Supplier Status"::Evaluation;
                    ProspectiveRec."Pre Qualified" := true;
                    ProspectiveRec.modify;
                end;
                Message(SupplierMovedToEvaluationMsg, BiddersSelect."Supplier Name");
            until BiddersSelect.Next() = 0;
    end;

    procedure SendProspectiveSupplierForEvaluation(ProspectiveRec: record "Prospective Suppliers")
    var
        TenderCommittee: Record "Tender Committees";
        CommitteeMembers: Record "Commitee Member";
        SupplierEval: Record "Supplier Evaluation Header";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SupplierEvalDocs: Record "Supplier Evaluation Document";
        TenderRec: Record "Procurement Request";
        TenderDocs: Record "Document required";
        ScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLine: Record "Supplier Evaluation Setup Line";
        Scores: Record "Supplier Evaluation Score";
        ScoreLines: Record "Supplier Evaluation Score Line";
        Instrm: InStream;
        Outstrm: OutStream;
        ScoreDescBigTxt: BigText;
        TendersApplied: Record "Prospective Supplier Tender";
    begin
        //ProspectiveRec.TestField("Tender No.");
        TendersApplied.Reset();
        TendersApplied.SetRange("Prospect No.", ProspectiveRec."No.");
        TendersApplied.SetRange("Sent for Evaluation", false);
        if TendersApplied.Find('-') then begin
            repeat
                TenderCommittee.reset;
                TenderCommittee.SetRange("Tender/Quotation No", TendersApplied."Tender No.");
                TenderCommittee.SetRange(Status, TenderCommittee.Status::Released);
                if not TenderCommittee.FindFirst then
                    error(TenderCommitteeNotExistErr, TendersApplied."Tender No.")
                else begin
                    //Create evaluation for each committee member
                    CommitteeMembers.Reset();
                    CommitteeMembers.SetRange("Appointment No", TenderCommittee."Appointment No");
                    if CommitteeMembers.Find('-') then
                        repeat //Insert header
                            SupplierEval.init;
                            SupplierEval."No." := '';
                            SupplierEval."Quote No" := TenderCommittee."Tender/Quotation No";
                            SupplierEval.Validate("Quote No");
                            SupplierEval.Type := SupplierEval.Type::Tender;
                            SupplierEval.User := TenderCommittee.GetEmpUserID(CommitteeMembers."Employee No");
                            SupplierEval."Supplier Code" := ProspectiveRec."No.";
                            SupplierEval.Validate("Supplier Code");
                            SupplierEval."Committee No." := TenderCommittee."Appointment No";
                            SupplierEval.Insert(true);
                            //Insert Documents
                            if TenderRec.Get(TenderCommittee."Tender/Quotation No") then begin
                                TenderDocs.Reset();
                                TenderDocs.SetRange("Quote No", TenderRec."No.");
                                if TenderDocs.Find('-') then begin
                                    repeat
                                        SupplierEvalDocs.Init();
                                        SupplierEvalDocs."Quote No." := SupplierEval."No.";
                                        SupplierEvalDocs."Document Code" := TenderDocs."Document Code";
                                        SupplierEvalDocs."Document Name" := TenderDocs."Document Name";
                                        SupplierEvalDocs.Mandatory := TenderDocs.Mandatory;
                                        SupplierEvalDocs."Supplier Code" := ProspectiveRec."No.";
                                        SupplierEvalDocs.Insert();
                                    until TenderDocs.Next = 0;
                                end
                                else
                                    Error(SetupTenderDocsErr, TenderRec."No.");
                                //Insert Scores
                                ScoreSetup.Reset();
                                ScoreSetup.SetRange(Active, true);
                                ScoreSetup.SetRange(Type, ScoreSetup.Type::Tender);
                                if ScoreSetup.Find('-') then begin
                                    repeat
                                        Scores.Init();
                                        Scores."Document No." := SupplierEval."No.";
                                        Scores."Supplier Code" := ProspectiveRec."No.";
                                        Scores."Score Parameter" := ScoreSetup.Code;
                                        Scores."Score Description" := ScoreSetup."Evalueation Description";
                                        Scores."Maximum Score" := ScoreSetup."Maximum Score";
                                        Scores."Minimum Score" := ScoreSetup."Minimum Score";
                                        ScoreSetup.CalcFields(Description);
                                        ScoreSetup.Description.CreateInStream(Instrm);
                                        ScoreDescBigTxt.Read(Instrm);
                                        Scores.Description := ScoreSetup.Description;
                                        Scores."Score Criteria" := ScoreSetup."Score Criteria";
                                        Scores.Insert();
                                        //Insert Lines
                                        ScoreSetupLine.Reset();
                                        ScoreSetupLine.SetRange(Code, ScoreSetup.Code);
                                        if ScoreSetupLine.Find('-') then begin
                                            repeat
                                                ScoreLines.Init();
                                                ScoreLines."Document No." := SupplierEval."No.";
                                                ScoreLines."Supplier Code" := ProspectiveRec."No.";
                                                ScoreLines."Score Parameter" := ScoreSetup.Code;
                                                ScoreLines."Line No." := ScoreSetupLine."Line No.";
                                                ScoreLines."Maximum Score" := ScoreSetupLine."Maximum Score";
                                                ScoreSetupLine.CalcFields(Description);
                                                ScoreLines."Score Description" := ScoreSetupLine.Description;
                                                ScoreLines."Score Criteria" := ScoreSetup."Score Criteria";
                                                ScoreLines.Insert();
                                            until ScoreSetupLine.Next = 0;
                                        end;
                                    until ScoreSetup.Next = 0;
                                end
                                else
                                    Error('');
                            end;
                        until CommitteeMembers.Next = 0;
                    TendersApplied."Sent for Evaluation" := true;
                    TendersApplied.Modify();
                end;
            until TendersApplied.Next = 0;
        end;
        ProspectiveRec."Supplier Status" := ProspectiveRec."Supplier Status"::Evaluation;
        ProspectiveRec."Pre Qualified" := true;
        ProspectiveRec.modify;
        Message(SupplierMovedToEvaluationMsg);
    end;

    procedure SendVendorForEvaluation(Vend: record Vendor)
    var
        SupplierEval: Record "Supplier Evaluation Header";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLine: Record "Supplier Evaluation Setup Line";
        Instrm: InStream;
        Outstrm: OutStream;
        ScoreDescBigTxt: BigText;
        Scores: Record "Supplier Evaluation Score";
        ScoreLines: Record "Supplier Evaluation Score Line";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        Message('Sent');
        PurchSetup.get;
        PurchSetup.testfield("Vendor Evaluation Nos");
        //Insert header
        SupplierEval.Init;
        SupplierEval."No." := NoSeriesManagement.GetNextNo(PurchSetup."Vendor Evaluation Nos", 0D, TRUE);
        SupplierEval.Type := SupplierEval.Type::Existing;
        SupplierEval."Supplier Code" := Vend."No.";
        SupplierEval.Validate("Supplier Code");
        SupplierEval.Period := GetOpenEvaluationPeriod();
        SupplierEval.Insert();
        //Insert Scores
        // Message('%1', SupplierEval."No.");
        ScoreSetup.Reset();
        ScoreSetup.SetRange(Active, true);
        ScoreSetup.SetRange(Type, ScoreSetup.Type::Tender);
        if ScoreSetup.Find('-') then begin
            repeat
                Scores.Init();
                Scores."Document No." := SupplierEval."No.";
                Scores."Supplier Code" := SupplierEval."Supplier Code";
                Scores."Score Parameter" := ScoreSetup.Code;
                Scores."Score Description" := ScoreSetup."Evalueation Description";
                Scores."Maximum Score" := ScoreSetup."Maximum Score";
                Scores."Minimum Score" := ScoreSetup."Minimum Score";
                ScoreSetup.CalcFields(Description);
                ScoreSetup.Description.CreateInStream(Instrm);
                ScoreDescBigTxt.Read(Instrm);
                Scores.Description := ScoreSetup.Description;
                Scores."Score Criteria" := ScoreSetup."Score Criteria";
                Scores.Insert();
                //Insert Lines
                ScoreSetupLine.Reset();
                ScoreSetupLine.SetRange(Code, ScoreSetup.Code);
                if ScoreSetupLine.Find('-') then begin
                    repeat
                        ScoreLines.Init();
                        ScoreLines."Document No." := SupplierEval."No.";
                        ScoreLines."Supplier Code" := SupplierEval."Supplier Code";
                        ScoreLines."Score Parameter" := ScoreSetup.Code;
                        ScoreLines."Line No." := ScoreSetupLine."Line No.";
                        ScoreLines.Passmark := ScoreSetupLine.Passmark;
                        ScoreLines."Maximum Score" := ScoreSetupLine."Maximum Score";
                        ScoreSetupLine.CalcFields(Description);
                        ScoreLines."Score Description" := ScoreSetupLine.Description;
                        ScoreLines."Score Criteria" := ScoreSetup."Score Criteria";
                        ScoreLines.Insert();
                    until ScoreSetupLine.Next = 0;
                end;
            until ScoreSetup.Next = 0;
        end;
        Message(SupplierMovedToEvaluationMsg, Vend.Name);
    end;

    procedure TransferItem(ItemNo: Code[20]; TransferNo: Code[20]; CompanyGoingTo: Text[250]; CompanyComingFrom: Text; Qty: Decimal; LocationTo: Code[20]; LocationFrom: Code[20]; ItemTo: Code[20])
    var
        Item: Record Item;
        ItemJnlLine: Record "Item Journal Line";
        ItemTrans: Record "Item Transfer";
        Item1: Record Item;
        ItemJnlLine2: Record "Item Journal Line";
        LineNo: Integer;
    begin
        PurchSetup.Reset;
        PurchSetup.Get;
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange("Journal Template Name", PurchSetup."Item Transfer Journal Template");
        ItemJnlLine.SetRange("Journal Batch Name", PurchSetup."Item Transfer Journal Batch");
        ItemJnlLine.DeleteAll;
        //Transfer From College
        LineNo := 0;
        ItemJnlLine.Init;
        LineNo := LineNo + 1000;
        ItemJnlLine."Journal Template Name" := PurchSetup."Item Transfer Journal Template";
        ItemJnlLine."Journal Batch Name" := PurchSetup."Item Transfer Journal Batch";
        ItemJnlLine."Line No." := LineNo;
        ItemJnlLine."Posting Date" := Today;
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
        ItemJnlLine."Document No." := TransferNo;
        ItemJnlLine.Description := CompanyGoingTo + ':' + TransferNo + ':' + ItemNo;
        ItemJnlLine."Item No." := ItemNo;
        ItemJnlLine.Validate("Item No.");
        ItemJnlLine."Location Code" := LocationFrom;
        ItemJnlLine.Validate("Location Code");
        ItemJnlLine.Quantity := Qty;
        ItemJnlLine.Validate(Quantity);
        ItemJnlLine.Insert;
        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post Batch", ItemJnlLine);
        Commit;
        //Transfer To Hotel
        ItemJnlLine2.ChangeCompany(CompanyGoingTo);
        //PurchSetup2.CHANGECOMPANY(CompanyGoingTo);
        //ItemJnlLine2.RESET;
        ItemJnlLine2.SetRange("Journal Template Name", PurchSetup2."Item Transfer Journal Template");
        ItemJnlLine2.SetRange("Journal Batch Name", PurchSetup2."Item Transfer Journal Batch");
        //IF ItemJnlLine2.FIND('-') THEN
        ItemJnlLine2.DeleteAll;
        ItemJnlLine2.Init;
        ItemJnlLine2."Line No." := LineNo + 1000;
        ItemJnlLine2."Journal Template Name" := PurchSetup2."Item Transfer Journal Template";
        ItemJnlLine2."Journal Batch Name" := PurchSetup2."Item Transfer Journal Batch";
        ItemJnlLine2."Posting Date" := Today;
        ItemJnlLine2."Entry Type" := ItemJnlLine2."Entry Type"::"Positive Adjmt.";
        ItemJnlLine2."Document No." := TransferNo;
        ItemJnlLine.Description := CompanyComingFrom + ':' + TransferNo + ':' + ItemNo;
        ItemJnlLine2."Item No." := ItemTo;
        ItemJnlLine2.Validate("Item No.");
        ItemJnlLine2."Location Code" := LocationTo;
        ItemJnlLine2.Validate("Location Code");
        ItemJnlLine2.Quantity := Qty;
        ItemJnlLine2.Validate(Quantity);
        ItemJnlLine2.Insert;
        ItemJnlLine2.Post;
    end;

    local procedure CheckifFullyordered(var IR: Record "Internal Request Header") FullyOrdered: Boolean
    var
        IRLines: Record "Internal Request Line";
    begin
        IRLines.Reset;
        IRLines.SetRange("Document Type", IR."Document Type");
        IRLines.SetRange("Document No.", IR."No.");
        if IRLines.FindFirst then begin
            IRLines.CalcSums(Quantity);
            IRLines.CalcSums("Quantity Received");
            if IRLines.Quantity = IRLines."Quantity Received" then FullyOrdered := true;
        end;
    end;

    local procedure GetLineNo(DocNo: Code[20]): Integer
    var
        LineNo: Integer;
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.Reset;
        PurchaseLine.SetRange("Document No.", DocNo);
        if PurchaseLine.FindLast then
            LineNo := LineNo + 1000
        else
            LineNo := 1000;
    end;

    local procedure GetQuoteDate(QuoteNo: Code[20]): Date
    var
        ProcurementRequest: Record "Procurement Request";
    begin
        ProcurementRequest.Reset;
        ProcurementRequest.SetRange("No.", QuoteNo);
        if ProcurementRequest.FindFirst then exit(ProcurementRequest."Creation Date");
    end;

    local procedure GetQuoteDueDate(QuoteNo: Code[20]): Date
    var
        ProcurementRequest: Record "Procurement Request";
    begin
        ProcurementRequest.Reset;
        ProcurementRequest.SetRange("No.", QuoteNo);
        if ProcurementRequest.FindFirst then exit(ProcurementRequest."Quotation Deadline");
    end;

    procedure NotifyAssetsAdmin(OrderNo: Code[20])
    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        CompanyInfo: Record "Company Information";
        UserSetup: Record "User Setup";
        FirstName: Text[100];
        PurchSetup: Record "Purchases & Payables Setup";
        Msg: Label '<p style="font-family:Verdana,Arial;font-size:10pt"><br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to inform you that a new asset %1 - %2 has been acquired. Please insure it.<br><br>Kind regards,<br><br><Strong>Thank you<Strong></p>';
    begin
        CompanyInfo.Get();
        //SMTPSetup.Get();
        PurchHeader.Reset();
        PurchHeader.SetRange("No.", OrderNo);
        PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
        if PurchHeader.FindFirst() then begin
            //Message('%1', PurchHeader."No.");
            PurchLine.Reset();
            PurchLine.SetRange("Document No.", PurchHeader."No.");
            PurchLine.SetRange(Type, PurchLine.Type::"Fixed Asset");
            PurchLine.SetRange("Asset admin notified", false);
            if PurchLine.Find('-') then
                repeat
                    PurchLine.TestField("No.");
                    Clear(Receipient);
                    SenderAddress := CompanyInfo."E-Mail";
                    SenderName := CompanyInfo.Name;
                    PurchSetup.get();
                    PurchSetup.TestField("Asset Manager Email");
                    // UserSetup.Reset();
                    // UserSetup.SetRange("Assets Admin", true);
                    // if UserSetup.FindFirst() then begin
                    //     if Employee.get(UserSetup."Employee No.") then begin
                    Receipient.Add(PurchSetup."Asset Manager Email");
                    //FirstName := Employee."First Name";
                    //     end;
                    // end;
                    Subject := 'New Asset';
                    TimeNow := Format(Time);
                    Emailmessage.Create(Receipient, Subject, '', true);
                    Emailmessage.AppendToBody(StrSubstNo(Msg, PurchLine."No.", PurchLine.Description));
                    email.Send(Emailmessage);
                    PurchLine."Asset admin notified" := true;
                    PurchLine.Modify();
                until PurchLine.Next() = 0;
            Message('Asset admin notified successfully');
        end;
    end;

    procedure CreateCustomer(var ProspectiveCust: Record "Prospective Customers")
    var
        Customers: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.Get;
        if ProspectiveCust."Customer No" = '' then begin
            Customers.Init();
            Customers."No." := '';
            Customers.Name := ProspectiveCust.Name;
            Customers.Address := ProspectiveCust."Postal Address";
            Customers.County := ProspectiveCust.County;
            Customers."Country/Region Code" := ProspectiveCust."Country/Region Code";
            Customers."Customer Posting Group" := SalesSetup."Default Customer Posting Group";
            Customers."Gen. Bus. Posting Group" := SalesSetup."Default Gen Business Group";
            Customers."VAT Bus. Posting Group" := SalesSetup."Default VAT Posting Group";
            Customers."Phone No." := ProspectiveCust."Mobile No";
            Customers."Mobile Phone No." := ProspectiveCust."Mobile No";
            Customers."Company Registration No." := ProspectiveCust."Registration No";
            Customers.Insert(true);
            ProspectiveCust."Customer No" := Customers."No.";
            ProspectiveCust.Modify();
        end;
    end;

    procedure FuelAllocation(var Fuellloc: Record "Fuel Allocations")
    var
        FuelLedgerEntries: Record "Fuel Allocation Ledger Entries";
        FuelAllocLines: Record "Fuel Allocation Lines";
    begin
        FuelAllocLines.Reset();
        FuelAllocLines.SetRange(Period, Fuellloc.Period);
        if FuelAllocLines.Find('-') then
            repeat
                FuelLedgerEntries.Init();
                FuelLedgerEntries.Period := Fuellloc.Period;
                FuelLedgerEntries.Vehicle := FuelAllocLines.Vehicle;
                FuelLedgerEntries."Card No" := FuelAllocLines."Card No";
                FuelLedgerEntries."Done by" := Fuellloc."Allocated by";
                FuelLedgerEntries.Amount := FuelAllocLines."Topup Amount";
                FuelLedgerEntries.Type := FuelLedgerEntries.Type::Allocation;
                FuelLedgerEntries."Registration Number" := FuelAllocLines."Registration Number";
                FuelLedgerEntries."Document No." := Fuellloc.Period;
                FuelLedgerEntries.Insert(true);
            until FuelAllocLines.Next = 0;
        Fuellloc.Allocated := true;
        Fuellloc.Modify();
    end;

    procedure FuelUsage(var DriverLog: Record "Driver Logging")
    var
        FuelLedgerEntries: Record "Fuel Allocation Ledger Entries";
        FA: Record "Fixed Asset";
    begin
        FuelLedgerEntries.Init();
        FuelLedgerEntries.Period := DriverLog.Period;
        FuelLedgerEntries.Vehicle := DriverLog."FA No.";
        if FA.Get(DriverLog."FA No.") then FuelLedgerEntries."Card No" := FA."Card No";
        FuelLedgerEntries."Done by" := DriverLog.Driver;
        FuelLedgerEntries.Amount := -DriverLog."Car Fuel Intakes";
        FuelLedgerEntries.Type := FuelLedgerEntries.Type::Usage;
        FuelLedgerEntries."Registration Number" := DriverLog."Car Registration Number";
        FuelLedgerEntries."Document No." := DriverLog."Log No.";
        FuelLedgerEntries.Insert(true);
        DriverLog.Submitted := true;
        DriverLog.Modify();
    end;

    procedure FuelTransfer(var FuelTransfer: Record "Fuel  Balance Transfer")
    var
        FuelLedgerEntries: Record "Fuel Allocation Ledger Entries";
        FA: Record "Fixed Asset";
    begin
        FuelLedgerEntries.Init();
        FuelLedgerEntries.Period := FuelTransfer.Period;
        FuelLedgerEntries.Vehicle := FuelTransfer."New Fixed Asset";
        FuelLedgerEntries."Card No" := FuelTransfer."New Card No";
        FuelLedgerEntries."Done by" := FuelTransfer."Created By";
        FuelLedgerEntries.Amount := FuelTransfer.Amount;
        FuelLedgerEntries.Type := FuelLedgerEntries.Type::Transfer;
        if FA.Get(FuelTransfer."FA No.") then FuelLedgerEntries."Registration Number" := FA."Registration No";
        FuelLedgerEntries."Document No." := FuelTransfer.No;
        FuelLedgerEntries.Insert(true);
        FuelLedgerEntries.Init();
        FuelLedgerEntries.Period := FuelTransfer.Period;
        FuelLedgerEntries.Vehicle := FuelTransfer."FA No.";
        FuelLedgerEntries."Card No" := FuelTransfer."Card No";
        FuelLedgerEntries."Done by" := FuelTransfer."Created By";
        FuelLedgerEntries.Amount := -FuelTransfer.Amount;
        FuelLedgerEntries.Type := FuelLedgerEntries.Type::Transfer;
        if FA.Get(FuelTransfer."FA No.") then FuelLedgerEntries."Registration Number" := FA."Registration No";
        FuelLedgerEntries."Document No." := FuelTransfer.No;
        FuelLedgerEntries.Insert(true);
        FuelTransfer.Transferred := true;
        FuelTransfer.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendPurchaseDocForApproval', '', false, false)]
    local procedure OnSendPurchaseDocForApproval(var PurchaseHeader: Record "Purchase Header")
    var
        PurchLines: Record "Purchase Line";
    begin
        PurchLines.Reset();
        PurchLines.SetRange("Document No.", PurchaseHeader."No.");
        PurchLines.SetRange("Document Type", PurchaseHeader."Document Type");
        if PurchLines.FindSet() then
            repeat
                PurchLines.TestField("Gen. Bus. Posting Group");
                PurchLines.TestField("Gen. Prod. Posting Group");
                PurchLines.TestField("VAT Bus. Posting Group");
            until PurchLines.Next() = 0;
    end;
    //Email to Notify Supplier when Quotation has been closed.
    procedure Emailnotification(var ProcurementRequest: Record "Procurement Request")
    var
        EmailAccount: Codeunit "Email Account";
        EmailMsg, EmailMsgRec : Text;
        RecepientSupp, RecipientsRec : List of [Text];
        Subject: Text;
        EmailMessage, EmailMessageRec : Codeunit "Email Message";
        Emailing, EmailingRec : Codeunit Email;
        EmailScenario: Codeunit "Email Scenario";
        EmailScenarioEnum: Enum "Email Scenario";
        ErrorMsg: Text;
        EmailLog: Record "Email Logging Liness";
        CompanyInfo: Record "Company Information";
        VendorRec: Record Vendor;
        EmailAcc, EmailAccRec : Record "Email Account";
        TenderEvaluationLine, TenderEvalRec : Record "Tender Evaluation Line";
        ProspectiveSupplier, ProspectSupp : Record "Prospective Suppliers";
    begin
        Clear(RecepientSupp);
        Clear(RecipientsRec);
        Clear(EmailMsg);
        Clear(EmailMsgRec);
        Clear(Emailing);
        Clear(EmailingRec);
        CompanyInfo.Get();
        Subject := 'Quotation Awarding and Closure';
        //Sending Email Message to Prospective Suppliers who won the Quotation:
        TenderEvaluationLine.Reset();
        TenderEvaluationLine.SetRange("Quote No", ProcurementRequest."No.");
        TenderEvaluationLine.SetRange(Awarded, true);
        if TenderEvaluationLine.FindSet() then begin
            repeat
                ProspectiveSupplier.Reset();
                ProspectiveSupplier.SetRange("No.", TenderEvaluationLine."Vendor No");
                if ProspectiveSupplier.FindFirst() then begin
                    RecepientSupp.Add(ProspectiveSupplier."Contact E-Mail Address");
                    if ProspectiveSupplier."Contact E-Mail Address" <> '' then begin
                        EmailMsg := 'Dear ' + TenderEvaluationLine."Vendor Name" + ',<br><br> Congratulations we are glad to inform you the Quotation ' + ProcurementRequest."No." + ' for ' + ProcurementRequest.Title + ' has been closed and you have been awarded the Quotatation';
                        EmailMessageRec.Create(RecepientSupp, Subject, StrSubstNo(EmailMsg), true);
                        EmailScenario.GetDefaultEmailAccount(EmailAcc);
                        EmailingRec.Send(EmailMessageRec, EmailAcc);
                    end;
                end;
            until TenderEvaluationLine.Next() = 0;
        end;
        //Sending Email Message to Prospective Suppliers who did not won the Quotation:
        TenderEvalRec.Reset();
        TenderEvalRec.SetRange("Quote No", ProcurementRequest."No.");
        TenderEvalRec.SetRange(Awarded, false);
        if TenderEvalRec.FindSet() then begin
            repeat
                ProspectSupp.Reset();
                ProspectSupp.SetRange("No.", TenderEvalRec."Vendor No");
                if ProspectSupp.FindFirst() then begin
                    RecipientsRec.Add(ProspectSupp."Contact E-Mail Address");
                    if ProspectSupp."Contact E-Mail Address" <> '' then begin
                        EmailMsgRec := 'Dear ' + TenderEvalRec."Vendor Name" + ',<br><br> We regret to inform you the Quotation ' + ProcurementRequest."No." + ' for ' + ProcurementRequest.Title + ' has been closed and Awarded hence keep trying once we announced new Quotations, Thank you for taking your time to participate in Quotation process';
                        EmailMessage.Create(RecipientsRec, Subject, StrSubstNo(EmailMsgRec), true);
                        EmailScenario.GetDefaultEmailAccount(EmailAccRec);
                        Emailing.Send(EmailMessage, EmailAccRec);
                    end;
                end;
            until TenderEvalRec.Next() = 0;
        end;
    end;
    //Sending Notification to Tender Commitee
    procedure NotifyOpeningCommitee(TenderCommitee: Record "Tender Committees")
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        PurchSetup: Record "Purchases & Payables Setup";
        AppointmentLetter: Report "Open Committee Report";
        Subject: Text;
        AttachmentInstream: InStream;
        AttachmentOutstream: OutStream;
        AttachmentTempblob: Codeunit "Temp Blob";
        EmployeeRec: Record Employee;
        FileRec: File;
        CustomerRecRef: RecordRef;
        AttachmentName: Text;
        FileSystem: Codeunit "File Management";
        PdfFileName: Text;
        CompanyInfo: Record "Company Information";
        CommitteeMembers: Record "Commitee Member";
        RecepientApp: List of [Text];
        Emailbody: Text;
        EmailScenario: Codeunit "Email Scenario";
        EmailAccountRec: Record "Email Account";
        EmailScenEnum: Enum "Email Scenario";
        Newbody: Label 'Dear %1, <br><br> You have been Successfully Selected to Opening Committee of Quotation reference No. %2, for %3 <strong> </strong> Find the Attached Opening Committee invitation from Executive Director <br><br> Kind regards<br> <br> Procurement Department';
    begin
        Clear(RecepientApp);
        Clear(EmailMessage);
        Clear(Email);
        CompanyInfo.Get();
        PurchSetup.Get();
        PurchSetup.TestField("Committee File Path");
        //Creating Filename:
        PdfFileName := PurchSetup."Comittee File Path" + '\' + EmployeeRec."No." + '.pdf';
        Clear(AppointmentLetter);
        AppointmentLetter.SetTableView(TenderCommitee);
        //EDDIEAppointmentLetter.SaveAsPdf(PdfFileName);
        CommitteeMembers.Reset();
        CommitteeMembers.SetRange("Appointment No", TenderCommitee."Appointment No");
        CommitteeMembers.SetRange("Committee Type", CommitteeMembers."Committee Type"::Opening);
        CommitteeMembers.SetRange(External, false);
        if CommitteeMembers.FindSet() then begin
            repeat
                if EmployeeRec.Get(CommitteeMembers."Employee No") then begin
                    EmployeeRec.TestField("Company E-Mail");
                    RecepientApp.Add(Employee."Company E-Mail");
                    Subject := 'Opening Committee Appointment Letter';
                    Emailbody := StrSubstNo(Newbody, EmployeeRec."First Name", TenderCommitee."Tender/Quotation No", TenderCommitee.Title);
                    EmailMessage.Create(RecepientApp, Subject, Emailbody, true);
                    //EDDIE if Exists(PdfFileName) then
                    begin
                        // FileRec.Open(PdfFileName);
                        // FileRec.CreateInStream(AttachmentInstream);
                        EmailMessage.AddAttachment(PdfFileName, EmployeeRec."No." + '.pdf', AttachmentInstream);
                        // FileRec.Close();
                    end;
                    EmailScenario.GetDefaultEmailAccount(EmailAccountRec);
                    Email.Send(EmailMessage, EmailAccountRec);
                end;
            until CommitteeMembers.Next() = 0;
        end;
    end;
}

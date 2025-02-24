report 50169 "Notification Email Extension"
{
    WordLayout = './NotificationEmail2.docx';
    // WordLayout = './NotificationEmail.docx';
    // RDLCLayout = './NotificationEmail2.rdl';
    Caption = 'Notification Email';
    DefaultLayout = Word;
    ApplicationArea = All;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            column(Line1; Line1)
            {
            }
            column(Line2; Line2)
            {
            }
            column(Line3; Line3Lbl)
            {
            }
            column(Line4; Line4Lbl)
            {
            }
            column(Settings_UrlText; SettingsLbl)
            {
            }
            column(Settings_Url; SettingsURL)
            {
            }
            column(SettingsWin_UrlText; SettingsWinLbl)
            {
            }
            column(SettingsWin_Url; SettingsWinURL)
            {
            }
            dataitem("Notification Entry"; "Notification Entry")
            {
                column(UserName; ReceipientUser."Full Name")
                {
                }
                column(DocumentType; DocumentType)
                {
                }
                column(DocumentNo; DocumentNo)
                {
                }
                column(Document_UrlText; DocumentName)
                {
                }
                column(Document_Url; DocumentURL)
                {
                }
                column(CustomLink_UrlText; CustomLinkLbl)
                {
                }
                column(CustomLink_Url; "Custom Link")
                {
                }
                column(ActionText; ActionText)
                {
                }
                column(Field1Label; Field1Label)
                {
                }
                column(Field1Value; Field1Value)
                {
                }
                column(Field2Label; Field2Label)
                {
                }
                column(Field2Value; Field2Value)
                {
                }
                column(Field3Label; Field3Label)
                {
                }
                column(Field3Value; Field3Value)
                {
                }
                column(Field4Label; Field4Label)
                {
                }
                column(Field4Value; Field4Value)
                {
                }
                column(Field5Label; Field5Label)
                {
                }
                column(Field5Value; Field5Value)
                {
                }
                column(Field6Label; Field6Label)
                {
                }
                column(Field6Value; Field6Value)
                {
                }
                column(Field7Label; Field7Label)
                {
                }
                column(Field7Value; Field7Value)
                {
                }
                column(DetailsValue; DetailsValue)
                {
                }
                column(RequesterDetails; RequesterDetails)
                {
                }
                column(Line2Lbl; Line2Lbl)
                {
                }
                column(Line4Lbl; Line4Lbl)
                {
                }
                trigger OnAfterGetRecord()
                var
                    RecRef: RecordRef;
                begin
                    FindReceipientUser();
                    CreateSettingsLink();
                    DataTypeManagement.GetRecordRef("Triggered By Record", RecRef);
                    SetDocumentTypeAndNumber(RecRef);
                    SetReportFieldPlaceholders(RecRef);
                    SetReportLinePlaceholders();
                    SetActionText();
                end;
            }
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
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
    end;

    var
        CompanyInformation: Record "Company Information";
        ReceipientUser: Record User;
        PageManagement: Codeunit "Page Management";
        DataTypeManagement: Codeunit "Data Type Management";
        NotificationManagement: Codeunit "Notification Management";
        SettingsURL: Text;
        SettingsWinURL: Text;
        DocumentType: Text;
        DocumentNo: Text;
        DocumentName: Text;
        DocumentURL: Text;
        ActionText: Text;
        Field1Label: Text;
        Field1Value: Text;
        Field2Label: Text;
        Field2Value: Text;
        Field3Label: Text;
        Field3Value: Text;
        Field4Label: Text;
        Field4Value: Text;
        Field5Label: Text;
        Field5Value: Text;
        Field6Label: Text;
        Field6Value: Text;
        Field7Label: Text;
        Field7Value: Text;
        Field8Label: Text;
        Field8Value: Text;
        SettingsLbl: Label 'Notification Settings';
        SettingsWinLbl: Label '(Windows Client)';
        CustomLinkLbl: Label '(Custom Link)';
        Line1Lbl: Label 'Hello %1,', Comment = '%1 = User Name';
        Line2Lbl: Label 'You are registered to receive notifications related to %1.', Comment = '%1 = Company Name';
        Line3Lbl: Label 'This is a message to notify you that:';
        Line4Lbl: Label 'Notification messages are sent automatically and cannot be replied to. But you can change when and how you receive notifications: ';
        DetailsLabel: Text;
        DetailsValue: Text;
        RequesterDetails: Text;
        Label2: Label ' has requested your approval for the following items';
        Label3: Label '';
        Label4: Label 'Click the following link to approve this document ';
        Line1: Text;
        Line2: Text;
        DetailsLbl: Label 'Details';
        Employee: Record Employee;
        UserSetup: Record "User Setup";

    local procedure FindReceipientUser()
    begin
        ReceipientUser.SetRange("User Name", "Notification Entry"."Recipient User ID");
        if not ReceipientUser.FindFirst then ReceipientUser.Init();
    end;

    local procedure CreateSettingsLink()
    begin
        if SettingsURL <> '' then exit;
        SettingsURL := GetUrl(CLIENTTYPE::Web, CompanyName, OBJECTTYPE::Page, Page::"Notification Setup");
    end;

    local procedure SetDocumentTypeAndNumber(SourceRecRef: RecordRef)
    var
        RecRef: RecordRef;
        IsHandled: Boolean;
    begin
        GetTargetRecRef(SourceRecRef, RecRef);
        IsHandled := false;
        OnBeforeGetDocumentTypeAndNumber("Notification Entry", RecRef, DocumentType, DocumentNo, IsHandled);
        if not IsHandled then NotificationManagement.GetDocumentTypeAndNumber(RecRef, DocumentType, DocumentNo);
        DocumentName := DocumentType + ' ' + DocumentNo;
    end;

    local procedure SetActionText()
    begin
        ActionText := NotificationManagement.GetActionTextFor("Notification Entry");
        if ActionText = 'requires your approval.' then begin
            ActionText := GetCreatedByText + ' requested your approval for the following items.';
            Field7Label := Label4 + DocumentURL + "Notification Entry"."Custom Link";
        end
        else if ActionText = 'has been created.' then begin
            ActionText := 'has been created by ' + GetCreatedByText + ' for your approval for the following items.';
        end
        else if ActionText = 'has been approved.' then begin
            ActionText := 'has been approved by ' + GetApprovedByText();
        end
        else
            ActionText := DocumentNo + ' ' + ActionText;
    end;

    local procedure SetReportFieldPlaceholders(SourceRecRef: RecordRef)
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        LeaveApp: Record "Leave Application";
        Item: Record Item;
        Payments: Record Payments;
        TrainingReq: Record "Training Request";
        InternalRequestHeader: Record "Internal Request Header";
        BankRec: Record "Bank Acc. Reconciliation";
        IncomingDocument: Record "Incoming Document";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        TenderEval: Record "Tender Evaluation Header";
        QuoteEval: Record "Quote Evaluation Header";
        Appraisal: Record "Employee Appraisal";
        RecruitmentReq: Record "Recruitment Needs";
        ApprovalEntry: Record "Approval Entry";
        TravelReq: Record "Travel Requests";
        OverdueApprovalEntry: Record "Overdue Approval Entry";
        Acting: Record "Employee Acting Position";
        RecRef: RecordRef;
        FieldRef: FieldRef;
        RecordDetails: Text;
        HasApprovalEntryAmount: Boolean;
        Amt: Decimal;
    begin
        Clear(Field1Label);
        Clear(Field1Value);
        Clear(Field2Label);
        Clear(Field2Value);
        Clear(Field3Label);
        Clear(Field3Value);
        Clear(Field4Label);
        Clear(Field4Value);
        Clear(Field5Label);
        Clear(Field5Value);
        Clear(Field6Label);
        Clear(Field6Value);
        Clear(Field7Value);
        Clear(DetailsLabel);
        Clear(DetailsValue);
        DetailsLabel := DetailsLbl;
        DetailsValue := GetCreatedByText + Label2;
        RequesterDetails := GetCreatedByText;
        if SourceRecRef.Number = DATABASE::"Approval Entry" then begin
            HasApprovalEntryAmount := true;
            SourceRecRef.SetTable(ApprovalEntry);
        end;
        GetTargetRecRef(SourceRecRef, RecRef);
        case RecRef.Number of
            DATABASE::"Incoming Document":
                begin
                    Field1Label := IncomingDocument.FieldCaption("Entry No.");
                    FieldRef := RecRef.Field(IncomingDocument.FieldNo("Entry No."));
                    Field1Value := Format(FieldRef.Value);
                    Field2Label := IncomingDocument.FieldCaption(Description);
                    FieldRef := RecRef.Field(IncomingDocument.FieldNo(Description));
                    Field2Value := Format(FieldRef.Value);
                end;
            DATABASE::"Sales Header", DATABASE::"Sales Invoice Header", DATABASE::"Sales Cr.Memo Header":
                GetSalesDocValues(Field1Label, Field1Value, Field2Label, Field2Value, RecRef, SourceRecRef);
            DATABASE::"Purchase Header", DATABASE::"Purch. Inv. Header", DATABASE::"Purch. Cr. Memo Hdr.":
                GetPurchaseDocValues(Field1Label, Field1Value, Field2Label, Field2Value, RecRef, SourceRecRef);
            DATABASE::"Gen. Journal Line":
                begin
                    RecRef.SetTable(GenJournalLine);
                    Field1Label := GenJournalLine.FieldCaption("Document No.");
                    Field1Value := Format(GenJournalLine."Document No.");
                    Field2Label := GenJournalLine.FieldCaption(Amount);
                    if GenJournalLine."Currency Code" <> '' then Field2Value := GenJournalLine."Currency Code" + ' ';
                    if HasApprovalEntryAmount then
                        Field2Value += FormatAmount(ApprovalEntry.Amount)
                    else
                        Field2Value += FormatAmount(GenJournalLine.Amount)
                end;
            DATABASE::"Gen. Journal Batch":
                begin
                    Field1Label := GenJournalBatch.FieldCaption(Description);
                    FieldRef := RecRef.Field(GenJournalBatch.FieldNo(Description));
                    Field1Value := Format(FieldRef.Value);
                    Field2Label := GenJournalBatch.FieldCaption("Template Type");
                    FieldRef := RecRef.Field(GenJournalBatch.FieldNo("Template Type"));
                    Field2Value := Format(FieldRef.Value);
                end;
            DATABASE::Customer:
                begin
                    Field1Label := Customer.FieldCaption("No.");
                    FieldRef := RecRef.Field(Customer.FieldNo("No."));
                    Field1Value := Format(FieldRef.Value);
                    Field2Label := Customer.FieldCaption(Name);
                    FieldRef := RecRef.Field(Customer.FieldNo(Name));
                    Field2Value := Format(FieldRef.Value);
                end;
            DATABASE::Vendor:
                begin
                    Field1Label := Vendor.FieldCaption("No.");
                    FieldRef := RecRef.Field(Vendor.FieldNo("No."));
                    Field1Value := Format(FieldRef.Value);
                    Field2Label := Vendor.FieldCaption(Name);
                    FieldRef := RecRef.Field(Vendor.FieldNo(Name));
                    Field2Value := Format(FieldRef.Value);
                end;
            DATABASE::"Leave Application":
                begin
                    FieldRef := RecRef.Field(LeaveApp.FieldNo("Application No"));
                    DocumentNo := Format(FieldRef.Value);
                    Field1Label := LeaveApp.FieldCaption("Days Applied");
                    FieldRef := RecRef.Field(LeaveApp.FieldNo("Days Applied"));
                    Field1Value := Format(FieldRef.Value);
                    Field2Label := LeaveApp.FieldCaption("Start Date");
                    FieldRef := RecRef.Field(LeaveApp.FieldNo("Start Date"));
                    Field2Value := Format(FieldRef.Value);
                    Field3Label := LeaveApp.FieldCaption("End Date");
                    FieldRef := RecRef.Field(LeaveApp.FieldNo("End Date"));
                    Field3Value := Format(FieldRef.Value);
                end;
            DATABASE::"Training Request":
                begin
                    FieldRef := RecRef.Field(TrainingReq.FieldNo("Request No."));
                    DocumentNo := Format(FieldRef.Value);
                    Field1Label := TrainingReq.FieldCaption("Training Need");
                    FieldRef := RecRef.Field(TrainingReq.FieldNo("Training Need"));
                    Field1Value := Format(FieldRef.Value);
                    Field2Label := TrainingReq.FieldCaption("Planned Start Date");
                    FieldRef := RecRef.Field(TrainingReq.FieldNo("Planned Start Date"));
                    Field2Value := Format(FieldRef.Value);
                    Field3Label := TrainingReq.FieldCaption("Planned End Date");
                    FieldRef := RecRef.Field(TrainingReq.FieldNo("Planned End Date"));
                    Field3Value := Format(FieldRef.Value);
                end;
            DATABASE::Payments:
                begin
                    FieldRef := RecRef.Field(Payments.FieldNo("No."));
                    DocumentNo := Format(FieldRef.Value);
                    Payments.CalcFields("Total Amount");
                    Field1Label := Payments.FieldCaption("Total Amount");
                    FieldRef := RecRef.Field(Payments.FieldNo("Total Amount"));
                    FieldRef.CalcField;
                    Amt := FieldRef.Value;
                    Field1Value += FormatAmount(Amt);
                    Field2Label := Payments.FieldCaption(Payee);
                    FieldRef := RecRef.Field(Payments.FieldNo(Payee));
                    Field2Value := Format(FieldRef.Value);
                    Field3Label := Payments.FieldCaption("Date Created");
                    FieldRef := RecRef.Field(Payments.FieldNo(Date));
                    Field3Value := Format(FieldRef.Value);
                end;
            DATABASE::"Travel Requests":
                begin
                    FieldRef := RecRef.Field(TravelReq.FieldNo("Request No."));
                    DocumentNo := Format(FieldRef.Value);
                    Field1Label := TravelReq.FieldCaption(Destination);
                    FieldRef := RecRef.Field(TravelReq.FieldNo(Destination));
                    Field1Value += FormatAmount(FieldRef.Value);
                    Field2Label := TravelReq.FieldCaption("Trip Planned Start Date");
                    FieldRef := RecRef.Field(TravelReq.FieldNo("Trip Planned Start Date"));
                    Field2Value := Format(FieldRef.Value);
                    Field3Label := TravelReq.FieldCaption("Trip Planned End Date");
                    FieldRef := RecRef.Field(TravelReq.FieldNo("Trip Planned End Date"));
                    Field3Value := Format(FieldRef.Value);
                end;
            DATABASE::"Internal Request Header":
                begin
                    FieldRef := RecRef.Field(InternalRequestHeader.FieldNo("No."));
                    DocumentNo := Format(FieldRef.Value);
                    // Field1Value := Format(InternalRequestHeader."Total Amount");
                    Field1Label := InternalRequestHeader.FieldCaption("Document Type");
                    FieldRef := RecRef.Field(InternalRequestHeader.FieldNo("Document Type"));
                    Field1Value := Format(FieldRef.Value);
                    if InternalRequestHeader."Document Type" = InternalRequestHeader."Document Type"::Purchase then begin
                        Field2Label := InternalRequestHeader.FieldCaption("Total Amount");
                        FieldRef := RecRef.Field(InternalRequestHeader.FieldNo("Total Amount"));
                        FieldRef.CalcField;
                        Amt := FieldRef.Value;
                        Field2Value += FormatAmount(Amt);
                    end
                    else if InternalRequestHeader."Document Type" = InternalRequestHeader."Document Type"::Stock then begin
                        Field2Label := 'Description';
                        FieldRef := RecRef.Field(InternalRequestHeader.FieldNo("Reason Description"));
                        Field2Value := Format(FieldRef.Value);
                    end;
                    Field3Label := InternalRequestHeader.FieldCaption("Document Date");
                    FieldRef := RecRef.Field(InternalRequestHeader.FieldNo("Document Date"));
                    Field3Value := Format(FieldRef.Value);
                end;
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    FieldRef := RecRef.Field(BankRec.FieldNo("Document No."));
                    DocumentNo := Format(FieldRef.Value);
                    // Field1Value := Format(InternalRequestHeader."Total Amount");
                    Field1Label := BankRec.FieldCaption("Bank Account No.");
                    FieldRef := RecRef.Field(BankRec.FieldNo("Bank Account No."));
                    Field1Value := Format(FieldRef.Value);
                    Field2Label := BankRec.FieldCaption("Statement No.");
                    FieldRef := RecRef.Field(BankRec.FieldNo("Statement Type"));
                    Field2Value += Format(FieldRef.Value);
                    Field3Label := BankRec.FieldCaption("Statement Date");
                    FieldRef := RecRef.Field(BankRec.FieldNo("Statement Date"));
                    Field3Value := Format(FieldRef.Value);
                end;
            DATABASE::Item:
                begin
                    Field1Label := Item.FieldCaption("No.");
                    FieldRef := RecRef.Field(Item.FieldNo("No."));
                    Field1Value := Format(FieldRef.Value);
                    Field2Label := Item.FieldCaption(Description);
                    FieldRef := RecRef.Field(Item.FieldNo(Description));
                    Field2Value := Format(FieldRef.Value);
                end;
            DATABASE::"Tender Evaluation Header":
                begin
                    Field1Label := TenderEval.FieldCaption("Quote No");
                    FieldRef := RecRef.Field(TenderEval.FieldNo("Quote No"));
                    Field1Value := Format(FieldRef.Value);
                    Field2Label := TenderEval.FieldCaption(Title);
                    FieldRef := RecRef.Field(TenderEval.FieldNo(Title));
                    Field2Value := Format(FieldRef.Value);
                    Field3Label := TenderEval.FieldCaption("Date of Award");
                    FieldRef := RecRef.Field(TenderEval.FieldNo("Date of Award"));
                    Field3Value := Format(FieldRef.Value);
                end;
            DATABASE::"Quote Evaluation Header":
                begin
                    Field1Label := QuoteEval.FieldCaption("Quote No");
                    FieldRef := RecRef.Field(QuoteEval.FieldNo("Quote No"));
                    Field1Value := Format(FieldRef.Value);
                    Field2Label := QuoteEval.FieldCaption(Title);
                    FieldRef := RecRef.Field(QuoteEval.FieldNo(Title));
                    Field2Value := Format(FieldRef.Value);
                    Field3Label := QuoteEval.FieldCaption("Date of Award");
                    FieldRef := RecRef.Field(QuoteEval.FieldNo("Date of Award"));
                    Field3Value := Format(FieldRef.Value);
                end;
            DATABASE::"Employee Appraisal":
                begin
                    FieldRef := RecRef.Field(Appraisal.FieldNo("Appraisal No"));
                    DocumentNo := Format(FieldRef.Value);
                    Field1Label := Appraisal.FieldCaption("Appraisee Name");
                    FieldRef := RecRef.Field(Appraisal.FieldNo("Appraisee Name"));
                    Field1Value := Format(FieldRef.Value);
                    Field2Label := Appraisal.FieldCaption("Appraisal Period");
                    FieldRef := RecRef.Field(Appraisal.FieldNo("Appraisal Period"));
                    Field2Value := Format(FieldRef.Value);
                    Field3Label := Appraisal.FieldCaption("Appraisers Name");
                    FieldRef := RecRef.Field(Appraisal.FieldNo("Appraisers Name"));
                    Field3Value := FormatAmount(FieldRef.Value);
                end;
            DATABASE::"Recruitment Needs":
                begin
                    FieldRef := RecRef.Field(RecruitmentReq.FieldNo("No."));
                    DocumentNo := Format(FieldRef.Value);
                    Field1Label := RecruitmentReq.FieldCaption(Description);
                    FieldRef := RecRef.Field(RecruitmentReq.FieldNo(Description));
                    Field1Value := Format(FieldRef.Value);
                    Field2Label := RecruitmentReq.FieldCaption("Appointment Type");
                    FieldRef := RecRef.Field(RecruitmentReq.FieldNo("Appointment Type Description"));
                    Field2Value := Format(FieldRef.Value);
                    Field3Label := RecruitmentReq.FieldCaption(Positions);
                    FieldRef := RecRef.Field(RecruitmentReq.FieldNo(Positions));
                    Field3Value := FormatAmount(FieldRef.Value);
                end;
            DATABASE::"Employee Acting Position":
                begin
                    FieldRef := RecRef.Field(Acting.FieldNo(No));
                    DocumentNo := Format(FieldRef.Value);
                    Field1Label := Acting.FieldCaption("Promotion Type");
                    FieldRef := RecRef.Field(Acting.FieldNo("Promotion Type"));
                    Field1Value := Format(FieldRef.Value);
                    Field2Label := Acting.FieldCaption(Name);
                    FieldRef := RecRef.Field(Acting.FieldNo(Name));
                    Field2Value := Format(FieldRef.Value);
                    if Acting."Promotion Type" = Acting."Promotion Type"::"Acting Position" then begin
                        Field3Label := Acting.FieldCaption("Relieved Employee");
                        FieldRef := RecRef.Field(Acting.FieldNo("Relieved Name"));
                        Field3Value := FormatAmount(FieldRef.Value);
                    end
                    else begin
                        Field3Label := Acting.FieldCaption(Position);
                        FieldRef := RecRef.Field(Acting.FieldNo("Position Name"));
                        Field3Value := FormatAmount(FieldRef.Value);
                    end;
                end;
            else
                OnSetReportFieldPlaceholders(RecRef, Field1Label, Field1Value, Field2Label, Field2Value, Field3Label, Field3Value);
        end;
        case "Notification Entry".Type of
            "Notification Entry".Type::Approval:
                begin
                    SourceRecRef.SetTable(ApprovalEntry);
                    if ApprovalEntry."Amount (LCY)" <> 0 then begin
                        Field1Label := ApprovalEntry.FieldCaption("Amount (LCY)");
                        Field1Value := Format(ApprovalEntry."Amount (LCY)");
                    end;
                    if Field2Label = '' then Field2Label := ApprovalEntry.FieldCaption("Due Date");
                    if Field2Value = '' then Field2Value := Format(ApprovalEntry."Due Date");
                    RecordDetails := ApprovalEntry.GetChangeRecordDetails;
                    if RecordDetails <> '' then DetailsValue += RecordDetails;
                end;
            "Notification Entry".Type::Overdue:
                begin
                    Field3Label := OverdueApprovalEntry.FieldCaption("Due Date");
                    FieldRef := SourceRecRef.Field(OverdueApprovalEntry.FieldNo("Due Date"));
                    Field3Value := Format(FieldRef.Value);
                end;
        end;
        DocumentURL := PageManagement.GetWebUrl(RecRef, "Notification Entry"."Link Target Page");
    end;

    local procedure SetReportLinePlaceholders()
    begin
        Line1 := StrSubstNo(Line1Lbl, GetUserFullName("Notification Entry"."Recipient User ID"));
        Line2 := StrSubstNo(Line2Lbl, CompanyInformation.Name);
    end;

    local procedure GetTargetRecRef(RecRef: RecordRef; var TargetRecRefOut: RecordRef)
    var
        ApprovalEntry: Record "Approval Entry";
        OverdueApprovalEntry: Record "Overdue Approval Entry";
    begin
        case "Notification Entry".Type of // "Notification Entry".Type::"New Record":
                                          //     TargetRecRefOut := RecRef;
            "Notification Entry".Type::Approval:
                begin
                    RecRef.SetTable(ApprovalEntry);
                    TargetRecRefOut.Get(ApprovalEntry."Record ID to Approve");
                end;
            "Notification Entry".Type::Overdue:
                begin
                    RecRef.SetTable(OverdueApprovalEntry);
                    TargetRecRefOut.Get(OverdueApprovalEntry."Record ID to Approve");
                end;
        end;
    end;

    local procedure GetSalesDocValues(var Field1Label: Text; var Field1Value: Text; var Field2Label: Text; var Field2Value: Text; RecRef: RecordRef; SourceRecRef: RecordRef)
    var
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        Customer: Record Customer;
        AmountFieldRef: FieldRef;
        CurrencyCode: Code[10];
        CustomerNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"Sales Header":
                begin
                    RecRef.SetTable(SalesHeader);
                    AmountFieldRef := RecRef.Field(SalesHeader.FieldNo(Amount));
                    CurrencyCode := SalesHeader."Currency Code";
                    CustomerNo := SalesHeader."Sell-to Customer No.";
                end;
            DATABASE::"Sales Invoice Header":
                begin
                    RecRef.SetTable(SalesInvoiceHeader);
                    AmountFieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo(Amount));
                    CurrencyCode := SalesInvoiceHeader."Currency Code";
                    CustomerNo := SalesInvoiceHeader."Sell-to Customer No.";
                end;
            DATABASE::"Sales Cr.Memo Header":
                begin
                    RecRef.SetTable(SalesCrMemoHeader);
                    AmountFieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo(Amount));
                    CurrencyCode := SalesCrMemoHeader."Currency Code";
                    CustomerNo := SalesCrMemoHeader."Sell-to Customer No.";
                end;
        end;
        GetSalesPurchDocAmountValue(Field1Label, Field1Value, SourceRecRef, AmountFieldRef, CurrencyCode);
        Field2Label := Customer.TableCaption;
        if Customer.Get(CustomerNo) then Field2Value := Customer.Name + ' (#' + Format(Customer."No.") + ')';
    end;

    local procedure GetPurchaseDocValues(var Field1Label: Text; var Field1Value: Text; var Field2Label: Text; var Field2Value: Text; RecRef: RecordRef; SourceRecRef: RecordRef)
    var
        PurchaseHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        Vendor: Record Vendor;
        AmountFieldRef: FieldRef;
        CurrencyCode: Code[10];
        VendorNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"Purchase Header":
                begin
                    RecRef.SetTable(PurchaseHeader);
                    AmountFieldRef := RecRef.Field(PurchaseHeader.FieldNo(Amount));
                    CurrencyCode := PurchaseHeader."Currency Code";
                    VendorNo := PurchaseHeader."Buy-from Vendor No.";
                end;
            DATABASE::"Purch. Inv. Header":
                begin
                    RecRef.SetTable(PurchInvHeader);
                    AmountFieldRef := RecRef.Field(PurchInvHeader.FieldNo(Amount));
                    CurrencyCode := PurchInvHeader."Currency Code";
                    VendorNo := PurchInvHeader."Buy-from Vendor No.";
                end;
            DATABASE::"Purch. Cr. Memo Hdr.":
                begin
                    RecRef.SetTable(PurchCrMemoHdr);
                    AmountFieldRef := RecRef.Field(PurchCrMemoHdr.FieldNo(Amount));
                    CurrencyCode := PurchCrMemoHdr."Currency Code";
                    VendorNo := PurchCrMemoHdr."Buy-from Vendor No.";
                end;
        end;
        GetSalesPurchDocAmountValue(Field1Label, Field1Value, SourceRecRef, AmountFieldRef, CurrencyCode);
        Field2Label := Vendor.TableCaption;
        if Vendor.Get(VendorNo) then Field2Value := Vendor.Name + ' (#' + Format(Vendor."No.") + ')';
    end;

    local procedure GetSalesPurchDocAmountValue(var Field1Label: Text; var Field1Value: Text; SourceRecRef: RecordRef; AmountFieldRef: FieldRef; CurrencyCode: Code[10])
    var
        ApprovalEntry: Record "Approval Entry";
        Amount: Decimal;
    begin
        Field1Label := AmountFieldRef.Caption;
        if CurrencyCode <> '' then Field1Value := CurrencyCode + ' ';
        if SourceRecRef.Number = DATABASE::"Approval Entry" then begin
            SourceRecRef.SetTable(ApprovalEntry);
            Field1Value += FormatAmount(ApprovalEntry.Amount);
        end
        else begin
            AmountFieldRef.CalcField;
            Amount := AmountFieldRef.Value;
            Field1Value += FormatAmount(Amount);
        end;
    end;

    local procedure FormatAmount(Amount: Decimal): Text
    begin
        exit(Format(Amount, 0, '<Precision,2><Standard Format,0>'));
    end;

    local procedure GetCreatedByText(): Text
    begin
        // if "Notification Entry"."Sender User ID" <> '' then
        //     exit(GetUserFullName("Notification Entry"."Sender User ID"));
        // exit(GetUserFullName("Notification Entry"."Created By"));
        UserSetup.Reset();
        UserSetup.SetRange("User ID", "Notification Entry"."Sender User ID");
        if UserSetup.FindFirst() then begin
            Employee.reset;
            Employee.SetRange("No.", UserSetup."Employee No.");
            if Employee.FindFirst() then exit(Employee."First Name" + ' ' + Employee."Last Name");
        end;
    end;

    local procedure GetApprovedByText(): Text
    begin
        // if "Notification Entry"."Sender User ID" <> '' then
        //     exit(GetUserFullName("Notification Entry"."Sender User ID"));
        // exit(GetUserFullName("Notification Entry"."Created By"));
        UserSetup.Reset();
        UserSetup.SetRange("User ID", "Notification Entry"."Recipient User ID");
        if UserSetup.FindLast() then begin
            Employee.reset;
            Employee.SetRange("No.", UserSetup."Employee No.");
            if Employee.FindFirst() then exit(Employee."First Name" + ' ' + Employee."Last Name");
        end;
    end;

    local procedure GetUserFullName(NotificationUserID: Code[50]): Text[80]
    var
        User: Record User;
    begin
        // User.SetRange("User Name", NotificationUserID);
        // if User.FindFirst and (User."Full Name" <> '') then
        //     exit(User."Full Name");
        // exit(NotificationUserID);
        UserSetup.Reset();
        UserSetup.SetRange("User ID", NotificationUserID);
        if UserSetup.FindFirst() then begin
            Employee.reset;
            Employee.SetRange("No.", UserSetup."Employee No.");
            if Employee.FindFirst() then exit(Employee."First Name" + ' ' + Employee."Last Name");
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentTypeAndNumber(var NotificationEntry: Record "Notification Entry"; var RecRef: RecordRef; var DocumentType: Text; var DocumentNo: Text; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnSetReportFieldPlaceholders(RecRef: RecordRef; var Field1Label: Text; var Field1Value: Text; var Field2Label: Text; var Field2Value: Text; var Field3Label: Text; var Field3Value: Text)
    begin
    end;
}

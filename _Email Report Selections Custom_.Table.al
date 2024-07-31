table 50484 "Email Report Selections Custom"
{
    Caption = 'Report Selections';

    fields
    {
        field(1; Usage; Option)
        {
            Caption = 'Usage';
            OptionCaption = 'Statement,Contributions Reconciliation,Client Notifications';
            OptionMembers = Statement, "Contributions Reconciliation", "Client Notifications";
        }
        field(2; Sequence; Code[10])
        {
            Caption = 'Sequence';
            Numeric = true;
        }
        field(3; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type"=CONST(Report));

            trigger OnValidate()
            begin
                CalcFields("Report Caption");
                Validate("Use for Email Body", false);
            end;
        }
        field(4; "Report Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type"=CONST(Report), "Object ID"=FIELD("Report ID")));
            Caption = 'Report Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Custom Report Layout Code"; Code[20])
        {
            Caption = 'Custom Report Layout Code';
            Editable = false;
            TableRelation = "Custom Report Layout".Code WHERE(Code=FIELD("Custom Report Layout Code"));
        }
        field(19; "Use for Email Attachment"; Boolean)
        {
            Caption = 'Use for Email Attachment';
            InitValue = true;

            trigger OnValidate()
            begin
                if not "Use for Email Body" then Validate("Email Body Layout Code", '');
            end;
        }
        field(20; "Use for Email Body"; Boolean)
        {
            Caption = 'Use for Email Body';

            trigger OnValidate()
            begin
                if not "Use for Email Body" then Validate("Email Body Layout Code", '');
            end;
        }
        field(21; "Email Body Layout Code"; Code[20])
        {
            Caption = 'Email Body Layout Code';
            TableRelation = IF("Email Body Layout Type"=CONST("Custom Report Layout"))"Custom Report Layout".Code WHERE(Code=FIELD("Email Body Layout Code"), "Report ID"=FIELD("Report ID"))
            ELSE IF("Email Body Layout Type"=CONST("HTML Layout"))"O365 HTML Template".Code;

            trigger OnValidate()
            begin
                if "Email Body Layout Code" <> '' then TestField("Use for Email Body", true);
                CalcFields("Email Body Layout Description");
            end;
        }
        field(22; "Email Body Layout Description"; Text[250])
        {
            CalcFormula = Lookup("Custom Report Layout".Description WHERE(Code=FIELD("Email Body Layout Code")));
            Caption = 'Email Body Layout Description';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                CustomReportLayout: Record "Custom Report Layout";
            begin
                if "Email Body Layout Type" = "Email Body Layout Type"::"Custom Report Layout" then if CustomReportLayout.LookupLayoutOK("Report ID")then Validate("Email Body Layout Code", CustomReportLayout.Code);
            end;
        }
        field(25; "Email Body Layout Type"; Option)
        {
            Caption = 'Email Body Layout Type';
            OptionCaption = 'Custom Report Layout,HTML Layout';
            OptionMembers = "Custom Report Layout", "HTML Layout";
        }
        field(30; "Communication Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'E-mail,SMS,E-mail & SMS';
            OptionMembers = "E-mail", SMS, "E-mail & SMS";
        }
    }
    keys
    {
        key(Key1; Usage, Sequence)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        CheckEmailBodyUsage;
    end;
    trigger OnModify()
    begin
        TestField("Report ID");
        CheckEmailBodyUsage;
    end;
    var ReportSelection2: Record "Email Report Selections Custom";
    MustSelectAndEmailBodyOrAttahmentErr: Label 'You must select an email body or attachment in report selection for %1.', Comment = '%1 = Usage, for example Sales Invoice';
    EmailBodyIsAlreadyDefinedErr: Label 'An email body is already defined for %1.', Comment = '%1 = Usage, for example Sales Invoice';
    CannotBeUsedAsAnEmailBodyErr: Label 'Report %1 uses the %2 which cannot be used as an email body.', Comment = '%1 = Report ID,%2 = Type';
    ReportLayoutSelection: Record "Report Layout Selection";
    InteractionMgt: Codeunit "Interaction Mgt.";
    procedure NewRecord()
    begin
        ReportSelection2.SetRange(Usage, Usage);
        if ReportSelection2.FindLast and (ReportSelection2.Sequence <> '')then Sequence:=IncStr(ReportSelection2.Sequence)
        else
            Sequence:='1';
    end;
    local procedure CheckEmailBodyUsage()
    var
        ReportSelections: Record "Email Report Selections Custom";
        ReportLayoutSelection: Record "Report Layout Selection";
    begin
        if "Use for Email Body" then begin
            ReportSelections.FilterEmailBodyUsage(Usage);
            ReportSelections.SetFilter(Sequence, '<>%1', Sequence);
            if not ReportSelections.IsEmpty then Error(EmailBodyIsAlreadyDefinedErr, Usage);
            if "Email Body Layout Code" = '' then if ReportLayoutSelection.GetDefaultType("Report ID") = ReportLayoutSelection.Type::"RDLC (built-in)" then Error(CannotBeUsedAsAnEmailBodyErr, "Report ID", ReportLayoutSelection.Type);
        end;
    end;
    procedure FilterPrintUsage(ReportUsage: Integer)
    begin
        Reset;
        SetRange(Usage, ReportUsage);
    end;
    procedure FilterEmailUsage(ReportUsage: Integer)
    begin
        Reset;
        SetRange(Usage, ReportUsage);
        SetRange("Use for Email Body", true);
    end;
    procedure FilterEmailBodyUsage(ReportUsage: Integer)
    begin
        Reset;
        SetRange(Usage, ReportUsage);
        SetRange("Use for Email Body", true);
    end;
    procedure FilterEmailAttachmentUsage(ReportUsage: Integer)
    begin
        Reset;
        SetRange(Usage, ReportUsage);
        SetRange("Use for Email Attachment", true);
    end;
    procedure FindPrintUsage(ReportUsage: Integer; CustNo: Code[20]; var ReportSelections: Record "Email Report Selections Custom")
    begin
        FilterPrintUsage(ReportUsage);
        SetFilter("Report ID", '<>0');
        FindReportSelections(ReportSelections, CustNo);
        ReportSelections.FindSet;
    end;
    procedure FindPrintUsageVendor(ReportUsage: Integer; VendorNo: Code[20]; var ReportSelections: Record "Email Report Selections Custom")
    begin
        FilterPrintUsage(ReportUsage);
        SetFilter("Report ID", '<>0');
        FindReportSelectionsVendor(ReportSelections, VendorNo);
        ReportSelections.FindSet;
    end;
    procedure FindEmailAttachmentUsage(ReportUsage: Integer; CustNo: Code[20]; var ReportSelections: Record "Email Report Selections Custom"): Boolean begin
        FilterEmailAttachmentUsage(ReportUsage);
        SetFilter("Report ID", '<>0');
        SetRange("Use for Email Attachment", true);
        FindReportSelections(ReportSelections, CustNo);
        exit(ReportSelections.FindSet);
    end;
    procedure FindEmailAttachmentUsageVendor(ReportUsage: Integer; VendorNo: Code[20]; var ReportSelections: Record "Email Report Selections Custom"): Boolean begin
        FilterEmailAttachmentUsage(ReportUsage);
        SetFilter("Report ID", '<>0');
        SetRange("Use for Email Attachment", true);
        FindReportSelectionsVendor(ReportSelections, VendorNo);
        exit(ReportSelections.FindSet);
    end;
    procedure FindEmailBodyUsage(ReportUsage: Integer; CustNo: Code[20]; var ReportSelections: Record "Email Report Selections Custom"): Boolean begin
        FilterEmailBodyUsage(ReportUsage);
        SetFilter("Report ID", '<>0');
        FindReportSelections(ReportSelections, CustNo);
        exit(ReportSelections.FindSet);
    end;
    procedure FindEmailBodyUsageVendor(ReportUsage: Integer; VendorNo: Code[20]; var ReportSelections: Record "Email Report Selections Custom"): Boolean begin
        FilterEmailBodyUsage(ReportUsage);
        SetFilter("Report ID", '<>0');
        FindReportSelectionsVendor(ReportSelections, VendorNo);
        exit(ReportSelections.FindSet);
    end;
    procedure PrintWithCheck(ReportUsage: Integer; RecordVariant: Variant; CustNo: Code[20])
    begin
        PrintWithGUIYesNoWithCheck(ReportUsage, RecordVariant, true, CustNo);
    end;
    procedure PrintWithGUIYesNoWithCheck(ReportUsage: Integer; RecordVariant: Variant; IsGUI: Boolean; CustNo: Code[20])
    var
        TempReportSelections: Record "Email Report Selections Custom" temporary;
    begin
        OnBeforeSetReportLayout(RecordVariant);
        FilterPrintUsage(ReportUsage);
        FindReportSelections(TempReportSelections, CustNo);
        if not TempReportSelections.FindSet then FindSet;
        repeat ReportLayoutSelection.SetTempLayoutSelected(TempReportSelections."Custom Report Layout Code");
            TempReportSelections.TestField("Report ID");
            REPORT.RunModal(TempReportSelections."Report ID", IsGUI, false, RecordVariant);
        until TempReportSelections.Next = 0;
        ReportLayoutSelection.SetTempLayoutSelected('');
    end;
    procedure Print(ReportUsage: Integer; RecordVariant: Variant; CustNo: Code[20])
    begin
        PrintWithGUIYesNo(ReportUsage, RecordVariant, true, CustNo);
    end;
    procedure PrintWithGUIYesNo(ReportUsage: Integer; RecordVariant: Variant; IsGUI: Boolean; CustNo: Code[20])
    var
        TempReportSelections: Record "Email Report Selections Custom" temporary;
    begin
        OnBeforeSetReportLayout(RecordVariant);
        FindPrintUsage(ReportUsage, CustNo, TempReportSelections);
        repeat ReportLayoutSelection.SetTempLayoutSelected(TempReportSelections."Custom Report Layout Code");
            REPORT.RunModal(TempReportSelections."Report ID", IsGUI, false, RecordVariant);
        until TempReportSelections.Next = 0;
        ReportLayoutSelection.SetTempLayoutSelected('');
    end;
    procedure PrintWithGUIYesNoVendor(ReportUsage: Integer; RecordVariant: Variant; IsGUI: Boolean; VendorNo: Code[20])
    var
        TempReportSelections: Record "Email Report Selections Custom" temporary;
    begin
        OnBeforeSetReportLayout(RecordVariant);
        FindPrintUsageVendor(ReportUsage, VendorNo, TempReportSelections);
        repeat ReportLayoutSelection.SetTempLayoutSelected(TempReportSelections."Custom Report Layout Code");
            REPORT.RunModal(TempReportSelections."Report ID", IsGUI, false, RecordVariant);
        until TempReportSelections.Next = 0;
        ReportLayoutSelection.SetTempLayoutSelected('');
    end;
    procedure GetHtmlReport(var ServerEmailBodyFilePath: Text[250]; ReportUsage: Integer; RecordVariant: Variant; CustNo: Code[20])
    var
        TempBodyReportSelections: Record "Email Report Selections Custom" temporary;
    begin
        ServerEmailBodyFilePath:='';
        FindPrintUsage(ReportUsage, CustNo, TempBodyReportSelections);
        ServerEmailBodyFilePath:=SaveReportAsHTML(TempBodyReportSelections."Report ID", RecordVariant, TempBodyReportSelections."Custom Report Layout Code");
    end;
    procedure GetPdfReport(var ServerEmailBodyFilePath: Text[250]; ReportUsage: Integer; RecordVariant: Variant; CustNo: Code[20])
    var
        TempBodyReportSelections: Record "Email Report Selections Custom" temporary;
    begin
        ServerEmailBodyFilePath:='';
        FindPrintUsage(ReportUsage, CustNo, TempBodyReportSelections);
        ServerEmailBodyFilePath:=SaveReportAsPDF(TempBodyReportSelections."Report ID", RecordVariant, TempBodyReportSelections."Custom Report Layout Code");
    end;
    procedure GetEmailBodyInPdf(var ServerEmailBodyFilePath: Text[250]; ReportUsage: Integer; RecordVariant: Variant; CustNo: Code[20]; var CustEmailAddress: Text[250]): Boolean var
        TempBodyReportSelections: Record "Email Report Selections Custom" temporary;
    begin
        ServerEmailBodyFilePath:='';
        CustEmailAddress:=GetEmailAddressIgnoringLayout(ReportUsage, RecordVariant, CustNo);
        if not FindEmailBodyUsage(ReportUsage, CustNo, TempBodyReportSelections)then exit(false);
        ServerEmailBodyFilePath:=SaveReportAsPDF(TempBodyReportSelections."Report ID", RecordVariant, TempBodyReportSelections."Email Body Layout Code");
        CustEmailAddress:=GetEmailAddress(ReportUsage, RecordVariant, CustNo, TempBodyReportSelections);
        exit(true);
    end;
    procedure GetEmailBody(var ServerEmailBodyFilePath: Text[250]; ReportUsage: Integer; RecordVariant: Variant; CustNo: Code[20]; var CustEmailAddress: Text[250]): Boolean var
        TempBodyReportSelections: Record "Email Report Selections Custom" temporary;
        O365HTMLTemplMgt: Codeunit "O365 HTML Templ. Mgt. Cust";
    begin
        ServerEmailBodyFilePath:='';
        if CustEmailAddress = '' then CustEmailAddress:=GetEmailAddressIgnoringLayout(ReportUsage, RecordVariant, CustNo);
        if not FindEmailBodyUsage(ReportUsage, CustNo, TempBodyReportSelections)then exit(false);
        case "Email Body Layout Type" of "Email Body Layout Type"::"Custom Report Layout": ServerEmailBodyFilePath:=SaveReportAsHTML(TempBodyReportSelections."Report ID", RecordVariant, TempBodyReportSelections."Email Body Layout Code");
        "Email Body Layout Type"::"HTML Layout": ServerEmailBodyFilePath:=O365HTMLTemplMgt.CreateEmailBodyFromReportSelections(Rec, RecordVariant, CustEmailAddress);
        end;
        CustEmailAddress:=GetEmailAddress(ReportUsage, RecordVariant, CustNo, TempBodyReportSelections);
        exit(true);
    end;
    local procedure GetEmailAddressIgnoringLayout(ReportUsage: Integer; RecordVariant: Variant; CustNo: Code[20]): Text[250]var
        TempBodyReportSelections: Record "Email Report Selections Custom" temporary;
        EmailAddress: Text[250];
    begin
        EmailAddress:=GetEmailAddress(ReportUsage, RecordVariant, CustNo, TempBodyReportSelections);
        exit(EmailAddress);
    end;
    local procedure GetEmailAddress(ReportUsage: Integer; RecordVariant: Variant; CustNo: Code[20]; var TempBodyReportSelections: Record "Email Report Selections Custom" temporary): Text[250]var
        DataTypeManagement: Codeunit "Data Type Management";
        RecordRef: RecordRef;
        FieldRef: FieldRef;
        DocumentNo: Code[20];
        EmailAddress: Text[250];
    begin
        RecordRef.GetTable(RecordVariant);
        if not RecordRef.IsEmpty then if DataTypeManagement.FindFieldByName(RecordRef, FieldRef, 'No.')then begin
                DocumentNo:=FieldRef.Value;
                EmailAddress:=GetDocumentEmailAddress(DocumentNo, ReportUsage);
                if EmailAddress <> '' then exit(EmailAddress);
            end;
        if not TempBodyReportSelections.IsEmpty then begin
            EmailAddress:=FindEmailAddressForEmailLayout(TempBodyReportSelections."Email Body Layout Code", CustNo, ReportUsage);
            if EmailAddress <> '' then exit(EmailAddress);
        end;
        EmailAddress:=GetCustEmailAddress(CustNo);
        exit(EmailAddress);
    end;
    procedure GetEmailBodyVendor(var ServerEmailBodyFilePath: Text[250]; ReportUsage: Integer; RecordVariant: Variant; VendorNo: Code[20]; var VendorEmailAddress: Text[250]): Boolean var
        TempBodyReportSelections: Record "Email Report Selections Custom" temporary;
    begin
        ServerEmailBodyFilePath:='';
        VendorEmailAddress:=GetVendorEmailAddress(VendorNo);
        if not FindEmailBodyUsageVendor(ReportUsage, VendorNo, TempBodyReportSelections)then exit(false);
        ServerEmailBodyFilePath:=SaveReportAsHTML(TempBodyReportSelections."Report ID", RecordVariant, TempBodyReportSelections."Email Body Layout Code");
        VendorEmailAddress:=FindEmailAddressForEmailLayoutVendor(TempBodyReportSelections."Email Body Layout Code", VendorNo, ReportUsage);
        if VendorEmailAddress = '' then VendorEmailAddress:=GetVendorEmailAddress(VendorNo);
        exit(true);
    end;
    procedure SendEmailInBackground(JobQueueEntry: Record "Job Queue Entry")
    var
        RecRef: RecordRef;
        ReportUsage: Integer;
        DocNo: Code[20];
        DocName: Text[150];
        No: Code[20];
        ParamString: Text;
    begin
        // Called from codeunit 260 OnRun trigger - in a background process.
        RecRef.Get(JobQueueEntry."Record ID to Process");
        RecRef.LockTable;
        RecRef.Find;
        RecRef.SetRecFilter;
        ParamString:=JobQueueEntry."Parameter String"; // Are set in function SendEmailToCust
        GetJobQueueParameters(ParamString, ReportUsage, DocNo, DocName, No);
        if ParamString = 'Vendor' then SendEmailToVendorDirectly(ReportUsage, RecRef, DocNo, DocName, false, No)
        else
            SendEmailToCustDirectly(ReportUsage, RecRef, DocNo, DocName, false, No);
    end;
    procedure GetJobQueueParameters(var ParameterString: Text; var ReportUsage: Integer; var DocNo: Code[20]; var DocName: Text[150]; var CustNo: Code[20])WasSuccessful: Boolean begin
        WasSuccessful:=Evaluate(ReportUsage, GetNextJobQueueParam(ParameterString));
        WasSuccessful:=WasSuccessful and Evaluate(DocNo, GetNextJobQueueParam(ParameterString));
        WasSuccessful:=WasSuccessful and Evaluate(DocName, GetNextJobQueueParam(ParameterString));
        WasSuccessful:=WasSuccessful and Evaluate(CustNo, GetNextJobQueueParam(ParameterString));
    end;
    local procedure GetNextJobQueueParam(var Parameter: Text): Text var
        i: Integer;
        Result: Text;
    begin
        i:=StrPos(Parameter, '|');
        if i > 0 then Result:=CopyStr(Parameter, 1, i - 1);
        if(i + 1) < StrLen(Parameter)then Parameter:=CopyStr(Parameter, i + 1);
        exit(Result);
    end;
    procedure SendEmailToCust(ReportUsage: Integer; RecordVariant: Variant; DocNo: Code[20]; DocName: Text[150]; ShowDialog: Boolean; CustNo: Code[20])
    var
        JobQueueEntry: Record "Job Queue Entry";
        SMTPMail: Codeunit "Email Message";
        OfficeMgt: Codeunit "Office Management";
        RecRef: RecordRef;
    begin
        if ShowDialog or //eddie  (not SMTPMail.IsEnabled) or
        (GetEmailAddressIgnoringLayout(ReportUsage, RecordVariant, CustNo) = '') or OfficeMgt.IsAvailable then begin
            SendEmailToCustDirectly(ReportUsage, RecordVariant, DocNo, DocName, true, CustNo);
            exit;
        end;
        RecRef.GetTable(RecordVariant);
        JobQueueEntry.Init;
        JobQueueEntry."Object Type to Run":=JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run":=CODEUNIT::"Document-Mailing";
        JobQueueEntry."Maximum No. of Attempts to Run":=3;
        JobQueueEntry."Record ID to Process":=RecRef.RecordId;
        JobQueueEntry."Parameter String":=StrSubstNo('%1|%2|%3|%4|', ReportUsage, DocNo, DocName, CustNo);
        JobQueueEntry.Description:=CopyStr(DocName, 1, MaxStrLen(JobQueueEntry.Description));
        CODEUNIT.Run(CODEUNIT::"Job Queue - Enqueue", JobQueueEntry);
    end;
    procedure SendEmailToVendor(ReportUsage: Integer; RecordVariant: Variant; DocNo: Code[20]; DocName: Text[150]; ShowDialog: Boolean; VendorNo: Code[20])
    var
        JobQueueEntry: Record "Job Queue Entry";
        SMTPMail: Codeunit "Email Message";
        OfficeMgt: Codeunit "Office Management";
        RecRef: RecordRef;
    begin
        if ShowDialog or //eddie  not SMTPMail.IsEnabled  
        (GetVendorEmailAddress(VendorNo) = '') or OfficeMgt.IsAvailable then begin
            SendEmailToVendorDirectly(ReportUsage, RecordVariant, DocNo, DocName, true, VendorNo);
            exit;
        end;
        RecRef.GetTable(RecordVariant);
        JobQueueEntry.Init;
        JobQueueEntry."Object Type to Run":=JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run":=CODEUNIT::"Document-Mailing";
        JobQueueEntry."Maximum No. of Attempts to Run":=3;
        JobQueueEntry."Record ID to Process":=RecRef.RecordId;
        JobQueueEntry."Parameter String":=StrSubstNo('%1|%2|%3|%4|%5', ReportUsage, DocNo, DocName, VendorNo, 'Vendor');
        JobQueueEntry.Description:=CopyStr(DocName, 1, MaxStrLen(JobQueueEntry.Description));
        CODEUNIT.Run(CODEUNIT::"Job Queue - Enqueue", JobQueueEntry);
    end;
    local procedure SendEmailToCustDirectly(ReportUsage: Integer; RecordVariant: Variant; DocNo: Code[20]; DocName: Text[150]; ShowDialog: Boolean; CustNo: Code[20]): Boolean var
        TempAttachReportSelections: Record "Email Report Selections Custom" temporary;
        CustomReportSelection: Record "Custom Report Selection";
        ReportDistributionManagement: Codeunit "Report Distribution Management";
        FoundBody: Boolean;
        FoundAttachment: Boolean;
        ServerEmailBodyFilePath: Text[250];
        EmailAddress: Text[250];
    begin
        OnBeforeSetReportLayout(RecordVariant);
        //InteractionMgt.SetEmailDraftLogging(true);
        BindSubscription(ReportDistributionManagement);
        FoundBody:=GetEmailBody(ServerEmailBodyFilePath, ReportUsage, RecordVariant, CustNo, EmailAddress);
        UnbindSubscription(ReportDistributionManagement);
        //InteractionMgt.SetEmailDraftLogging(false);
        FoundAttachment:=FindEmailAttachmentUsage(ReportUsage, CustNo, TempAttachReportSelections);
        CustomReportSelection.SetRange("Source Type", DATABASE::Customer);
        CustomReportSelection.SetFilter("Source No.", CustNo);
        exit(SendEmailDirectly(ReportUsage, RecordVariant, DocNo, DocName, FoundBody, FoundAttachment, ServerEmailBodyFilePath, EmailAddress, ShowDialog, TempAttachReportSelections, CustomReportSelection));
    end;
    local procedure SendEmailToVendorDirectly(ReportUsage: Integer; RecordVariant: Variant; DocNo: Code[20]; DocName: Text[150]; ShowDialog: Boolean; VendorNo: Code[20]): Boolean var
        TempAttachReportSelections: Record "Email Report Selections Custom" temporary;
        CustomReportSelection: Record "Custom Report Selection";
        FoundBody: Boolean;
        FoundAttachment: Boolean;
        ServerEmailBodyFilePath: Text[250];
        EmailAddress: Text[250];
    begin
        OnBeforeSetReportLayout(RecordVariant);
        //InteractionMgt.SetEmailDraftLogging(true);
        FoundBody:=GetEmailBodyVendor(ServerEmailBodyFilePath, ReportUsage, RecordVariant, VendorNo, EmailAddress);
        //InteractionMgt.SetEmailDraftLogging(false);
        FoundAttachment:=FindEmailAttachmentUsageVendor(ReportUsage, VendorNo, TempAttachReportSelections);
        CustomReportSelection.SetRange("Source Type", DATABASE::Vendor);
        CustomReportSelection.SetFilter("Source No.", VendorNo);
        exit(SendEmailDirectly(ReportUsage, RecordVariant, DocNo, DocName, FoundBody, FoundAttachment, ServerEmailBodyFilePath, EmailAddress, ShowDialog, TempAttachReportSelections, CustomReportSelection));
    end;
    local procedure SendEmailDirectly(ReportUsage: Integer; RecordVariant: Variant; DocNo: Code[20]; DocName: Text[150]; FoundBody: Boolean; FoundAttachment: Boolean; ServerEmailBodyFilePath: Text[250]; var DefaultEmailAddress: Text[250]; ShowDialog: Boolean; var TempAttachReportSelections: Record "Email Report Selections Custom" temporary; var CustomReportSelection: Record "Custom Report Selection")AllEmailsWereSuccessful: Boolean var
        DocumentMailing: Codeunit "Document-Mailing";
        OfficeAttachmentManager: Codeunit "Office Attachment Manager";
        ServerAttachmentFilePath: Text[250];
        EmailAddress: Text[250];
    begin
        AllEmailsWereSuccessful:=true;
        ShowNoBodyNoAttachmentError(ReportUsage, FoundBody, FoundAttachment);
        if FoundBody and not FoundAttachment then // eddie AllEmailsWereSuccessful :=
            //   DocumentMailing.EmailFile('', '', ServerEmailBodyFilePath, DocNo, EmailAddress, DocName, not ShowDialog, ReportUsage);
            if not FoundBody then //InteractionMgt.SetEmailDraftLogging(true);
            // /
            begin
            //eddie OfficeAttachmentManager.IncrementCount(TempAttachReportSelections.Count - 1);
            // repeat
            //     EmailAddress := CopyStr(
            //         GetNextEmailAddressFromCustomReportSelection(CustomReportSelection, DefaultEmailAddress, TempAttachReportSelections.Usage, TempAttachReportSelections.Sequence),
            //         1, MaxStrLen(EmailAddress));
            //     ServerAttachmentFilePath := SaveReportAsPDF(TempAttachReportSelections."Report ID", RecordVariant, TempAttachReportSelections."Custom Report Layout Code");
            //     AllEmailsWereSuccessful := AllEmailsWereSuccessful and DocumentMailing.EmailFile(
            //         ServerAttachmentFilePath,
            //         '',
            //         ServerEmailBodyFilePath,
            //         DocNo,
            //         EmailAddress,
            //         DocName,
            //         not ShowDialog,
            //         ReportUsage);
            // until TempAttachReportSelections.Next = 0;
            end;
        //END;
        //InteractionMgt.SetEmailDraftLogging(false);
        exit(AllEmailsWereSuccessful);
    end;
    procedure SendToDisk(ReportUsage: Integer; RecordVariant: Variant; DocNo: Code[20]; DocName: Text; CustNo: Code[20])
    var
        TempReportSelections: Record "Email Report Selections Custom" temporary;
        ElectronicDocumentFormat: Record "Electronic Document Format";
        FileManagement: Codeunit "File Management";
        ServerAttachmentFilePath: Text[250];
        ClientAttachmentFileName: Text;
    begin
        OnBeforeSetReportLayout(RecordVariant);
        FindPrintUsage(ReportUsage, CustNo, TempReportSelections);
        repeat ServerAttachmentFilePath:=SaveReportAsPDF(TempReportSelections."Report ID", RecordVariant, TempReportSelections."Custom Report Layout Code");
        //eddie  ClientAttachmentFileName := ElectronicDocumentFormat.GetAttachmentFileName(DocNo, DocName, 'pdf');
        //     FileManagement.DownloadHandler(
        //       ServerAttachmentFilePath,
        //       '',
        //       '',
        //       FileManagement.GetToFilterText('', ClientAttachmentFileName),
        //       ClientAttachmentFileName);
        until TempReportSelections.Next = 0;
    end;
    procedure SendToDiskVendor(ReportUsage: Integer; RecordVariant: Variant; DocNo: Code[20]; DocName: Text; VendorNo: Code[20])
    var
        TempReportSelections: Record "Email Report Selections Custom" temporary;
        ElectronicDocumentFormat: Record "Electronic Document Format";
        FileManagement: Codeunit "File Management";
        ServerAttachmentFilePath: Text[250];
        ClientAttachmentFileName: Text;
    begin
        OnBeforeSetReportLayout(RecordVariant);
        FindPrintUsageVendor(ReportUsage, VendorNo, TempReportSelections);
    // eddie repeat
    //     ServerAttachmentFilePath := SaveReportAsPDF(TempReportSelections."Report ID", RecordVariant, TempReportSelections."Custom Report Layout Code");
    //     ClientAttachmentFileName := ElectronicDocumentFormat.GetAttachmentFileName(DocNo, DocName, 'pdf');
    //     FileManagement.DownloadHandler(
    //       ServerAttachmentFilePath,
    //       '',
    //       '',
    //       FileManagement.GetToFilterText('', ClientAttachmentFileName),
    //       ClientAttachmentFileName);
    // until TempReportSelections.Next = 0;
    end;
    procedure SendToZip(ReportUsage: Integer; RecordVariant: Variant; DocNo: Code[20]; CustNo: Code[20]; var FileManagement: Codeunit "File Management")
    var
        TempReportSelections: Record "Email Report Selections Custom" temporary;
        ElectronicDocumentFormat: Record "Electronic Document Format";
        ServerAttachmentFilePath: Text;
    begin
        OnBeforeSetReportLayout(RecordVariant);
        FindPrintUsage(ReportUsage, CustNo, TempReportSelections);
        repeat ServerAttachmentFilePath:=SaveReportAsPDF(TempReportSelections."Report ID", RecordVariant, TempReportSelections."Custom Report Layout Code");
        /* FileManagement.AddFileToZipArchive(
          ServerAttachmentFilePath,
          ElectronicDocumentFormat.GetAttachmentFileName(DocNo, 'Invoice', 'pdf')); */
        until TempReportSelections.Next = 0;
    end;
    procedure SendToZipVendor(ReportUsage: Integer; RecordVariant: Variant; DocNo: Code[20]; VendorNo: Code[20]; var FileManagement: Codeunit "File Management")
    var
        TempReportSelections: Record "Email Report Selections Custom" temporary;
        ElectronicDocumentFormat: Record "Electronic Document Format";
        ServerAttachmentFilePath: Text;
    begin
        OnBeforeSetReportLayout(RecordVariant);
        FindPrintUsageVendor(ReportUsage, VendorNo, TempReportSelections);
        repeat ServerAttachmentFilePath:=SaveReportAsPDF(TempReportSelections."Report ID", RecordVariant, TempReportSelections."Custom Report Layout Code");
        /* FileManagement.AddFileToZipArchive(
          ServerAttachmentFilePath,
          ElectronicDocumentFormat.GetAttachmentFileName(DocNo, 'Purchase Order', 'pdf')); */
        until TempReportSelections.Next = 0;
    end;
    procedure GetDocumentEmailAddress(DocumentNo: Code[20]; ReportUsage: Integer): Text[250]var
        EmailParameter: Record "Email Parameter";
        ToAddress: Text;
    begin
        if EmailParameter.GetEntryWithReportUsage(DocumentNo, ReportUsage, EmailParameter."Parameter Type"::Address)then ToAddress:=EmailParameter.GetParameterValue;
        exit(ToAddress);
    end;
    procedure GetCustEmailAddress(BillToCustomerNo: Code[20]): Text[250]var
        Customer: Record Customer;
        Contact: Record Contact;
        ToAddress: Text;
        IsHandled: Boolean;
    begin
        OnBeforeGetCustEmailAddress(BillToCustomerNo, ToAddress, IsHandled);
        if IsHandled then exit(ToAddress);
        if Customer.Get(BillToCustomerNo)then ToAddress:=Customer."E-Mail"
        else if Contact.Get(BillToCustomerNo)then ToAddress:=Contact."E-Mail";
        exit(ToAddress);
    end;
    procedure GetVendorEmailAddress(BuyFromVendorNo: Code[20]): Text[250]var
        Vendor: Record Vendor;
        ToAddress: Text;
        IsHandled: Boolean;
    begin
        OnBeforeGetVendorEmailAddress(BuyFromVendorNo, ToAddress, IsHandled);
        if IsHandled then exit(ToAddress);
        if Vendor.Get(BuyFromVendorNo)then ToAddress:=Vendor."E-Mail";
        exit(ToAddress);
    end;
    local procedure SaveReportAsPDF(ReportID: Integer; RecordVariant: Variant; LayoutCode: Code[20])FilePath: Text[250]var
        ReportLayoutSelection: Record "Report Layout Selection";
        FileMgt: Codeunit "File Management";
    begin
        //eddie  OnBeforeSetReportLayout(RecordVariant);
        // FilePath := CopyStr(FileMgt.ServerTempFileName('pdf'), 1, 250);
        // ReportLayoutSelection.SetTempLayoutSelected(LayoutCode);
        // REPORT.SaveAsPdf(ReportID, FilePath, RecordVariant);
        // ReportLayoutSelection.SetTempLayoutSelected('');
        Commit;
    end;
    local procedure SaveReportAsHTML(ReportID: Integer; RecordVariant: Variant; LayoutCode: Code[20])FilePath: Text[250]var
        ReportLayoutSelection: Record "Report Layout Selection";
        FileMgt: Codeunit "File Management";
    begin
        // eddie OnBeforeSetReportLayout(RecordVariant);
        // FilePath := CopyStr(FileMgt.ServerTempFileName('html'), 1, 250);
        // ReportLayoutSelection.SetTempLayoutSelected(LayoutCode);
        // REPORT.SaveAsHtml(ReportID, FilePath, RecordVariant);
        // ReportLayoutSelection.SetTempLayoutSelected('');
        Commit;
    end;
    local procedure FindReportSelections(var ReportSelections: Record "Email Report Selections Custom"; CustNo: Code[20]): Boolean var
        Handled: Boolean;
    begin
        if CopyCustomReportSectionToReportSelection(CustNo, ReportSelections)then exit(true);
        OnFindReportSelections(ReportSelections, Handled);
        if Handled then exit(true);
        exit(CopyReportSelectionToReportSelection(ReportSelections));
    end;
    local procedure FindReportSelectionsVendor(var ReportSelections: Record "Email Report Selections Custom"; VendorNo: Code[20]): Boolean var
        Handled: Boolean;
    begin
        if CopyCustomReportSectionToReportSelectionVendor(VendorNo, ReportSelections)then exit(true);
        OnFindReportSelections(ReportSelections, Handled);
        if Handled then exit(true);
        exit(CopyReportSelectionToReportSelection(ReportSelections));
    end;
    local procedure CopyCustomReportSectionToReportSelection(CustNo: Code[20]; var ToReportSelections: Record "Email Report Selections Custom"): Boolean var
        CustomReportSelection: Record "Custom Report Selection";
    begin
        GetCustomReportSelectionByUsageFilter(CustomReportSelection, CustNo, GetFilter(Usage));
        CopyToReportSelection(ToReportSelections, CustomReportSelection);
        if not ToReportSelections.FindSet then exit(false);
        exit(true);
    end;
    local procedure CopyCustomReportSectionToReportSelectionVendor(VendorNo: Code[20]; var ToReportSelections: Record "Email Report Selections Custom"): Boolean var
        CustomReportSelection: Record "Custom Report Selection";
    begin
        GetCustomReportSelectionByUsageFilterVendor(CustomReportSelection, VendorNo, GetFilter(Usage));
        CopyToReportSelection(ToReportSelections, CustomReportSelection);
        if not ToReportSelections.FindSet then exit(false);
        exit(true);
    end;
    local procedure CopyToReportSelection(var ToReportSelections: Record "Email Report Selections Custom"; var CustomReportSelection: Record "Custom Report Selection")
    var
        ReportUsage: Enum "Report Selection Usage";
    begin
        ToReportSelections.Reset;
        ToReportSelections.DeleteAll;
        if CustomReportSelection.FindSet then repeat //ToReportSelections.Usage := ReportUsage;
                ToReportSelections.Sequence:=Format(CustomReportSelection.Sequence);
                ToReportSelections."Report ID":=CustomReportSelection."Report ID";
                ToReportSelections."Custom Report Layout Code":=CustomReportSelection."Custom Report Layout Code";
                ToReportSelections."Email Body Layout Code":=CustomReportSelection."Email Body Layout Code";
                ToReportSelections."Use for Email Attachment":=CustomReportSelection."Use for Email Attachment";
                ToReportSelections."Use for Email Body":=CustomReportSelection."Use for Email Body";
                ToReportSelections.Insert;
            until CustomReportSelection.Next = 0;
    end;
    local procedure CopyReportSelectionToReportSelection(var ToReportSelections: Record "Email Report Selections Custom"): Boolean begin
        ToReportSelections.Reset;
        ToReportSelections.DeleteAll;
        if FindSet then repeat ToReportSelections:=Rec;
                ToReportSelections.Insert;
            until Next = 0;
        exit(ToReportSelections.FindSet);
    end;
    local procedure GetCustomReportSelection(var CustomReportSelection: Record "Custom Report Selection"; CustNo: Code[20]): Boolean begin
        CustomReportSelection.SetRange("Source Type", DATABASE::Customer);
        CustomReportSelection.SetFilter("Source No.", CustNo);
        if CustomReportSelection.IsEmpty then exit(false);
        CustomReportSelection.SetFilter("Use for Email Attachment", GetFilter("Use for Email Attachment"));
        CustomReportSelection.SetFilter("Use for Email Body", GetFilter("Use for Email Body"));
    end;
    local procedure GetCustomReportSelectionVendor(var CustomReportSelection: Record "Custom Report Selection"; VendorNo: Code[20]): Boolean begin
        CustomReportSelection.SetRange("Source Type", DATABASE::Vendor);
        CustomReportSelection.SetFilter("Source No.", VendorNo);
        if CustomReportSelection.IsEmpty then exit(false);
        CustomReportSelection.SetFilter("Use for Email Attachment", GetFilter("Use for Email Attachment"));
        CustomReportSelection.SetFilter("Use for Email Body", GetFilter("Use for Email Body"));
    end;
    local procedure GetCustomReportSelectionByUsageFilter(var CustomReportSelection: Record "Custom Report Selection"; CustNo: Code[20]; ReportUsageFilter: Text): Boolean begin
        CustomReportSelection.SetFilter(Usage, ReportUsageFilter);
        exit(GetCustomReportSelection(CustomReportSelection, CustNo));
    end;
    local procedure GetCustomReportSelectionByUsageFilterVendor(var CustomReportSelection: Record "Custom Report Selection"; VendorNo: Code[20]; ReportUsageFilter: Text): Boolean begin
        CustomReportSelection.SetFilter(Usage, ReportUsageFilter);
        exit(GetCustomReportSelectionVendor(CustomReportSelection, VendorNo));
    end;
    local procedure GetCustomReportSelectionByUsageOption(var CustomReportSelection: Record "Custom Report Selection"; CustNo: Code[20]; ReportUsage: Integer): Boolean begin
        CustomReportSelection.SetRange(Usage, ReportUsage);
        exit(GetCustomReportSelection(CustomReportSelection, CustNo));
    end;
    local procedure GetCustomReportSelectionByUsageOptionVendor(var CustomReportSelection: Record "Custom Report Selection"; VendorNo: Code[20]; ReportUsage: Integer): Boolean begin
        CustomReportSelection.SetRange(Usage, ReportUsage);
        exit(GetCustomReportSelectionVendor(CustomReportSelection, VendorNo));
    end;
    local procedure GetNextEmailAddressFromCustomReportSelection(var CustomReportSelection: Record "Custom Report Selection"; DefaultEmailAddress: Text; UsageValue: Option; SequenceText: Text): Text var
        SequenceInteger: Integer;
    begin
        if Evaluate(SequenceInteger, SequenceText)then begin
            CustomReportSelection.SetRange(Usage, UsageValue);
            CustomReportSelection.SetRange(Sequence, SequenceInteger);
            if CustomReportSelection.FindFirst then if CustomReportSelection."Send To Email" <> '' then exit(CustomReportSelection."Send To Email");
        end;
        exit(DefaultEmailAddress);
    end;
    procedure PrintForUsage(ReportUsage: Integer)
    var
        Handled: Boolean;
    begin
        OnBeforePrintForUsage(ReportUsage, Handled);
        if Handled then exit;
        FilterPrintUsage(ReportUsage);
        if FindSet then repeat REPORT.RunModal("Report ID", true);
            until Next = 0;
    end;
    local procedure FindEmailAddressForEmailLayout(LayoutCode: Code[20]; CustNo: Code[20]; ReportUsage: Integer): Text[200]var
        CustomReportSelection: Record "Custom Report Selection";
    begin
        // Search for a potential email address from Custom Report Selections
        GetCustomReportSelectionByUsageOption(CustomReportSelection, CustNo, ReportUsage);
        CustomReportSelection.SetFilter("Send To Email", '<>%1', '');
        CustomReportSelection.SetRange("Email Body Layout Code", LayoutCode);
        if CustomReportSelection.FindFirst then exit(CustomReportSelection."Send To Email");
        // Relax the filter and search for an email address
        CustomReportSelection.SetFilter("Use for Email Body", '');
        CustomReportSelection.SetRange("Email Body Layout Code", '');
        if CustomReportSelection.FindFirst then exit(CustomReportSelection."Send To Email");
        exit('');
    end;
    local procedure FindEmailAddressForEmailLayoutVendor(LayoutCode: Code[20]; VendorNo: Code[20]; ReportUsage: Integer): Text[200]var
        CustomReportSelection: Record "Custom Report Selection";
    begin
        // Search for a potential email address from Custom Report Selections
        GetCustomReportSelectionByUsageOptionVendor(CustomReportSelection, VendorNo, ReportUsage);
        CustomReportSelection.SetFilter("Send To Email", '<>%1', '');
        CustomReportSelection.SetRange("Email Body Layout Code", LayoutCode);
        if CustomReportSelection.FindFirst then exit(CustomReportSelection."Send To Email");
        // Relax the filter and search for an email address
        CustomReportSelection.SetFilter("Use for Email Body", '');
        CustomReportSelection.SetRange("Email Body Layout Code", '');
        if CustomReportSelection.FindFirst then exit(CustomReportSelection."Send To Email");
        exit('');
    end;
    local procedure ShowNoBodyNoAttachmentError(ReportUsage: Integer; FoundBody: Boolean; FoundAttachment: Boolean)
    begin
        if not(FoundBody or FoundAttachment)then begin
            Usage:=ReportUsage;
            Error(MustSelectAndEmailBodyOrAttahmentErr, Usage);
        end;
    end;
    procedure ReportUsageToDocumentType(var DocumentType: Option; ReportUsage: Integer): Boolean var
        SalesHeader: Record "Sales Header";
    begin
        case ReportUsage of //Usage::"S.Invoice",Usage::"S.Invoice Draft",Usage::"P.Invoice":
        Usage::"Client Notifications": DocumentType:=Usage::"Client Notifications"; //SalesHeader."Document Type"::Invoice;
        //Usage::"S.Quote",Usage::"P.Quote":
        Usage::"Contributions Reconciliation": DocumentType:=Usage::"Contributions Reconciliation"; //SalesHeader."Document Type"::Quote;
        //Usage::"S.Cr.Memo",Usage::"P.Cr.Memo":
        Usage::Statement: DocumentType:=Usage::Statement; //SalesHeader."Document Type"::"Credit Memo";
        //  Usage::"S.Order",Usage::"P.Order":
        //    DocumentType := SalesHeader."Document Type"::Order;
        else
            exit(false);
        end;
        exit(true);
    end;
    procedure SendEmailInForeground(DocRecordID: RecordID; DocNo: Code[20]; DocName: Text[150]; ReportUsage: Integer; SourceIsCustomer: Boolean; SourceNo: Code[20]): Boolean var
        RecRef: RecordRef;
    begin
        // Blocks the user until the email is sent; use SendEmailInBackground for normal purposes.
        if not RecRef.Get(DocRecordID)then exit(false);
        RecRef.LockTable;
        RecRef.Find;
        RecRef.SetRecFilter;
        if SourceIsCustomer then exit(SendEmailToCustDirectly(ReportUsage, RecRef, DocNo, DocName, false, SourceNo));
        exit(SendEmailToVendorDirectly(ReportUsage, RecRef, DocNo, DocName, false, SourceNo));
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetCustEmailAddress(BillToCustomerNo: Code[20]; var ToAddress: Text; var IsHandled: Boolean)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetVendorEmailAddress(BuyFromVendorNo: Code[20]; var ToAddress: Text; var IsHandled: Boolean)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforePrintForUsage(var ReportUsage: Integer; var Handled: Boolean)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetReportLayout(RecordVariant: Variant)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnFindReportSelections(var ReportSelections: Record "Email Report Selections Custom"; var Handled: Boolean)
    begin
    end;
}

codeunit 50162 Eprocurement
{
    Permissions = tabledata 454 = RIMD;

    [ServiceEnabled]
    procedure FnUploadAttachedDocument(docNo: Code[50]; fileName: Text; fileExt: Text; attachment: Text; tableID: Integer) returnV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not UploadAttachedDocument(docNo, fileName, fileExt, attachment, tableID) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(returnV);
    end;

    [TryFunction]
    procedure UploadAttachedDocument(DocNo: Code[50]; FileName: Text; fileExt: Text; attachment: Text; TableID: Integer)
    var
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        tableFound: Boolean;
        DocAttachment: Record "Document Attachment";
    begin
        tableFound := false;
        if TableID = Database::Payments then begin
            prospectiveSuppliersRec.RESET;
            PaymentsRec.SETRANGE("No.", DocNo);
            if PaymentsRec.FIND('-') then begin
                FromRecRef.GETTABLE(PaymentsRec);
            end;
            tableFound := true;
        end;
        if TableID = Database::"Internal Request Header" then begin
            purchasesRec.RESET;
            purchasesRec.SETRANGE("No.", DocNo);
            if purchasesRec.FIND('-') then begin
                FromRecRef.GETTABLE(purchasesRec);
            end;
            tableFound := true;
        end;


        if tableFound = true then begin
            if FileName <> '' then begin
                Clear(DocAttachment);
                TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
                Base64Convert.FromBase64(attachment, Outstr);
                TempBlob_lRec.CreateInStream(InStr, TEXTENCODING::UTF8);

                DocAttachment.Init();
                DocAttachment.Validate("File Extension", fileExt);
                DocAttachment.Validate("File Name", FileName);
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("No.", DocNo);
                DocAttachment."Document Reference ID".ImportStream(InStr, '', FileName);
                DocAttachment.Insert(true);
                JsObject.Add('Error', 'FALSE');
            end else
                Error('No file to upload');
        end else
            Error('File not uploaded. No table filter found');
    end;

    [ServiceEnabled]
    procedure FnDeleteDocumentAttachment(docNo: Code[20]; tableID: Integer; docID: Integer) returnV: Text
    var
        DocAttachment: Record "Document Attachment";
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DropDocumentAttachment(docNo, tableID, docID) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(returnV);
    end;

    [TryFunction]
    procedure DropDocumentAttachment(DocNo: Code[20]; TableID: Integer; DocID: Integer)
    var
        DocAttachment: Record "Document Attachment";
    begin
        DocAttachment.Reset();
        DocAttachment.SetRange("Table ID", TableID);
        DocAttachment.SetRange("No.", DocNo);
        DocAttachment.SetRange(ID, DocID);
        if DocAttachment.Find('-') then begin
            if DocAttachment."Document Reference ID".HasValue then begin
                Clear(DocAttachment."Document Reference ID");
                DocAttachment.Modify(true);
            end;
            DocAttachment.Delete(true);
            JsObject.Add('Error', 'FALSE');
        end;
    end;

    [ServiceEnabled]
    procedure FnGetDocumentAttachment(tableId: Integer; no: Code[20]; recID: Integer) BaseImage: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not GetAttachment(tableId, no, recID) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(BaseImage);
    end;

    [TryFunction]
    procedure GetAttachment(tableId: Integer; No: Code[20]; RecID: Integer)
    var
        TenantMedia: Record "Tenant Media";
        imageID: GUID;
        docAttachment: Record "Document Attachment";
        BaseImage: Text;
        fom: Codeunit "Format Document";
    begin
        docAttachment.Reset();
        docAttachment.SetRange("Table ID", tableId);
        docAttachment.SetRange("No.", No);
        docAttachment.SetRange(ID, RecID);
        if docAttachment.find('-') then begin
            if docAttachment."Document Reference ID".Hasvalue then begin
                imageID := docAttachment."Document Reference ID".MediaId;
                IF TenantMedia.GET(imageID) THEN BEGIN
                    TenantMedia.CALCFIELDS(Content);
                    TenantMedia.Content.CreateInstream(InStr, TEXTENCODING::UTF8);
                    BaseImage := Base64Convert.ToBase64(InStr);
                    JsObject.Add('Error', 'FALSE');
                    JsObject.Add('BaseImage', BaseImage);
                END;
            end;
        end;
    end;

    var
        JsObject: JsonObject;
        NextNo: Code[20];
        TempBlob_lRec: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        RecRef: RecordRef;
        FileManagement_lCdu: Codeunit "File Management";
        Base64Convert: Codeunit "Base64 Convert";
        prospectiveSuppliersRec: Record "Prospective Suppliers";

        purchasesRec: Record "Internal Request Header";
        PaymentsRec: Record Payments;

}
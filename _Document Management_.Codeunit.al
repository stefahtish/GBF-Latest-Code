codeunit 50145 "Document Management"
{
// var
//     FileMgt: Codeunit "File Management";
//     // PathHelper: DotNet Path;
//     // ClientFileHelper: DotNet File;
//     DataInstream: InStream;
//     DataOutstream: OutStream;
//     TempFile: File;
//     UploadFile: Text;
//     ErrorText: Text;
//     AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
// trigger OnRun()
// begin
// end;
// procedure UploadDocument(DocID: code[100]; PageCaption: text; RecID: RecordId): Text
// var
//     FilePath: Text;
//     OnlinePath: Text;
//     FileName: Text;
//     TempFile: File;
//     NewStream: InsTream;
//     RecRef: RecordRef;
//     TableID: Integer;
//     RecLink: Record "Record Link";
//     CompanyInfo: Record "Company Information";
//     LineNo: Integer;
//     DocNamePage: page "Document Name";
//     DocName: Text;
//     FileUploadedSuccessTxt: Label 'File %1 uploaded successfully';
//     FinalFilename: Text;
//     FinalPath: Text;
//     //eddieFileSystem: DotNet MyDirectory;
//     RandomNo: Integer;
//     RandomNoTxt: Guid;
//     NewFileName: Text;
//     NewTxt: Text;
//     ProcurementDocs: Record "Procurement Document Links";
//     DocMgmt: Codeunit "Document Management";
//     UrlPath: Text;
// begin
//     CompanyInfo.get;
//     CompanyInfo.TestField("Document Path");
//     CompanyInfo.TestField("Online Document Path");
//     RandomNoTxt := CreateGuid();
//     // NewTxt := RandomNoTxt.slice(1, -1);
//     FilePath := CompanyInfo."Document Path" + '\' + DocID + PageCaption;
//     OnlinePath := CompanyInfo."Online Document Path" + '/' + DocID + PageCaption;
//     // EDDIE if not FileMgt.ServerDirectoryExists(FilePath) then
//     //     FileMgt.ServerCreateDirectory(FilePath);
//     if UploadIntoStream('Upload', '', AllFilesDescriptionTxt, FileName, DataInstream) then begin
//         UploadFile := FilePath + '\' + DocID + '_' + RandomNoTxt + '_' + FileName;
//         if FileMgt.ServerFileExists(UploadFile) then
//             //EDDIE FileMgt.DeleteServerFile(UploadFile);
//             //EDDIE TempFile.Create(UploadFile);
//             //EDDIE TempFile.CreateOutStream(DataOutstream);
//             CopyStream(DataOutstream, DataInstream);
//         //EDDIE TempFile.Close();
//         //Add Record Link
//         RecLink.Reset();
//         if RecLink.FindLast() then
//             LineNo := RecLink."Link ID" + 1
//         else
//             LineNo := 1;
//         Commit();
//         if CompanyInfo."Save to Sharepoint" then begin
//             RecLink.Init();
//             RecLink."Link ID" := LineNo;
//             RecLink."Record ID" := RecID;
//             RecLink.URL1 := OnlinePath + '/' + DocID + '_' + RandomNoTxt + '_' + FileName;
//             RecLink.Description := DocID + '_' + RandomNoTxt + '_' + FileName;
//             RecLink.Type := RecLink.Type::Link;
//             RecLink.Created := CurrentDateTime;
//             RecLink.Company := CompanyName;
//             RecLink."User ID" := UserId;
//             RecLink.Insert();
//             ProcurementDocs.Init();
//             ProcurementDocs."No." := DocID;
//             ProcurementDocs.Link := FilePath + '\' + DocID + '_' + RandomNoTxt + '_' + FileName;
//             ProcurementDocs.Description := Format(DocID + '_' + RandomNoTxt + '_' + FileName);
//             ProcurementDocs."Record ID" := (RecID);
//             ProcurementDocs.Insert();
//             OpenDocument(RecID, LineNo);
//             exit(FileName);
//             FilePath := '';
//         end else begin
//             RecLink.Init();
//             RecLink."Link ID" := LineNo;
//             RecLink."Record ID" := RecID;
//             RecLink.URL1 := FilePath + '\' + DocID + '_' + RandomNoTxt + '_' + FileName;
//             RecLink.Description := DocID + '_' + RandomNoTxt + '_' + FileName;
//             RecLink.Type := RecLink.Type::Link;
//             RecLink.Created := CurrentDateTime;
//             RecLink.Company := CompanyName;
//             RecLink."User ID" := UserId;
//             RecLink.Insert();
//             ProcurementDocs.Init();
//             ProcurementDocs."No." := DocID;
//             ProcurementDocs.LineNo := LineNo;
//             ProcurementDocs.Link := FilePath + '\' + DocID + '_' + RandomNoTxt + '_' + FileName;
//             ProcurementDocs.Description := DocID + '_' + RandomNoTxt + '_' + FileName;
//             ProcurementDocs."Record ID" := (RecID);
//             ProcurementDocs.Insert();
//             OpenDocument(RecID, LineNo);
//             exit(FileName);
//             FilePath := '';
//         end;
//     end;
// end;
// procedure UploadDocument(DocID: code[20]; PageCaption: text; RecID: RecordId; Data: Variant; FileName: Text): Text
// var
//     RecLink: Record "Record Link";
//     CompanyInfo: Record "Company Information";
//     FilePath: Text;
//     OnlinePath: Text;
//     LineNo: Integer;
//     //EDDIE MemoryStream: DotNet MemoryStream;
//     //   RegEx: DotNet BCRegex;
//     //  Match: DotNet BCMatch;
//     // Convert: DotNet BCConvert;
//     //   ClientContext: DotNet ClientContext;
//     // NetworkCredential: DotNet NetworkCredential;
//     // FileCreationInformation: DotNet FileCreationInformation;
//     //  Web: DotNet Web;
//     //  FolderName: DotNet FolderName;
//     //MyList: DotNet MyList;
//     //eddie FileContent: DotNet FileContent;
//     NewFoldername: Text;
//     RandomNo: Integer;
//     RandomNoTxt: text;
//     NewFileName: Text;
// begin
//     CompanyInfo.Get();
//     CompanyInfo.TestField(Name);
//     CompanyInfo.TestField("Document Path");
//     CompanyInfo.TestField("Online Document Path");
//     FilePath := CompanyInfo."Document Path" + '\' + CompanyInfo.Name + '\' + PageCaption + RandomNoTxt + '\' + DocID + '\';
//     OnlinePath := CompanyInfo."Online Document Path" + '/' + CompanyInfo.Name + '/' + PageCaption + '/' + DocID;
//     //EDDIE if not FileMgt.ServerDirectoryExists(FilePath) then
//     //EDDIE  FileMgt.ServerCreateDirectory(FilePath);
//     //EDDIE UploadFile := FilePath + '\' + FileName;
//     //EDDIE  if Exists(UploadFile) then
//     //EDDIE     Erase(UploadFile);
//     //EDDIE TempFile.Create(UploadFile);
//     //EDDIE TempFile.CreateOutStream(DataOutstream);
//     // RegEx := RegEx.Regex('data\:.*/(.*?);base64,(.*)');
//     // Match := RegEx.Match(Data);
//     //EDDIE MemoryStream := MemoryStream.MemoryStream();
//     //DataInstream := MemoryStream.MemoryStream(Convert.FromBase64String(Match.Groups.Item(2).Value));
//     CopyStream(DataOutstream, DataInstream);
//     //EDDIE TempFile.Close();
//     if CompanyInfo."Save to Sharepoint" then begin
//         CompanyInfo.TestField("Sharepoint URL");
//         CompanyInfo.TestField("Sharepoint Username");
//         CompanyInfo.TestField("Sharepoint Password");
//         CompanyInfo.TestField("Sharepoint Domain");
//         CompanyInfo.TestField("Sharepoint Library");
//         CompanyInfo.TestField("Sharepoint Folder");
//         /*
//                     ClientContext := ClientContext.ClientContext(CompanyInfo."Sharepoint URL");
//                     ClientContext.Credentials := NetworkCredential.NetworkCredential(CompanyInfo."Sharepoint Username", CompanyInfo."Sharepoint Password", CompanyInfo."Sharepoint Domain");
//                     FileCreationInformation := FileCreationInformation.FileCreationInformation;
//                     FileCreationInformation.Content := FileContent.ReadAllBytes(UploadFile);
//                     FileCreationInformation.Url := FileMgt.GetFileName(UploadFile);
//                     FileCreationInformation.Overwrite := TRUE;
//                     Web := ClientContext.Web;
//                     MyList := Web.Lists.GetByTitle(CompanyInfo."Sharepoint Library");
//                     //Folder
//                     FolderName := MyList.RootFolder.Folders.GetByUrl(CompanyInfo."Sharepoint Folder");
//                     if not FileMgt.ServerDirectoryExists(FilePath) then
//                         FolderName.AddSubFolder(CompanyInfo.Name);
//                     //Modified by Faith
//                     // if CompanyInfo.Name <> '' then
//                     //     FolderName := MyList.RootFolder.Folders.GetByUrl(CompanyInfo."Sharepoint Folder" + '/' + CompanyInfo.Name);
//                     // FolderName.AddSubFolder(PageCaption);
//                     // if PageCaption <> '' then
//                     //     FolderName := MyList.RootFolder.Folders.GetByUrl(CompanyInfo."Sharepoint Folder" + '/' + CompanyInfo.Name + '/' + PageCaption);
//                     // FolderName.AddSubFolder(DocID);
//                     FolderName := MyList.RootFolder.Folders.GetByUrl(CompanyInfo."Sharepoint Folder" + '/' + CompanyInfo.Name + '/' + PageCaption + '/' + DocID);
//                     FolderName.Files.Add(FileCreationInformation);
//                     // if PageCaption <> '' then
//                     //     FolderName.AddSubFolder(PageCaption);
//                     // FolderName.AddSubFolder(DocID);
//                     // FolderName.Files.Add(FileCreationInformation);
//                     //Library
//                     // MyList.RootFolder.Files.Add(FileCreationInformation);
//                     ClientContext.ExecuteQuery;
//                     //OnlinePath := FolderName.Path.ToString();
//         */
//     end;
//     //Add Record Link
//     RecLink.Reset();
//     if RecLink.FindLast() then
//         LineNo := RecLink."Link ID" + 1
//     else
//         LineNo := 1;
//     RecLink.Init();
//     RecLink."Link ID" := LineNo;
//     RecLink."Record ID" := RecID;
//     if CompanyInfo."Save to Sharepoint" then
//         RecLink.URL1 := OnlinePath + '/' + FileName
//     else
//         RecLink.URL1 := FilePath + '\' + FileName;
//     RecLink.Description := FileName;
//     RecLink.Type := RecLink.Type::Link;
//     RecLink.Created := CurrentDateTime;
//     RecLink.Company := CompanyName;
//     RecLink."User ID" := UserId;
//     RecLink.Insert();
//     exit(FileName);
//     FilePath := '';
//     //download docs 
//     RecLink.Reset();
//     RecLink.SetRange("Record ID", RecId);
//     IF RecLink.FindFirst() then begin
//         FileName := FileMgt.GetFileName(RecLink.URL1);
//         Clear(TempFile);
//         //EDDIE if TempFile.Open(RecLink.URL1) then begin
//         //EDDIE   Download(RecLink.URL1, '', '', '', FileName);
//         //EDDIE end;
//     end;
// end;
// procedure DownloadDocument(FilePath: Text)
// var
//     FileName: Text;
//     ImportTxt: Label 'Attach a document.';
//     FileDialogTxt: Label 'Attachments (%1)|%1', Comment = '%1=file types, such as *.txt or *.docx';
//     DocFile: File;
//     DocumentStream: OutStream;
//     DownloadFile: Text;
//     tempBlob: Codeunit "Temp Blob";
// begin
//     // eddie FileName := FilePath;
//     // FilePath := FileMgt.OpenFileDialog('Select File', FilePath, 'All Files(*.*)|*.*');
//     // FileMgt.DownloadToFile(FilePath, FileMgt.GetFileName(FilePath));
// end;
// procedure CountFiles(DocID: code[50]; PageCaption: Text; FileNameFilter: Text): Integer
// var
//     FilePath: Text;
//     FileCounter: Integer;
//     NameValueBuffer: Record "Name/Value Buffer";
//     CompanyInfo: Record "Company Information";
// begin
//     CompanyInfo.Get;
//     CompanyInfo.TestField(Name);
//     CompanyInfo.TestField("Document Path");
//     FilePath := CompanyInfo."Document Path" + '\' + CompanyInfo.Name + '\' + PageCaption + '\' + DocID;
//     FileCounter := 0;
//     NameValueBuffer.DeleteAll();
//     //EDDIE if FileMgt.ServerDirectoryExists(FilePath) then
//     //EDDIE    FileMgt.GetServerDirectoryFilesList(NameValueBuffer, FilePath);
//     FileCounter := NameValueBuffer.Count;
//     exit(FileCounter);
// end;
// procedure UploadFileSilentToServerPath(ClientFilePath: Text; ServerFilePath: Text): Text
// var
//     //EDDIE ClientFileAttributes: DotNet FileAttributes;
//     Text010: Label 'The file %1 has not been uploaded.';
//     FileDoesNotExistErr: Label 'The file %1 does not exist.', Comment = '%1 File Path';
//     ServerFileName: Text;
//     TempClientFile: Text;
//     FileName: Text;
//     FileExtension: Text;
//     TempFile: File;
//     DataOutStream: OutStream;
// begin
//     //EDDIE 
//     // if not ClientFileHelper.Exists(ClientFilePath) then
//     //     Error(FileDoesNotExistErr, ClientFilePath);
//     // FileName := FileMgt.GetFileName(ClientFilePath);
//     // FileExtension := FileMgt.GetExtension(FileName);
//     // TempFile.Create(ServerFilePath);
//     // TempFile.CreateOutStream(DataOutStream);
//     // TempClientFile := ClientTempFileName(FileExtension);
//     // ClientFileHelper.Copy(ClientFilePath, TempClientFile, true);
//     // if ServerFilePath <> '' then
//     //     ServerFileName := ServerFilePath
//     // else
//     //     ServerFileName := FileMgt.ServerTempFileName(FileExtension);
//     // if not Upload('', FileMgt.Magicpath, AllFilesDescriptionTxt, FileMgt.GetFileName(TempClientFile), ServerFileName) then
//     //     Error(Text010, ClientFilePath);
//     // ClientFileHelper.SetAttributes(TempClientFile, ClientFileAttributes.Normal);
//     // ClientFileHelper.Delete(TempClientFile);
// end;
// procedure ClientTempFileName(FileExtension: Text) ClientFileName: Text
// var
//     TempFile: File;
//     ClientTempPath: Text;
// begin
//     //EDDIE 
//     //     // Returns the pseudo uniquely generated name of a non existing file in the client temp directory
//     //     TempFile.CreateTempFile;
//     //     ClientFileName := FileMgt.CreateFileNameWithExtension(TempFile.Name, FileExtension);
//     //     TempFile.Close;
//     //     TempFile.Create(ClientFileName);
//     //     TempFile.Close;
//     //     ClientTempPath := FileMgt.GetDirectoryName(FileMgt.DownloadTempFile(ClientFileName));
//     //     if Erase(ClientFileName) then;
//     //     ClientFileHelper.Delete(ClientTempPath + '\' + PathHelper.GetFileName(ClientFileName));
//     //     ClientFileName := FileMgt.CreateFileNameWithExtension(ClientTempPath + '\' + Format(CreateGuid), FileExtension);
// end;
// procedure InsertProcurementLinks(ProcReq: Record "Procurement Request")
// var
//     RecLinks: Record "Record Link";
//     RecID: RecordId;
//     ProcDocument: Record "Procurement Document Links";
// begin
//     ProcDocument.Reset();
//     ProcDocument.SetRange("Process Type", ProcReq."Process Type");
//     ProcDocument.SetRange("No.", ProcReq."No.");
//     if ProcDocument.find('-') then
//         ProcDocument.DeleteAll();
//     RecID := ProcReq.RecordId;
//     RecLinks.SetRange("Record ID", RecID);
//     if RecLinks.find('-') then
//         repeat
//             ProcDocument.Init();
//             ProcDocument."Process Type" := ProcReq."Process Type";
//             ProcDocument."No." := ProcReq."No.";
//             // ProcDocument.Description := ProcReq.;
//             ProcDocument.Link := RecLinks.URL1;
//             ProcDocument.Insert();
//         until RecLinks.next = 0;
//     // OpenDocument(RecID);
// end;
// procedure InsertFileProcurementLinks(ProcReq: Record "Procurement Request"; FileName: text[100])
// var
//     RecLinks: Record "Record Link";
//     RecID: RecordId;
//     ProcDocument: Record "Procurement Document Links";
// begin
//     ProcDocument.Reset();
//     ProcDocument.SetRange("Process Type", ProcReq."Process Type");
//     ProcDocument.SetRange("No.", ProcReq."No.");
//     if ProcDocument.find('-') then
//         ProcDocument.DeleteAll();
//     RecID := ProcReq.RecordId;
//     RecLinks.SetRange("Record ID", RecID);
//     if RecLinks.find('-') then
//         repeat
//             ProcDocument.Init();
//             ProcDocument."Process Type" := ProcReq."Process Type";
//             ProcDocument."No." := ProcReq."No.";
//             ProcDocument.Description := FileName;
//             ProcDocument.Link := RecLinks.URL1;
//             ProcDocument.Insert();
//         until RecLinks.next = 0;
//     // OpenDocument(RecID);
// end;
// procedure OpenDocument(RecId: RecordId; lineNo: integer): Boolean
// var
//     RecLink: Record "Record Link";
//     FileName: Text;
// begin
//     RecLink.Reset();
//     RecLink.SetRange("Record ID", RecId);
//     RecLink.SetRange("Link ID", lineNo);
//     IF RecLink.Findlast() then begin
//         FileName := FileMgt.GetFileName(RecLink.URL1);
//         Clear(TempFile);
//         //EDDIE if TempFile.Open(RecLink.URL1) then begin
//         //EDDIE   Download(RecLink.URL1, '', '', '', FileName);
//         //EDDIE  end;
//     end;
// end;
// //DEO...START 1/3/2023
// [EventSubscriber(ObjectType::Page, page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', true, true)]
// local procedure DocumentOnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
// var
//     PaymentsRec: Record Payments;
//     CommitterRec: Record "Tender Committees";
// begin
//     case DocumentAttachment."Table ID" OF
//         Database::Payments:
//             begin
//                 RecRef.Open(Database::Contract);
//                 if PaymentsRec.Get(DocumentAttachment."No.") then
//                     RecRef.GetTable(PaymentsRec);
//             end;
//         Database::"Tender Committees":
//             begin
//                 RecRef.Open(Database::Contract);
//                 if CommitterRec.Get(DocumentAttachment."No.") then
//                     RecRef.GetTable(CommitterRec);
//             end;
//     end;
// end;
// [EventSubscriber(ObjectType::page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
// local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
// var
//     FieldRec: FieldRef;
//     RecNo: Code[20];
//     FieldRef: FieldRef;
// begin
//     case RecRef.Number of
//         Database::Payments:
//             begin
//                 FieldRec := RecRef.Field(1);
//                 RecNo := FieldRec.Value;
//                 DocumentAttachment.SetRange("No.", RecNo);
//             end;
//         Database::"Tender Committees":
//             begin
//                 FieldRec := RecRef.Field(7);
//                 RecNo := FieldRec.Value;
//                 DocumentAttachment.SetRange("No.", RecNo);
//             end;
//     end;
// end;
// //DEO...END 1/3/2023
// //Procedure to Upload InterBank Documents:
// procedure UploadInterbankTransferfiles(DocID: Code[100]; PageCaption: Text; RecID: RecordId): Text
// var
//     FilePath: Text;
//     FileName: Text;
//     TempFile: File;
//     CompanyInformtion: Record "Company Information";
//     LineNo: Integer;
//     InterbankLink: Record "Interbank Document Links";
//     FileMgt: Codeunit "File Management";
//     DataInstream: InStream;
//     DataOutstrem: OutStream;
//     UploadFile: Text;
//     RecLink: Record "Record Link";
//     OnlinePath: Text;
// begin
//     CompanyInformtion.Get();
//     CompanyInformtion.TestField("Document Path");
//     CompanyInformtion.TestField("Online Document Path");
//     FilePath := CompanyInformtion."Document Path" + '\' + DocID + PageCaption;
//     OnlinePath := CompanyInformtion."Online Document Path" + '\' + DocID + PageCaption;
//     //EDDIE 
//     // if not FileMgt.ServerDirectoryExists(FilePath) then
//     //     FileMgt.ServerCreateDirectory(FilePath);
//     // if UploadIntoStream('Upload', '', AllFilesDescriptionTxt, FileName, DataInstream) then begin
//     //     UploadFile := FilePath + '\' + FileName;
//     //     if FileMgt.ServerFileExists(UploadFile) then
//     //         FileMgt.DeleteServerFile(UploadFile);
//     //     TempFile.Create(UploadFile);
//     //     TempFile.CreateOutStream(DataOutstrem);
//     //     CopyStream(DataOutstrem, DataInstream);
//     //     TempFile.Close();
//     RecLink.Reset();
//     if RecLink.FindLast() then
//         LineNo := RecLink."Link ID" + 1
//     else
//         LineNo := 1;
//     Commit();
//     if CompanyInformtion."Save to Sharepoint" then begin
//         RecLink.Init();
//         RecLink."Link ID" := LineNo;
//         RecLink."Record ID" := RecID;
//         RecLink.URL1 := OnlinePath + '\' + FileName;
//         RecLink.Description := OnlinePath + '\' + FileName;
//         RecLink.Type := RecLink.Type::Link;
//         RecLink.Created := CurrentDateTime;
//         RecLink.Company := CompanyName;
//         RecLink."User ID" := UserId;
//         RecLink.Insert();
//         exit(FileName);
//         FilePath := '';
//     end else begin
//         RecLink.Init();
//         RecLink."Link ID" := LineNo;
//         RecLink."Record ID" := RecID;
//         RecLink.URL1 := FilePath + '\' + FileName;
//         RecLink.Description := FilePath + '\' + FileName;
//         RecLink.Type := RecLink.Type::Link;
//         RecLink.Created := CurrentDateTime;
//         RecLink.Company := CompanyName;
//         RecLink."User ID" := UserId;
//         RecLink.Insert();
//         FilePath := '';
//     end;
//     InterbankLink.Init();
//     InterbankLink."Document Code" := Format(RecID);
//     InterbankLink.URL := FilePath + '\' + FileName;
//     InterbankLink.Description := FilePath + '\' + FileName;
//     InterbankLink."No." := DocID;
//     InterbankLink."Document Name" := FileName;
//     InterbankLink."Line No." := LineNo;
//     InterbankLink.Insert();
//     exit(FileName);
//     // EDDIE end;
// end;
// procedure UploadSUpplierAppDocuments(DocID: code[100]; PageCaption: text; RecID: RecordId): Text
// var
//     FilePath: Text;
//     OnlinePath: Text;
//     FileName: Text;
//     TempFile: File;
//     NewStream: InsTream;
//     RecRef: RecordRef;
//     TableID: Integer;
//     RecLink: Record "Record Link";
//     CompanyInfo: Record "Company Information";
//     LineNo: Integer;
//     //DocNamePage: page "Document Name";
//     DocName: Text;
//     FileUploadedSuccessTxt: Label 'File %1 uploaded successfully';
//     FinalFilename: Text;
//     FinalPath: Text;
//     //eddie FileSystem: DotNet MyDirectory;
//     RandomNo: Integer;
//     RandomNoTxt: Guid;
//     NewFileName: Text;
//     NewTxt: Text;
//     // ProcurementDocs: Record "Procurement Document Links";
//     ProcurementDocs: Record "Supplier Document Links";
//     DocMgmt: Codeunit "Document Management";
//     UrlPath: Text;
// begin
//     CompanyInfo.get;
//     CompanyInfo.TestField("Document Path");
//     CompanyInfo.TestField("Online Document Path");
//     RandomNoTxt := CreateGuid();
//     // NewTxt := RandomNoTxt.slice(1, -1);
//     FilePath := CompanyInfo."Document Path" + '\' + DocID + PageCaption;
//     OnlinePath := CompanyInfo."Online Document Path" + '/' + DocID + PageCaption;
//     //EDDIE 
//     // if not FileMgt.ServerDirectoryExists(FilePath) then
//     //     FileMgt.ServerCreateDirectory(FilePath);
//     // if UploadIntoStream('Upload', '', AllFilesDescriptionTxt, FileName, DataInstream) then begin
//     //     UploadFile := FilePath + '\' + DocID + '_' + RandomNoTxt + '_' + FileName;
//     //     if FileMgt.ServerFileExists(UploadFile) then
//     //         FileMgt.DeleteServerFile(UploadFile);
//     //     TempFile.Create(UploadFile);
//     //     TempFile.CreateOutStream(DataOutstream);
//     //     CopyStream(DataOutstream, DataInstream);
//     //     TempFile.Close();
//     //Add Record Link
//     RecLink.Reset();
//     if RecLink.FindLast() then
//         LineNo := RecLink."Link ID" + 1
//     else
//         LineNo := 1;
//     Commit();
//     if CompanyInfo."Save to Sharepoint" then begin
//         RecLink.Init();
//         RecLink."Link ID" := LineNo;
//         RecLink."Record ID" := RecID;
//         RecLink.URL1 := OnlinePath + '/' + DocID + '_' + RandomNoTxt + '_' + FileName;
//         RecLink.Description := DocID + '_' + RandomNoTxt + '_' + FileName;
//         RecLink.Type := RecLink.Type::Link;
//         RecLink.Created := CurrentDateTime;
//         RecLink.Company := CompanyName;
//         RecLink."User ID" := UserId;
//         RecLink.Insert();
//         ProcurementDocs.Init();
//         ProcurementDocs."No." := DocID;
//         ProcurementDocs.Link := FilePath + '\' + DocID + '_' + RandomNoTxt + '_' + FileName;
//         ProcurementDocs.Description := Format(DocID + '_' + RandomNoTxt + '_' + FileName);
//         ProcurementDocs."Record ID" := (RecID);
//         ProcurementDocs.Insert();
//         OpenDocument(RecID, LineNo);
//         exit(FileName);
//         FilePath := '';
//     end else begin
//         RecLink.Init();
//         RecLink."Link ID" := LineNo;
//         RecLink."Record ID" := RecID;
//         RecLink.URL1 := FilePath + '\' + DocID + '_' + RandomNoTxt + '_' + FileName;
//         RecLink.Description := DocID + '_' + RandomNoTxt + '_' + FileName;
//         RecLink.Type := RecLink.Type::Link;
//         RecLink.Created := CurrentDateTime;
//         RecLink.Company := CompanyName;
//         RecLink."User ID" := UserId;
//         RecLink.Insert();
//         ProcurementDocs.Init();
//         ProcurementDocs."No." := DocID;
//         ProcurementDocs.LineNo := LineNo;
//         ProcurementDocs.Link := FilePath + '\' + DocID + '_' + RandomNoTxt + '_' + FileName;
//         ProcurementDocs.Description := DocID + '_' + RandomNoTxt + '_' + FileName;
//         ProcurementDocs."Record ID" := (RecID);
//         ProcurementDocs.Insert();
//         OpenDocument(RecID, LineNo);
//         exit(FileName);
//         FilePath := '';
//         //EDDIE end;
//     end;
// end;
}

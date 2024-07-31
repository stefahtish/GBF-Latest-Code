page 51262 "Document Management"
{
    PageType = Card;
    SourceTable = Customer;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                group("Document Files")
                {
                    Caption = 'Document Files';

                    field(DocCount; DocCount)
                    {
                        Caption = 'Files Attached';
                        Editable = false;
                    }
                    // eddieusercontrol(Path; BCDocumentManagement)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    // }
                    field(FilePath; FilePath)
                    {
                        Caption = 'Drag File Here';
                        Visible = false;

                        trigger OnValidate()
                        begin
                            //Upload dropped files
                            /*IF CONFIRM(Text001, FALSE) = TRUE THEN BEGIN
                                    //DocumentManagement.UploadDocument(FilePath, CurrPage.CAPTION, "No.");
                                    CompanyInfo.TestField("Document Path");
                                    UploadPath := CompanyInfo."Document Path" + '\' + CompanyInfo.Name + '\' + CurrPage.Caption + '\' + "No.";
                                    DocCount := DocumentManagement.CountFiles(FilePath, '');

                                    FromPath := FileMgt.GetDirectoryName(FilePath);
                                    FromFile := FileMgt.GetFileName(FilePath);

                                    UploadFile := UploadPath + '\' + FromFile;

                                    if UploadIntoStream('Upload', FromPath, AllFilesDescriptionTxt, FilePath, DataInstream) then begin
                                        TempFile.Create(UploadFile);
                                        TempFile.CreateOutStream(DataOutstream);
                                        CopyStream(DataOutstream, DataInstream);
                                        TempFile.Close();

                                        ErrorText := GetLastErrorText;
                                        if ErrorText <> '' then
                                            Error(ErrorText);
                                        Message(Text002, FromFile);
                                    end else begin
                                        if Directory.Exists(UploadFile) then
                                            Directory.Delete(UploadFile);
                                    end;

                                END;

                                FilePath := '';
                                MESSAGE(Text002, FilePath);*/
                        end;

                        trigger OnControlAddIn(Index: Integer; Data: Text)
                        var
                            Text001: Label 'Are you sure you want to upload this document?';
                            Text002: Label 'File %1 uploaded successfully';
                        begin
                            //Upload dropped files
                            /* IF CONFIRM(Text001, FALSE) = TRUE THEN BEGIN
                                     FilePath := CompanyInfo."Document Path" + '\' + CompanyInfo.Name + '\' + CurrPage.Caption + '\' + "No.";
                                     DocumentManagement.UploadDocument(FilePath, FilePath, RecordId);
                                     MESSAGE(Text002, Data);
                                     DocCount := DocumentManagement.CountFiles(FilePath, '');
                                     FilePath := '';
                                 END;*/
                        end;
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Upload Document")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Upload documents for the record.';

                trigger OnAction()
                var
                begin
                    CompanyInfo.Get;
                    CompanyInfo.TestField(Name);
                    CompanyInfo.TestField("Document Path");
                    FilePath := CompanyInfo."Document Path" + '\' + CompanyInfo.Name + '\' + CurrPage.Caption + '\' + Rec."No." + '\';
                    // FromFile := DocumentManagement.UploadDocument(FilePath, FilePath, Rec.RecordId);
                    Message(Text002, FromFile);
                    FilePath := '';
                end;
            }
            action("View Documents")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View documents uploaded for the record.';

                trigger OnAction()
                var
                    ImportTxt: Label 'Attach a document.';
                    FileDialogTxt: Label 'Attachments (%1)|%1', Comment = '%1=file types, such as *.txt or *.docx';
                begin
                    CompanyInfo.Get;
                    CompanyInfo.TestField(Name);
                    CompanyInfo.TestField("Document Path");
                    FilePath := CompanyInfo."Document Path" + '\' + CompanyInfo.Name + '\' + CurrPage.Caption + '\' + Rec."No.";
                    // DocumentManagement.DownloadDocument(FilePath);
                    FilePath := '';
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        //Get Count of files
        CompanyInfo.Get;
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("Document Path");
        FilePath := CompanyInfo."Document Path" + '\' + CompanyInfo.Name + '\' + CurrPage.Caption + '\' + Rec."No.";
        //DocCount := DocumentManagement.CountFiles(FilePath, '');
        FilePath := '';
    end;

    var
        CompanyInfo: Record "Company Information";
        DocumentManagement: Codeunit "Document Management";
        FileMgt: Codeunit "File Management";
        //eddie [RunOnClient]
        // DocManagement: DotNet BCDocumentManagement;
        //[RunOnClient]
        //Directory: DotNet MyDirectory;
        DocCount: Integer;
        DataInstream: InStream;
        DataOutstream: OutStream;
        TempFile: File;
        FilePath: Text;
        FromPath: Text;
        FromFile: Text;
        UploadFile: Text;
        UploadPath: Text;
        ErrorText: Text;
        Text001: Label 'Are you sure you want to upload this document?';
        Text002: Label 'File %1 uploaded successfully';
        FilterTxt: Label '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*', Locked = true;
        AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
}

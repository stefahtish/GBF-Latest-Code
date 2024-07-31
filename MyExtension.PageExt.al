pageextension 50160 MyExtension extends "Job G/L Journal"
{
    actions
    {
        addafter("Post and &Print")
        {
            action("&Import")
            {
                Caption = '&Import';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Import data from excel.';

                trigger OnAction()
                var
                begin
                    ReadExcelSheet();
                    ImportExcelData(rec."Journal Batch Name", Rec."Journal Template Name");
                end;
            }
            action(ExportToExcel)
            {
                Caption = 'Export to Excel';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                begin
                    ExportCustLedgerEntries(Rec);
                end;
            }
        }
    }
    var BatchName: Code[10];
    FileName: Text[100];
    SheetName: Text[100];
    TempExcelBuffer: Record "Excel Buffer" temporary;
    UploadExcelMsg: Label 'Please Choose the Excel file.';
    NoFileFoundMsg: Label 'No Excel file found!';
    BatchISBlankMsg: Label 'Batch name is blank';
    ExcelImportSucess: Label 'Excel is successfully imported.';
    local procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile <> '' then begin
            FileName:=FileMgt.GetFileName(FromFile);
            SheetName:=TempExcelBuffer.SelectSheetsNameStream(IStream);
        end
        else
            Error(NoFileFoundMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(IStream, SheetName);
        TempExcelBuffer.ReadSheet();
    end;
    local procedure ImportExcelData(LBatchName: Code[20]; LBatchTemp: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
    begin
        RowNo:=0;
        ColNo:=0;
        MaxRowNo:=0;
        LineNo:=0;
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", LBatchTemp);
        GenJournalLine.SetRange("Journal Batch Name", LBatchName);
        if GenJournalLine.FindLast()then LineNo:=GenJournalLine."Line No.";
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast()then begin
            MaxRowNo:=TempExcelBuffer."Row No.";
        end;
        for RowNo:=2 to MaxRowNo do begin
            LineNo:=LineNo + 10000;
            GenJournalLine.Init();
            //Evaluate(SOImportBuffer."Batch Name", BatchName);
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Journal Batch Name":=LBatchName;
            GenJournalLine."Journal Template Name":=LBatchTemp;
            GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
            Evaluate(GenJournalLine."Posting Date", GetValueAtCell(RowNo, 1));
            Evaluate(GenJournalLine."Document No.", GetValueAtCell(RowNo, 2));
            // Evaluate(GenJournalLine."Account Type", GetValueAtCell(RowNo, 3));
            Evaluate(GenJournalLine."Account No.", GetValueAtCell(RowNo, 3));
            Evaluate(GenJournalLine.Description, GetValueAtCell(RowNo, 4));
            GenJournalLine.Amount:=GetDecimal(TempExcelBuffer, RowNo, 5);
            //  Evaluate(GenJournalLine.Amount, GetValueAtCell(RowNo, 6));
            Evaluate(GenJournalLine."Job No.", GetValueAtCell(RowNo, 6));
            Evaluate(GenJournalLine."Job Task No.", GetValueAtCell(RowNo, 7));
            Evaluate(GenJournalLine."Job Quantity", GetValueAtCell(RowNo, 8));
            Evaluate(GenJournalLine."Shortcut Dimension 1 Code", GetValueAtCell(RowNo, 9));
            Evaluate(GenJournalLine."Shortcut Dimension 2 Code", GetValueAtCell(RowNo, 10));
            Evaluate(GenJournalLine."External Document No.", GetValueAtCell(RowNo, 11));
            // SOImportBuffer."Sheet Name" := SheetName;
            // SOImportBuffer."File Name" := FileName;
            // SOImportBuffer."Imported Date" := Today;
            // SOImportBuffer."Imported Time" := Time;
            GenJournalLine.Insert();
        end;
        Message(ExcelImportSucess);
    end;
    procedure GetDecimal(var Buffer: Record "Excel Buffer" temporary; Row: Integer; Col: Integer): Decimal var
        D: Decimal;
    begin
        if Buffer.Get(Row, Col)then begin
            Evaluate(D, Buffer."Cell Value as Text")end;
        exit(D);
    end;
    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text begin
        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo)then exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;
    local procedure ExportCustLedgerEntries(var GenJounalLine: Record "Gen. Journal Line")
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        CustLedgerEntriesLbl: Label 'Journal Entries';
        ExcelFileName: Label 'Jornalentries%1_%2';
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(GenJounalLine.FieldCaption("Posting Date"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GenJounalLine.FieldCaption("Document No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //TempExcelBuffer.AddColumn(GenJounalLine.FieldCaption("Account Type"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GenJounalLine.FieldCaption("Account No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GenJounalLine.FieldCaption(Description), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GenJounalLine.FieldCaption(Amount), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GenJounalLine.FieldCaption("Job No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GenJounalLine.FieldCaption("Job Task No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GenJounalLine.FieldCaption("Job Quantity"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GenJounalLine.FieldCaption("Shortcut Dimension 1 Code"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GenJounalLine.FieldCaption("Shortcut Dimension 2 Code"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GenJounalLine.FieldCaption("External Document No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.CreateNewBook(CustLedgerEntriesLbl);
        TempExcelBuffer.WriteSheet(CustLedgerEntriesLbl, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
    end;
}

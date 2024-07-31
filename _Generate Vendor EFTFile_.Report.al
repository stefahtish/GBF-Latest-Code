report 50346 "Generate Vendor EFTFile"
{
    Caption = 'Generate Vendor EFTFile';
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(Payments; Payments)
        {
            MaxIteration = 1;

            trigger OnAfterGetRecord()
            begin
                GenerateBankTransferFile(CashMgmt."EFT Path", Payments);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CashMgmt.Get();
        CompInfo.Get();
        CompInfo.TestField("Bank Account No.");
        CashMgmt.TestField("EFT Path");
    end;
    var CashMgmt: Record "Cash Management Setups";
    BanksFileName: Label 'S2S3306%1%2.txt';
    FilePath: Text;
    PaymentBank: Record "Bank Account";
    ToFile: Text;
    Comment: Text[100];
    CompInfo: Record "Company Information";
    TxtBuilder: TextBuilder;
    NoSeriesMgt: Codeunit NoSeriesManagement;
    SerialNumber: Code[30];
    EFTLines: Record "EFT Lines New";
    local procedure GenerateBankTransferFile(DocPath: text; PayHeader: record Payments)
    var
        File: File;
    begin
        Clear(TxtBuilder);
        if PaymentBank.get(CashMgmt."Default Bank")then;
        PaymentBank.TestField("SWIFT Code");
        Comment:=format(PayHeader.Date, 0, '<Month Text,3>') + ' ' + format(PayHeader.Date, 0, '<Year4>') + ' SALARY';
        EFTLines.Reset();
        EFTLines.SetRange("Document No.", PayHeader."No.");
        EFTLines.setrange("PV Posted", false);
        EFTLines.setfilter("Total Net Amount", '>%1', 0);
        if EFTLines.FindFirst()then begin
            repeat if EFTLines."Total Net Amount" > 0 then begin
                    TxtBuilder.AppendLine(StrSubstNo('%1,%2,%3,%4,%5,%6,%7,%8,%9,%10,%11,%12,%13,%14,%15,%16,%17,%18', (COPYSTR(EFTLines."Paying Bank Account", 1, 6)), EFTLines."Paying Bank Account", DelChr(Format(EFTLines."Total Net Amount"), '=', ',/|:'), EFTLines.Currency, Format(PayHeader.Date, 0, '<Day,2><Month,2><YEAR4>'), EFTLines."POP Code", EFTLines."Payee Name", EFTLines."Payee Bank Account No", EFTLines."Pay Mode", (COPYSTR(EFTLines."Payee Bank Code", 1, 2) + COPYSTR(EFTLines."Payee Bank Branch Code", 1, 3)), EFTLines."Payee Email", EFTLines."Payment Description1", EFTLines."Payment Description2", EFTLines."Payment Description3", EFTLines."Payment Description4", CashMgmt."Debit Narrative", CashMgmt."Credit Narrative", EFTLines."Purpose Pay"));
                end;
            until EFTLines.Next = 0;
        end;
        if SerialNumber = '' then begin
            CashMgmt.TestField(CashMgmt."Serial No");
            NoSeriesMgt.InitSeries(CashMgmt."Serial No", Payments."No. Series", 0D, SerialNumber, Payments."No. Series");
        end;
        FilePath:=CashMgmt."EFT Path" + StrSubstNo(BanksFileName, Format(Today, 0, '<YEAR><Month,2><Day,2>'), SerialNumber);
    //eddie eft  if Exists(FilePath) then
    //     Erase(FilePath);
    // //Create File to Save to
    // File.Create(FilePath);
    // File.Close();
    // File.TextMode(true);
    // File.WriteMode(true);
    // File.Open(FilePath);
    // File.Write(TxtBuilder.ToText);
    // File.Close();
    // IF Exists(FilePath) then begin
    //     ToFile := StrSubstNo(BanksFileName, Format(Today, 0, '<YEAR><Month,2><Day,2>'), SerialNumber);
    // end;
    // Download(FilePath, 'Generating EFT File', CashMgmt."EFT Path", '', ToFile);
    end;
}

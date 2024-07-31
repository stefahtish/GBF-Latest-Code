report 50326 GenerateEFTFile
{
    Caption = 'Generate EFT File';
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("Payroll Approval"; "Payroll Approval")
        {
            MaxIteration = 1;

            trigger OnAfterGetRecord()
            begin
                GenerateBankTransferFile(HRSetup."EFT Document Path", "Payroll Approval");
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
        HRSetup.get;
        HRSetup.TestField("Default Bank");
        HRSetup.TestField("Net pay POP Code");
        HRSetup.TestField("Pay Mode");
        CompInfo.TestField("Bank Account No.");
        CashMgmt.TestField("EFT Payee Reference Nos");
        CashMgmt.TestField("Default Currency Code");
        HRSetup.TestField("EFT Document Path");
        HRSetup.TestField("Interbank EFT Path");
    end;
    var CashMgmt: Record "Cash Management Setups";
    BanksFileName: Label 'S2S6433%1%2.txt';
    FilePath: Text;
    Banks: Record Banks;
    PaymentBank: Record "Bank Account";
    Paymentmethod: Record "Payment Method";
    ToFile: Text;
    HRSetup: Record "Human Resources Setup";
    Comment: Text[100];
    PayrollApprovalLines: record "Payroll Approval Lines";
    Employees: Record Employee;
    BankCode: Text[20];
    BankBranch: Text[20];
    PmtMode: Text[20];
    LocBankCode: Text[20];
    CompInfo: Record "Company Information";
    Bankref: record "Payroll Approval Bank Ref";
    TxtBuilder: TextBuilder;
    NoSeriesMgt: Codeunit NoSeriesManagement;
    SerialNumber: Code[30];
    local procedure GenerateBankTransferFile(DocPath: text; PayrollApprovalHeader: record "Payroll Approval")
    var
        File: File;
    begin
        Clear(TxtBuilder);
        PayrollApprovalHeader.CalcFields("Total Net Amount");
        //Appending Header
        TxtBuilder.AppendLine(StrSubstNo('%1,%2,%3,%4,%5', COPYSTR(CompInfo."Bank Account No.", 1, 6), CompInfo."Bank Account No.", DelChr(Format(PayrollApprovalHeader."Total Net Amount"), '=', ',/|:'), CashMgmt."Default Currency Code", Format(Today, 0, '<Day,2><Month,2><Year4>')));
        //Insert Lines
        if PaymentBank.get(HRSetup."Default Bank")then;
        PaymentBank.TestField("SWIFT Code");
        Comment:=format(PayrollApprovalHeader."Payroll Period", 0, '<Month Text,3>') + ' ' + format(PayrollApprovalHeader."Payroll Period", 0, '<Year4>') + ' SALARY';
        PayrollApprovalLines.Reset();
        PayrollApprovalLines.SetRange("Document No.", PayrollApprovalHeader."No.");
        PayrollApprovalLines.setrange(Paid, false);
        PayrollApprovalLines.setfilter("Net Amount", '>%1', 0);
        if PayrollApprovalLines.FindFirst()then begin
            repeat Employees.Reset();
                Employees.SetRange("No.", PayrollApprovalLines."Payee No");
                if Employees.FindFirst()then begin
                    Employees.testfield("Employee's Bank");
                    Employees.testfield("Bank Branch");
                    Employees.TestField("Bank Account Number");
                    Employees.TestField("Employee Bank Name");
                    Banks.Reset();
                    Banks.SetRange(Code, Employees."Employee's Bank");
                    if Banks.FindFirst()then begin
                        if not Banks."Non-bank" then begin
                            if Banks."Swift Code" = PaymentBank."SWIFT Code" then begin
                                Paymentmethod.Reset();
                                Paymentmethod.SetRange("Bal. Account Type", Paymentmethod."Bal. Account Type"::BT);
                                if Paymentmethod.FindFirst()then PmtMode:=Paymentmethod.Code;
                                BankCode:=PaymentBank."SWIFT Code";
                                LocBankCode:='';
                                BankBranch:='';
                            end;
                            if Banks."Swift Code" <> PaymentBank."SWIFT Code" then begin
                                PmtMode:=HRSetup."Pay Mode";
                                Paymentmethod.Reset();
                                Paymentmethod.SetRange(Code, PmtMode);
                                Paymentmethod.SetFilter("Bal. Account Type", '=%1|%2', Paymentmethod."Bal. Account Type"::RTGS, Paymentmethod."Bal. Account Type"::BT);
                                if Paymentmethod.FindFirst()then begin
                                    BankCode:=Banks."SWIFT Code";
                                    LocBankCode:='';
                                    BankBranch:='';
                                end
                                else
                                begin
                                    BankCode:=' ';
                                    LocBankCode:=Banks."Bank Code";
                                    BankBranch:=Banks."Bank Branch Code";
                                end;
                            end;
                        end;
                        //check if pay directly
                        if Banks."Non-bank" then begin
                            Bankref.reset;
                            Bankref.SetRange(Bank, Banks.Code);
                            Bankref.SetRange("Document No.", PayrollApprovalHeader."No.");
                            Bankref.setrange("Pay Directly", true);
                            if Bankref.FindFirst()then begin
                                PmtMode:=HRSetup."Pay Mode";
                                Paymentmethod.Reset();
                                Paymentmethod.SetRange(Code, PmtMode);
                                Paymentmethod.SetFilter("Bal. Account Type", '=%1|%2', Paymentmethod."Bal. Account Type"::RTGS, Paymentmethod."Bal. Account Type"::BT);
                                if Paymentmethod.FindFirst()then begin
                                    BankCode:=Banks."SWIFT Code";
                                    LocBankCode:='';
                                    BankBranch:='';
                                end
                                else
                                begin
                                    BankCode:=' ';
                                    LocBankCode:=Banks."Bank Code";
                                    BankBranch:=Banks."Bank Branch Code";
                                end;
                            end;
                        end;
                        if PayrollApprovalLines."Net Amount" > 0 then begin
                            TxtBuilder.AppendLine(StrSubstNo('%1,%2,%3,%4,%5,%6,%7,%8,%9,%10,%11,%12,%13,%14', DelChr(Format(PayrollApprovalLines."Net Amount"), '=', ',/|:'), HRSetup."Net pay POP Code", PayrollApprovalLines."Payee Name", Employees."Bank Account Number", PmtMode, (COPYSTR(Employees."Employee's Bank", 1, 2) + COPYSTR(Employees."Bank Branch", 1, 3)), Employees."Company E-Mail", HRSetup."Payment Description1", HRSetup."Payment Description2", HRSetup."Payment Description3", HRSetup."Payment Description4", HRSetup."Debit Narrative", HRSetup."Credit Narrative", HRSetup."Purpose Pay"));
                        end;
                    end;
                end;
            until PayrollApprovalLines.Next = 0;
        end;
        if SerialNumber = '' then begin
            HRSetup.TestField(HRSetup."Serial No");
            NoSeriesMgt.InitSeries(HRSetup."Serial No", "Payroll Approval"."No. Series", 0D, SerialNumber, "Payroll Approval"."No. Series");
        end;
    //eddie
    // FilePath := HRSetup."EFT Document Path" + StrSubstNo(BanksFileName, Format(Today, 0, '<YEAR><Month,2><Day,2>'), SerialNumber);
    // if Exists(FilePath) then
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
    // Download(FilePath, 'Generating EFT File', HRSetup."EFT Document Path", '', ToFile);
    end;
}

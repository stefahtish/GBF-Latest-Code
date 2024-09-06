report 50451 "RFP Evaluation Score"
{
    Caption = 'RFP Evaluation Score';
    DefaultLayout = RDLC;
    RDLCLayout = 'RFP Evaluation Score.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(TenderCommittees; "Tender Committees")
        {
            column(AppointmentNo; "Appointment No")
            {
            }
            column(CommitteeID; "Committee ID")
            {
            }
            column(CommitteeName; "Committee Name")
            {
            }
            column(CreationDate; "Creation Date")
            {
            }
            column(TenderQuotationNo; "Tender/Quotation No")
            {
            }
            column(Title; Title)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompPic; CompanyInfo.Picture)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(Companycity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(TechincalPercentage; PurchSetup."Technical Percentage")
            {
            }
            column(FinancialPercentage; PurchSetup."Financial Percentage")
            {
            }
            column(SelectedSupplierAmnt; SelectedSupplierAmnt)
            {
            }
            column(SelectedSupplierName; SelectedSupplierName)
            {
            }
            column(SelectedSupplierScore; SelectedSupplierScore)
            {
            }
            column(RFPTitle; RFPTitle)
            {
            }
            column(SupplierAmntTxt; SupplierAmntTxt)
            {
            }
            dataitem(CommiteeMembers; "Commitee Member")
            {
                DataItemLink = "Appointment No" = field("Appointment No");

                column(AppointmentNo_CommiteeMembers; "Appointment No")
                {
                }
                column(EmployeeNo_CommiteeMembers; "Employee No")
                {
                }
                column(Name_CommiteeMembers; Name)
                {
                }
                column(RefNo_CommiteeMembers; "Ref No")
                {
                }
                column(Role_CommiteeMembers; Role)
                {
                }
                column(SuppScore; Suppscore)
                {
                }
                trigger OnAfterGetRecord()
                var
                    Committee: Record "Commitee Member";
                begin
                    // Suppscore := 0;
                    Suppscore := "Supplier Evaluation Score Line".Score;
                    // Get commitee member total technical score
                    EmpRec.Reset();
                    If EmpRec.Get(CommiteeMembers."Employee No") then begin
                        SuppEvalHeader.Reset();
                        SuppEvalHeader.SetRange("Committee No.", TenderCommittees."Appointment No");
                        SuppEvalHeader.SetRange("Quote No", TenderCommittees."Tender/Quotation No");
                        SuppEvalHeader.SetRange(Type, SuppEvalHeader.Type::RFP);
                        SuppEvalHeader.SetRange(User, EmpRec."User ID");
                        If SuppEvalHeader.Findfirst() then begin
                            SuppEvalScore.Reset();
                            SuppEvalScore.SetRange("Document No.", SuppEvalHeader."No.");
                            If SuppEvalScore.FindFirst() then begin
                                SuppEvalScore.CalcFields("Total Score");
                                Suppscore := SuppEvalScore."Total Score";
                                // Message('%1,%2,%3,%4', Suppscore, SuppEvalHeader."Supplier Name", SuppEvalScore."Supplier Code", SuppEvalScore."Total Passmark");
                            end;
                        end;
                    end;
                end;
            }
            dataitem("Supplier Evaluation Header"; "Supplier Evaluation Header")
            {
                DataItemLink = "Committee No." = field("Appointment No");

                column(No_; "No.")
                {
                }
                column(Quote_No; "Quote No")
                {
                }
                column(Total_Score; "Total Score")
                {
                }
                column(User; User)
                {
                }
                column(NoOfMembers; NoOfMembers)
                {
                }
                column(Supplier_Code; "Supplier Code")
                {
                }
                column(Supplier_Name; GetSupplierName("Supplier Code"))
                {
                }
                dataitem("Supplier Evaluation Score"; "Supplier Evaluation Score")
                {
                    DataItemLink = "Document No." = field("No.");

                    column(Score_Parameter; "Score Parameter")
                    {
                    }
                    column(Score_DescriptionHeader; "Score Description")
                    {
                    }
                    column(Total_ScoreHeader; "Total Score")
                    {
                    }
                    column(BlobDescription; DescTxt)
                    {
                    }
                    column(SupplierAmnt; SupplierAmnt)
                    {
                    }
                    column(LeastAmount; LeastAmount)
                    {
                    }
                    column(Ranking; Ranking)
                    {
                    }
                    dataitem("Supplier Evaluation Score Line"; "Supplier Evaluation Score Line")
                    {
                        DataItemLink = "Document No." = field("Document No."), "Supplier Code" = field("Supplier Code"), "Score Parameter" = field("Score Parameter");

                        column(Score_DescriptionLine; ScoreDescTxt)
                        {
                        }
                        column(SupplierCode_SupplierEvaluationScoreLine; "Supplier Code")
                        {
                        }
                        column(Score; Score)
                        {
                        }
                        column(Y_N; "Y/N")
                        {
                        }
                        column(Maximum_Score; "Maximum Score")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            PurchSetup.Get();
                            ScoreSetupLines.reset;
                            ScoreSetupLines.SetRange(Code, "Supplier Evaluation Score Line"."Score Parameter");
                            ScoreSetupLines.SetRange("Line No.", "Supplier Evaluation Score Line"."Line No.");
                            if ScoreSetupLines.FindFirst then begin
                                ScoreSetupLines.CalcFields(Description);
                                ScoreSetupLines.Description.CreateInStream(ScoreInstrm);
                                ScoreDescBigTxt.Read(ScoreInstrm);
                                ScoreDescTxt := Format(ScoreDescBigTxt);
                            end;
                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        LeastAmount := 0;
                        SupplierAmnt := 0;
                        TotalFinancialScore := 0;
                        TotalScore := 0;
                        NoOfMembers := 0;
                        TotalTechnicalScore := 0;
                        // Ranking := 0;
                        SupScoreSetup.Reset();
                        SupScoreSetup.SetRange(Code, "Supplier Evaluation Score"."Score Parameter");
                        if SupScoreSetup.FindFirst() then begin
                            SupScoreSetup.CalcFields(Description);
                            SupScoreSetup.Description.CreateInStream(Instrm);
                            DescBigTxt.Read(Instrm);
                            DescTxt := Format(DescBigTxt);
                        end;
                        // supplier amount
                        RFPEvalLines.Reset();
                        RFPEvalLines.SetRange("Quote No", TenderCommittees."Tender/Quotation No");
                        RFPEvalLines.SetRange("Vendor No", "Supplier Evaluation Score"."Supplier Code");
                        RFPEvalLines.SetFilter(Amount, '>%1', 0);
                        If RFPEvalLines.FindFirst() then begin
                            SupplierAmnt := RFPEvalLines.Amount;
                        end;
                        // least amount
                        QuoteLines.Reset;
                        QuoteLines.SetRange("Quote No", "Supplier Evaluation Header"."Quote No");
                        QuoteLines.SetFilter(Amount, '>%1', 0);
                        if QuoteLines.Find('-') then begin
                            QuoteLines.CalcFields("Min Value");
                            LeastAmount := QuoteLines."Min Value";
                        end;
                        // committe member score
                        Committee.Reset();
                        Committee.SetRange("Ref No", CommiteeMembers."Ref No");
                        Committee.SetRange("Tender No.", CommiteeMembers."Tender No.");
                        Committee.SetRange("Appointment No", CommiteeMembers."Appointment No");
                        NoOfMembers := Committee.Count;
                        // Rankings
                        QuoteLines2.Reset;
                        QuoteLines2.SetRange("Quote No", TenderCommittees."Tender/Quotation No");
                        QuoteLines2.SetRange("Vendor No", "Supplier Evaluation Score"."Supplier Code");
                        QuoteLines2.SetCurrentKey("Total Score");
                        QuoteLines2.SetFilter("Total score", '>%1', 0);
                        QuoteLines2.SetAscending("Total Score", false);
                        If QuoteLines2.FindSet() then begin
                            repeat
                                Ranking := Ranking + 1;
                            until QuoteLines2.Next() = 0;
                        end;
                        /*"Supplier Evaluation Score".CalcFields(Description);
                            "Supplier Evaluation Score".Description.CreateInStream(Instrm);
                            DescBigTxt.Read(Instrm);
                            DescTxt := Format(DescBigTxt);*/
                    end;
                }
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                SelectedSupplierAmnt := 0;
                // selected supplier
                QuoteLines.Reset();
                QuoteLines.SetRange(Suggested, true);
                QuoteLines.SetRange("Quote No", TenderCommittees."Tender/Quotation No");
                QuoteLines.SetFilter(Amount, '>%1', 0);
                If QuoteLines.FindFirst() then begin
                    SelectedSupplierAmnt := Round(QuoteLines.Amount, 1, '=');
                    SelectedSupplierName := QuoteLines."Vendor Name";
                    SelectedSupplierScore := QuoteLines."Total Score";
                    Currency.Reset();
                    If Currency.FindFirst() then InitTextVariable();
                    FormatNoText(NoText, SelectedSupplierAmnt, Currency.code);
                    SupplierAmntTxt := NoText[1];
                    // Message('%1,%2,%3', SelectedSupplierName, SelectedSupplierAmnt, SelectedSupplierScore);
                end;
                // RFP title
                RFPHeader.Reset();
                RFPHeader.SetRange("Quote No", TenderCommittees."Tender/Quotation No");
                If RFPHeader.FindFirst() then begin
                    RFPTitle := RFPHeader.Title;
                    // Message('%1', RFPTitle);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture);
        PurchSetup.Get();
    end;

    var
        ProspectRec: Record "Prospective Suppliers";
        Instrm: InStream;
        Outstrm: OutStream;
        DescBigTxt: BigText;
        LeastAmount: Decimal;
        DescTxt: Text;
        SupScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLines: Record "Supplier Evaluation Setup Line";
        ScoreInstrm: InStream;
        ScoreOutstrm: OutStream;
        ScoreDescBigTxt: BigText;
        ScoreDescTxt: Text;
        TotalScore: Decimal;
        TotalFinancialScore: Decimal;
        TotalTechnicalScore: Decimal;
        PurchSetup: Record "Purchases & Payables Setup";
        QuoteLines: Record "RFP Evaluation Line";
        CompanyInfo: Record "Company Information";
        NoOfMembers: Integer;
        RFPEvalLines: Record "RFP Evaluation Line";
        SupplierAmnt: Decimal;
        SuppEvalHeader: Record "Supplier Evaluation Header";
        SuppEvalScore: Record "Supplier Evaluation Score";
        EmpRec: Record Employee;
        Committee: Record "Commitee Member";
        Suppscore: Decimal;
        SelectedSupplierName: Text;
        SelectedSupplierAmnt: Decimal;
        SelectedSupplierScore: Decimal;
        RFPTitle: Text;
        RFPHeader: Record "RFP Evaluation Header";
        SupplierAmntTxt: Text;
        RepCheck: Report Check;
        Currency: Record Currency;
        NoText: array[2] of text[100];
        QuoteLines2: Record "RFP Evaluation Line";
        Ranking: Integer;
        Text000: Label 'Preview is not allowed.';
        Text001: Label 'Last Check No. must be filled in.';
        Text002: Label 'Filters on %1 and %2 are not allowed.';
        Text003: Label 'XXXXXXXXXXXXXXXX';
        Text004: Label 'must be entered.';
        Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
        Text008: Label 'Both Bank Accounts must have the same currency.';
        Text010: Label 'XXXXXXXXXX';
        Text011: Label 'XXXX';
        Text012: Label 'XX.XXXXXXXXXX.XXXX';
        Text013: Label '%1 already exists.';
        Text014: Label 'Check for %1 %2';
        Text016: Label 'In the Check report, One Check per Vendor and Document No.\must not be activated when Applies-to ID is specified in the journal lines.';
        Text019: Label 'Total';
        Text020: Label 'The total amount of check %1 is %2. The amount must be positive.';
        Text021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        Text022: Label 'NON-NEGOTIABLE';
        Text023: Label 'Test print';
        Text024: Label 'XXXX.XX';
        Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text030: Label ' is already applied to %1 %2 for customer %3.';
        Text031: Label ' is already applied to %1 %2 for vendor %3.';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
        Text063: Label 'Net Amount %1';
        Text064: Label '%1 must not be %2 for %3 %4.';
        Text065: Label 'Subtotal';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];

    local procedure GetSupplierName(SupplierCode: Code[50]): Text
    begin
        if ProspectRec.get(SupplierCode) then exit(ProspectRec.Name);
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        GLSetup: Record "General Ledger Setup";
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';
        GLSetup.Get();

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        else
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div Power(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        DecimalPosition := GetAmtDecimalPosition();
        AddToNoText(NoText, NoTextIndex, PrintExponent, (Format(No * DecimalPosition) + '/' + Format(DecimalPosition)));

        if CurrencyCode <> '' then
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);

        OnAfterFormatNoText(NoText, No, CurrencyCode);
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(Text029, AddText);
        end;

        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    local procedure GetAmtDecimalPosition(): Decimal
    var
        Currency: Record Currency;
        GenJnlLine: record "Gen. Journal Line";
    begin
        if GenJnlLine."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(GenJnlLine."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;
        exit(1 / Currency."Amount Rounding Precision");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    begin
    end;

}

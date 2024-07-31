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
                    If Currency.FindFirst() then RepCheck.InitTextVariable;
                    RepCheck.FormatNoText(NoText, SelectedSupplierAmnt, Currency.code);
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

    local procedure GetSupplierName(SupplierCode: Code[50]): Text
    begin
        if ProspectRec.get(SupplierCode) then exit(ProspectRec.Name);
    end;
}

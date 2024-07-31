report 50313 "RFP Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RFPAnalysis.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("RFP Evaluation Header"; "RFP Evaluation Header")
        {
            RequestFilterFields = "Quote No";

            column(Quote_No; "Quote No")
            {
            }
            column(Title; Title)
            {
            }
            column(Requisition_No; "Requisition No")
            {
            }
            column(RFP_Generated; "RFP Generated")
            {
            }
            column(Minutes; Minutes)
            {
            }
            column(Awarding_Committee; "Awarding Committee")
            {
            }
            column(Date_of_Award; "Date of Award")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            dataitem("RFP Evaluation Line"; "RFP Evaluation Line")
            {
                DataItemLink = "Quote No" = FIELD("Quote No");

                column(Quote_No1; "Quote No")
                {
                }
                column(Vendor_No; "Vendor No")
                {
                }
                column(Type; Type)
                {
                }
                column(No_; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_Amount; "Unit Amount")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Awarded; Awarded)
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(Line_No; "Line No")
                {
                }
                column(Quote_Generated; "Quote Generated")
                {
                }
                column(Vendor_Name; "Vendor Name")
                {
                }
                column(Title1; Title)
                {
                }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
                {
                }
                column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
                {
                }
                column(Dimension_Set_ID; "Dimension Set ID")
                {
                }
                column(Committed; Committed)
                {
                }
                column(Quantity_Received; "Quantity Received")
                {
                }
                column(Procurement_Plan; "Procurement Plan")
                {
                }
                column(Procurement_Plan_Item; "Procurement Plan Item")
                {
                }
                column(Budget_Line; "Budget Line")
                {
                }
                column(Request_Date; "Request Date")
                {
                }
                column(Expected_Receipt_Date; "Expected Receipt Date")
                {
                }
                column(Suggested; Suggested)
                {
                }
                column(Amount_Inclusive_VAT; "Amount Inclusive VAT")
                {
                }
                column(AwardedVendorNo; AwardedVendorNo)
                {
                }
                column(AwardedVendorName; AwardedVendorName)
                {
                }
                column(AwardedVendorAmnt; AwardedVendorAmnt)
                {
                }
                trigger OnAfterGetRecord()
                var
                    NoOfRecs: Integer;
                    HalfCount: Integer;
                    SupEval: Record "Supplier Evaluation Header";
                    SuppScore: Record "Supplier Evaluation Score";
                    TotalPassMark: Decimal;
                    TotalTechnicalScore: Decimal;
                    TotalFinancialScore: Decimal;
                    TotalScore: Decimal;
                    ScoreSetup: Record "Supplier Evaluation SetUp";
                    PurchSetup: Record "Purchases & Payables Setup";
                    SuppDocs: Record "Supplier Evaluation Document";
                    Counter: Integer;
                    SuggestedSupplier: Decimal;
                    Vendor: Record Vendor;
                begin
                    LeastAmount := 0;
                    NoOfRecs := 0;
                    HalfCount := 0;
                    Counter := 0;
                    TotalPassMark := 0;
                    TotalScore := 0;
                    TotalFinancialScore := 0;
                    TotalTechnicalScore := 0;
                    PurchSetup.Get();
                    PurchSetup.TestField("Shortlisted Suppliers");
                    PurchSetup.TestField("Technical Percentage");
                    // financials opened after passing technical shortlisting.those who have passed should be the only ones on the list
                    // total score * 70 + least amount/firm under consideration amount * 30
                    //get total count
                    QuoteLines.Reset;
                    QuoteLines.SetRange("Quote No", "RFP Evaluation Header"."Quote No");
                    if QuoteLines.Find('-') then;
                    NoOfRecs := QuoteLines.Count;
                    //Check Score and above pass mark to suggested = true
                    SupEval.Reset();
                    SupEval.SetRange("Quote No", "RFP Evaluation Header"."Quote No");
                    If SupEval.Findfirst() then begin
                        repeat
                            ScoreSetup.Reset();
                            ScoreSetup.SetRange("Procurement Ref No.", "RFP Evaluation Header"."Quote No");
                            ScoreSetup.SetRange(Active, true);
                            If ScoreSetup.FindFirst() then begin
                                If ScoreSetup."Score Criteria" = ScoreSetup."Score Criteria"::Score then begin
                                    SuppScore.Reset();
                                    SuppScore.SetRange("Document No.", SupEval."No.");
                                    if SuppScore.Find('-') then begin
                                        repeat
                                            SuppScore.CalcFields("Total Score");
                                            TotalScore := SuppScore."Total Score";
                                        until SuppScore.Next() = 0;
                                        // Award highest combined score of (technical and financial)
                                        TotalTechnicalScore := Round(TotalScore * PurchSetup."Technical Percentage" / 100, 1);
                                        //financialscore
                                        QuoteLines.Reset;
                                        QuoteLines.SetRange("Quote No", "RFP Evaluation Header"."Quote No");
                                        QuoteLines.SetRange("Vendor No", SuppScore."Supplier Code");
                                        QuoteLines.SetFilter(Amount, '>%1', 0);
                                        if QuoteLines.Find('-') then begin
                                            QuoteLines.CalcFields("Min Value");
                                            LeastAmount := QuoteLines."Min Value";
                                            //total financial score = leastamount divided by the amount by the financial percentage
                                            TotalFinancialScore := Round(LeastAmount / QuoteLines.Amount * PurchSetup."Financial Percentage", 1);
                                            TotalScore := TotalFinancialScore + TotalTechnicalScore;
                                            QuoteLines."Total Score" := TotalScore;
                                            QuoteLines.Suggested := false;
                                            QuoteLines.Modify();
                                        end;
                                    end;
                                end
                                else if ScoreSetup."Score Criteria" = ScoreSetup."Score Criteria"::"Yes/No" then begin
                                    SuppScore.Reset();
                                    SuppScore.SetRange("Document No.", SupEval."No.");
                                    if SuppScore.Find('-') then begin
                                        QuoteLines.Reset;
                                        QuoteLines.SetRange(QuoteLines."Vendor No", SupEval."Supplier Code");
                                        if QuoteLines.Find('-') then begin
                                            if SuppScore.Pass then begin
                                                QuoteLines.Suggested := true;
                                                QuoteLines.Modify;
                                            end
                                            else begin
                                                QuoteLines.Suggested := false;
                                                QuoteLines.Modify;
                                            end;
                                        end;
                                    end;
                                end;
                            end // else
                        //     if ScoreSetup."Score Criteria" = ScoreSetup."Score Criteria"::"True/False" then begin
                        //         SuppScore.Reset();
                        //         SuppScore.SetRange("Document No.", SupEval."No.");
                        //         if SuppScore.Find('-') then begin
                        //             QuoteLines.Reset;
                        //             QuoteLines.SetRange(QuoteLines."Vendor No", SupEval."Supplier Code");
                        //             if QuoteLines.Find('-') then begin
                        //                 if SuppScore."Yes/No" = SuppScore."Yes/No"::Yes then begin
                        //                     QuoteLines.Suggested := true;
                        //                 end else begin
                        //                     QuoteLines.Suggested := false;
                        //                 end;
                        //             end;
                        //             QuoteLines.Modify;
                        //         end;
                        //     end
                        //     else
                        //         if ScoreSetup."Score Criteria" = ScoreSetup."Score Criteria"::"Yes/No" then begin
                        //             SuppScore.Reset();
                        //             SuppScore.SetRange("Document No.", SupEval."No.");
                        //             if SuppScore.Find('-') then begin
                        //                 QuoteLines.Reset;
                        //                 QuoteLines.SetRange(QuoteLines."Vendor No", SupEval."Supplier Code");
                        //                 if QuoteLines.Find('-') then begin
                        //                     if SuppScore."Yes/No" = SuppScore."Yes/No"::Yes then begin
                        //                         QuoteLines.Suggested := true;
                        //                     end else begin
                        //                         QuoteLines.Suggested := false;
                        //                     end;
                        //                     // end;
                        //                 end;
                        //             end;
                        //         end;
                        // QuoteLines.Modify;
                        until SupEval.Next() = 0;
                        // suggest supplier with highest score
                        QuoteLines2.Reset;
                        QuoteLines2.SetRange("Quote No", "RFP Evaluation Header"."Quote No");
                        QuoteLines2.SetCurrentKey("Total Score");
                        QuoteLines2.SetAscending("Total Score", false);
                        If QuoteLines2.FindFirst() then begin
                            QuoteLines2.Suggested := true;
                            QuoteLines2.Modify;
                            AwardedVendorNo := QuoteLines2."Vendor No";
                            AwardedVendorName := QuoteLines2."Vendor Name";
                            AwardedVendorAmnt := QuoteLines2."Amount Inclusive VAT";
                        end;
                    end;
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        LeastAmount: Decimal;
        CompanyInfo: Record "Company Information";
        QuoteLines: Record "RFP Evaluation Line";
        QuoteLines2: Record "RFP Evaluation Line";
        AwardedVendorNo: Code[50];
        AwardedVendorName: Text;
        AwardedVendorAmnt: Decimal;
}

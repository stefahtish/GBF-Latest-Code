report 50318 "EOI Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './EOIAnalysis.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("EOI Evaluation Header"; "EOI Evaluation Header")
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
            column(EOI_Generated; "EOI Generated")
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
            dataitem("EOI Evaluation Line"; "EOI Evaluation Line")
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
                column(Counter; Counter)
                {
                }
                column(ShortListedRecords; ShortListedRecords)
                {
                }
                column(VendAddress; VendAddress)
                {
                }
                column(VendEmail; VendEmail)
                {
                }
                column(VendPhone; VendPhone)
                {
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    // Vendor details
                    Vend.Reset();
                    Vend.SetRange("No.", "EOI Evaluation Line"."Vendor No");
                    If Vend.FindFirst() then begin
                        VendAddress := Vend."Postal Address";
                        VendEmail := Vend."E-mail";
                        VendPhone := Vend."Contact Phone No.";
                    end
                end;
            }
            trigger OnAfterGetRecord()
            var
                NoOfDocsRequired: Integer;
                NoOfDocsSubmitted: Integer;
                SuppCount: Integer;
                SupEval: Record "Supplier Evaluation Header";
                SuppScore: Record "Supplier Evaluation Score";
                PurchSetup: Record "Purchases & Payables Setup";
                SuppDocs: Record "Supplier Evaluation Document";
                DocsRequired: Record "Document required";
            begin
                NoOfDocsRequired := 0;
                NoOfDocsSubmitted := 0;
                Counter := 0;
                SuppCount := 0;
                PurchSetup.Get();
                //get total count for needed documents
                DocsRequired.Reset();
                DocsRequired.SetRange("Quote No", "EOI Evaluation Header"."Quote No");
                NoOfDocsRequired := DocsRequired.Count;
                QuoteLines.Reset;
                QuoteLines.SetRange(QuoteLines."Quote No", "EOI Evaluation Header"."Quote No");
                if QuoteLines.Find('-') then begin
                    //total suppliers
                    SuppCount := QuoteLines.Count;
                    repeat // Suppliers Counter
                        Counter := Counter + 1;
                        // Check Supplier Submitted Documents
                        SuppDocs.Reset();
                        SuppDocs.SetRange("Supplier Code", QuoteLines."Vendor No");
                        SuppDocs.SetRange("Tender No.", QuoteLines."Quote No");
                        SuppDocs.SetRange(Submitted, True);
                        If SuppDocs.Find('-') then begin
                            //get total count for submitted documents
                            NoOfDocsSubmitted := SuppDocs.Count;
                            DocsRequired.Reset;
                            DocsRequired.SetRange("Document Code", SuppDocs."Document Code");
                            if DocsRequired.Find('-') then begin
                                //check if no of docs submitted is equal to required
                                If NoOfDocsSubmitted >= NoOfDocsRequired then begin
                                    QuoteLines.Suggested := true;
                                    QuoteLines.Modify;
                                end
                                else begin
                                    QuoteLines.Suggested := false;
                                    QuoteLines.Modify;
                                end;
                            end;
                        end;
                    // Message('%1 docsrequired, %2 vendor, %3 submitted, %4 Suggested', NoOfDocsRequired, SuppDocs."Supplier Code", NoOfDocsSubmitted, QuoteLines.Suggested)
                    until Quotelines.Next() = 0;
                end;
            end;
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
        QuoteLines: Record "EOI Evaluation Line";
        QuoteLines2: Record "EOI Evaluation Line";
        Counter: Integer;
        ShortListedRecords: Integer;
        Vend: Record "Prospective Suppliers";
        VendPhone: Code[50];
        VendEmail: Text;
        VendAddress: Text;
}

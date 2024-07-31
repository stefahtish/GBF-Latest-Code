report 50317 EOI
{
    DefaultLayout = RDLC;
    RDLCLayout = './EOI.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Supplier Selection"; "Supplier Selection")
        {
            DataItemTableView = WHERE(Invited = CONST(true));
            RequestFilterFields = "Reference No.";

            column(ReferenceNo_SupplierSelection; "Supplier Selection"."Reference No.")
            {
            }
            column(SupplierName_SupplierSelection; "Supplier Selection"."Supplier Name")
            {
            }
            column(SupplierCategory_SupplierSelection; "Supplier Selection"."Supplier Category")
            {
            }
            column(Invited_SupplierSelection; "Supplier Selection".Invited)
            {
            }
            column(Address_SupplierSelection; "Supplier Selection".Address)
            {
            }
            column(City_SupplierSelection; "Supplier Selection".City)
            {
            }
            column(PhoneNo_SupplierSelection; "Supplier Selection"."Phone No.")
            {
            }
            column(PostCode_SupplierSelection; "Supplier Selection"."Post Code")
            {
            }
            column(CountryRegionCode_SupplierSelection; "Supplier Selection"."Country/Region Code")
            {
            }
            column(County_SupplierSelection; "Supplier Selection".County)
            {
            }
            column(SupplierCode_SupplierSelection; "Supplier Selection"."Supplier Code")
            {
            }
            column(SupplierEmail_SupplierSelection; "Supplier Selection"."Supplier Email")
            {
            }
            dataitem("Procurement Request"; "Procurement Request")
            {
                DataItemLink = "No." = FIELD("Reference No.");

                column(No_ProcurementRequest; "Procurement Request"."No.")
                {
                }
                column(Title_ProcurementRequest; "Procurement Request".Title)
                {
                }
                column(RequisitionNo_ProcurementRequest; "Procurement Request"."Requisition No")
                {
                }
                column(ProcurementPlanNo_ProcurementRequest; "Procurement Request"."Procurement Plan No")
                {
                }
                column(CreationDate_ProcurementRequest; "Procurement Request"."Creation Date")
                {
                }
                column(UserID_ProcurementRequest; "Procurement Request"."User ID")
                {
                }
                column(Procurementtype_ProcurementRequest; "Procurement Request"."Procurement type")
                {
                }
                column(NoSeries_ProcurementRequest; "Procurement Request"."No. Series")
                {
                }
                column(ProcessType_ProcurementRequest; "Procurement Request"."Process Type")
                {
                }
                column(ProcurementPlanItem_ProcurementRequest; "Procurement Request"."Procurement Plan Item")
                {
                }
                column(Category_ProcurementRequest; "Procurement Request".Category)
                {
                }
                column(ShortcutDimension1Code_ProcurementRequest; "Procurement Request"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_ProcurementRequest; "Procurement Request"."Shortcut Dimension 2 Code")
                {
                }
                column(TenderOpeningDate_ProcurementRequest; "Procurement Request".TenderOpeningDate)
                {
                }
                column(TenderStatus_ProcurementRequest; "Procurement Request"."Tender Status")
                {
                }
                column(TenderClosingDate_ProcurementRequest; "Procurement Request".TenderClosingDate)
                {
                }
                column(Addedum_ProcurementRequest; "Procurement Request".Addedum)
                {
                }
                column(SiteView_ProcurementRequest; "Procurement Request".SiteView)
                {
                }
                column(Status_ProcurementRequest; "Procurement Request".Status)
                {
                }
                column(QuotationDeadline_ProcurementRequest; "Procurement Request"."Quotation Deadline")
                {
                }
                column(DimensionSetID_ProcurementRequest; "Procurement Request"."Dimension Set ID")
                {
                }
                column(ExpectedClosingTime_ProcurementRequest; "Procurement Request"."Expected Closing Time")
                {
                }
                column(CompanyInfo_Name; CompanyInfo.Name)
                {
                }
                column(CompanyInfo_Address; CompanyInfo.Address)
                {
                }
                column(CompanyInfo_Address2; CompanyInfo."Address 2")
                {
                }
                column(CompanyInfo_City; CompanyInfo.City)
                {
                }
                column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
                {
                }
                column(CompanyInfo_FaxNo; CompanyInfo."Fax No.")
                {
                }
                column(CompanyInfo_Picture; CompanyInfo.Picture)
                {
                }
                column(CompNameCaption; CompNameCaption)
                {
                }
                column(ReportTitleCaption; ReportTitleCaption)
                {
                }
                column(Inivite; Inivite)
                {
                }
                column(NoteA; NoteA)
                {
                }
                column(NoteC; NoteC)
                {
                }
                column(NoteD; NoteD)
                {
                }
                column(DeliveryNote; DeliveryNote)
                {
                }
                column(NBCaption; NBCaption)
                {
                }
                column(SellersCaption; SellersCaption)
                {
                }
                column(DateCation; DateCation)
                {
                }
                column(OpennedByCaption; OpennedByCaption)
                {
                }
                column(DesignationCaption; DesignationCaption)
                {
                }
                column(SignatureCaptiion; SignatureCaptiion)
                {
                }
                column(TimeCaption; TimeCaption)
                {
                }
                column(ConditionsCaption; ConditionsCaption)
                {
                }
                column(Cond1; Cond1)
                {
                }
                column(Cond2; Cond2)
                {
                }
                column(Cond3; Cond3)
                {
                }
                column(Cond4; Cond4)
                {
                }
                column(InstructionCaption; InstructionCaption)
                {
                }
                column(Instruct1; Instruct1)
                {
                }
                column(Instruct2; Instruct2)
                {
                }
                column(Instruct3; Instruct3)
                {
                }
                column(Instruct4; Instruct4)
                {
                }
                column(Instruct5; Instruct5)
                {
                }
                column(CountryCaption; CountryCaption)
                {
                }
                column(Counter; Counter)
                {
                }
                dataitem("Procurement Request Lines"; "Procurement Request Lines")
                {
                    DataItemLink = "Requisition No" = FIELD("No.");

                    column(RequisitionNo_ProcurementRequestLines; "Procurement Request Lines"."Requisition No")
                    {
                    }
                    column(LineNo_ProcurementRequestLines; "Procurement Request Lines"."Line No")
                    {
                    }
                    column(Type_ProcurementRequestLines; "Procurement Request Lines".Type)
                    {
                    }
                    column(No_ProcurementRequestLines; "Procurement Request Lines".No)
                    {
                    }
                    column(Description_ProcurementRequestLines; "Procurement Request Lines".Description)
                    {
                    }
                    column(Quantity_ProcurementRequestLines; "Procurement Request Lines".Quantity)
                    {
                    }
                    column(UnitofMeasure_ProcurementRequestLines; "Procurement Request Lines"."Unit of Measure")
                    {
                    }
                    column(UnitPrice_ProcurementRequestLines; "Procurement Request Lines"."Unit Price")
                    {
                    }
                    column(Amount_ProcurementRequestLines; "Procurement Request Lines".Amount)
                    {
                    }
                    column(ProcurementPlan_ProcurementRequestLines; "Procurement Request Lines"."Procurement Plan")
                    {
                    }
                    column(ProcurementPlanItem_ProcurementRequestLines; "Procurement Request Lines"."Procurement Plan Item")
                    {
                    }
                    column(BudgetLine_ProcurementRequestLines; "Procurement Request Lines"."Budget Line")
                    {
                    }
                    column(AmountLCY_ProcurementRequestLines; "Procurement Request Lines"."Amount LCY")
                    {
                    }
                    column(Select_ProcurementRequestLines; "Procurement Request Lines".Select)
                    {
                    }
                    column(RequestGenerated_ProcurementRequestLines; "Procurement Request Lines"."Request Generated")
                    {
                    }
                    column(RequestDate_ProcurementRequestLines; "Procurement Request Lines"."Request Date")
                    {
                    }
                    column(ExpectedReceiptDate_ProcurementRequestLines; "Procurement Request Lines"."Expected Receipt Date")
                    {
                    }
                    column(ShortcutDimension1Code_ProcurementRequestLines; "Procurement Request Lines"."Shortcut Dimension 1 Code")
                    {
                    }
                    column(ShortcutDimension2Code_ProcurementRequestLines; "Procurement Request Lines"."Shortcut Dimension 2 Code")
                    {
                    }
                    column(Committed_ProcurementRequestLines; "Procurement Request Lines".Committed)
                    {
                    }
                    column(DimensionSetID_ProcurementRequestLines; "Procurement Request Lines"."Dimension Set ID")
                    {
                    }
                    column(Specifications_ProcurementRequestLines; "Procurement Request Lines".Specification2)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        Counter := Counter + 1;
                    end;
                }
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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        Counter := 0;
    end;

    var
        CompNameCaption: Label 'KMRC';
        ReportTitleCaption: Label 'TENDER';
        Inivite: Label 'You are invited to submit quotation on materials listed below:';
        NoteA: Label '(a) THIS IS NOT AN ORDER. Read the conditions and instructions on reverse before quoting.';
        NoteC: Label '(c) Your quotation should indicate final unit price which includes all costs for delivery ,discount, duty and sales tax.';
        NoteD: Label '(d) Return the original copy and retain the duplicate for your record.';
        DeliveryNote: Label 'Delivery to be made within 3 days after receipt of purchase order (LPO) to user department:';
        NBCaption: Label 'N/B: Please attach your AGPO certificate ( if registered) when submitting your quotation';
        SellersCaption: Label 'Seller''s Signature & Official Rubber Stamp';
        DateCation: Label 'Date';
        OpennedByCaption: Label 'Opened By:';
        DesignationCaption: Label 'Designation';
        SignatureCaptiion: Label 'Signature';
        TimeCaption: Label 'Time';
        ConditionsCaption: Label 'CONDITIONS';
        Cond1: Label '1.The General Conditions of Contract with the Government of Kenya apply to this transaction.  This form properly submitted constitutes the entire agreement.';
        Cond2: Label '2.The offer shall remain firm for 60 days from the closing date unless otherwise stipulated by the seller.';
        Cond3: Label '3.The buyer shall not be bound to accept the lowest or any other offer, and reserves the right to accept any offer in part unless the contrary stipulated by the seller.';
        Cond4: Label '4.Samples of offers when required will be provided free and if not destroyed during tests will, upon request, be returned at the seller''s expenses.';
        InstructionCaption: Label 'INSTRUCTIONS';
        Instruct1: Label '1.All entries must be typed or written in ink. Mistakes must not be erased but should be crossed out and corrections be made and initialed by the person signing the quotation.';
        Instruct2: Label '2.Quote on each item separately, and in units as specified.';
        Instruct3: Label '3.This form must be signed by a competent person and preferably it should also be rubber stamped.';
        Instruct4: Label '4.Each quotation should be submitted separately in a sealed envelope with the Quotation Number endorsed on the outside.Descriptive literature or samples of the items offered may be forwarded with the quotation.';
        Instruct5: Label '5.If you do not wish to quote, please endorse the reasons on this form and return it, otherwise your name may be deleted from the buyer''s mailing list for the items listed hereon.';
        CompanyInfo: Record "Company Information";
        CountryCaption: Label 'Kenya';
        Counter: Integer;
}

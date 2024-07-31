report 50486 "Test Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Test2023.rdl';

    dataset
    {
        dataitem("Procurement Request"; "Procurement Request")
        {
            //PrintOnlyIfDetail = true;
            column(QuoteText; QuoteText)
            {
            }
            column(TechnicalResponseText; TechnicalResponseText)
            {
            }
            column(ResponseText; ResponseText)
            {
            }
            column(No_; "No.")
            {
            }
            column(Title; UpperCase(Title))
            {
            }
            column(TenderClosingDate; TenderClosingDate)
            {
            }
            column(Expected_Closing_Time; "Expected Closing Time")
            {
            }
            column(Introdcution; Introdcution)
            {
            }
            column(Company_Logo; CompInfor.Picture)
            {
            }
            column(Company_Name; CompInfor.Name)
            {
            }
            column(Recommendation; Recommendation)
            {
            }
            dataitem("Supplier Selection"; "Supplier Selection")
            {
                DataItemLink = "Reference No."=field("No."), "Supplier Category"=field(Category);

                column(Supplier_Code; "Supplier Code")
                {
                }
                column(Supplier_Name; "Supplier Name")
                {
                }
                column(InvitedVendorsCount; InvitedVendorsCount)
                {
                }
                column(InvitedVendorCountText; InvitedVendorCountText)
                {
                }
                trigger OnAfterGetRecord()
                var
                    SupplSelecl: Record "Supplier Selection";
                    VendCont: Integer;
                begin
                    SupplSelecl.Reset();
                    SupplSelecl.SetRange("Reference No.", "Reference No.");
                    SupplSelecl.SetRange("Supplier Category", "Supplier Category");
                    VendCont:=SupplSelecl.Count();
                    InvitedVendorsCount+=1;
                    InvitedVendorCountText:='Quotations were sought from' + ' ' + Format(VendCont) + ' ' + 'service providers namely;';
                end;
            }
            dataitem("Prospective Supplier Tender"; "Prospective Supplier Tender")
            {
                DataItemLink = "Tender No."=field("No.");

                column(Tender_No_; "Tender No.")
                {
                }
                column(Title_Prospect_Supplier; Title)
                {
                }
                column(Passed_Financial; "Passed Financial")
                {
                }
                column(Passed_Preliminary; "Passed Preliminary")
                {
                }
                column(Prospect_No_; "Prospect No.")
                {
                }
                column(AppliedVendorsCount; AppliedVendorsCount)
                {
                }
                column(Applied_VendorName; Applied_VendorName)
                {
                }
                dataitem("Supplier Evaluation Header"; "Supplier Evaluation Header")
                {
                    DataItemLink = "Supplier Code"=field("Prospect No."), "Quote No"=field("Tender No.");

                    //DataItemTableView = where(Stage = const(Preliminary));
                    column(Supplier_Name_Docs; "Supplier Name")
                    {
                    }
                    dataitem("Supplier Evaluation Document"; "Supplier Evaluation Document")
                    {
                        DataItemLink = "Quote No."=field("No."), "Tender No."=field("Quote No");

                        column(Document_Name; "Document Name")
                        {
                        }
                        column(Document_Code; "Document Code")
                        {
                        }
                        column(Submitted; Submitted)
                        {
                        }
                        column(Remarks; Remarks)
                        {
                        }
                        column(DocumentCount; DocumentCount)
                        {
                        }
                        column(ResposiveNess; ResposiveNess)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            DocumentCount:=DocumentCount + 1;
                            Clear(ResposiveNess);
                            DocumentsRec.Reset();
                            DocumentsRec.SetRange("Document Code", "Document Code");
                            DocumentsRec.SetRange("Supplier Code", "Supplier Code");
                            DocumentsRec.SetRange("Tender No.", "Tender No.");
                            DocumentsRec.SetRange(Submitted, false);
                            if DocumentsRec.FindFirst()then ResposiveNess:='N'
                            else
                                ResposiveNess:='R';
                        end;
                    }
                    trigger OnPreDataItem()
                    begin
                        "Supplier Evaluation Header".SetFilter(Stage, '%1', "Supplier Evaluation Header".Stage::Preliminary);
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    i: Integer;
                begin
                    //Clear(ResponseText);
                    AppliedVendorsCount:=AppliedVendorsCount + 1;
                    Clear(Applied_VendorName);
                    ProspectiveSupplier.Reset();
                    ProspectiveSupplier.Reset();
                    ProspectiveSupplier.SetRange(ProspectiveSupplier."No.", "Prospective Supplier Tender"."Prospect No.");
                    if ProspectiveSupplier.FindFirst()then Applied_VendorName:=ProspectiveSupplier.Name;
                end;
            }
            dataitem("Procurement Request Lines"; "Procurement Request Lines")
            {
                DataItemLink = "Requisition No"=field("No.");

                column(Type; Type)
                {
                }
                column(Description; Description)
                {
                }
                column(Specification2; Specification2)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_Price; "Unit Price")
                {
                }
                dataitem(Prospective_Supplier_Tender_Technical; "Prospective Supplier Tender")
                {
                    DataItemLink = "Tender No."=field("Requisition No");

                    column(Passed_Technical; "Passed Technical")
                    {
                    }
                    column(Prospect_No_Technical; "Prospect No.")
                    {
                    }
                    column(Supplier_Name_Technical; Supplier_Name_Technical)
                    {
                    }
                    column(TechnicalResponsiveness; TechnicalResponsiveness)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        ProspectiveSuppTechnical.Reset();
                        ProspectiveSuppTechnical.SetRange("No.", "Prospect No.");
                        if ProspectiveSuppTechnical.FindFirst()then Supplier_Name_Technical:=ProspectiveSuppTechnical.Name;
                        if "Passed Technical" then TechnicalResponsiveness:='Passed'
                        else
                            TechnicalResponsiveness:='Failed';
                    end;
                    trigger OnPreDataItem()
                    begin
                        Prospective_Supplier_Tender_Technical.SetFilter("Passed Preliminary", '%1', true);
                    end;
                }
                dataitem("Tender Evaluation Line"; "Tender Evaluation Line")
                {
                    DataItemLink = "Quote No"=field("Requisition No"), "Line No"=field("Line No"), Type=field(Type);

                    column(Description_Eval; Description)
                    {
                    }
                    column(Quantity_Eval; Quantity)
                    {
                    }
                    column(Unit_Amount; "Unit Amount")
                    {
                    }
                    column(Amount; Amount)
                    {
                    }
                    column(Amount_Inclusive_VAT; "Amount Inclusive VAT")
                    {
                    }
                    column(Vendor_Name; "Vendor Name")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        Clear(SupplierNameFinancial);
                        ProspectiveSuppFinancial.Reset();
                        ProspectiveSuppFinancial.SetRange("No.", "Vendor No");
                    end;
                }
            }
            dataitem("Commitee Member"; "Commitee Member")
            {
                DataItemLink = "Tender No."=field("No.");

                column(Role; UpperCase(format(Role)))
                {
                }
                column(Employee_No; "Employee No")
                {
                }
                column(Name; Name)
                {
                }
                column(ComitteeCount; ComitteeCount)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    ComitteeCount+=1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                GenCount: Integer;
            begin
                //Clear(ResponseText);
                BiddProspect2.Reset();
                BiddProspect2.SetRange("Tender No.", "Procurement Request"."No.");
                ResponseCount:=BiddProspect2.Count();
                BiddProspect3.Reset();
                BiddProspect3.SetRange("Tender No.", "No.");
                BiddProspect3.SetFilter("Passed Preliminary", '%1', true);
                GenCount:=BiddProspect3.Count();
                if ResponseCount = GenCount then QuoteText:='All the ' + ' ' + Format(ResponseCount) + ' ' + 'firms were responsive in the preliminary evaluation and were considered for technical evaluation.'
                else
                    QuoteText:='Out of the ' + ' ' + Format(ResponseCount) + ' ' + 'firms that were invited,' + ' ' + 'Only' + ' ' + Format(GenCount) + ' ' + 'firms were responsive in the preliminary evaluation and were considered for technical evaluation.';
                Clear(Supplier_Name_Technical);
                ProspectiveSupplierTender.Reset();
                ProspectiveSupplierTender.SetRange("Tender No.", "No.");
                ProspectiveSupplierTender.SetRange("Passed Technical", true);
                TechnicalCount:=ProspectiveSupplierTender.Count();
                if ResponseCount = TechnicalCount then TechnicalResponseText:='All the ' + ' ' + Format(ResponseCount) + ' ' + 'firms were responsive in the technical evaluation and were considered for financial evaluation.'
                else
                    TechnicalResponseText:='Out of the ' + ' ' + Format(ResponseCount) + 'firms that passed the preliminary evaluation,' + ' ' + 'Only' + ' ' + Format(TechnicalCount) + ' ' + 'firms were responsive in the technical evaluation and were considered for financial evaluation.';
                ResponseText:='The quotation was closed on ' + Format(TenderClosingDate) + ' ' + 'at' + ' ' + Format("Expected Closing Time") + '.' + ' ' + 'At the closing time, ONLY ' + Format(ResponseCount) + ' ' + 'firms had responded. The firms were:';
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
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
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompInfor.Get();
        CompInfor.CalcFields(Picture);
    end;
    var TechnicalResponsiveness: Text;
    ComitteeCount: Integer;
    //myInt: Report 204;
    InvitedVendorsCount: Integer;
    AppliedVendorsCount: Integer;
    ProspectiveSupplier: Record "Prospective Suppliers";
    Applied_VendorName: Text;
    ResposiveNess: Text;
    DocuRec: Record "Supplier Evaluation Document";
    EvaluatedItemCount: Integer;
    InvitedVendorCountText: text;
    BidderContent: Text;
    BiddProspect: Record "Prospective Supplier Tender";
    BiddProspect2: Record "Prospective Supplier Tender";
    BiddProspect3: Record "Prospective Supplier Tender";
    ResponseCount: Integer;
    ProspectiveSuppliers: Record "Prospective Suppliers";
    ResponseText: Text;
    QuoteText: Text;
    CompInfor: Record "Company Information";
    CommitteCount: Integer;
    SubmittedCount: Integer;
    RequestedVendCount: Integer;
    DocumentCount: Integer;
    DocumentsRec: Record "Supplier Evaluation Document";
    ProspectiveSupplierTender: Record "Prospective Supplier Tender";
    ProspectiveSupplierTender2: Record "Prospective Supplier Tender";
    Supplier_Name_Technical: Text[100];
    TechnicalCount: Integer;
    TechnicalResponseText: Text;
    TechnicalSuppName: Text;
    ProspectiveSuppTechnical: Record "Prospective Suppliers";
    ProspectiveSuppFinancial: Record "Prospective Suppliers";
    SupplierNameFinancial: Text;
}

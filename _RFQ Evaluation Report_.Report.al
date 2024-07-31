report 50485 "RFQ Evaluation Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './RFQEvaluationRept.rdl';

    dataset
    {
        dataitem("Procurement Request"; "Procurement Request")
        {
            PrintOnlyIfDetail = true;

            column(CountText; CountText)
            {
            }
            column(No_; "No.")
            {
            }
            column(Requisition_No; "Requisition No")
            {
            }
            column(Title; Title)
            {
            }
            column(Expected_Closing_Time; "Expected Closing Time")
            {
            }
            column(TenderClosingDate; TenderClosingDate)
            {
            }
            column(Introdcution; Introdcution)
            {
            }
            column(ResponseText; ResponseText)
            {
            }
            column(QuoteText; QuoteText)
            {
            }
            column(CompInfor_Logo; CompInfor.Picture)
            {
            }
            dataitem("Supplier Selection"; "Supplier Selection")
            {
                DataItemLink = "Reference No."=field("No."), "Supplier Category"=field(Category);
                DataItemTableView = where(Invited=const(true));

                column(Supplier_Code; "Supplier Code")
                {
                }
                column(Supplier_Name; "Supplier Name")
                {
                }
                column(RequestedVendCount; RequestedVendCount)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    RequestedVendCount:=RequestedVendCount + 1;
                end;
            }
            dataitem("Prospective Supplier Tender"; "Prospective Supplier Tender")
            {
                //PrintOnlyIfDetail = true;
                DataItemLink = "Tender No."=field("No.");

                column(SubmittedCount; SubmittedCount)
                {
                }
                column(Type; Type)
                {
                }
                column(Tender_No_; "Tender No.")
                {
                }
                column(Prospect_No_; "Prospect No.")
                {
                }
                column(BidderContent; BidderContent)
                {
                }
                column(ResposiveNess; ResposiveNess)
                {
                }
                dataitem("Supplier Evaluation Document"; "Supplier Evaluation Document")
                {
                    DataItemLink = "Supplier Code"=field("Prospect No."), "Tender No."=field("Tender No.");

                    column(Document_Code; "Document Code")
                    {
                    }
                    column(Document_Name; "Document Name")
                    {
                    }
                    column(Submitted; Submitted)
                    {
                    }
                }
                trigger OnAfterGetRecord()
                var
                    LineCount: Integer;
                begin
                    Clear(ResposiveNess);
                    Clear(BidderContent);
                    //if ResponseCount > 0 then begin
                    LineCount:=LineCount + 1;
                    SubmittedCount+=1;
                    ProspectiveSuppliers.Reset();
                    ProspectiveSuppliers.SetRange("No.", "Prospect No.");
                    if ProspectiveSuppliers.FindFirst()then;
                    BidderContent:=ProspectiveSuppliers.Name;
                    //end;
                    DocuRec.Reset();
                    DocuRec.SetRange("Supplier Code", "Prospect No.");
                    DocuRec.SetRange(Submitted, false);
                    if DocuRec.FindFirst()then ResposiveNess:=false
                    else
                        ResposiveNess:=true;
                end;
            }
            dataitem("Tender Committees"; "Tender Committees")
            {
                DataItemLink = "Tender/Quotation No"=field("No.");
                DataItemTableView = where("Committee Type"=const(Evaluation));

                column(Appointment_No; "Appointment No")
                {
                }
                dataitem("Commitee Member"; "Commitee Member")
                {
                    DataItemLink = "Appointment No"=field("Appointment No");

                    column(CommitteCount; CommitteCount)
                    {
                    }
                    column(Employee_No; "Employee No")
                    {
                    }
                    column(Name; Name)
                    {
                    }
                    column(Role; Role)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        myInt: Integer;
                    begin
                        CommitteCount+=1;
                    end;
                }
            }
            dataitem("Tender Evaluation Line"; "Tender Evaluation Line")
            {
                DataItemLink = "Quote No"=field("No.");

                column(Specification2; Specification2)
                {
                }
                column(EvaluatedItemCount; EvaluatedItemCount)
                {
                }
                column(Vendor_No; "Vendor No")
                {
                }
                column(Vendor_Name; "Vendor Name")
                {
                }
                column(Description; Description)
                {
                }
                column(No_Tender_Eval_Lines; "No.")
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
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
                column(Awarded; Awarded)
                {
                }
                /*column()
                {

                }*/
                trigger OnAfterGetRecord()
                begin
                    EvaluatedItemCount:=EvaluatedItemCount + 1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                GenCount: Integer;
            begin
                Clear(ResponseText);
                Clear(QuoteText);
                Clear(CountText);
                BiddProspect2.Reset();
                BiddProspect2.SetRange("Tender No.", "Procurement Request"."No.");
                ResponseCount:=BiddProspect2.Count();
                ResponseText:='The quotation was closed on ' + Format(TenderClosingDate) + ' ' + 'at' + ' ' + Format("Expected Closing Time") + '.' + ' ' + 'At the closing time, ONLY ' + Format(ResponseCount) + ' ' + 'firms had responded. The firms were:';
                BiddProspect3.Reset();
                BiddProspect3.SetRange("Tender No.", "No.");
                BiddProspect3.SetFilter("Passed Preliminary", '%1', true);
                GenCount:=BiddProspect3.Count();
                if ResponseCount = GenCount then QuoteText:='All the ' + ' ' + Format(ResponseCount) + ' ' + 'firms were responsive in the preliminary evaluation and were considered for technical evaluation.'
                else
                    QuoteText:='Out of the ' + ' ' + Format(ResponseCount) + 'firms that were invited,' + ' ' + 'Only' + ' ' + Format(GenCount) + ' ' + 'firms were responsive in the preliminary evaluation and were considered for technical evaluation.';
                CountText:='Quotations were sought from' + ' ' + Format(ResponseCount) + ' ' + 'service providers namely;';
            end;
            trigger OnPreDataItem()
            begin
                ResponseCount:=0;
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
            }
        }
    }
    trigger OnPreReport()
    begin
        CompInfor.get();
        CompInfor.CalcFields(Picture);
    end;
    var ResposiveNess: Boolean;
    DocuRec: Record "Supplier Evaluation Document";
    EvaluatedItemCount: Integer;
    CountText: text;
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
}

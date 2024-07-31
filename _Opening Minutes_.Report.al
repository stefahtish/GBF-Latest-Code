report 50487 "Opening Minutes"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    //  RDLCLayout = './OpeningMinutes.rdl';
    RDLCLayout = './Reports/Report 51521616 OpeningMinutes Report.rdl';

    dataset
    {
        dataitem("Procurement Request"; "Procurement Request")
        {
            column(No_; "No.")
            {
            }
            column(TenderClosingDate; TenderClosingDate)
            {
            }
            column(Title; Title)
            {
            }
            column(Requisition_No; "Requisition No")
            {
            }
            column(Category; Category)
            {
            }
            column(Company_Logo; CompInfor.Picture)
            {
            }
            dataitem("Tender Committees"; "Tender Committees")
            {
                DataItemLink = "Tender/Quotation No"=field("No.");
                DataItemTableView = where("Committee Type"=const(Opening));

                column(Appointment_No; "Appointment No")
                {
                }
                column(Submission_Date; "Submission Date")
                {
                }
                column(Submission_Time; "Submission Time")
                {
                }
                column(Tender_Quotation_No; "Tender/Quotation No")
                {
                }
                column(ReportTitle; ReportTitle)
                {
                }
                dataitem("Commitee Member"; "Commitee Member")
                {
                    DataItemLink = "Appointment No"=field("Appointment No"), "Tender No."=field("Tender/Quotation No");

                    column(Employee_No; "Employee No")
                    {
                    }
                    column(Name; Name)
                    {
                    }
                    column(Role; Uppercase(format(Role)))
                    {
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    ReportTitle:='MINUTES FOR QUOTATION OPENING, QUOTATION NO.' + ' ' + "Tender Committees"."Tender/Quotation No" + ' ' + 'HELD ON' + ' ' + format("Tender Committees"."Submission Date") + ' ' + 'IN BPIT 7TH FLOOR BOARDROOM FOR' + ' ' + UpperCase("Tender Committees".Title);
                end;
            }
            dataitem("Prospective Supplier Tender"; "Prospective Supplier Tender")
            {
                DataItemLink = "Tender No."=field("No.");

                column(Title_Lines; Title)
                {
                }
                column(ReceivedText; ReceivedText)
                {
                }
                column(VendorName; VendorName)
                {
                }
                column(QuotedPrice; QuotedPrice)
                {
                }
                column(VendorCount; VendorCount)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Clear(QuotedPrice);
                    Clear(VendorName);
                    ProspSuppTender.Reset();
                    ProspSuppTender.SetRange("Tender No.", "Procurement Request"."No.");
                    myInt:=ProspSuppTender.Count();
                    //Message(ReceivedText);
                    ProspecSuppliers.Reset();
                    ProspecSuppliers.SetRange("No.", "Prospect No.");
                    if ProspecSuppliers.FindFirst()then VendorName:=ProspecSuppliers.Name;
                    TenderLinesPrice.Reset();
                    TenderLinesPrice.SetRange("Tender No.", "Tender No.");
                    TenderLinesPrice.SetRange("Response No", "Prospect No.");
                    if TenderLinesPrice.FindSet()then repeat QuotedPrice:=QuotedPrice + TenderLinesPrice.Amount;
                        until TenderLinesPrice.Next() = 0;
                    if QuotedPrice = 0 then CurrReport.Skip();
                    VendorCount:=VendorCount + 1;
                    ReceivedText:=Format(VendorCount) + ' ' + 'Quotations were received with respect to the above request and recorded as follows;';
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
            end;
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompInfor.Get();
        CompInfor.CalcFields(Picture);
    end;
    trigger OnInitReport()
    begin
        CompInfor.Get();
        CompInfor.CalcFields(Picture);
    end;
    var myInt: Integer;
    ReportTitle: text;
    CompInfor: Record "Company Information";
    VendorName: Text;
    ProspecSuppliers: Record "Prospective Suppliers";
    VendorCount: Integer;
    ReceivedText: Text;
    ProspSuppTender: Record "Prospective Supplier Tender";
    QuotedPrice: Decimal;
    TenderLinesPrice: Record "Prospective Tender Line";
}

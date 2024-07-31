report 50461 TenderAwardLetter
{
    Caption = 'TenderAwardLetter';
    DefaultLayout = Word;
    WordLayout = './TenderAwardLetter.docx';
    ApplicationArea = All;

    dataset
    {
        dataitem(RFPEvaluationLine; "Quote Evaluation")
        {
            column(QuoteNo_EOIEvaluationHeader; "Quote No")
            {
            }
            column(Title_EOIEvaluationHeader; RefTitle)
            {
            }
            column(VendorNo_RFPEvaluationLine; "Vendor No")
            {
            }
            column(VendorName_RFPEvaluationLine; "Vendor Name")
            {
            }
            column(Vendor_Address; Address)
            {
            }
            column(Description_RFPEvaluationLine; Description)
            {
            }
            column(Vendor_email; Email)
            {
            }
            column(Vendor_PhoneNo; PhoneNo)
            {
            }
            column(Vendor_ContactName; ContactName)
            {
            }
            column(Title_ContactName; Contacttitle)
            {
            }
            column(RefNo; RefNo)
            {
            }
            column(Amount_RFPEvaluationLine; Amount)
            {
            }
            trigger OnAfterGetRecord()
            begin
                ProsSup.Reset();
                If ProsSup.Get("Vendor No") then begin
                    Email := ProsSup."Contact E-Mail Address";
                    Address := ProsSup."Postal Address";
                    PhoneNo := ProsSup."Contact Phone No.";
                    ContactName := ProsSup."Contact Person Name";
                    ContactTitle := Format(ProsSup.Title);
                end;
                RFPHeader.Reset();
                If RFPHeader.Get("Quote No") then begin
                    RefNo := RFPHeader."Reference No.";
                    RefTitle := RFPHeader.Title;
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
    var
        ProsSup: Record "Prospective Suppliers";
        Email: Text;
        Address: Text;
        RFPHeader: Record "Procurement Request";
        RefNo: code[30];
        ContactName: Text;
        PhoneNo: code[20];
        ContactTitle: Text;
        RFPLine: Record "RFP Evaluation Line";
        RefTitle: Text;
}

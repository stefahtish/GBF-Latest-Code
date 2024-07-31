report 50444 "Award Letter"
{
    DefaultLayout = Word;
    WordLayout = './EOIAwardLetter.docx';
    Caption = 'Award Letter';
    ApplicationArea = All;

    dataset
    {
        dataitem(EOIEvaluationLine; "EOI Evaluation Line")
        {
            column(QuoteNo_EOIEvaluationHeader; "Quote No")
            {
            }
            column(Title_EOIEvaluationHeader; RefTitle)
            {
            }
            column(VendorNo_EOIEvaluationLine; "Vendor No")
            {
            }
            column(VendorName_EOIEvaluationLine; "Vendor Name")
            {
            }
            column(Vendor_Address; Address)
            {
            }
            column(Description_EOIEvaluationLine; Description)
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
                EOIHeader.Reset();
                If EOIHeader.Get("Quote No") then begin
                    RefNo := EOIHeader."Reference No.";
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
        EOIHeader: Record "Procurement Request";
        RefNo: code[30];
        ContactName: Text;
        PhoneNo: code[20];
        ContactTitle: Text;
        RefTitle: Text;
}

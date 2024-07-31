report 50445 "Regret Letter"
{
    DefaultLayout = Word;
    WordLayout = './EOIRegretLetter.docx';
    Caption = 'Regret Letter';
    ApplicationArea = All;

    dataset
    {
        dataitem(EOIEvaluationLine; "EOI Evaluation Line")
        {
            column(QuoteNo_EOIEvaluationHeader; "Quote No")
            {
            }
            column(Title_EOIEvaluationHeader; Title)
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
            column(RefNo; RefNo)
            {
            }
            column(Comments; Comments)
            {
            }
            trigger OnAfterGetRecord()
            begin
                ProsSup.Reset();
                If ProsSup.Get("Vendor No") then begin
                    Email := ProsSup."E-mail";
                    Address := ProsSup."Postal Address";
                    PhoneNo := ProsSup."Contact Phone No.";
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
        PhoneNo: code[20];
        Comments: Label 'Documents submitted were not satisfactory';
}

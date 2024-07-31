report 50450 "RFP Regret Letter"
{
    DefaultLayout = Word;
    WordLayout = './RFPRegretLetter.docx';
    Caption = 'Regret Letter';
    ApplicationArea = All;

    dataset
    {
        dataitem(RFPEvaluationLine; "RFP Evaluation Line")
        {
            column(QuoteNo_RFPEvaluationHeader; "Quote No")
            {
            }
            column(Title_RFPEvaluationHeader; Title)
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
                RFPHeader.Reset();
                If RFPHeader.Get("Quote No") then begin
                    RefNo := RFPHeader."Reference No.";
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
        PhoneNo: code[20];
        Comments: Label 'Documents submitted were not satisfactory';
}

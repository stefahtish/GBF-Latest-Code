page 50233 "Prospective Tender Lines"
{
    Caption = 'Prospective Tender Lines';
    PageType = List;
    SourceTable = "Prospective Tender Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Response No"; Rec."Response No")
                {
                    ApplicationArea = All;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Specification2; SpecificationTxt)
                {
                    Caption = 'Specifications';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Specification2);
                        REC.Specification2.CreateInStream(InStrm);
                        SpecificationBigTxt.read(InStrm);
                        if SpecificationTxt <> format(SpecificationBigTxt) then begin
                            Clear(Rec.Specification2);
                            Clear(SpecificationBigTxt);
                            SpecificationBigTxt.AddText(SpecificationTxt);
                            REC.Specification2.CreateOutStream(OutStrm);
                            SpecificationBigTxt.Write(OutStrm)
                        end;
                    end;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Inclusive VAT"; Rec."Amount Inclusive VAT")
                {
                    ApplicationArea = All;
                }
                field("Amount LCY"; Rec."Amount LCY")
                {
                    ApplicationArea = All;
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                }
                field("Tender Awarded"; Rec."Tender Awarded")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("RFP Awarded"; Rec."RFP Awarded")
                {
                    Visible = false;
                }
                field("RFQ Awarded"; Rec."RFQ Awarded")
                {
                    Visible = false;
                }
                field("EOI Awarded"; Rec."EOI Awarded")
                {
                    Visible = false;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control55; Links)
            {
            }
        }
    }
    trigger OnAfterGetRecord()
    var
    begin
        Rec.CalcFields(Specification2);
        REC.Specification2.CreateInStream(InStrm);
        SpecificationBigTxt.Read(InStrm);
        SpecificationTxt := Format(SpecificationBigTxt);
    end;

    var
        InStrm: InStream;
        OutStrm: OutStream;
        SpecificationBigTxt: BigText;
        SpecificationTxt: Text;
}

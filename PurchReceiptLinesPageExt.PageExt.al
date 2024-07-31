pageextension 50118 PurchReceiptLinesPageExt extends "Purch. Receipt Lines"
{
    layout
    {
        addafter(Description)
        {
            field("General Expense Code"; Rec."General Expense Codes")
            {
                Caption = 'General expense Code';
                ApplicationArea = All;
            }
            field(SpecificationsTxt; SpecificationsTxt)
            {
                Caption = 'Specifications';
                ApplicationArea = All;
                MultiLine = true;

                trigger OnValidate()
                begin
                    Rec.CalcFields(Specification2);
                    rec.Specification2.CreateInStream(Instr);
                    SpecificationsBigTxt.Read(Instr);
                    if SpecificationsTxt <> format(SpecificationsBigTxt) then begin
                        clear(Rec.Specification2);
                        clear(SpecificationsBigTxt);
                        SpecificationsBigTxt.AddText(SpecificationsTxt);
                        rec.Specification2.CreateOutStream(OutStr);
                        SpecificationsBigTxt.Write(OutStr);
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(Specification2);
        rec.Specification2.CreateInStream(Instr);
        SpecificationsBigTxt.Read(Instr);
        SpecificationsTxt := Format(SpecificationsBigTxt);
    end;

    var
        Instr: InStream;
        OutStr: OutStream;
        SpecificationsTxt: Text;
        SpecificationsBigTxt: BigText;
}

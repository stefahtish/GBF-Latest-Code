pageextension 50117 "Purchase Invoice Subform Ext" extends "Purch. Invoice Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        addafter(Description)
        {
            field(Specification2; SpecificationsTxt)
            {
                Caption = 'Specifications';
                ApplicationArea = All;
                //MultiLine = true;

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
        addafter("Tax Group Code")
        {
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
        }
        addlast(PurchDetailLine)
        {
            field("Gen. Bus. Posting Groups"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field';
            }
            // field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field';
            // }
            field("VAT Bus. Posting Groups"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Bus. Posting Group field';
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.SuspendStatusCheck(true);
    end;

    trigger OnModifyRecord(): boolean
    var
        myInt: Integer;
    begin
        Rec.SuspendStatusCheck(true);
    end;

    var
        Instr: InStream;
        OutStr: OutStream;
        SpecificationsTxt: Text;
        SpecificationsBigTxt: BigText;
}

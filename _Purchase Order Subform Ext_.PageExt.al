pageextension 50116 "Purchase Order Subform Ext" extends "Purchase Order Subform"
{
    layout
    {
        modify("Qty. to Receive")
        {
            Enabled = QtyEditable;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        addafter(Description)
        {
            field(SpecificationsTxt; SpecificationsTxt)
            {
                Caption = 'Specifications';
                ApplicationArea = All;
                Visible = false;

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
            field(Specifications; Rec.Specifications)
            {
                Caption = 'Specification';
                ApplicationArea = all;
            }
            field("General expense Code"; Rec."General expense Codes")
            {
                Caption = 'General expense Code';
                Visible = false;
                ApplicationArea = All;
            }
            field("Inspection Decision"; Rec."Inspection Decisions")
            {
                Caption = 'Inspection Decision';
                Enabled = false;
                Visible = false;
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field("Gen. Bus. Posting Groups"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field';
            }
            field("Gen. Prod. Posting Groups"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field';
            }
            field("VAT Bus. Posting Groups"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Bus. Posting Group field';
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        ProcMgmt: Codeunit "Procurement Management";
    begin
        Rec.CalcFields(Specification2);
        rec.Specification2.CreateInStream(Instr);
        SpecificationsBigTxt.Read(Instr);
        SpecificationsTxt := Format(SpecificationsBigTxt);
        //  ProcMgmt.GetInspectionDecision(Rec);
        SetControlAppearance();
    end;

    var
        Instr: InStream;
        OutStr: OutStream;
        SpecificationsTxt: Text;
        SpecificationsBigTxt: BigText;
        QtyEditable: Boolean;

    procedure SetControlAppearance()
    var
        myInt: Integer;
    begin
        if Rec."Inspection Decisions" <> Rec."Inspection Decisions"::" " then
            QtyEditable := false
        else
            QtyEditable := true;
    end;
}

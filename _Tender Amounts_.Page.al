page 50231 "Tender Amounts"
{
    PageType = ListPart;
    SourceTable = "Tender Amount";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Description;

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                }
                field("Scope Type"; Rec."Scope Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetControlApperance();
                        CurrPage.Update();
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Indent)
            {
                Caption = 'Manually Indent';
                Image = Indent;

                trigger OnAction()
                begin
                    ProcMgt.IndentTenderAmounts(Rec."Tender No.", Rec."Scope Type");
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlApperance();
        NameIndent := Rec.Indentation;
        NameEmphasize := Rec."Scope Type" <> Rec."Scope Type"::"Scope Parameter";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        NameEmphasize := Rec."Scope Type" <> Rec."Scope Type"::"Scope Parameter";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        NameEmphasize := Rec."Scope Type" <> Rec."Scope Type"::"Scope Parameter";
    end;

    trigger OnOpenPage()
    begin
        SetControlApperance();
    end;

    var
        NoEmphasize: Boolean;
        [InDataSet]
        NameEmphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;
        ProcMgt: Codeunit "Procurement Management";
        TenderRec: Record "Procurement Request";

    local procedure GetHeader()
    begin
        TenderRec.SetRange("No.", Rec."Tender No.");
        if TenderRec.FindFirst() then;
    end;

    local procedure SetControlApperance()
    begin
        GetHeader();
    end;
}

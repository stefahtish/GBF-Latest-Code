page 50230 "Tender Scope of Work"
{
    Caption = 'Tender Scope of Work';
    PageType = ListPart;
    SourceTable = "Tender Scope of Work";
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
                    ProcMgt.IndentTenderScopeOfWork(Rec."Tender No.", Rec."Scope Type");
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
        Rec.Type := Rec.Type::Scope;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        NameEmphasize := Rec."Scope Type" <> Rec."Scope Type"::"Scope Parameter";
        Rec.Type := Rec.Type::Scope;
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

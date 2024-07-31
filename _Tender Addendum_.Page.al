page 50269 "Tender Addendum"
{
    Caption = 'Addendum';
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
                field("Type"; Rec."Scope Type")
                {
                    Caption = 'Type';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetControlApperance();
                        CurrPage.Update();
                    end;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(TypeAdd; Rec.Type)
                {
                    Visible = false;
                    ApplicationArea = all;
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
        Rec.Type := Rec.Type::Addendum;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        NameEmphasize := Rec."Scope Type" <> Rec."Scope Type"::"Scope Parameter";
        Rec.Type := Rec.Type::Addendum;
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

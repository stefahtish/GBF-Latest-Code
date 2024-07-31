page 50572 "Knowledge Required"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Knowledge Required";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = NameIndent;
                IndentationControls = "Knowledge Code";

                field("Knowledge Code"; Rec."Knowledge Code")
                {
                    Caption = 'Code';
                    Style = Strong;
                    StyleExpr = NameEmphasize;

                    trigger OnValidate()
                    begin
                        SetcontrolAppearance();
                        CurrPage.update();
                    end;
                }
                field("Line Type"; Rec."Line Type")
                {
                    trigger OnValidate()
                    begin
                        SetcontrolAppearance();
                        CurrPage.update();
                    end;
                }
                field(Remarks; Rec.Description)
                {
                    Style = Strong;
                    StyleExpr = NameEmphasize;

                    trigger OnValidate()
                    begin
                        SetcontrolAppearance();
                        CurrPage.update();
                    end;
                }
                field(Code; Rec.Code)
                {
                    visible = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        SetcontrolAppearance();
        ;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        SetcontrolAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetcontrolAppearance();
    end;

    var
        [InDataSet]
        NoEmphasize: Boolean;
        [InDataSet]
        NameEmphasize: Boolean;
        NameIndent: integer;

    procedure SetcontrolAppearance()
    var
        myInt: Integer;
        i: Integer;
    begin
        if Rec."Line Type" = Rec."Line Type"::Header then
            NameEmphasize := true
        else
            NameEmphasize := false;
        case Rec."Line Type" of
            Rec."Line Type"::Header:
                i := 0;
            Rec."Line Type"::Objective:
                i := 1;
        end;
        NameIndent := i;
    end;
}

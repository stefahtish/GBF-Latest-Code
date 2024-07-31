page 50825 "Supplier Evaluation Scores"
{
    Caption = 'Supplier Evaluation Scores';
    PageType = ListPart;
    CardPageId = "Supplier Eval Scores Card";
    SourceTable = "Supplier Evaluation Score";
    InsertAllowed = false;
    DeleteAllowed = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Score Parameter"; Rec."Score Parameter")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Score Description"; Rec."Score Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Score"; Rec."Total Score")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Yes/No"; Rec."Yes/No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Total Passmark"; Rec."Total Passmark")
                {
                    Enabled = false;
                    ApplicationArea = all;
                    Visible = ISScoreEditable;
                }
                field("Maximum Score"; Rec."Maximum Score")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = ISScoreEditable;
                }
            }
        }
    }
    var
        SupplierEval: Record "Supplier Evaluation Header";
        ISYesNoEditable: Boolean;
        ISScoreEditable: Boolean;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        case Rec."Score Criteria" of
            Rec."Score Criteria"::Score:
                begin
                    ISScoreEditable := true;
                end;
            Rec."Score Criteria"::"Yes/No":
                begin
                    ISYesNoEditable := true;
                end;
        end;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        case Rec."Score Criteria" of
            Rec."Score Criteria"::Score:
                begin
                    ISScoreEditable := true;
                end;
            Rec."Score Criteria"::"Yes/No":
                begin
                    ISYesNoEditable := true;
                end;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        GetHeader();
        Rec."Tender No." := SupplierEval."Quote No";
    end;

    local procedure GetHeader()
    begin
        if SupplierEval.Get(Rec."Document No.") then;
    end;
}

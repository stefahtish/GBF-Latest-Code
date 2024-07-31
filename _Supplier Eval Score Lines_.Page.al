page 50833 "Supplier Eval Score Lines"
{
    Caption = 'Supplier Evaluation Score Lines';
    PageType = ListPart;
    SourceTable = "Supplier Evaluation Score Line";
    InsertAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Score Description"; DescTxt)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Score; Rec.Score)
                {
                    Visible = ScoreVisible;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Y/N"; Rec."Y/N")
                {
                    Visible = YesNoVisible;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Pass/Fail"; Rec."Pass/Fail")
                {
                    ToolTip = 'Specifies the value of the Pass/Fail field.';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Maximum Score"; Rec."Maximum Score")
                {
                    Visible = ScoreVisible;
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Passmark; Rec.Passmark)
                {
                    Visible = false;
                    // Visible = ScoreVisible;
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetPageView();
    end;

    trigger OnOpenPage()
    begin
        SetPageView();
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        SetPageView();
    end;

    var
        ScoreVisible: Boolean;
        YesNoVisible: Boolean;
        Instrm: InStream;
        Outstrm: OutStream;
        DescBigTxt: BigText;
        DescTxt: Text;
        PassFail: Boolean;

    local procedure SetPageView()
    begin
        case Rec."Score Criteria" of
            Rec."Score Criteria"::Score:
                begin
                    ScoreVisible := true;
                    PassFail := false;
                    YesNoVisible := false;
                end;
            Rec."Score Criteria"::"Yes/No":
                begin
                    YesNoVisible := true;
                    PassFail := true;
                    ScoreVisible := false;
                end;
            else begin
                YesNoVisible := false;
                PassFail := false;
                ScoreVisible := false;
            end;
        end;
        Rec.CalcFields("Score Description");
        rec."Score Description".CreateInStream(Instrm);
        DescBigTxt.Read(Instrm);
        DescTxt := Format(DescBigTxt);
    end;
}

page 51389 "Supplier Eval Setup Lines2"
{
    Caption = 'Supplier Evaluation Setup Lines';
    PageType = ListPart;
    SourceTable = "Supplier Evaluation Setup Line";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; DescTxt)
                {
                    ApplicationArea = All;
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Description);
                        rec.Description.CreateInStream(Instrm);
                        DescBigTxt.Read(Instrm);
                        if DescTxt <> format(DescBigTxt) then begin
                            Clear(Rec.Description);
                            Clear(DescBigTxt);
                            DescBigTxt.AddText(DescTxt);
                            rec.Description.CreateOutStream(OutStrm);
                            DescBigTxt.Write(OutStrm)
                        end;
                        GetHeader();
                    end;
                }
                field("Maximum Score"; Rec."Maximum Score")
                {
                    ApplicationArea = All;
                    Editable = MaxVisible;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Passmark; Rec.Passmark)
                {
                    ApplicationArea = All;
                    Editable = MaxVisible;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        GetHeader();
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(Description);
        rec.Description.CreateInStream(Instrm);
        DescBigTxt.Read(Instrm);
        DescTxt := Format(DescBigTxt);
        GetHeader();
    end;

    var
        ScoreSetupHeader: Record "Supplier Evaluation SetUp";
        MaxVisible: Boolean;
        Instrm: InStream;
        Outstrm: OutStream;
        DescBigTxt: BigText;
        DescTxt: Text;

    local procedure GetHeader()
    begin
        if ScoreSetupHeader.Get(Rec.Code) then;
        case ScoreSetupHeader."Score Criteria" of
            ScoreSetupHeader."Score Criteria"::Score:
                MaxVisible := true;
            else
                MaxVisible := false;
        end;
    end;
}

page 51305 "Applicant Motivation"
{
    Caption = 'Applicant Motivation';
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Applicant Resume & Motivation";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Applicant No"; Rec."Applicant No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applicant No field';
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No field';
                    ApplicationArea = All;
                }
                field(Motivation; MotivationTxt)
                {
                    ApplicationArea = All;
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS(Motivation);
                        rec.Motivation.CREATEINSTREAM(Instr);
                        MotivationBigTxt.READ(Instr);
                        IF MotivationTxt <> FORMAT(MotivationBigTxt) THEN BEGIN
                            CLEAR(Rec.Motivation);
                            MotivationBigTxt.ADDTEXT(MotivationTxt);
                            rec.Motivation.CREATEOUTSTREAM(OutStr);
                            MotivationBigTxt.WRITE(OutStr);
                        END;
                    end;
                }
                field(Type; Rec.Type)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Type field';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS(Motivation);
        rec.Motivation.CREATEINSTREAM(Instr);
        MotivationBigTxt.READ(Instr);
        MotivationTxt := FORMAT(MotivationBigTxt)
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Motivation;
    end;

    var
        Instr: InStream;
        OutStr: OutStream;
        MotivationBigTxt: BigText;
        MotivationTxt: Text;
}

page 51304 "Applicant Resume"
{
    Caption = 'Applicant Resume';
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
                field(Resume; ResumeTxt)
                {
                    ApplicationArea = All;

                    //MultiLine = true;
                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS(Resume);
                        rec.Resume.CREATEINSTREAM(Instr);
                        ResumeBigTxt.READ(Instr);
                        IF ResumeTxt <> FORMAT(ResumeBigTxt) THEN BEGIN
                            CLEAR(Rec.Resume);
                            ResumeBigTxt.ADDTEXT(ResumeTxt);
                            rec.Resume.CREATEOUTSTREAM(OutStr);
                            ResumeBigTxt.WRITE(OutStr);
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
        Rec.CALCFIELDS(Resume);
        rec.Resume.CREATEINSTREAM(Instr);
        ResumeBigTxt.READ(Instr);
        ResumeTxt := FORMAT(ResumeBigTxt);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Resume;
    end;

    var
        ResumeBigTxt: BigText;
        ResumeTxt: Text;
        Instr: InStream;
        OutStr: OutStream;
}

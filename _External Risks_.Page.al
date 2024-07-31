page 50938 "External Risks"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Audit Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("External Risks"; DNotesText)
                {
                    Caption = 'External Risks';

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS(Description);
                        rec.Description.CREATEINSTREAM(Instr);
                        DNotes.READ(Instr);
                        IF DNotesText <> FORMAT(DNotes) THEN BEGIN
                            CLEAR(Rec.Description);
                            CLEAR(DNotes);
                            DNotes.ADDTEXT(DNotesText);
                            rec.Description.CREATEOUTSTREAM(OutStr);
                            DNotes.WRITE(OutStr);
                        END;
                    end;
                }
                field("Risk Likelihood"; Rec."Risk Likelihood")
                {
                }
                field("Risk Category"; Rec."Risk Category")
                {
                }
                field("Risk Category Description"; Rec."Risk Category Description")
                {
                }
                field("Risk Rating"; Rec.Rating2)
                {
                    Caption = 'Rating';
                }
                field("Risk Impacts"; Rec."Risk Impacts")
                {
                }
                field("Risk Mitigation"; Rec."Risk Mitigation")
                {
                }
                field("Risk Opportunities"; Rec."Risk Opportunities")
                {
                }
                field("Accept/Reject"; Rec."Accept/Reject")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                    visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    visible = false;
                }
                field("Audit Line Type"; Rec."Audit Line Type")
                {
                    ApplicationArea = All;
                    visible = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetCurrRecord()
    begin
        Rec.CALCFIELDS(Description);
        rec.Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS(Description);
        rec.Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
    end;

    var
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;
}

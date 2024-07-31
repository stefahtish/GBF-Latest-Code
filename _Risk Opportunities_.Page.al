page 51208 "Risk Opportunities"
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
                field(Opportunities; DNotesText)
                {
                    Caption = 'Opportunities';

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

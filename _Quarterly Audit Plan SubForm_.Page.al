page 51240 "Quarterly Audit Plan SubForm"
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
                field(Number; Rec.Number)
                {
                    Caption = 'Ref';
                    ApplicationArea = All;
                }
                field(Findings; Rec.Findings)
                {
                    ApplicationArea = All;
                }
                field(Recommendation; Rec.Recommendation)
                {
                    ApplicationArea = All;
                }
                field(AuditArea; DNotesText)
                {
                    Caption = 'Management Responses';
                    ApplicationArea = All;

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
                field(Timeline; Rec.Timeline)
                {
                    Caption = 'Timeline';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption = 'Audit Committee Remarks';
                    ApplicationArea = All;
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

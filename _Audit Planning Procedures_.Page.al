page 50918 "Audit Planning Procedures"
{
    Caption = 'Procedures';
    PageType = ListPart;
    SourceTable = "Audit Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Audit Description"; Rec."Audit Description")
                {
                    ApplicationArea = All;
                    Caption = 'Audit Step';
                }
                field(Description; DNotesText)
                {
                    Caption = 'Procedure';

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
                field("Done By"; Rec."Done By")
                {
                    ApplicationArea = All;
                    Caption = 'Done by: Initials';
                }
                field("WorkPlan Ref"; Rec."WorkPlan Ref")
                {
                    ApplicationArea = All;
                    Caption = 'W.P Ref';
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    Visible = false;
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

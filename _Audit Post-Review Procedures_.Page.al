page 50920 "Audit Post-Review Procedures"
{
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
                // field("Post - Review"; DNotesText)
                // {
                //     trigger OnValidate()
                //     begin
                //         CALCFIELDS(Description);
                //         Description.CREATEINSTREAM(Instr);
                //         DNotes.READ(Instr);
                //         IF DNotesText <> FORMAT(DNotes) THEN BEGIN
                //             CLEAR(Description);
                //             CLEAR(DNotes);
                //             DNotes.ADDTEXT(DNotesText);
                //             Description.CREATEOUTSTREAM(OutStr);
                //             DNotes.WRITE(OutStr);
                //         END;
                //     end;
                // }
                field(Date; Rec.Date)
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

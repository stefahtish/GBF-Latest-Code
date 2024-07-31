page 50919 "Audit Review"
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
                field("Review Scope No."; Rec."Review Scope No.")
                {
                    ApplicationArea = all;
                }
                field(Review; Rec.Review)
                {
                    Enabled = false;
                    Caption = 'Objective';
                }
                field("Review Scope"; DNotesText)
                {
                    Caption = 'Expected Internal Controls';

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
                field("Review Procedure"; DNotesText2)
                {
                    Caption = 'Test/Procedure';

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Review Procedure Blob");
                        rec."Review Procedure Blob".CREATEINSTREAM(Instr2);
                        DNotes2.READ(Instr2);
                        IF DNotesText2 <> FORMAT(DNotes2) THEN BEGIN
                            CLEAR(Rec."Review Procedure Blob");
                            CLEAR(DNotes2);
                            DNotes2.ADDTEXT(DNotesText2);
                            rec."Review Procedure Blob".CREATEOUTSTREAM(OutStr2);
                            DNotes2.WRITE(OutStr2);
                        END;
                    end;
                }
                field("Done By"; Rec."Done By")
                {
                }
                field("WorkPlan Ref"; Rec."WorkPlan Ref")
                {
                    Caption = 'W.P  Ref';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Select Scope")
            {
                Image = PostBatch;

                trigger OnAction()
                begin
                    Rec.GetReviewScope(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        Rec.CALCFIELDS(Description);
        rec.Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
        Rec.CALCFIELDS("Review Procedure Blob");
        rec."Review Procedure Blob".CREATEINSTREAM(Instr2);
        DNotes2.READ(Instr2);
        DNotesText2 := FORMAT(DNotes2);
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS(Description);
        rec.Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
        Rec.CALCFIELDS("Review Procedure Blob");
        rec."Review Procedure Blob".CREATEINSTREAM(Instr2);
        DNotes2.READ(Instr2);
        DNotesText2 := FORMAT(DNotes2);
    end;

    var
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;
        DNotes2: BigText;
        Instr2: InStream;
        DNotesText2: Text;
        OutStr2: OutStream;
}

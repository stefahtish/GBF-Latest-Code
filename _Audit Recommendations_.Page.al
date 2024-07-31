page 51210 "Audit Recommendations"
{
    PageType = List;
    SourceTable = "Audit Recommendations";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Audit Observation"; ObsNoteText)
                {
                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Audit Observation");
                        rec."Audit Observation".CREATEINSTREAM(ObsInstr);
                        ObsInstr.READ(ObsInstr);
                        IF ObsNoteText <> FORMAT(ObsNote) THEN BEGIN
                            CLEAR(Rec."Audit Observation");
                            CLEAR(ObsNote);
                            ObsNote.ADDTEXT(ObsNoteText);
                            rec."Audit Observation".CREATEOUTSTREAM(ObstOutstr);
                            ObsNote.WRITE(ObstOutstr);
                        END;
                    end;
                }
                field("Audit Recommendation"; RecomNoteText)
                {
                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Audit Recommendation");
                        rec."Audit Recommendation".CREATEINSTREAM(RecomInstr);
                        RecomNote.READ(RecomInstr);
                        IF RecomNoteText <> FORMAT(RecomNote) THEN BEGIN
                            CLEAR(Rec."Audit Recommendation");
                            CLEAR(RecomNote);
                            RecomNote.ADDTEXT(RecomNoteText);
                            rec."Audit Recommendation".CREATEOUTSTREAM(RecomOutstr);
                            RecomNote.WRITE(RecomOutstr);
                        END;
                    end;
                }
                field("Management Response"; Rec."Management Response")
                {
                }
                field("Implementation Date"; Rec."Implementation Date")
                {
                }
                field("Department Responsible"; Rec."Department Responsible")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("New Recommendation"; Rec."New Recommendation")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Recomendation Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    REPORT.RUN(Report::"Audit Recommendations", TRUE, FALSE, Recommendation);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        //Observation
        Rec.CALCFIELDS("Audit Observation");
        rec."Audit Observation".CREATEINSTREAM(ObsInstr);
        ObsNote.READ(ObsInstr);
        ObsNoteText := FORMAT(ObsNote);
        //Recomendation
        Rec.CALCFIELDS("Audit Recommendation");
        rec."Audit Recommendation".CREATEINSTREAM(RecomInstr);
        RecomNote.READ(RecomInstr);
        RecomNoteText := FORMAT(RecomNote);
    end;

    var
        ObsNote: BigText;
        ObsNoteText: Text;
        ObsInstr: InStream;
        ObstOutstr: OutStream;
        RecomNote: BigText;
        RecomNoteText: Text;
        RecomInstr: InStream;
        RecomOutstr: OutStream;
        Recommendation: Record "Audit Recommendations";
}

page 50934 "Audit Report UnFav Observation"
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
                field("Observation Title"; DNotesText)
                {
                    Editable = AuditeeAmmend;

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
                field("Observation / Condition"; ObservationNotesTxt)
                {
                    Caption = 'Recommendation';
                    Editable = AuditeeAmmend;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Observation/Condition");
                        rec."Observation/Condition".CREATEINSTREAM(ObsInstr);
                        ObservationNotes.READ(ObsInstr);
                        IF ObservationNotesTxt <> FORMAT(ObservationNotes) THEN BEGIN
                            CLEAR(Rec."Observation/Condition");
                            CLEAR(ObservationNotes);
                            ObservationNotes.ADDTEXT(ObservationNotesTxt);
                            rec."Observation/Condition".CREATEOUTSTREAM(ObsOutStr);
                            ObservationNotes.WRITE(ObsOutStr);
                        END;
                    end;
                }
                field("Due Date"; Rec.Date)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption = 'Management Response';
                }
                field(CriteriaNotesTxt; CriteriaNotesTxt)
                {
                    Caption = 'Criteria';
                    Editable = AuditeeAmmend;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS(Criteria);
                        rec.Criteria.CREATEINSTREAM(CriteriaInstr);
                        CriteriaNotes.READ(CriteriaInstr);
                        IF CriteriaNotesTxt <> FORMAT(CriteriaNotes) THEN BEGIN
                            CLEAR(Rec.Criteria);
                            CLEAR(CriteriaNotes);
                            CriteriaNotes.ADDTEXT(CriteriaNotesTxt);
                            rec.Criteria.CREATEOUTSTREAM(CriteriaOutStr);
                            CriteriaNotes.WRITE(CriteriaOutStr);
                        END;
                    end;
                }
                field(ImplicationNotesText; ImplicationNotesText)
                {
                    Caption = 'Risk Implication';
                    Editable = AuditeeAmmend;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Risk Implication");
                        rec."Risk Implication".CREATEINSTREAM(ImplicationInstr);
                        ImplicationNotes.READ(ImplicationInstr);
                        IF ImplicationNotesText <> FORMAT(ImplicationNotes) THEN BEGIN
                            CLEAR(Rec."Risk Implication");
                            CLEAR(ImplicationNotes);
                            ImplicationNotes.ADDTEXT(ImplicationNotesText);
                            rec."Risk Implication".CREATEOUTSTREAM(ImplicationOutStr);
                            ImplicationNotes.WRITE(ImplicationOutStr);
                        END;
                    end;
                }
                field("Risk Rating"; Rec."Risk Rating")
                {
                }
                field("Responsible Personnel"; Rec."Responsible Personnel")
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        SetControlApp;
        //Description
        Rec.CALCFIELDS(Description);
        rec.Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
        //
        //Risk Implication
        Rec.CALCFIELDS("Risk Implication");
        rec."Risk Implication".CREATEINSTREAM(ImplicationInstr);
        ImplicationNotes.READ(ImplicationInstr);
        ImplicationNotesText := FORMAT(ImplicationNotes);
        //
        //Criteria
        Rec.CALCFIELDS(Criteria);
        rec.Criteria.CREATEINSTREAM(CriteriaInstr);
        CriteriaNotes.READ(CriteriaInstr);
        CriteriaNotesTxt := FORMAT(CriteriaNotes);
        //
        //Observation/Condition
        Rec.CALCFIELDS("Observation/Condition");
        rec."Observation/Condition".CREATEINSTREAM(ObsInstr);
        ObservationNotes.READ(ObsInstr);
        ObservationNotesTxt := FORMAT(ObservationNotes);
        //
        //Action Plan / Management Response
        Rec.CALCFIELDS("Action Plan / Mgt Response");
        rec."Action Plan / Mgt Response".CREATEINSTREAM(ResponseInstr);
        ResponseNotes.READ(ResponseInstr);
        ResponseNotesTxt := FORMAT(ResponseNotes);
        //
    end;

    trigger OnOpenPage()
    begin
        SetControlApp;
    end;

    var
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;
        ImplicationNotes: BigText;
        ImplicationNotesText: Text;
        CriteriaNotes: BigText;
        CriteriaNotesTxt: Text;
        ObservationNotes: BigText;
        ObservationNotesTxt: Text;
        ResponseNotes: BigText;
        ResponseNotesTxt: Text;
        ImplicationInstr: InStream;
        ImplicationOutStr: OutStream;
        CriteriaInstr: InStream;
        CriteriaOutStr: OutStream;
        ObsInstr: InStream;
        ObsOutStr: OutStream;
        ResponseInstr: InStream;
        ResponseOutStr: OutStream;
        AuditeeAmmend: Boolean;

    local procedure SetControlApp()
    var
        AuditHeader: Record "Audit Header";
    begin
        //TESTFIELD("Document No.");
        IF AuditHeader.GET(Rec."Document No.") THEN BEGIN
            IF (AuditHeader."Report Status" = AuditHeader."Report Status"::Auditee) THEN BEGIN
                AuditeeAmmend := FALSE;
            END
            ELSE
                AuditeeAmmend := TRUE;
        END;
    end;
}

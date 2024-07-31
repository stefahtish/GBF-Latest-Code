page 51164 "Audit Plan"
{
    PageType = Card;
    SourceTable = "Audit Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Audit Period"; Rec."Audit Period Start Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Audit Manager No."; Rec."Audit Manager No.")
                {
                }
                field("Audit Manager"; Rec."Audit Manager")
                {
                    Enabled = false;
                }
                label("Cut Off Period:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Cut Off Start Date"; Rec."Cut Off Start Date")
                {
                    ApplicationArea = All;
                }
                field("Cut Off End Date"; Rec."Cut Off End Date")
                {
                    ApplicationArea = All;
                }
                field("Audit Status"; Rec."Audit Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            field(Introduction; IntroNotesText)
            {
                ApplicationArea = Basic, Suite;
                MultiLine = true;

                trigger OnValidate()
                begin
                    Rec.CALCFIELDS(Introduction);
                    rec.Introduction.CREATEINSTREAM(Instr);
                    IntroNote.READ(Instr);
                    IF IntroNotesText <> FORMAT(IntroNote) THEN BEGIN
                        CLEAR(Rec.Introduction);
                        CLEAR(IntroNote);
                        IntroNote.ADDTEXT(IntroNotesText);
                        rec.Introduction.CREATEOUTSTREAM(OutStr);
                        IntroNote.WRITE(OutStr);
                    END;
                end;
            }
            field("Objectives Statement"; ObjectivesNotesText)
            {
                ApplicationArea = Basic, Suite;
                MultiLine = true;

                trigger OnValidate()
                begin
                    Rec.CALCFIELDS("Objectives Statement");
                    rec."Objectives Statement".CREATEINSTREAM(Instr);
                    ObjectivesNote.READ(Instr);
                    IF ObjectivesNotesText <> FORMAT(ObjectivesNote) THEN BEGIN
                        CLEAR(Rec."Objectives Statement");
                        CLEAR(ObjectivesNote);
                        ObjectivesNote.ADDTEXT(ObjectivesNotesText);
                        rec."Objectives Statement".CREATEOUTSTREAM(OutStr);
                        ObjectivesNote.WRITE(OutStr);
                    END;
                end;
            }
            part(Objectives; Objectives)
            {
                SubPageLink = "Document No." = field("No."), "Audit Line Type" = CONST(Objectives);
                ApplicationArea = All;
            }
            part(PlanArea; "Audit Areas")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
            part(Control13; "Audit Plan SubForm")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Audit Plan");
                ApplicationArea = All;
            }
            part(Indicator; "Audit Perfomance Indicators")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Indicators);
                ApplicationArea = All;
            }
            part(Budget; "Audit Budget")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST(Budget);
                ApplicationArea = All;
                UpdatePropagation = Both;
            }
            field("Total Amount"; Rec."Total Amount")
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }
        area(FactBoxes)
        {
            systempart(Control35; Links)
            {
            }
            systempart(Control34; Notes)
            {
            }
            part("Audit FactBox Test"; "Audit FactBox Test")
            {
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Plan)
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    AuditHeader.RESET;
                    AuditHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Audit Plan New", TRUE, FALSE, AuditHeader);
                end;
            }
            action(Submit)
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = not Rec.Posted;

                trigger OnAction()
                begin
                    Rec.Posted := true;
                    CurrPage.Close();
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Audit Plan";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit Plan";
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Rec.CALCFIELDS(Introduction, "Objectives Statement");
        rec.Introduction.CREATEINSTREAM(Instr);
        IntroNote.READ(Instr);
        IntroNotesText := Format(IntroNote);
        rec."Objectives Statement".CREATEINSTREAM(Instr);
        ObjectivesNote.READ(Instr);
        ObjectivesNotesText := Format(ObjectivesNote)
    end;

    var
        AuditHeader: Record "Audit Header";
        IntroNote: BigText;
        IntroNotesText: Text;
        ObjectivesNote: BigText;
        ObjectivesNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
}

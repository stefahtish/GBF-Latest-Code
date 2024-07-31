page 51239 "Quarterly Audit Plan"
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
                field(Title; Rec.Title)
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
                Visible = false;
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
                Visible = false;
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
            part("Quarterly Audit"; "Quarterly Audit Plan SubForm")
            {
                SubPageLink = "Document No." = field("No."), "Audit Line Type" = CONST(Objectives);
                ApplicationArea = All;
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
                var
                    QuarterlyReport: Report "Quarterly Audit Plan";
                begin
                    AuditHeader.RESET;
                    AuditHeader.SETRANGE("No.", Rec."No.");
                    QuarterlyReport.SetTableView(AuditHeader);
                    QuarterlyReport.Run();
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
        Rec.Type := Rec.Type::"Quarterly Audit";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Quarterly Audit";
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

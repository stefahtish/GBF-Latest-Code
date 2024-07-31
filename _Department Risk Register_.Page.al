page 51204 "Department Risk Register"
{
    PageType = List;
    SourceTable = "Risk Register";
    SourceTableView = WHERE(Type = FILTER(Department), Archive = FILTER(false));
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
                field(Type; Rec.Type)
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                }
                field("Risk Description"; RiskNotesText)
                {
                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Risk Description");
                        rec."Risk Description".CREATEINSTREAM(Instr);
                        RiskNote.READ(Instr);
                        IF RiskNotesText <> FORMAT(RiskNote) THEN BEGIN
                            CLEAR(Rec."Risk Description");
                            CLEAR(RiskNote);
                            RiskNote.ADDTEXT(RiskNotesText);
                            rec."Risk Description".CREATEOUTSTREAM(OutStr);
                            RiskNote.WRITE(OutStr);
                        END;
                    end;
                }
                field("Risk Type"; Rec."Risk Type")
                {
                }
                field(Category; Rec.Category)
                {
                }
                field("Value at Risk"; Rec."Value at Risk")
                {
                }
                field("Value at Risk Amount"; Rec."Value at Risk Amount")
                {
                }
                field("Gross (L*I)"; Rec."Gross (L*I)")
                {
                }
                field("Existing Control / Mitigation"; Rec."Existing Control / Mitigation")
                {
                }
                field("Residual (L*I)"; Rec."Residual (L*I)")
                {
                }
                field("KRI(s) Description"; Rec."KRI(s) Description")
                {
                }
                field("Mitigation Action"; Rec."Mitigation Action")
                {
                }
                field("Mitigation Owner"; Rec."Mitigation Owner")
                {
                }
                field("KRI(s) Status"; Rec."KRI(s) Status")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field(Archive; Rec.Archive)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Risk Line Type"; Rec."Risk Line Type")
                {
                }
                field("Mitigation Status"; Rec."Mitigation Status")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Send to Corporate Register")
            {
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditMgt.SendToCorporateRegister(Rec);
                end;
            }
            action("Archive Risk")
            {
                Image = Closed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditMgt.ArchiveRiskInRegister(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Risk Description");
        rec."Risk Description".CREATEINSTREAM(Instr);
        RiskNote.READ(Instr);
        RiskNotesText := FORMAT(RiskNote);
    end;

    trigger OnOpenPage()
    begin
        /* IF NOT UserSetup.GET(USERID) THEN
                ERROR(UserNotFoundErr, USERID)
            ELSE BEGIN
                IF NOT UserSetup."Risk Admin" THEN BEGIN
                    FILTERGROUP(2);

                    RiskChamp.RESET;
                    RiskChamp.SETRANGE(Type, RiskChamp.Type::Risk);
                    RiskChamp.SETRANGE("User ID", USERID);
                    IF RiskChamp.FINDFIRST THEN BEGIN
                        SETRANGE("Global Dimension 1 Code", RiskChamp."Shortcut Dimension 1 Code");
                        SETRANGE("Global Dimension 2 Code", RiskChamp."Shortcut Dimension 2 Code");
                    END ELSE
                        ERROR(RiskChampNotFoundErr, USERID);
                END;
            END; */
    end;

    var
        Register: Record "Risk Register";
        AuditMgt: Codeunit "Internal Audit Management";
        UserSetup: Record "User Setup";
        UserNotFoundErr: Label 'The User %1 cannot be found in the User Setup!';
        RiskNote: BigText;
        RiskNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
        RiskChamp: Record "Internal Audit Champions";
        RiskChampNotFoundErr: Label 'User ID %1 not found in the Risk Champions Setup!';
}

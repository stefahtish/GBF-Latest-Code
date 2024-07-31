page 51198 "Risk Champion List"
{
    CardPageID = "Risk Card";
    PageType = List;
    SourceTable = "Risk Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Description"; RiskNotesText)
                {
                    ApplicationArea = Basic, Suite;

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
            }
        }
    }
    actions
    {
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
        /* if not UserSetup.Get(UserId) THEN
                ERROR(UserNotFoundErr, USERID)
            else begin
                if not UserSetup."Risk Admin" then begin
                    RiskChampion.Reset();
                    RiskChampion.SetRange("User ID", UserId);
                    if RiskChampion.FindFirst() then begin
                        FilterGroup(2);
                        SetRange("Risk Region", RiskChampion."Shortcut Dimension 1 Code");
                    end;
                end;
            end; */
    end;

    var
        UserSetup: Record "User Setup";
        RiskChampion: Record "Internal Audit Champions";
        UserNotFoundErr: Label 'The User Name %1 does not exist in the User Setup.';
        RiskNote: BigText;
        RiskNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
}

page 50913 "Risks List"
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
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
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
        /*
            IF UserSetup.GET(USERID) THEN BEGIN
                IF NOT UserSetup."Risk Admin" THEN
                  BEGIN
                    FILTERGROUP(2);
                    SETRANGE("Created By",USERID);
                  END;
              END ELSE
                ERROR('The User %1 does not exist in the User Setup',USERID);
            */
    end;

    var
        UserSetup: Record "User Setup";
        RiskNote: BigText;
        RiskNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
}

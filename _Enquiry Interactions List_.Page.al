page 50863 "Enquiry Interactions List"
{
    PageType = List;
    SourceTable = "Client Interaction Header";
    CardPageID = "Enquiry Interaction Card";
    SourceTableView = where("Interaction Type" = filter(Enquiry));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("Interact Code"; Rec."Interact Code")
                {
                }
                field("Date and Time"; Rec."Date and Time")
                {
                }
                field("Client No."; Rec."Client No.")
                {
                }
                field("Client Name"; Rec."Client Name")
                {
                }
                field("Client Type"; Rec."Client Type")
                {
                }
                field("Client Phone No."; Rec."Client Phone No.")
                {
                }
                field("Client Email"; Rec."Client Email")
                {
                }
                field("Branch Code"; Rec."Branch Code")
                {
                }
                field("Interaction Type"; Rec."Interaction Type")
                {
                }
                field("Problem Reported"; ProblemNotesText)
                {
                    caption = 'Issue Reported';
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Problem Reported");
                        rec."Problem Reported".CREATEINSTREAM(Instr);
                        ProblemNote.READ(Instr);
                        IF ProblemNotesText <> FORMAT(ProblemNote) THEN BEGIN
                            CLEAR(Rec."Problem Reported");
                            CLEAR(ProblemNote);
                            ProblemNote.ADDTEXT(ProblemNotesText);
                            rec."Problem Reported".CREATEOUTSTREAM(OutStr);
                            ProblemNote.WRITE(OutStr);
                        END;
                    end;
                }
                field("Interaction Channel"; Rec."Interaction Channel")
                {
                }
                field("Interaction Type No."; Rec."Interaction Type No.")
                {
                }
                field("Interaction Cause No."; Rec."Interaction Cause No.")
                {
                }
                field("Interaction Resolution No."; Rec."Interaction Resolution No.")
                {
                }
                field("Major Category"; Rec."Major Category")
                {
                }
                field(Notes; Rec.Notes)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Assigned to User"; Rec."Assigned to User")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("Last Updated Date and Time"; Rec."Last Updated Date and Time")
                {
                }
                field("Escalation Level No."; Rec."Escalation Level No.")
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
    end;

    var
        ProblemNote: BigText;
        ProblemNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
}

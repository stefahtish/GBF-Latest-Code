page 50860 "Complaints Client Interaction"
{
    CardPageID = "Complaint Interaction Card";
    Editable = false;
    PageType = List;
    SourceTable = "Client Interaction Header";
    SourceTableView = where("Interaction Type" = filter(Complaint));
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
                field(ClientTypeID; Rec.ClientTypeID)
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
        area(navigation)
        {
            group("&Complaint")
            {
                Caption = '&Complaint';

                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Client Interaction Card";
                    RunPageLink = "Interact Code" = FIELD("Interact Code");
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        //SetRange(Status, Status::Logged);
        //SetRange("User ID", UserId);
    end;

    trigger OnInsertRecord(BelowXRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        Rec."Interaction Type" := Rec."Interaction Type"::Complaint;
    end;

    trigger OnNewRecord(BelowXRec: Boolean)
    var
        myInt: Integer;
    begin
        Rec."Interaction Type" := Rec."Interaction Type"::Complaint;
    end;

    var
        ProblemNote: BigText;
        ProblemNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;

    procedure GetClientInterNo() IntCode: Code[10]
    begin
        IntCode := Rec."Interact Code";
    end;

    procedure RecGet(var RecClientLine: Record "Client Interaction Header")
    begin
    end;
}

table 50473 "Interactions Escalation Setup"
{
    DrillDownPageID = "Interactions Escalation List";
    LookupPageID = "Interactions Escalation List";

    fields
    {
        field(2; "Channel No."; Code[20])
        {
            Editable = true;
            TableRelation = "Interaction Channel".Code;

            trigger OnValidate()
            begin
                recInterChannel.Reset;
                recInterChannel.SetRange(recInterChannel.Code, "Channel No.");
                if recInterChannel.FindFirst then begin
                    "Channel Name":=recInterChannel.Description;
                end;
            end;
        }
        field(3; "Channel Name"; Text[100])
        {
            Editable = false;
        }
        field(4; "Level Code"; Code[20])
        {
        }
        field(5; "Level Duration - Hours"; Integer)
        {
        }
        field(12; "Distribution E-mail for Level"; Text[100])
        {
        }
        field(30; "Level Alert Time"; Time)
        {
        }
    }
    keys
    {
        key(Key1; "Channel No.", "Level Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var recInterChannel: Record "Interaction Channel";
}

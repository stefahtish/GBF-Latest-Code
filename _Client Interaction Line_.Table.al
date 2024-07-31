table 50465 "Client Interaction Line"
{
    fields
    {
        field(10; "Client Interaction No."; Code[20])
        {
        }
        field(20; "Line No."; Integer)
        {
        }
        field(30; "Line Type"; Option)
        {
            OptionMembers = Manual, System;
        }
        field(40; "Action Type"; Option)
        {
            OptionCaption = 'Logged,Assigned,Escalated,Response Out,Reply In,Comment,Resolution,Closed';
            OptionMembers = Logged, Assigned, Escalated, "Response Out", "Reply In", Comment, Resolution, Closed;
        }
        field(50; "User ID"; Code[50])
        {
        }
        field(60; "Date and Time"; DateTime)
        {
        }
        field(70; Description; Text[250])
        {
        }
    }
    keys
    {
        key(Key1; "Client Interaction No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

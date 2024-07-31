page 50859 "Interaction Escalation Setup"
{
    PageType = Card;
    SourceTable = "Interaction Channel";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Day Start Time"; Rec."Day Start Time")
                {
                }
                field("Day End Time"; Rec."Day End Time")
                {
                }
                part(Control1000000010; "Interactions Escalation List")
                {
                    SubPageLink = "Channel No." = FIELD(Code);
                }
            }
        }
    }
    actions
    {
    }
}

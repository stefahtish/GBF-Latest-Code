page 50563 "User Incidences"
{
    Caption = 'HelpDesk Issues';
    CardPageID = "User Incidences Card";
    PageType = List;
    SourceTable = "User Support Incident";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                }
                field("Incident Date"; Rec."Incident Date")
                {
                }
                field("Incident Status"; Rec."Incident Status")
                {
                }
            }
        }
    }
    actions
    {
    }
}

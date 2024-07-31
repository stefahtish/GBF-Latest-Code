page 50871 "Previous Interaction ListPart"
{
    AutoSplitKey = true;
    CardPageID = "Client Interaction Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Client Interaction Header";
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
                field("Interaction Type Desc."; Rec."Interaction Type Desc.")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
    actions
    {
    }
}

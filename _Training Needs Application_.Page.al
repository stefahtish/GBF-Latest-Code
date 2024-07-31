page 50576 "Training Needs Application"
{
    CardPageID = "Processed Training Needs";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Training Need";
    ApplicationArea = All;

    //SourceTableView = WHERE (Status = FILTER (Application));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field(Venue; Rec.Venue)
                {
                    Visible = false;
                }
                field("Provider Name"; Rec."Provider Name")
                {
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                }
                field("Cost Of Training (LCY)"; Rec."Cost Of Training (LCY)")
                {
                }
                field("No. of Participants"; Rec."No. of Participants")
                {
                }
                field("Total Cost"; Rec."Total Cost")
                {
                }
                field("Total PerDiem"; Rec."Total PerDiem")
                {
                }
            }
        }
    }
    actions
    {
    }
}

pageextension 50130 MaintenanceRegPageExt extends "Maintenance Registration"
{
    layout
    {
        modify("FA No.")
        {
            Visible = true;
        }
        addlast(Control1)
        {
            field("Employee No"; Rec."Employee No")
            {
                ApplicationArea = All;
            }
        }
    }
}

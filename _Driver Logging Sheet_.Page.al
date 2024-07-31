page 50707 "Driver Logging Sheet"
{
    Caption = 'Driver Logging Sheet';
    CardPageId = "Driver Logging";
    PageType = List;
    Editable = false;
    SourceTable = "Driver Logging";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Log No."; Rec."Log No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Car Registration Number"; Rec."Car Registration Number")
                {
                    ApplicationArea = All;
                }
                field("Car Mileage"; Rec."Car Mileage")
                {
                    Caption = 'Current Mileage reading';
                    ApplicationArea = All;
                }
                field("Location From"; Rec."Location From")
                {
                    ApplicationArea = All;
                }
                field("Location To"; Rec."Location To")
                {
                    ApplicationArea = All;
                }
                field("Date of Travel"; Rec."Date of Travel")
                {
                    ApplicationArea = All;
                }
                field("Time of Travel"; Rec."Time of Travel")
                {
                    ApplicationArea = All;
                }
                field("Date of Arrival"; Rec."Date of Arrival")
                {
                    ApplicationArea = All;
                }
                field("Time of Arrival"; Rec."Time of Arrival")
                {
                    ApplicationArea = All;
                }
                field(Submitted; Rec.Submitted)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }
}

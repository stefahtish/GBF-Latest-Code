page 50974 "Lab Setup"
{
    PageType = Card;
    SourceTable = "Lab Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                field("Annual schedule Nos"; Rec."Annual schedule Nos")
                {
                    ApplicationArea = All;
                }
                field("Sample Analysis Nos"; Rec."Sample Analysis Nos")
                {
                    ApplicationArea = All;
                }
                field("Sample Reception  Nos"; Rec."Sample Reception  Nos")
                {
                    ApplicationArea = All;
                }
                field("Testing allocation Nos"; Rec."Testing schedule Nos")
                {
                    ApplicationArea = All;
                }
                field("Sample ID Nos"; Rec."Sample ID")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Test No."; Rec."Test No.")
                {
                    ApplicationArea = All;
                }
                field("COA Nos"; Rec."COA Nos")
                {
                    ApplicationArea = All;
                }
                field("Maintenance Request Nos"; Rec."Maintenance Request Nos")
                {
                    ApplicationArea = All;
                }
                field("Calibration Request Nos"; Rec."Calibration Request Nos")
                {
                    ApplicationArea = All;
                }
                field("Sample Disposal Nos"; Rec."Sample Disposal Nos")
                {
                    ApplicationArea = All;
                }
            }
            Group(Communication)
            {
                field("Schedule Notification Time"; Rec."Schedule Notification Time")
                {
                    ApplicationArea = All;
                }
                field("Schedule notification email"; Rec."Schedule notification email")
                {
                    ApplicationArea = all;
                }
                field("Disposal Notification Email"; Rec."Disposal Notification Email")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Lab Location Code';
                }
            }
        }
    }
    actions
    {
    }
}

page 51117 "Strategy Activities"
{
    Caption = 'Strategy Activities';
    PageType = ListPart;
    SourceTable = "Strategic Activity";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = All;
                }
                field(Activity2; Rec.Activity2)
                {
                    ApplicationArea = All;
                }
                field(Output; Rec.Output)
                {
                    ApplicationArea = All;
                }
                field("Perfomance indicator"; Rec."Perfomance indicator")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                }
                field("Responsible person"; Rec."Responsible person")
                {
                    ApplicationArea = All;
                }
                field("Percentage Done"; Rec."Percentage Done")
                {
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("TimeFrame/Allocations")
            {
                Image = Process;
                RunObject = page "Activity TimeFrames";
                RunPageLink = "Activity Code" = field("Activity Code"), "Strategy Code" = field("Strategy Code"), KRA = field(KRA), "Strategic Issue No." = field("Strategic Issue No."), "Strategy Objective No." = field("Strategy Objective No.");
            }
        }
    }
}

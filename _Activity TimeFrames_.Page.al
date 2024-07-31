page 51121 "Activity TimeFrames"
{
    Caption = 'Activity TimeFrames';
    PageType = List;
    SourceTable = "Strategic Activity TimeFrame";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(TimeFrame; Rec.TimeFrame)
                {
                    ApplicationArea = All;
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Percentage Done"; Rec."Percentage Done")
                {
                    Enabled = false;
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    Enabled = false;
                }
            }
        }
    }
}

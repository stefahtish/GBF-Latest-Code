page 51295 "Appraisal Recommendations"
{
    PageType = ListPart;
    SourceTable = "Appraisal Recommendations";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Recommendation Type"; Rec."Recommendation Type")
                {
                    Caption = 'Type';
                    ApplicationArea = All;
                }
                field("Performance Reward"; Rec."Performance Reward")
                {
                }
                field("Increment Until Date"; Rec."Increment Until Date")
                {
                }
                field("Ready for Promotion"; Rec."Ready for Promotion")
                {
                    ToolTip = 'Ready for promotion to higher responsibilities';
                }
                field("Has Potential for Promotion"; Rec."Has Potential for Promotion")
                {
                    ToolTip = 'Has potential for promotion to the next grade';
                }
                field("Capable of Performing present"; Rec."Capable of Performing present")
                {
                    ToolTip = 'Capable of performing present job satisfaction But not promotable within the next year';
                }
                field("Unlikely to Go Further"; Rec."Unlikely to Go Further")
                {
                    ToolTip = 'Unlikely to go further';
                }
                field("Unsuitable for Promotion"; Rec."Unsuitable for Promotion")
                {
                    ToolTip = 'Unsuitable for Promotion';
                }
                field("Recognition Reason"; Rec."Recognition Reason")
                {
                    Caption = 'Reason for recognition';
                }
                field("Recognition By"; Rec."Recognition By")
                {
                }
                field("Other Recognition"; Rec."Other Recognition")
                {
                    Caption = 'Other Specify';
                }
            }
        }
    }
}

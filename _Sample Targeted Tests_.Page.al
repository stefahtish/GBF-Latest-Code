page 50969 "Sample Targeted Tests"
{
    Caption = 'Sample targeted tests';
    PageType = ListPart;
    SourceTable = "Sample Test Lines";
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Lab; Rec.Lab)
                {
                    ApplicationArea = All;
                }
                field(Test; Rec.Test)
                {
                    ApplicationArea = All;
                }
                field("To be tested"; Rec."To be tested")
                {
                    ApplicationArea = all;
                }
                field("Sample ID"; Rec."Sample ID")
                {
                    ApplicationArea = All;
                    enabled = FALSE;
                }
                field("Sample Name"; Rec."Sample Name")
                {
                    Caption = 'Sample name';
                    ApplicationArea = All;
                    enabled = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            // action("Generate multiple Lines")
            // {
            // }
        }
    }
}

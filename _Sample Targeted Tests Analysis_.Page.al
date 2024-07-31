page 50980 "Sample Targeted Tests Analysis"
{
    AutoSplitKey = true;
    Caption = 'Sample targeted tests';
    PageType = ListPart;
    SourceTable = "Sample Test Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Sample Name"; Rec."Sample Name")
                {
                    ApplicationArea = All;
                }
                field(Lab; Rec.Lab)
                {
                    ApplicationArea = All;
                }
                field(Test; Rec.Test)
                {
                    ApplicationArea = All;
                }
                field("Cannot be done"; Rec."Cannot be done")
                {
                    ApplicationArea = All;
                }
                field(Results; Rec.Results)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Specification; Rec.Specification)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sample ID"; Rec."Sample ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

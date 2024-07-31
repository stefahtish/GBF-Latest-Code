page 51065 "Butter Fat Test"
{
    AutoSplitKey = true;
    Caption = 'Butter Fat Test';
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Butter Fat content (%)"; Rec."Butter Fat content (%)")
                {
                    ApplicationArea = All;
                }
                field("Specification Code"; Rec."Specification Code")
                {
                    ApplicationArea = All;
                }
                // field("Specification (%)"; Rec."Specification (%)")
                // {
                //     ApplicationArea = All;
                // }
                field("Remarks(PassFail)"; Rec."Remarks(PassFail)")
                {
                    ApplicationArea = All;
                }
                field("Cannot be done"; Rec."Cannot be done")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

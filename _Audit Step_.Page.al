page 51281 "Audit Step"
{
    PageType = ListPart;
    SourceTable = "Audit Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Audit Description"; Rec."Audit Description")
                {
                    ApplicationArea = All;
                    Caption = 'Audit Step';
                }
                field("Done By"; Rec."Done By")
                {
                    ApplicationArea = All;
                    Caption = 'Done by: Initials';
                }
                field("WorkPlan Ref"; Rec."WorkPlan Ref")
                {
                    ApplicationArea = All;
                    Caption = 'W.P Ref';
                }
            }
        }
    }
}

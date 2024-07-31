page 51199 "Closed Risks"
{
    CardPageID = "Risk Card";
    PageType = List;
    SourceTable = "Risk Header";
    SourceTableView = WHERE("Document Status" = FILTER(Closed));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Document Status"; Rec."Document Status")
                {
                }
                field("Risk Category"; Rec."Risk Category")
                {
                }
                field("Risk Category Description"; Rec."Risk Category Description")
                {
                }
            }
        }
    }
    actions
    {
    }
}

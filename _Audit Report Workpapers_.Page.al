Page 51213 "Audit Report Workpapers"
{
    PageType = ListPart;
    SourceTable = "Audit Lines";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Report Workpaper No."; Rec."Report Workpaper No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Report Workpaper Description"; Rec."Report Workpaper Description")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}

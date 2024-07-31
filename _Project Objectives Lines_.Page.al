page 51411 "Project Objectives Lines"
{
    Caption = 'Project Objectives Lines';
    PageType = ListPart;
    SourceTable = "Project Lines";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Objective; Rec.Objective)
                {
                    ToolTip = 'Specifies the value of the Objective field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

page 51413 "Project Limitations"
{
    Caption = 'Project Limitations';
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
                field(Limitation; Rec.Limitation)
                {
                    ToolTip = 'Specifies the value of the Limitation field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

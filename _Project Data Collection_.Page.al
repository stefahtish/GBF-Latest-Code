page 51412 "Project Data Collection"
{
    Caption = 'Project Data Collection';
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
                field("Data Collection Method"; Rec."Data Collection Method")
                {
                    ToolTip = 'Specifies the value of the Data Collection Method field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

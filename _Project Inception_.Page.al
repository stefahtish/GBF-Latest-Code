page 51395 "Project Inception"
{
    PageType = ListPart;
    Caption = 'Project Inception';
    SourceTable = "Project Inception";
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Background/Context"; Rec."Background/Context")
                {
                    ToolTip = 'Specifies the value of the Background/Context field.';
                    ApplicationArea = All;
                }
                field(Objective; Rec.Objective)
                {
                    ToolTip = 'Specifies the value of the Objective field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

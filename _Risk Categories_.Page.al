page 51169 "Risk Categories"
{
    PageType = List;
    SourceTable = "Risk Categories";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
    }
}

page 50728 "BOD Committee Members"
{
    Caption = 'Committee Members';
    PageType = ListPart;
    SourceTable = "BOD Members";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field';
                    ApplicationArea = All;
                }
                field(Role; Rec.Role)
                {
                    ToolTip = 'Specifies the value of the Chair field';
                    ApplicationArea = All;
                }
            }
        }
    }
}

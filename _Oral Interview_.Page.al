page 50531 "Oral Interview"
{
    PageType = ListPart;
    SourceTable = "Oral Interview";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Applicant No"; Rec."Applicant No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applicant No field';
                    ApplicationArea = All;
                }
                field("Need Code"; Rec."Need Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Need Code field';
                    ApplicationArea = All;
                }
                field("Panel Member"; Rec."Panel Member")
                {
                    ToolTip = 'Specifies the value of the Panel Member field';
                    ApplicationArea = All;
                }
                field("Test Parameter"; Rec."Test Parameter")
                {
                    ToolTip = 'Specifies the value of the Test Parameter field';
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}

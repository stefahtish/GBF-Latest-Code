page 51393 "Project Management Plan"
{
    PageType = ListPart;
    Caption = 'Management Plan';
    SourceTable = ProjectManagementPlan;
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Project Personel"; Rec."Project Personel")
                {
                    ToolTip = 'Specifies the value of the Project Personel field.';
                    ApplicationArea = All;
                }
                field("Project Resposibilities"; Rec."Project Resposibilities")
                {
                    ToolTip = 'Specifies the value of the Project Resposibilities field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}

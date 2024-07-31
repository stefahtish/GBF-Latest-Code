page 50385 "Project Tasks"
{
    Caption = 'Contract Milestones';
    CardPageID = "Projects Tasks Card";
    //PageType = List;
    pagetype = listpart;
    SourceTable = "Project Tasks";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Task No"; Rec."Task No")
                {
                    ApplicationArea = all;
                    Caption = 'Milestone No.';
                    // Visible = false;
                    Enabled = false;
                }
                field(Descriprion; Rec.Descriprion)
                {
                    ApplicationArea = all;
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = all;
                }
                field("Responsible Person Name"; Rec."Responsible Person Name")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Responsible Person Name field.';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    // ApplicationArea = all;
                    Visible = false;
                }
                field("Progress Level %"; Rec."Progress Level %")
                {
                    // ApplicationArea = all;
                    Visible = false;
                }
                field("Task Budget"; Rec."Task Budget")
                {
                    ApplicationArea = all;
                    Caption = 'Milestone Budget';
                }
            }
        }
    }
    // actions
    // {
    //     area(creation)
    //     {
    //     }
    // }
}

page 51366 ProjectIdentification
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = ProjectIdentificationCard;
    SourceTable = ProjectIdentification;
    RefreshOnActivate = true;
    Caption = 'Project Identification';
    SourceTableView = where(Initiated=const(false));

    layout
    {
        area(Content)
        {
            repeater(Projects)
            {
                field("Project No."; Rec."Project No.")
                {
                    ToolTip = 'Specifies the value of the Project No. field.';
                    ApplicationArea = All;
                }
                field("Contractor Name"; Rec."Contractor Name")
                {
                    ToolTip = 'Specifies the value of the Client Name field.';
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ToolTip = 'Specifies the value of the Project Name field.';
                    ApplicationArea = All;
                }
                field("Project Start Date"; Rec."Project Start Date")
                {
                    ToolTip = 'Specifies the value of the Project Start Date field.';
                    ApplicationArea = All;
                }
                field("Project End Date"; Rec."Project End Date")
                {
                    ToolTip = 'Specifies the value of the Project End Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(ApprovalStatus; Rec."Project Approval Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    style = favorable;
                }
                field("Project Manager"; Rec."Project Manager name")
                {
                    ToolTip = 'Specifies the value of the Project Manager field.';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Project Budget"; Rec."Project Budget")
                {
                    ToolTip = 'Specifies the value of the Project Budget field.';
                    ApplicationArea = All;
                    Caption = 'Estimated Budget';
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                //ApplicationArea = All;
                trigger OnAction();
                begin
                end;
            }
        }
    }
}

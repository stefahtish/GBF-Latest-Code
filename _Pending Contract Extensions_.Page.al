page 51408 "Pending Contract Extensions"
{
    CardPageID = "Pending Contract Extension";
    Caption = 'Pending Contract Extension';
    Editable = false;
    PageType = List;
    InsertAllowed = false;
    SourceTable = "Project Header";
    SourceTableView = WHERE(type = CONST("Extension"), Status = Const("Pending Approval"), "Direct Contract" = const(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Project Name"; Rec."Project Name")
                {
                    Caption = 'Contract Name';
                    ApplicationArea = all;
                }
                field("Project Date"; Rec."Project Date")
                {
                    Caption = 'Contract Date';
                    ApplicationArea = all;
                }
                field("New Extended Date"; Rec."New Extended Date")
                {
                    ToolTip = 'Specifies the value of the New Extended Date field.';
                    ApplicationArea = All;
                }
                field("Extension duration"; Rec."Extension duration")
                {
                    ToolTip = 'Specifies the value of the Extension duration field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Extension Status"; Rec."Extension Status")
                {
                    ToolTip = 'Specifies the value of the Extension Status field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}

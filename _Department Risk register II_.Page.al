page 51227 "Department Risk register II"
{
    Caption = 'Department Risk register';
    PageType = List;
    Editable = false;
    CardPageId = "Department Risk Register Card";
    SourceTable = "Audit Header";
    SourceTableView = WHERE(Type = FILTER("Department Register"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
            }
        }
    }
    actions
    {
    }
}

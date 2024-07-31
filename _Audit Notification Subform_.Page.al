page 51170 "Audit Notification Subform"
{
    PageType = ListPart;
    SourceTable = "Communication Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category; Rec.Category)
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Dept. Code';
                }
                field("Department Name"; Rec."Department Name")
                {
                    Editable = false;
                }
                field("Recipient E-Mail"; Rec."Recipient E-Mail")
                {
                    Caption = 'Dept. E-Mail';
                }
                field("E-Mail Sent"; Rec."E-Mail Sent")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Departments)
            {
                Image = Holiday;

                trigger OnAction()
                begin
                    AuditMgt.GetAuditCommunicationDept(Rec."No.");
                end;
            }
        }
    }
    var
        CommLines: Record "Communication Lines";
        AuditMgt: Codeunit "Internal Audit Management";
}

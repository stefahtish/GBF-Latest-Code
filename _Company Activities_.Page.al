page 50431 "Company Activities"
{
    PageType = List;
    SourceTable = "Company Activities";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Day; Rec.Day)
                {
                }
                field(Venue; Rec.Venue)
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field("Unit of measure"; Rec."Unit of measure")
                {
                }
                field(Responsibility; Rec.Responsibility)
                {
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Notify Responsible Person")
            {
                Image = ContactPerson;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Notify responsible employee on the activity.';

                trigger OnAction()
                var
                    HrMgmt: Codeunit "HR Management";
                begin
                    HrMgmt.SendActivityNotice(Rec.Code);
                end;
            }
        }
    }
}

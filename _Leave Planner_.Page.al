page 51425 "Leave Planner"
{
    Caption = 'Leave Planner';
    PageType = Card;
    SourceTable = "Leave Planner Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Days Planned"; Rec."Days Planned")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    Enabled = false;
                }
                field(Submitted; Rec.Submitted)
                {
                    enabled = false;
                }
            }
            part("Leave Planner Lines"; "Leave Planner Lines")
            {
                SubPageLink = "Document No." = field("No."), "Leave Period" = field("Leave Period");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.Submitted := true;
                    Rec.Modify();
                    CurrPage.close;
                end;
            }
        }
    }
}

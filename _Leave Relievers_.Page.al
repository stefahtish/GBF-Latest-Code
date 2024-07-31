page 50580 "Leave Relievers"
{
    PageType = ListPart;
    SourceTable = "Leave Relievers";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff No"; Rec."Staff No")
                {
                    trigger OnValidate()
                    begin
                        LeaveApp.Get(Rec."Leave Code");
                        LeaveApp.Reset();
                        LeaveApp.SetRange("Application No", Rec."Leave Code");
                        if LeaveApp.Find('-') then begin
                            LeaveApp."Reliever No." := Rec."Staff No";
                            LeaveApp."Relieving Name" := Rec."Staff Name";
                            LeaveApp.Modify();
                            // CurrPage.Update();
                        end;
                    end;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    Enabled = false;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
    }
    var
        LeaveApp: Record "Leave Application";
}

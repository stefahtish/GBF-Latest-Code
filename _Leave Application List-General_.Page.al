page 50607 "Leave Application List-General"
{
    CardPageID = "Emp Leave Application Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Leave Application";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No"; Rec."Application No")
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Leave Code"; Rec."Leave Code")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Days Applied"; Rec."Days Applied")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Leave Period"; Rec."Leave Period")
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("User ID", UserId);
            end;
        end
        else
            Error('%1 does not exist in the Users Setup', UserId);
        // FILTERGROUP(2);
        // SETRANGE("User ID",USERID);
    end;

    var
        UserSetup: Record "User Setup";
}

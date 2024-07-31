page 51457 "Self Service Application 1"
{
    PageType = List;
    Caption = 'Self Service Leave Application';
    SourceTable = "Leave Application";
    // SourceTableView = where(Status = filter("Reliever Open"));
    CardPageID = "Emp Leave Application Card";
    ApplicationArea = All;

    layout
    {
        area(Content)
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
        area(Factboxes)
        {
        }
    }
    trigger OnOpenPage()
    begin
        // CalcFields("Reliever No.");
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                if Rec."User ID" = UserId then
                    Rec.SetRange("User ID", UserId)
                else
                    Rec.SetRange("Reliever No.", UserSetup."Employee No.");
            end;
        end
        else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        UserSetup: Record "User Setup";
}

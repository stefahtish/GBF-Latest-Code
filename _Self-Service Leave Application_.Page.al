page 51455 "Self-Service Leave Application"
{
    CardPageID = "Emp Leave Application Card";
    //DeleteAllowed = false;
    PageType = List;
    SourceTable = "Leave Application";
    ApplicationArea = All;

    //SourceTableView = WHERE (Status = FILTER (<> Released));
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
        Rec.SetRange("User ID", UserId);
        // CalcFields("Reliever No.");
        // if UserSetup.Get(UserId) then begin
        //     if not UserSetup."Show All" then begin
        //         if "User ID" = UserId then
        //             SetRange("User ID", UserId)
        //         else
        //             SetRange("Reliever No.", UserSetup."Employee No.");
        //     end;
        // end else
        //     Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        UserSetup: Record "User Setup";
}

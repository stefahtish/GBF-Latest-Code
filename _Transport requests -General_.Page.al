page 50608 "Transport requests -General"
{
    CardPageID = "Transport Request";
    PageType = List;
    SourceTable = "Travel Requests";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No."; Rec."Request No.")
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Requested By';
                }
                field(Status; Rec.Status)
                {
                }
                field(Destinations; Rec.Destinations)
                {
                }
                field("Trip Planned Start Date"; Rec."Trip Planned Start Date")
                {
                    Caption = 'Planned Start Date';
                }
                field("Trip Planned End Date"; Rec."Trip Planned End Date")
                {
                    Caption = 'Planned End Date';
                }
                field("No. of Personnel"; Rec."No. of Personnel")
                {
                    Caption = 'Employees';
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
            if not UserSetup."HOD User" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("User ID", UserId);
            end;
        end
        else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        UserSetup: Record "User Setup";
}

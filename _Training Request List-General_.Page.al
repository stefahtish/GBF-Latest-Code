page 50609 "Training Request List-General"
{
    CardPageID = "Training Request Card";
    PageType = List;
    SourceTable = "Training Request";
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
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Designation; Rec.Designation)
                {
                }
                field("No. Of Days"; Rec."No. Of Days")
                {
                }
                field(Destination; Rec.Destination)
                {
                }
                field(Venue; Rec.Venue)
                {
                }
                field(Status; Rec.Status)
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

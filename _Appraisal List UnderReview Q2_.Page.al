page 50596 "Appraisal List UnderReview Q2"
{
    CardPageID = "Appraisal Card-Review";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Employee Appraisal";
    SourceTableView = WHERE(Status = FILTER("Mid-Year Approved" | "Pending Approval" | Released), "Appraisal Status" = FILTER(Review | Set), AppraisalType = CONST("Q2"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Appraisee Name"; Rec."Appraisee Name")
                {
                }
                field("Appraisee's Job Title"; Rec."Appraisee's Job Title")
                {
                }
                field("Appraiser No"; Rec."Appraiser No")
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
                Rec.SetRange("Appraisee ID", UserId);
            end;
        end
        else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        UserSetup: Record "User Setup";
}

page 51249 "Incident Reports - Pending"
{
    Caption = 'Incidences';
    CardPageID = "Incident Report";
    PageType = List;
    SourceTable = "User Support Incident";
    SourceTableView = where(Status = filter(Pending));
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    Caption = 'No.';
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Status"; Rec."Incident Status")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::AUDIT;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::AUDIT;
    end;

    trigger OnOpenPage()
    begin
        if not UserSetup.Get(UserId) THEN
            ERROR(UserNotFoundErr, USERID)
        else begin
            if UserSetup."Risk Admin" then begin
                RiskChampion.Reset();
                RiskChampion.SetRange("User ID", UserId);
                if RiskChampion.FindFirst() then begin
                    Rec.FilterGroup(2);
                    Rec.SetRange("Shortcut Dimension 1 Code", RiskChampion."Shortcut Dimension 1 Code");
                end;
            end;
        end;
    end;

    var
        UserSetup: Record "User Setup";
        RiskChampion: Record "Internal Audit Champions";
        UserNotFoundErr: Label 'The User Name %1 does not exist in the User Setup.';
}

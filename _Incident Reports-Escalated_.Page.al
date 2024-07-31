page 51251 "Incident Reports-Escalated"
{
    Caption = 'Incidences';
    CardPageID = "Incident Report";
    PageType = List;
    SourceTable = "User Support Incident";
    SourceTableView = where(Status = filter(Escalated));
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
            if not UserSetup."Risk Admin" then begin
                RiskChampion.Reset();
                RiskChampion.SetRange("Shortcut Dimension 1 Code", RiskChampion."Shortcut Dimension 1 Code");
                RiskChampion.SetRange("User ID", RiskChampion."Escalator ID");
                if RiskChampion.FindFirst() then begin
                    Rec.FilterGroup(2);
                end;
            end;
        end;
    end;

    var
        UserSetup: Record "User Setup";
        RiskChampion: Record "Internal Audit Champions";
        UserNotFoundErr: Label 'The User Name %1 does not exist in the User Setup.';
}

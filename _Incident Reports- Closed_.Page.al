page 51252 "Incident Reports- Closed"
{
    Caption = 'Incidences';
    CardPageID = "Incident Report";
    PageType = List;
    SourceTable = "User Support Incident";
    SourceTableView = where(Status = filter(Closed));
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
        // IF UserSetup.GET(USERID) THEN BEGIN
        //     FILTERGROUP(2);
        //     SETRANGE("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        // END ELSE
        //     ERROR('The User %1 does not exist in the User Setup', USERID);
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange(User, UserId);
            end;
        end
        else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        UserSetup: Record "User Setup";
}

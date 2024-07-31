page 50560 "ICT Support Incidences"
{
    Caption = 'ICT HelpDesk Issues';
    CardPageID = "User Incidences Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "User Support Incident";
    SourceTableView = WHERE(Type = filter(ICT));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                }
                field("Incident Description"; Rec."Incident Description")
                {
                }
                field("Incident Date"; Rec."Incident Date")
                {
                }
                field(User; Rec.User)
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Incident Status"; Rec."Incident Status")
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::ICT;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::ICT;
    end;

    trigger OnOpenPage()
    begin
        // if UserSetup.Get(UserId) then begin
        //     if not UserSetup."HOD User" then begin
        //         FilterGroup(2);
        //         SetRange(User, UserId);
        //     end;
        // end;
    end;

    var
        UserSetup: Record "User Setup";
}

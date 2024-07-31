page 51422 "Submitted Supplier Eval RFP"
{
    CardPageID = "Supplier Evaluation Card2";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Supplier Evaluation Header";
    SourceTableView = where(Type = const(RFP), Status = const(Approved));
    Caption = 'Supplier Evaluation List';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Quote No"; Rec."Quote No")
                {
                    Caption = 'RFP No.';
                    ApplicationArea = all;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = all;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    // trigger OnOpenPage()
    // var
    //     UserSetup: record "User Setup";
    // begin
    //     if UserSetup.Get(UserId) then begin
    //         if not UserSetup."Show All" then begin
    //             FilterGroup(2);
    //             SetRange(User, UserId);
    //         end;
    //     end else
    //         Error('%1 does not exist in the Users Setup', UserId);
    // end;
}
